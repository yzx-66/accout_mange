package com.hfut.laboratory.controller.authc.perms;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.pojo.CouponCard;
import com.hfut.laboratory.pojo.CouponCardDetail;
import com.hfut.laboratory.pojo.Project;
import com.hfut.laboratory.service.CouponCardDetailService;
import com.hfut.laboratory.service.CouponCardService;
import com.hfut.laboratory.service.ProjectService;
import com.hfut.laboratory.util.QueryWapperUtils;
import com.hfut.laboratory.vo.ApiResponse;
import com.hfut.laboratory.vo.card.CardDetailVo;
import com.hfut.laboratory.vo.card.CardSimple;
import com.hfut.laboratory.vo.card.CouponCardVo;
import com.hfut.laboratory.vo.PageResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yzx
 * @since 2019-11-06
 */
@RestController
@RequestMapping("card")
@Api(tags = "优惠卡相关接口")
@Slf4j
public class CouponCardController {

    @Autowired
    private CouponCardService couponCardService;

    @Autowired
    private CouponCardDetailService couponCardDetailService;

    @Autowired
    private ProjectService projectService;


    @GetMapping("/list")
    @ApiOperation("获取优惠卡列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "getCouponCardList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<PageResult<CouponCard>> getCouponCardList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                                 @RequestParam(required = false,defaultValue = "20") Integer size){
        Page<CouponCard> page=new Page<>(current,size);
        IPage<CouponCard> cardIPage = couponCardService.page(page, null);
        return ApiResponse.ok(new PageResult<>(cardIPage.getRecords(),cardIPage.getTotal(),cardIPage.getSize()));
    }

    @GetMapping("/simple/list")
    @ApiOperation("获取收费项目列表id、name列表")
    @Cacheable(value = "getProjectSimpleList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<List<CardSimple>> getProjectSimpleList(){
        List<CardSimple> res=new ArrayList<>();
        couponCardService.list(null).forEach(card -> res.add(new CardSimple(card.getId(),card.getName())));
        return ApiResponse.ok(res);
    }

    @GetMapping("/c_d/list")
    @ApiOperation("获取优惠卡及对应项目的列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "getCouponCardAndDetailList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<PageResult<CouponCardVo>> getCouponCardAndDetailList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                                            @RequestParam(required = false,defaultValue = "20") Integer size){
        List<CouponCardVo> res=new ArrayList<>();
        Page<CouponCard> page=new Page<>(current,size);
        IPage<CouponCard> couponCardIPage = couponCardService.page(page, null);

        couponCardIPage.getRecords().forEach(card -> {
            res.add(getCardDetailVo(card));
        });

        return ApiResponse.ok(new PageResult<>(res,couponCardIPage.getTotal(),couponCardIPage.getSize()));
    }



    @GetMapping("/{id}")
    @ApiOperation("通过id获取优惠卡")
    @ApiImplicitParam(name = "id",value = "优惠卡的id")
    @Cacheable(value = "getCouponCardById",keyGenerator="simpleKeyGenerator")
    public ApiResponse<CouponCard> getCouponCardById(@PathVariable Integer id){
        CouponCard card = couponCardService.getById(id);
        return ApiResponse.ok(card);
    }

    @GetMapping("/c_d/{id}")
    @ApiOperation("通过id获取优惠卡及对应项目")
    @ApiImplicitParam(name = "id",value = "优惠卡的id")
    @Cacheable(value = "getCouponCardAndDetailById",keyGenerator="simpleKeyGenerator")
    public ApiResponse<CouponCardVo> getCouponCardAndDetailById(@PathVariable Integer id){
        CouponCard card = couponCardService.getById(id);
        return ApiResponse.ok(getCardDetailVo(card));
    }

    @PostMapping("/add")
    @ApiOperation("添加优惠卡（需要权限：[card_add]）")
    @ApiImplicitParam(name = "card",value = "优惠卡的json对象")
    public ApiResponse<Void> insertCouponCard(@RequestBody CouponCard card){
        boolean res = couponCardService.save(card);
        return res ? ApiResponse.created():ApiResponse.serverError();
    }

    @PutMapping("/edit")
    @ApiOperation("修改优惠卡（需要权限：[card_edit]）")
    @ApiImplicitParam(name = "card",value = "优惠卡的json对象")
    public ApiResponse<Void> updateCouponCard(@RequestBody CouponCard card){
        if(!isCardExist(card.getId())){
            return ApiResponse.selfError(ReturnCode.CARD_NOT_EXIST);
        }
        boolean res = couponCardService.updateById(card);
        return res ? ApiResponse.ok():ApiResponse.serverError();
    }


    @PutMapping("/edit_pro")
    @ApiOperation("修改优惠卡的项目（需要权限：[card_edit]）")
    @ApiImplicitParam(name = "cardDetailVo",value = "传递card_pro的项目信息")
    @Transactional
    public ApiResponse<Void> updateCouponCardDetail(@RequestBody CardDetailVo cardDetailVo){
        if(!isCardExist(cardDetailVo.getCardId())){
            return ApiResponse.selfError(ReturnCode.CARD_NOT_EXIST);
        }

        AtomicBoolean res= new AtomicBoolean(true);
        cardDetailVo.getProDetails().forEach(pro->{
            CouponCardDetail couponCardDetail=CouponCardDetail.builder()
                    .cardId(cardDetailVo.getCardId())
                    .projectId(pro.getProjectId())
                    .introduction(pro.getIntroduction())
                    .times(pro.getTimes())
                    .build();
            if(!couponCardDetailService.save(couponCardDetail)){
                log.info(this.getClass().getName()+"updateCouponCardDetail:error");
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                res.set(false);
                return;
            }
        });

        return res.get()?ApiResponse.ok():ApiResponse.serverError();
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation("删除优惠卡（需要权限：[card_del]）")
    @ApiImplicitParam(name = "id",value = "优惠卡的id")
    @Transactional
    public ApiResponse<Void> deleteCouponCard(@PathVariable Integer id){
        boolean res1=true,res2=true;
        try{
            res1=couponCardDetailService.remove(QueryWapperUtils.getInWapper("card_id",new Integer[]{id}));
            res2 = couponCardService.removeById(id);
        }catch (Exception e){
            log.info(this.getClass().getName()+"deleteCouponCard:error");
            return ApiResponse.selfError(ReturnCode.DELETE_FALI_Foreign_KEY);
        }

        if(res1 && res2){
            return ApiResponse.ok();
        } else {
            log.info(this.getClass().getName()+"deleteCouponCard:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.serverError();
        }
    }

    private boolean isCardExist(Integer id) {
        return couponCardService.getById(id)!=null;
    }

    public CouponCardVo getCardDetailVo(CouponCard card){
        List<CouponCardVo.Deatil> deatils=new ArrayList<>();
        couponCardDetailService.list(QueryWapperUtils.getInWapper("card_id",new Integer[]{card.getId()})).forEach(d_p-> {
            CouponCardDetail couponCardDetail = (CouponCardDetail) d_p;
            Project project = projectService.getById(couponCardDetail.getProjectId());
            CouponCardVo.Deatil deatil = new CouponCardVo.Deatil(project.getId(),project.getName(), couponCardDetail.getTimes());
            deatils.add(deatil);
        });

         return new CouponCardVo(card,deatils);
    }


}
