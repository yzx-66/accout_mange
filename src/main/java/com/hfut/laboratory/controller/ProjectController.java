package com.hfut.laboratory.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.pojo.Project;
import com.hfut.laboratory.pojo.RecordBusiness;
import com.hfut.laboratory.service.ProjectService;
import com.hfut.laboratory.service.RecordBusinessService;
import com.hfut.laboratory.util.QueryWapperUtils;
import com.hfut.laboratory.vo.ApiResponse;
import com.hfut.laboratory.vo.PageResult;
import com.hfut.laboratory.vo.project.ProjectSimple;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author yzx
 * @since 2019-11-06
 */
@RestController
@RequestMapping("project")
@Api(tags = "收费项目的相关接口")
@Slf4j
public class ProjectController {

    @Autowired
    private ProjectService projectService;

    @Autowired
    private RecordBusinessService recordBusinessService;

    @GetMapping("/list")
    @ApiOperation("获取收费项目列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "getProjectList",keyGenerator="simpleKeyGenerator")
    public ApiResponse getProjectList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                           @RequestParam(required = false,defaultValue = "20") Integer size){
        Page<Project> page=new Page<>(current,size);
        IPage<Project> projectIPage = projectService.page(page, null);
        return ApiResponse.ok(new PageResult<>(projectIPage.getRecords(),projectIPage.getTotal(),projectIPage.getSize()));
    }

    @GetMapping("/simple/list")
    @ApiOperation("获取没有冻结的收费项目列表id、name列表")
    @Cacheable(value = "getProjectSimpleList",keyGenerator="simpleKeyGenerator")
    public ApiResponse getProjectSimpleList(){
        List<ProjectSimple> res=new ArrayList<>();
        projectService.list(QueryWapperUtils.getInWapper("status",1))
                .forEach(project -> res.add(new ProjectSimple(((Project)project).getId(),((Project)project).getName())));
        return ApiResponse.ok(res);
    }

    @GetMapping("/simple/all/list")
    @ApiOperation("获取所有收费项目列表")
    @Cacheable(value = "getAllProjectSimpleList",keyGenerator="simpleKeyGenerator")
    public ApiResponse getAllProjectSimpleList(){
        List<ProjectSimple> res=new ArrayList<>();
        projectService.list(null).forEach(project -> res.add(new ProjectSimple(((Project)project).getId(),((Project)project).getName())));
        return ApiResponse.ok(res);
    }

    @GetMapping("/{id}")
    @ApiOperation("通过id获取收费项目")
    @ApiImplicitParam(name = "id",value = "收费项目的id")
    @Cacheable(value = "getProjectById",keyGenerator="simpleKeyGenerator")
    public ApiResponse getProjectById(@PathVariable Integer id){
        Project project = projectService.getById(id);
        return ApiResponse.ok(project);
    }

    @PostMapping("/freeze/{id}")
    @ApiOperation("冻结项目")
    public ApiResponse freezeProject(@PathVariable Integer id){
        Project project = projectService.getById(id);
        if(project==null){
            return ApiResponse.selfError(ReturnCode.PROJECT_NOT_EXITST);
        }
        project.setStatus(project.getStatus()==1 ? 0 : 1);
        projectService.updateById(project);
        return ApiResponse.ok();
    }

    @PostMapping("/add")
    @ApiOperation("添加收费项目（需要权限：[pro_add]）")
    @ApiImplicitParam(name = "project",value = "收费项目的json对象")
    public ApiResponse insertProject(@RequestBody Project project){
        if(project.getPercentage()==null || project.getPrice()==null ||project.getName()==null){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        boolean res=projectService.save(project);
        project.setStatus(1);
        return res ? ApiResponse.created():ApiResponse.serverError();
    }

    @PutMapping("/edit")
    @ApiOperation("修改收费项目（需要权限：[pro_edit]）")
    @ApiImplicitParam(name = "project",value = "收费项目的json对象")
    public ApiResponse updateProject(@RequestBody Project project){
        if(project.getId()==null || project.getPercentage()==null || project.getPrice()==null ||project.getName()==null){
            return ApiResponse.selfError(ReturnCode.NEED_PARAM);
        }
        if(projectService.getById(project.getId())==null){
            return ApiResponse.selfError(ReturnCode.PROJECT_NOT_EXITST);
        }


        boolean res=projectService.updateById(project);
        return res ? ApiResponse.ok():ApiResponse.serverError();
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation("删除收费项目（需要权限：[pro_del]）")
    @ApiImplicitParam(name = "id",value = "收费项目的id")
    public ApiResponse deleteProject(@PathVariable Integer id){
        boolean res=true;
        QueryWrapper<RecordBusiness> queryWapper=new QueryWrapper<>();
        queryWapper.and(wapper->wapper.in("type",2))
                .and(wapper->wapper.in("thing_id",id));

        if(recordBusinessService.list(queryWapper).size()!=0){
            return ApiResponse.selfError(ReturnCode.DELETE_FALI_Foreign_KEY);
        }

        try{
            res=projectService.removeById(id);
        }catch (Exception e){
            log.info(this.getClass().getName()+"deleteProject:error");
            return ApiResponse.selfError(ReturnCode.DELETE_FALI_Foreign_KEY);
        }
        return res ? ApiResponse.ok():ApiResponse.serverError();
    }

}
