package com.hfut.laboratory.controller.authc.roles.root;

import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.pojo.Permission;
import com.hfut.laboratory.service.PermissionService;
import com.hfut.laboratory.util.QueryWapperUtils;
import com.hfut.laboratory.vo.ApiResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/perm")
@Api(tags = "权限相关接口（只有root可以访问）")
@Slf4j
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    @GetMapping("/list")
    @ApiOperation("获取权限列表")
    @Cacheable(value = "getPermissionList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<List<Permission>> getPermissionList(){
        List<Permission> permissionList = permissionService.list(null);
        return ApiResponse.ok(permissionList);
    }

    @GetMapping("/{id}")
    @ApiOperation("通过id获取权限")
    @ApiImplicitParam(name = "id",value = "权限的id")
    @Cacheable(value = "getPermessionById",keyGenerator="simpleKeyGenerator")
    public ApiResponse<Permission> getPermessionById(@PathVariable Integer id){
        Permission permission = permissionService.getById(id);
        return ApiResponse.ok(permission);
    }

    @PostMapping
    @ApiOperation("添加权限")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "name",value = "权限的英文名字"),
            @ApiImplicitParam(name = "introduction",value = "该权限的中文介绍")
    })
    public ApiResponse<Void> insertPermission(@RequestParam String name,
                                                 @RequestParam String introduction){
        Permission permission=new Permission();
        permission.setName(name);
        permission.setIntroduction(introduction);
        boolean res=permissionService.save(permission);
        return res ? ApiResponse.created() : ApiResponse.serverError();
    }

    @DeleteMapping("/{id}")
    @ApiOperation("删除权限")
    @ApiImplicitParam(name = "id",value = "权限的英文名字")
    public ApiResponse<Void> deletePermission(@PathVariable Integer id){
        boolean res =true;
        try {
            res= permissionService.remove(QueryWapperUtils.getInWapper("id", id));
        }catch (Exception e){
            log.info(this.getClass().getName()+"deletePermission:error");
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ApiResponse.selfError(ReturnCode.DELETE_FALI_Foreign_KEY);
        }
        return res ? ApiResponse.ok(): ApiResponse.serverError();
    }

}
