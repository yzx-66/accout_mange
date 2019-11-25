package com.hfut.laboratory.service.impl;

import com.hfut.laboratory.pojo.User;
import com.hfut.laboratory.mapper.UserMapper;
import com.hfut.laboratory.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author yzx
 * @since 2019-11-10
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

}
