package com.hfut.laboratory.task;

import com.hfut.laboratory.enums.PayTypeEnum;
import com.hfut.laboratory.pojo.RecordsConsumption;
import com.hfut.laboratory.pojo.RecordsTurnover;
import com.hfut.laboratory.service.RecordsConsumptionService;
import com.hfut.laboratory.service.RecordsTurnoverService;
import com.hfut.laboratory.util.QueryWapperUtils;
import com.hfut.laboratory.util.TimeConvertUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

/**
 * 计算每天营业额的定时器
 */
@Component
public class TurnoverTask {

    @Autowired
    private RecordsConsumptionService recordsConsumptionService;

    @Autowired
    private RecordsTurnoverService recordsTurnoverService;

    //TODO 生产环境： 0 0 0/2 * * ?
    @Scheduled(cron = "0 0/1 * * * ?")
    public void insertTurnover(){
        recordsConsumptionService.list(QueryWapperUtils.getInWapper("is_record", new Integer[]{0})).forEach(consum->{
            RecordsConsumption consumption= (RecordsConsumption) consum;
            LocalDateTime date= TimeConvertUtils.convertTo_yMd(consumption.getPayTime());

            RecordsTurnover turnover = recordsTurnoverService.getOne(QueryWapperUtils.getInWapper("date", new LocalDateTime[]{date}));
            if(turnover==null){
                turnover=RecordsTurnover.builder()
                        .date(date)
                        .sumIncome(0.0f)
                        .moneyIncome(0.0f)
                        .moneyOutcome(0.0f)
                        .balanceReduce(0.0f)
                        .cardReduce(0.0f)
                        .build();
            }

           if(consumption.getPayType()==PayTypeEnum.USE_MONEY.getType()){
               turnover.setMoneyIncome(turnover.getMoneyIncome()+consumption.getPrice());
           }else if(consumption.getPayType()==PayTypeEnum.RETURN_TO_COSTOMER.getType()){
               turnover.setMoneyOutcome(turnover.getMoneyOutcome()+consumption.getPrice());
           }else if(consumption.getPayType()==PayTypeEnum.REDUCE_CARD_TIMES.getType()){
               turnover.setCardReduce(turnover.getCardReduce()+consumption.getPrice());
           }else if(consumption.getPayType()==PayTypeEnum.REDUCE_BALANCE.getType()){
               turnover.setBalanceReduce(turnover.getBalanceReduce()+consumption.getPrice());
           }else {
               return;
           }

           consumption.setRecord(true);
           recordsConsumptionService.updateById(consumption);

           turnover.setSumIncome(turnover.getMoneyIncome()-turnover.getMoneyOutcome());
           recordsTurnoverService.saveOrUpdate(turnover);
        });
    }
}
