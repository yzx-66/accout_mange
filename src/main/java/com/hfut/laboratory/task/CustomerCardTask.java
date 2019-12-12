package com.hfut.laboratory.task;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hfut.laboratory.pojo.CustomerCard;
import com.hfut.laboratory.pojo.CustomerCardProject;
import com.hfut.laboratory.service.CustomerCardProjectService;
import com.hfut.laboratory.service.CustomerCardService;
import com.hfut.laboratory.util.QueryWapperUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 删除客户过期和次数用完的优惠卡
 */
@Component
public class CustomerCardTask {

    @Autowired
    private CustomerCardService customerCardService;

    @Autowired
    private CustomerCardProjectService customerCardProjectService;


    @Scheduled(cron = "0 0 0 * * ?")
    @Transactional
    public void delDeadCustomerCard(){
        boolean res1=true,res2=true,res3=true,res4=true;

        QueryWrapper customerCardQueryWrapper=new QueryWrapper<>().lt("dead_time",LocalDateTime.now());
        List<Integer> deadTimeCardIdList=new ArrayList<>();
        customerCardService.list(customerCardQueryWrapper)
                .forEach(c_card->deadTimeCardIdList.add(((CustomerCard)c_card).getId()));
        if(deadTimeCardIdList.size()!=0){
            res1 = customerCardProjectService.remove(QueryWapperUtils.getInWapper("customer_card_id", deadTimeCardIdList.toArray()));
            res2 = customerCardService.removeByIds(deadTimeCardIdList);
        }

        Set<Integer> noTimesCardIdList=new HashSet<>();
        customerCardProjectService.list(QueryWapperUtils.getInWapper("residual_times",0)).forEach(c_c_p->{
                    CustomerCardProject customerCardProject=(CustomerCardProject)c_c_p;
                    noTimesCardIdList.add(customerCardProject.getCustomerCardId());
                });
        for(Integer c_c_id:noTimesCardIdList){
            List<CustomerCardProject> customerCardProjects=customerCardProjectService.list(QueryWapperUtils.getInWapper("customer_card_id",c_c_id));
            List<Integer> delIds=new ArrayList<>();
            boolean shoulDel=true;
            for(CustomerCardProject customerCardProject:customerCardProjects){
                if(customerCardProject.getResidualTimes()!=0){
                    shoulDel=false;
                    noTimesCardIdList.remove(c_c_id);
                    break;
                }
                delIds.add(customerCardProject.getId());
            }
            if(shoulDel){
                if(!customerCardProjectService.removeByIds(delIds)){
                    res3=false;
                    break;
                }
            }
        }
        if(noTimesCardIdList.size()!=0){
            res4=customerCardService.removeByIds(noTimesCardIdList);
        }

        if(!(res1 &&  res2 && res3 && res4)){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        }
    }
}
