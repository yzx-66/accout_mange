$(function () {

//    对表单进行校验
    var btn = $("#btn_submit");
    var form = $("#login_form");

    //对表单内容进行校验
    form.bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },

        fields: {
            username: {
                validators: {
                    notEmpty: {
                        message: "用户名不能为空"
                    },
                    callback: {
                        message: "用户名不存在",
                    }
                },
            },
            password: {
                validators: {
                    notEmpty: {
                        message: "密码不能为空"
                    },
                    stringLength: {
                        min: 4,
                        max: 12,
                        message: '用户名长度必须在4到12之间'
                    },
                    callback: {
                        message:"密码错误",
                    }
                }
            }
        }
    })

    //点击提交后对数据进行处理
    form.on('success.form.bv', function (e) {
        e.preventDefault();
        //使用ajax提交逻辑

        //生成需求的对象
        var username = $("#username").val();
        var password = $("#password").val();


        //包装数据
        obj = {
            name: username,
            pwd: password
        };
        json_str = JSON.stringify(obj);

		$.ajax({
            contentType: 'application/json',
            type: "post",
            dataType: "json",
            url: "http://localhost/api/login",
            data: json_str,

            success: function (info) {
                if (info.code=="0001") {
                    location.href = "./customer.html";
                }else {
                    alert(info.msg);
                }
                //    要添加判错提示
                // if(info.error===1000){
                //     form.data('bootstrapValidator').updateStatus('username', 'INVALID', 'callback')
                // }
                // if(info.error===1001){
                //     form.data('bootstrapValidator').updateStatus('password', 'INVALID', 'callback')
                // }

            }
        })

    });

//   重置表单
    $("#form_reset").click(function(){
        form.data('bootstrapValidator').resetForm();
    })

//    滚动条功能的实现
    $( document ).ajaxStart(function(){
        NProgress.start();
    })
    $( document ).ajaxStop(function(){
            NProgress.done();
    })



})