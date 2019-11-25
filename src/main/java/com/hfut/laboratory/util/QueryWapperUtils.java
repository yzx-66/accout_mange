package com.hfut.laboratory.util;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

public class QueryWapperUtils {

    public static QueryWrapper getInWapper(String colum,Object[] s){
        QueryWrapper queryWrapper=new QueryWrapper();
        queryWrapper.in(colum,s);
        return queryWrapper;
    }

    public static QueryWrapper getLikeWapper(String colum,Object s){
        QueryWrapper queryWrapper=new QueryWrapper();
        queryWrapper.like(colum,s);
        return queryWrapper;
    }

}
