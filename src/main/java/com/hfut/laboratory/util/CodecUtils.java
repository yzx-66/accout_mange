package com.hfut.laboratory.util;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;

import java.util.UUID;

public class CodecUtils {


    /*
     * md5加密
     *  data：要加密的字符串
     *  salt：盐
     */
    public static String md5Hex(String data,String salt) {
        if (StringUtils.isBlank(salt)) {
            salt = data.hashCode() + "";
        }
        return DigestUtils.md5Hex(salt + DigestUtils.md5Hex(data));
    }

    /**
     *
     * @param data
     * @param times:次数
     * @return
     */
    public static String md5Hex(String data,Integer times){
        String res="";
        for(int i=0;i<times;i++){
            res+=DigestUtils.md5Hex(data);
        }
        return res;
    }

    /*
     *  sha加密
     *  data：要加密的字符串
     *  salt：盐
     */
    public static String shaHex(String data, String salt) {
        if (StringUtils.isBlank(salt)) {
            salt = data.hashCode() + "";
        }
        return DigestUtils.sha512Hex(salt + DigestUtils.sha512Hex(data));
    }

    /*
     * 生成盐
     */
    public static String generateSalt(){
        return StringUtils.replace(UUID.randomUUID().toString(), "-", "");
    }
}

