package com.hfut.laboratory.task;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hfut.laboratory.constants.TimeFormatConstants;
import com.hfut.laboratory.enums.ConsumeTypeEnum;
import com.hfut.laboratory.enums.PayTypeEnum;
import com.hfut.laboratory.pojo.*;
import com.hfut.laboratory.service.*;
import com.hfut.laboratory.util.QueryWapperUtils;
import com.hfut.laboratory.util.TimeConvertUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Component
public class SalaryTask {

    @Autowired
    private SalaryService salaryService;

    @Autowired
    private RecordsConsumptionService recordsConsumptionService;

    @Autowired
    private RecordBusinessService recordBusinessService;

    @Autowired
    private UserService userService;

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    private ProjectService projectService;


    @Value("${salary.salaryPath}")
    private String salaryPath;

    @Scheduled(cron = "0 0 0 * * ?")
    public void genSalary() throws IOException {

        File file=new File(salaryPath);
        if(!file.exists()){
            return;
        }

        BufferedReader bufferedReader=new BufferedReader(new FileReader(file));
        String content = bufferedReader.readLine();
        LocalDateTime resTime=LocalDateTime.parse(content, DateTimeFormatter.ofPattern(TimeFormatConstants.DEFAULT_DATE_TIME_FORMAT));
        LocalDateTime now= TimeConvertUtils.convertTo_yMd(LocalDateTime.now());
        if(resTime.getDayOfMonth()!=now.getDayOfMonth()){
            return;
        }

        List<Integer> staffIds=new ArrayList<>();
        userRoleService.list(QueryWapperUtils.getInWapper("role_id", 2, 3, 4)).forEach(u_r-> staffIds.add(((UserRole)u_r).getUserId()));

        List<Salary> salaryList=new ArrayList<>();
        staffIds.forEach(id->{
            User staff=userService.getById(id);
            if(staff.getStatus()==0){
                return;
            }
            Float cardSum=0.0f,proSum=0.0f, makeMoneyIncome=0.0f,proAdd=0.0f;

            QueryWrapper<RecordsConsumption> consumptionQqueryWrapper = new QueryWrapper();
            consumptionQqueryWrapper.lt("pay_time", LocalDateTime.now())
                    .and(wapper -> wapper.ge("pay_time", LocalDateTime.now().minusMonths(1)))
                    .and(wapper -> wapper.in("user_id", id));
            List<RecordsConsumption> recordsConsumptionList = recordsConsumptionService.list(consumptionQqueryWrapper);

            for(RecordsConsumption consum:recordsConsumptionList){
                if(consum.getConsumType()== ConsumeTypeEnum.PROJECT.getType()){
                    proSum+=consum.getPrice();
                }else if(consum.getConsumType()==ConsumeTypeEnum.MAKE_CARD.getType()){
                    cardSum+=consum.getPrice();
                }
                if(consum.getPayType()== PayTypeEnum.USE_MONEY.getType()){
                    makeMoneyIncome+=consum.getPrice();
                }
            }

            QueryWrapper<RecordBusiness> businessQueryWrapper = new QueryWrapper();
            businessQueryWrapper.lt("date", LocalDateTime.now())
                    .and(wapper -> wapper.ge("date", LocalDateTime.now().minusMonths(1)))
                    .and(wapper -> wapper.in("user_id", id))
                    .and(wapper->wapper.in("type",2));
            List<RecordBusiness> recordBusinessList=recordBusinessService.list(businessQueryWrapper);
            for(RecordBusiness business:recordBusinessList){
                Project project=projectService.getById(business.getThingId());
                proAdd+=(project.getPrice()*project.getPercentage());
            }

            Salary salary=Salary.builder()
                    .userId(id)
                    .settleDate(LocalDateTime.now())
                    .cardSum(cardSum)
                    .proSum(proSum)
                    .makeMoneyIncome(makeMoneyIncome)
                    .proAdd(proAdd)
                    .baseSalary(staff.getBaseSalary())
                    .sumSalary(proAdd+staff.getBaseSalary()+makeMoneyIncome)
                    .build();
            salaryList.add(salary);
        });

        salaryService.saveBatch(salaryList);
    }
}
