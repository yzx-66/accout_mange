package com.hfut.laboratory.controller.authc.perms;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hfut.laboratory.enums.ReturnCode;
import com.hfut.laboratory.pojo.Project;
import com.hfut.laboratory.service.ProjectService;
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

    @GetMapping("/list")
    @ApiOperation("获取收费项目列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "current",value = "当前页"),
            @ApiImplicitParam(name = "size",value = "需要数据的条数limit")
    })
    @Cacheable(value = "getProjectList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<PageResult<Project>> getProjectList(@RequestParam(required = false,defaultValue = "1") Integer current,
                                                           @RequestParam(required = false,defaultValue = "20") Integer size){
        Page<Project> page=new Page<>(current,size);
        IPage<Project> projectIPage = projectService.page(page, null);
        return ApiResponse.ok(new PageResult<>(projectIPage.getRecords(),projectIPage.getTotal(),projectIPage.getSize()));
    }

    @GetMapping("/simple/list")
    @ApiOperation("获取收费项目列表id、name列表")
    @Cacheable(value = "getProjectSimpleList",keyGenerator="simpleKeyGenerator")
    public ApiResponse<List<ProjectSimple>> getProjectSimpleList(){
        List<ProjectSimple> res=new ArrayList<>();
        projectService.list(null).forEach(project -> res.add(new ProjectSimple(project.getId(),project.getName())));
        return ApiResponse.ok(res);
    }

    @GetMapping("/{id}")
    @ApiOperation("通过id获取收费项目")
    @ApiImplicitParam(name = "id",value = "收费项目的id")
    @Cacheable(value = "getProjectById",keyGenerator="simpleKeyGenerator")
    public ApiResponse<Project> getProjectById(@PathVariable Integer id){
        Project project = projectService.getById(id);
        return ApiResponse.ok(project);
    }

    @PostMapping("/add")
    @ApiOperation("添加收费项目（需要权限：[pro_add]）")
    @ApiImplicitParam(name = "project",value = "收费项目的json对象")
    public ApiResponse<Void> insertProject(@RequestBody Project project){
        boolean res=projectService.save(project);
        return res ? ApiResponse.created():ApiResponse.serverError();
    }

    @PutMapping("/edit")
    @ApiOperation("修改收费项目（需要权限：[pro_edit]）")
    @ApiImplicitParam(name = "project",value = "收费项目的json对象")
    public ApiResponse<Void> updateProject(@RequestBody Project project){
        if(projectService.getById(project.getId())==null){
            return ApiResponse.selfError(ReturnCode.PROJECT_NOT_EXITST);
        }

        boolean res=projectService.updateById(project);
        return res ? ApiResponse.ok():ApiResponse.serverError();
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation("删除收费项目（需要权限：[pro_del]）")
    @ApiImplicitParam(name = "id",value = "收费项目的id")
    public ApiResponse<Void> deleteProject(@PathVariable Integer id){
        boolean res=true;
        try{
            res=projectService.removeById(id);
        }catch (Exception e){
            log.info(this.getClass().getName()+"deleteProject:error");
            return ApiResponse.selfError(ReturnCode.DELETE_FALI_Foreign_KEY);
        }
        return res ? ApiResponse.ok():ApiResponse.serverError();
    }

}
