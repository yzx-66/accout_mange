package com.hfut.laboratory.shiro.matcher;

import com.hfut.laboratory.util.CodecUtils;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;

/**
 * 调用suject.login的时候会调用该方法进行密码校验
 */
public class UserCredentialsMatcher extends SimpleCredentialsMatcher {

    @Override
    public boolean doCredentialsMatch(AuthenticationToken authcToken, AuthenticationInfo info) {
        UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
        String tokenCredentials = CodecUtils.md5Hex(new String(token.getPassword()),3);
        String accountCredentials = (String) getCredentials(info);

        return equals(tokenCredentials, accountCredentials);
    }
}
