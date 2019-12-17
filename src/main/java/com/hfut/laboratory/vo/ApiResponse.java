package com.hfut.laboratory.vo;

import com.hfut.laboratory.enums.ReturnCode;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ApiResponse {

    /**是否成功*/
    private boolean success;
    /**返回码*/
    private String code;
    /**返回信息*/
    private String msg;
    /**返回数据*/
    private Object data;


    /**
     * 成功
     * @param data
     * @return
     */
    public static ApiResponse ok(Object data){
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setSuccess(true);
        apiResponse.setCode(ReturnCode.SUCCESS.getCode());
        apiResponse.setMsg(ReturnCode.SUCCESS.getMsg());
        apiResponse.setData(data);
        return  apiResponse;
    }

    /**
     * 成功 但没有返回内容
     * @return
     */
    public static ApiResponse ok(){
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setSuccess(true);
        apiResponse.setCode(ReturnCode.SUCCESS.getCode());
        apiResponse.setMsg(ReturnCode.SUCCESS.getMsg());
        return  apiResponse;
    }


    /**
     * 添加成功
     * @return
     */
    public static ApiResponse created(){
        ApiResponse apiResponse  = new ApiResponse();
        apiResponse.setSuccess(true);
        apiResponse.setCode(ReturnCode.CREATED.getCode());
        apiResponse.setMsg(ReturnCode.CREATED.getMsg());
        return apiResponse;
    }


    /**
     * 没有权限错误
     * @return
     */
    public static ApiResponse authError(){
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setSuccess(false);
        apiResponse.setCode(ReturnCode.UNAUTHORIZED.getCode());
        apiResponse.setMsg(ReturnCode.UNAUTHORIZED.getMsg());
        return apiResponse;
    }

    /**
     * 服务器错误
     * @return
     */
    public static ApiResponse serverError(){
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setSuccess(false);
        apiResponse.setCode(ReturnCode.INTERNAL_SERVER_ERROR.getCode());
        apiResponse.setMsg(ReturnCode.INTERNAL_SERVER_ERROR.getMsg());
        return apiResponse;
    }

    /**
     * 参数为空或者参数格式错误
     * @return
     */
    public static ApiResponse paramError(){
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setSuccess(false);
        apiResponse.setCode(ReturnCode.NEED_PARAM.getCode());
        apiResponse.setMsg(ReturnCode.NEED_PARAM.getMsg());
        return apiResponse;
    }

    /**
     * 有外键删除失败错误
     * @return
     */
    public static ApiResponse deleteError(){
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setSuccess(false);
        apiResponse.setCode(ReturnCode.DELETE_FALI_Foreign_KEY.getCode());
        apiResponse.setMsg(ReturnCode.DELETE_FALI_Foreign_KEY.getMsg());
        return apiResponse;
    }

    public static ApiResponse selfError(ReturnCode returnCode){
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setSuccess(false);
        apiResponse.setCode(returnCode.getCode());
        apiResponse.setMsg(returnCode.getMsg());
        return  apiResponse;
    }
}
