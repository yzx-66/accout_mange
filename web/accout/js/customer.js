$(function () {

    //对数据内容进行渲染
    var my_page = 1;
    var my_pagesize = 8;
    var inform_total;

    var render = function () {

        $.ajax({
            url: "http://localhost/api/customer/list",
            type: "get",
            data: {
                current: my_page + "",
                size: my_pagesize + "",
            },
            success: function (info) {
                if (info.code != "0001" && info.code != "0002") {
                    alert(info.msg);
                }
                console.log(info);
                var htmlstr = template("tql", info);
                $(".list_table").html(htmlstr);
                inform_total = info.data.total;

                //分页功能
                $("#page_classify").bootstrapPaginator({
                    bootstrapMajorVersion: 3,//默认是2，如果是bootstrap3版本，这个参数必填
                    currentPage: my_page,//当前页
                    totalPages: Math.ceil(inform_total / my_pagesize),//总页数
                    size: "small",//设置控件的大小，mini, small, normal,large
                    onPageClicked: function (event, originalEvent, type, page) {
                        my_page = page;
                        render();
                    }
                });

            }
        })
    };

    render();


//    ----------------------------------------------------

    //按照用户名进行搜索

    $("#search_byname_btn").click(function () {
        var name = $("#search_byname").val();
        var name_search_render = function () {
            $.ajax({
                url: "http://localhost/api/customer",
                type: "get",
                data: {
                    name: name,
                    current: my_page,
                    size:8,
                },
                success: function (info) {
                    if (info.code != "0001" && info.code != "0002") {
                        alert(info.msg);
                    }
                    console.log(info);
                    var htmlstr = template("tql", info);
                    $(".list_table").html(htmlstr);

                    inform_total = info.data.total;
                    console.log(inform_total)

                    //清空搜索栏
                    $("#search_byname").val("");

                    //分页功能
                    $("#page_classify").bootstrapPaginator({
                        bootstrapMajorVersion: 3,//默认是2，如果是bootstrap3版本，这个参数必填
                        currentPage: my_page,//当前页
                        totalPages: Math.ceil(inform_total / 8),//总页数
                        size: "small",//设置控件的大小，mini, small, normal,large
                        onPageClicked: function (event, originalEvent, type, page) {
                            my_page = page;
                            name_search_render();
                        }
                    });

                }
            })
        }
        my_page = 1;

        name_search_render();
    });

    //按照电话进行搜索

    $("#search_byphone_btn").click(function () {
        var phone = $("#search_byphone").val();
        var phone_search_render = function () {
            $.ajax({
                url: "http://localhost/api/customer",
                type: "get",
                data: {
                    phone: phone,
                    current: my_page,
                    size:8,
                },
                success: function (info) {
                    if (info.code != "0001" && info.code != "0002") {
                        alert(info.msg);
                    }
                    $("#search_byphone").val("");
                    console.log(info);
                    var htmlstr = template("tql", info);
                    $(".list_table").html(htmlstr);
                    inform_total = info.data.total;

                    //分页功能
                    $("#page_classify").bootstrapPaginator({
                        bootstrapMajorVersion: 3,//默认是2，如果是bootstrap3版本，这个参数必填
                        currentPage: my_page,//当前页
                        totalPages: Math.ceil(inform_total / 8),//总页数
                        size: "small",//设置控件的大小，mini, small, normal,large
                        onPageClicked: function (event, originalEvent, type, page) {
                            my_page = page;
                            phone_search_render();
                        }
                    });

                }
            })
        }
        my_page = 1;
        phone_search_render();
    });

    //添加模态框显示
    $("#add_btn").click(function () {
        $('#myModal_add').modal({
            show: true,
        });
        $("#dropdownMenu1_inner").html("性别");
        $("#form_add").data('bootstrapValidator').updateStatus('sex', 'NOT_VALIDATED', null);
        $("#add_choice_input").val("");
    });
//    ----------------------------------------------------

    //对输入的添加内容进行提交
    var form = $("#form_add");
    //对插入表单查入进行验证
    form.bootstrapValidator({
        excluded: [],
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },

        //3. 指定校验字段
        fields: {
            //校验用户名，对应name表单的name属性
            name: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '用户名不能为空'
                    },
                }
            },
            sex: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '请选择用户性别'
                    },
                }
            },

            phone: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '手机号不能为空'
                    },
                    stringLength: {
                        min: 11,
                        max: 11,
                        message: '手机号格式输入不正确'
                    },
                }
            },

            weixin: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '微信号不能为空'
                    },
                }
            },
        }
    });
//    ------------------------------------------------------

    //对选择框中的隐藏表单进行实时更新
    $(".dropdown-menu li a").click(function () {
        $("#add_choice_input").val($(this).data("id"));
        $("#form_add").data('bootstrapValidator').updateStatus('sex', 'VALID', null);
        if ($(this).data("id") === 1) {
            $("#dropdownMenu1_inner").text("男");
        } else {
            $("#dropdownMenu1_inner").text("女");
        }

    });

    //    阻止页面默认跳转
    form.on('success.form.bv', function (e) {
        if (info.code != "0001" && info.code != "0002") {
            alert(info.msg);
        }
        e.preventDefault();

        //生成需求的对象
        var form_sex = $("[name='sex']").val();
        var form_name = $("#add_user_name").val();
        var form_phone = $("[name='phone']").val();
        var form_weixin = $("[name='weixin']").val();
        obj = {
            sex: form_sex,
            name: form_name,
            phone: form_phone,
            weixin: form_weixin,
        };
        console.log(form_name);

        json_str = JSON.stringify(obj);


        //使用ajax提交逻辑
        $.ajax({
            beforeSend: function (jqXHR, options) {
                jqXHR.setRequestHeader("content-Type", "application/json");  // 增加一个自定义请求头
            },

            processData: false,
            url: "http://localhost/api/customer/add",
            type: "post",
            dataType: "json",
            data: json_str,
            success: function (info) {
                if (info.code != "0001" && info.code != "0002") {
                    alert(info.msg);
                }
                console.log(info);
                my_page = 1;
                render();
                //添加模态框隐藏
                $('#myModal_add').modal('hide');
                //    清除表中的内容
                var validator = form.data('bootstrapValidator');
                validator.resetForm(true);
                //调整选择栏内容
                $("#dropdownMenu1_inner").html("");
                //    返回第一页
                my_page = 1;
            }
        })
    });
//    ----------------------------------------

    var my_id;
//    增加余额模态框显示
    $(".list_table").on("click", ".change_increase", function () {
        //获取用户id
        my_id = $(this).parent().data("id");
        console.log($(this).parent().data("id"));

        staff_render();
        $("#form_increase").data('bootstrapValidator').updateStatus('staffId', 'NOT_VALIDATED', null);
        $("#form_increase").data('bootstrapValidator').updateStatus('changeBlance', 'NOT_VALIDATED', null);
        $("#changeBlance").val("");
        $('#myModal_increase').modal({
            show: true,
        });
    });

//    充值模态框内容
    //表单校验
    $("#form_increase").bootstrapValidator({
        excluded: [],
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },

        //3. 指定校验字段
        fields: {
            //校验用户名，对应name表单的name属性
            staffId: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '请选择员工'
                    },
                }
            },

            changeBlance: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '请填写充值的金额'
                    },
                }
            },

        }
    });
    //内容提交
    $("#form_increase").on('success.form.bv', function (e) {
        e.preventDefault();

        //生成需求的对象
        var form_increase = $("[name='changeBlance']").val();
        var staffId = $("#increase_staffId").val();

        obj = {
            changeBalance: form_increase,
            staffId: staffId,
        };

        json_str = JSON.stringify(obj);

        console.log(json_str);

        //使用ajax提交逻辑
        $.ajax({
            contentType: 'application/json',
            url: "http://localhost/api/customer/balance/" + my_id,
            type: "put",
            dataType: "json",
            data: json_str,

            success: function (info) {
                if (info.code != "0001" && info.code != "0002") {
                    alert(info.msg);
                }
                console.log(info);
                my_page = 1;
                render();
                //添加模态框隐藏
                $('#myModal_increase').modal('hide');
                //    清除表中的内容
                var validator = form.data('bootstrapValidator');
                validator.resetForm(true);
            }
        })
    });


//    ----------------------------------------------------
    //    减少余额模态框显示
    $(".list_table").on("click", ".change_decrease", function () {
        my_id = $(this).parent().data("id");
        console.log($(this).parent().data("id"));
        project_render();
        staff_render();
        $("#decrease_staffId").val("");
        $("#decrease_choice_input").val("");
        $(".decrease_project_input").val("");
        $("#project_choice").html("项目种类");
        $("#form_decrease").data('bootstrapValidator').updateStatus('consumType', 'NOT_VALIDATED', null);
        $("#form_decrease").data('bootstrapValidator').updateStatus('increase_staffId', 'NOT_VALIDATED', null);
        $("#form_decrease").data('bootstrapValidator').updateStatus('projectId', 'NOT_VALIDATED', null);
        $('#myModal_decrease').modal({
            show: true,
        });
    });
//    ----------------------------------------------------

//     减少模态狂内容

//    下选栏实时更新
    $(".dropdown-menu li a").click(function () {
        $("#decrease_choice_input").val($(this).data("id"));

        $("#decrease_choice").text($(this).text());
        $("#form_decrease").data('bootstrapValidator').updateStatus('consumType', 'VALID', null);

    });


    //表单校验
    $("#form_decrease").bootstrapValidator({
        excluded: [],
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },

        //3. 指定校验字段
        fields: {
            //校验用户名，对应name表单的name属性
            consumType: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '请选择支付方式'
                    },
                }
            },

            increase_staffId: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '请选择员工姓名'
                    },
                }
            },

            projectId: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '请选择项目种类'
                    },
                }
            },

        }
    });


    //减少余额提交
    $("#form_decrease").on('success.form.bv', function (e) {
        e.preventDefault();

        //生成需求的对象
        var changeBalance = $("[name='changeBalance']").val();
        var remark = $("[name='remark']").val();
        var payType = $("[name='consumType']").val();
        var staffId = $("#decrease_staffId").val();
        var projectId = $(".decrease_project_input").val();

        //扣除卡的余额
        if (payType === "2") {

            obj = {
                price: (changeBalance) ,
                remark: remark,
                customerId: my_id,
                payType: payType,
                staffId: staffId,
                projectId: projectId
            };
            console.log(obj)

            json_str = JSON.stringify(obj);

            console.log(json_str);

            //使用ajax提交逻辑
            $.ajax({
                contentType: 'application/json',
                url: "http://localhost/api/customer/settle",
                type: "post",
                dataType: "json",
                data: json_str,

                success: function (info) {
                        alert(info.msg);

                    console.log(info);
                    my_page = 1;
                    //添加模态框隐藏
                    $('#myModal_decrease').modal('hide');
                    //    清除表中的内容
                    $("#decrease_balance").val("");
                    $("#remark").val("");
                    $("#decrease_choice").html("消费种类");
                    $("#decrease_staffId").val("");
                    render();
                }
            })
        }

        //用现金进行消费
        if (payType === "3") {

            obj = {
                remark: remark,
                price: changeBalance,
                staffId: staffId,
                projectId: projectId,
                payType: payType,
                customerId: my_id + ""
            };

            json_str = JSON.stringify(obj);

            console.log(json_str);

            //使用ajax提交逻辑
            $.ajax({
                contentType: 'application/json',
                url: "http://localhost/api/customer/settle",
                type: "post",
                dataType: "json",
                data: json_str,

                success: function (info) {

                        alert(info.msg);

                    console.log(info);
                    my_page = 1;
                    //添加模态框隐藏
                    $('#myModal_decrease').modal('hide');
                    //    清除表中的内容
                    $("#decrease_balance").val("");
                    $("#remark").val("");
                    $("#decrease_choice").html("消费种类");
                    $("#decrease_staffId").val("");
                    render();

                }
            });
        }
    });

//    ----------------------------------------------------

//用现金消费
//    模态框显示
    $("#consume_btn").click(function () {
        my_id = $(this).parent().data("id");
        console.log($(this).parent().data("id"));
        staff_render();
        project_render();
        $("#consume_cash_price").val("");
        $(".decrease_project_input").val("");
        $('#myModal_consume').modal({
            show: true,
        });
        $(".project_choice").html("项目种类");
    });

    //表单验证
    $('#form_consume').bootstrapValidator({
        excluded: [],
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },

        //3. 指定校验字段
        fields: {
            //校验用户名，对应name表单的name属性
            cash_project: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '请选择项目'
                    },
                }
            },
            staffId: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '请选择员工名称'
                    },
                }
            },

        }
    });

//现金消费提交
    $("#form_consume").on('success.form.bv', function (e) {
        e.preventDefault();
        //生成需求的对象
        var staffId = $("[name='staffId']").val();
        var price = $("[name='price']").val();
        var projectId = $(".decrease_project_input").val();

        obj = {
            payType: "3",
            price: price,
            staffId: staffId,
            projectId: projectId,
        };

        json_str = JSON.stringify(obj);

        console.log(json_str);

        //使用ajax提交逻辑
        $.ajax({
            contentType: 'application/json',
            url: "http://localhost/api/customer/settle",
            type: "post",
            dataType: "json",
            data: json_str,

            success: function (info) {

                    alert(info.msg);

                console.log(info);
                my_page = 1;
                //添加模态框隐藏
                $('#myModal_consume').modal('hide');
                //    清除表中的内容
                var validator = $("#form_consume").data('bootstrapValidator');
                validator.resetForm(true);
                //    清除表中的内容
                $("#consume_cash_id").val("");
                $("#consume_cash_staffid").val("");
                $("#consume_cash_price").val("");
                $(".project_choice").val("项目种类");
                render();

            }
        })
    });

//    ----------------------

//    冻结解冻用户
    $(".list_table").on("click", ".btn_change", function () {
        my_id = $(this).parent().data("id");
        $.ajax({
            contentType: 'application/json',
            url: "http://localhost/api/customer/freeze/" + my_id,
            type: "post",
            success: function (info) {
                if (info.code != "0001" && info.code != "0002") {
                    alert(info.msg);
                }
                console.log(info);
                render();
            }
        })
    });


    //办卡
//    模态框显示
    $(".list_table").on("click", ".change_makecard", function () {
        my_id = $(this).parent().data("id");
        console.log($(this).parent().data("id"));
        staff_render()
        $("#makecard_project_choice").html("请选择卡的种类");
        $("#makecard_project_input").val("");
        $("#makecard_choice").html("支付方式");
        $("#makecard_choice_input").val("");
        $("#form_makecard").data('bootstrapValidator').updateStatus('changeBalance', 'NOT_VALIDATED', null);
        $("#form_makecard").data('bootstrapValidator').updateStatus('consumType', 'NOT_VALIDATED', null);
        $("#form_makecard").data('bootstrapValidator').updateStatus('staffId', 'NOT_VALIDATED', null);
        $("#form_makecard").data('bootstrapValidator').updateStatus('cardclass', 'NOT_VALIDATED', null);
        $('#myModal_makecard').modal({
            show: true,
        });

        //对卡的种类进行渲染
        $.ajax({
            type: "get",
            url: "http://localhost/api/card/simple/list",
            dataType: "json",
            success: function (info) {
                if (info.code != "0001" && info.code != "0002") {
                    alert(info.msg);
                }
                console.log(info);
                var htmlstr = template("card_tql", info);
                $("#dropdownMenu3").html(htmlstr);
                inform_total = info.data.total;
            }
        })

    });
    //进行内容实时更新

    $("#dropdownMenu3").on('click', ".project_choice", function (e) {
        $("#makecard_project_choice").html($(this).html());
        $("#makecard_project_input").val($(this).data("id"));
        $("#form_makecard").data('bootstrapValidator').updateStatus('cardclass', 'VALID', null);
    });

    $("#dropdownMenu2 a").click(function (e) {
        $("#makecard_choice").html($(this).html());
        $("#makecard_choice_input").val($(this).data("id"));
        $("#form_makecard").data('bootstrapValidator').updateStatus('consumType', 'VALID', null);
    });

    //对插入表单查入进行验证
    $("#form_makecard").bootstrapValidator({
        excluded: [],
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },

        //3. 指定校验字段
        fields: {
            //校验用户名，对应name表单的name属性
            changeBalance: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '充值金额不能为空'
                    },
                }
            },


            consumType: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '请选择支付方式'
                    },
                }
            },

            staffId: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '请选择员工'
                    },
                }
            },

            cardclass: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '请选择卡的种类'
                    },
                }
            },
        }
    });
    //办卡提交
    $("#form_makecard").on('success.form.bv', function (e) {
        e.preventDefault();

        //生成需求的对象
        var price = $("#makecard_balance").val();
        var staffId = $("#makecard_staffId").val();
        var payType = $("#makecard_choice_input").val();
        var cardId = $("#makecard_project_input").val();

        obj = {
            price: price,
            staffId: staffId,
            payType: payType,
            cardId: cardId
        };

        json_str = JSON.stringify(obj);

        console.log(json_str);

        //使用ajax提交逻辑
        $.ajax({
            contentType: 'application/json',
            url: "http://localhost/api/customer/card/" + my_id,
            type: "post",
            dataType: "json",
            data: json_str,

            success: function (info) {
                if (info.code != "0001" && info.code != "0002") {
                    alert(info.msg);
                }
                console.log(info);
                my_page = 1;
                //添加模态框隐藏
                $('#myModal_makecard').modal('hide');
                //    清除表中的内容
                $("#makecard_balance").val("");
                $("#makecard_staffId").val("");
                $("#makecard_remark").val("");
                $("#makecard_choice").html("支付方式");
                render();
            }
        })
    });


    //查询卡
    //    模态框显示
    var card_detail_render;
    $(".list_table").on("click", ".change_findcark", function () {
        my_id = $(this).parent().data("id");
        console.log(my_id);
        staff_render();
        $(".rightbox").html("");
        $('#myModal_show_card').modal({
            show: true,
        });

        //对卡的种类进行渲染
        $.ajax({
            type: "get",
            url: "http://localhost/api/customer/card/" + my_id,
            dataType: "json",
            success: function (info) {
                if (info.code != "0001" && info.code != "0002") {
                    alert(info.msg);
                }
                console.log(info);
                var htmlstr = template("leftbox_tql", info);
                $(".leftbox").html(htmlstr);
            }
        });

        //获取卡的详细信息
        $(".leftbox").off("click").on("click", ".line", function () {
            var card_id = $(this).data("num");

            card_detail_render = function () {
                $.ajax({
                    type: "get",
                    url: "http://localhost/api/customer/card/" + my_id,
                    dataType: "json",
                    success: function (info) {
                        if (info.code != "0001" && info.code != "0002") {
                            alert(info.msg);
                        }
                        var info_data = info.data;
                        console.log(info_data[card_id])
                        var htmlstr = template("rightbox_tql", info_data[card_id]);
                        $(".rightbox").html(htmlstr);
                    }
                })
            }
            card_detail_render();
            times = 0;
        })

        //更改卡的次数
        var times = 0;
        $(".big_box").off("click").on("click", ".change_card", function () {
            value = $(this).siblings(".card_change_result").html();
            //value = $(this).siblings(".card_change_result").html();
            if ($(this).data("choice") === 1) {
                if (value > 0) {
                    value = +value - 1;
                } else {
                    alert("已无剩余次数");
                }
            }
            if ($(this).data("choice") === 2) {
                value = +value + 1;
            }
            if ($(this).data("choice") === 3) {
                value = +value + 10;
            }
            value = $(this).siblings(".card_change_result").html(value);
        });

        $(".rightbox").off("click").on("click", ".card_decide", function () {
            var customerCardId = $(".rightbox_item").data("cardid");
            var projectId = $(this).siblings(".change_card").data("projectid");
            var payType = 2;
            var staffId = $(".staff_id_input").val();
            if ($(".staff_id_input").val() == 0) {
                alert("请选择员工");
                return;
            }

            value = $(this).siblings(".card_change_result").html();
            times = value - $(this).parent().siblings(".col-lg-4").children(".last_num").html();


            var obj = {
                customerCardId: customerCardId,
                projectId: projectId,
                payType: payType,
                staffId: staffId,
                times: times,
            };

            json_str = JSON.stringify(obj);

            console.log(json_str);

            $.ajax({
                url: "http://localhost/api/customer/card/" + my_id,
                contentType: 'application/json',
                type: "put",
                dataType: "json",
                data: json_str,
                success: function (info) {
                    if (info.code != "0001" && info.code != "0002") {
                        alert(info.msg);
                    }
                    times = 0;
                    card_detail_render();
                    alert("成功")
                }
            })


        });
    });


    //员工下拉框渲染
    var staff_render = function () {
        $(".staff_id").html("员工姓名");
        $(".increase_staffId").val("");
        $.ajax({
            url: "http://localhost/api/staff/list",
            type: "get",
            dataType: "json",
            success: function (info) {
                if (info.code != "0001" && info.code != "0002") {
                    alert(info.msg);
                }
                var htmlstr = template("staff_tql", info);
                $(".staff_list").html(htmlstr);

                $("#form_makecard").data('bootstrapValidator').updateStatus('staffId', 'NOT_VALIDATED', null);
                $("#form_consume").data('bootstrapValidator').updateStatus('staffId', 'NOT_VALIDATED', null);
            }
        })
    }

//    下拉框点击触发事件
    $(".staff_box").on("click", ".staff_list a", function () {
        $("#form_consume").data('bootstrapValidator').updateStatus('staffId', 'VALID', null);
        $(".staff_id").html($(this).html());

        $(".increase_staffId").val($(this).data("id"));
        $("#form_decrease").data('bootstrapValidator').updateStatus('increase_staffId', 'VALID', null);
        $("#form_makecard").data('bootstrapValidator').updateStatus('staffId', 'VALID', null);
        $("#form_increase").data('bootstrapValidator').updateStatus('staffId', 'VALID', null);
    });


    $("#delete_mark").on("click", ".card_delete", function () {
        var customerCardId = $(".rightbox_item").data("cardid");
        if(confirm("确认是否删除")===false){
            return;
        }
        $.ajax({
            url: "http://localhost/api/customer/card?cardId=" + customerCardId,
            contentType: 'application/json',
            dataType: "json",
            type: "delete",
            data: {
                cardId: customerCardId
            },
            success: function (info) {
                if (info.code != "0001" && info.code != "0002") {
                    alert(info.msg);
                }
                $(".rightbox").html("");
                $('#myModal_show_card').modal('hide');
            }
        })
    })


    //项目下拉框渲染
    var project_render = function () {
        $.ajax({
            url: "http://localhost/api/project/simple/list",
            type: "get",
            dataType: "json",
            success: function (info) {
                if (info.code != "0001" && info.code != "0002") {
                    alert(info.msg);
                }
                var htmlstr = template("project_tql", info);
                $(".project_box").html(htmlstr);
                $("#form_consume").data('bootstrapValidator').updateStatus('cash_project', 'NOT_VALIDATED', null);
            }
        })
    }

//    下拉框点击触发事件
    $(".project_box").on("click", "a", function () {
        $("#form_consume").data('bootstrapValidator').updateStatus('cash_project', 'VALID', null);
        $("#form_decrease").data('bootstrapValidator').updateStatus('projectId', 'VALID', null);

        $(".project_choice").html($(this).html());

        $(".decrease_project_input").val($(this).data("id"));
    });
});





