package com.hfut.laboratory.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;

import lombok.*;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author yzx
 * @since 2019-11-09
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RecordsConsumption implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Integer customerId;

    private Integer userId;

    /**
     * 消费类型 1：收费项目、2.办卡、3.充值余额、4.给卡增加次数
     */
    private Integer consumType;

    private Float price;

    /**
     * 1：从卡里扣除，2：从余额扣除，3.支付
     */
    private Integer payType;

    private LocalDateTime payTime;

    private String remark;

    /**
     * 是否被营业额所统计
   */
    private boolean isRecord;


}
