$(function(){

    //对数据内容进行渲染
    var my_page = 1;
    var my_pagesize = 5;
    var inform_total;

    var render = function () {

        $.ajax({
            url: "http://106.14.125.136/acc/card/c_d/list",
            type: "get",
            data: {
                current: my_page + "",
                size: my_pagesize + ""
            },
            success: function (info) {
                console.log(info);
                if(!info.success){
                    $.alert(info.msg);
                }
                $("search_byName").val("");
                $("#search_startTime").val("");
                $("#search_endTime").val("");
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

    //不显示冻结的卡
    var show_hide = function (){
        my_page = 1;
        my_pagesize = 5;
        $.ajax({
            url: "http://106.14.125.136/acc/card/c_d/list",
            type: "get",
            data: {
                current: my_page + "",
                size: my_pagesize + ""
            },
            success: function (info) {
                if(!info.success){
                    $.alert(info.msg);
                }
                console.log(info);
                var htmlstr = template("hide", info);
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
                        show_hide();
                    }
                });

            }
        })
    };
    $(".list_table").on("click", "#hide_frozen", function () {
        my_page = 1;
        my_pagesize = 5;
        $.ajax({
            url: "http://106.14.125.136/acc/card/c_d/list",
            type: "get",
            data: {
                current: my_page + "",
                size: my_pagesize + ""
            },
            success: function (info) {
                if(!info.success){
                    $.alert(info.msg);
                }
                console.log(info);
                var htmlstr = template("hide", info);
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
                        show_hide();
                    }
                });

            }
        })
    });
    //显示冻结的优惠卡
    $(".list_table").on("click", "#show_frozen", function () {
        my_page = 1;
        my_pagesize = 5;
        $.ajax({
            url: "http://106.14.125.136/acc/card/c_d/list",
            type: "get",
            data: {
                current: my_page + "",
                size: my_pagesize + ""
            },
            success: function (info) {
                console.log(info);
                if(!info.success){
                    $.alert(info.msg);
                }
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
    });
// ----------------------------------------------------------------------

    var form_startTime;
    var form_endTime;
    //添加优惠卡
    //添加模态框显示
    $("#add_btn").click(function () {

        $('#myModal_add').modal({
            show: true
        });
    });
    //起始时间及结束时间组件
    laydate.render({
        elem: '#startTime'
        ,type: 'datetime'
        ,format: 'yyyy-MM-dd HH:mm:ss'
        ,value: '2019-11-10 00:00:00'
        ,max: '2099-11-10 00:00:00'
        ,theme: '#A8A8A8'
        ,done: function(value, date, endDate){
            console.log(value); //得到日期生成的值，如：2017-08-18
            form_startTime = value;
        }
    });
    laydate.render({
        elem: '#endTime'
        ,type: 'datetime'
        ,format: 'yyyy-MM-dd HH:mm:ss'
        ,value: '2019-11-10 00:00:00'
        ,max: '2099-11-10 00:00:00'
        ,theme: '#A8A8A8'
        ,done: function(value, date, endDate){
            console.log(value); //得到日期生成的值，如：2017-08-18
            form_endTime = value;
        }
    });
    //对插入表单进行验证
    var form = $("#form_add");
    function bv(){
        form.bootstrapValidator({
            excluded: [],
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },

            //2. 指定校验字段
            fields: {
                //校验用户名，对应表单的name属性
                name: {
                    validators: {
                        //不能为空
                        notEmpty: {
                            message: '优惠卡类型不能为空'
                        }
                    }
                },
                price: {
                    validators: {
                        //不能为空
                        notEmpty: {
                            message: '优惠卡金额不能为空'
                        }
                    }
                },

                percentage: {
                    validators: {
                        //不能为空
                        notEmpty: {
                            message: '提成不能为空'
                        }
                    }
                },

                introduction: {
                    validators: {
                        //不能为空
                        notEmpty: {
                            message: '介绍不能为空'
                        }
                    }
                }
            }
        });
    }
    bv();

    //提交数据
    form.on('success.form.bv', function (e) {
        e.preventDefault();

        //生成需求的对象
        var form_name = $("#add_card_name").val();
        var form_price = $("[name='price']").val();
        var form_percentage = $("[name='percentage']").val();
        var form_introduction = $("[name='introduction']").val();
        obj = {
            name: form_name,
            price: form_price,
            percentage: form_percentage,
            startTime: form_startTime,
            endTime: form_endTime,
            introduction: form_introduction
        };
        console.log(form_name);
        json_str = JSON.stringify(obj);


        //使用ajax提交逻辑
        $.ajax({
            beforeSend: function (jqXHR, options) {
                jqXHR.setRequestHeader("content-Type", "application/json");  // 增加一个自定义请求头
            },

            processData: false,
            url: "http://106.14.125.136/acc/card/add",
            type: "post",
            dataType: "json",
            data: json_str,
            success: function (info) {
                console.log(info);
                if(!info.success){
                    $.alert(info.msg);
                }
                my_page = 1;
                render();
                //添加模态框隐藏
                $('#myModal_add').modal('hide');
                //    清除表中的内容
                /*form[0].reset();
                var validator = form.data('bootstrapValidator');
                validator.resetForm(true);*/
                $("#add_card_name").val("");
                $("[name='price']").val("");
                $("[name='percentage']").val("");
                $("[name='introduction']").val("");
                $("#form_add").data('bootstrapValidator').destroy();
                $('#form_add').data('bootstrapValidator',null);
                bv();

                //    返回第一页
                my_page = 1;
            }
        })
    });

    // -----------------------------------------------------------------------------

    //修改优惠卡里的项目
    //对下拉框进行设置
    //div    id  dropdown-1   （点击时需要） √
    //ul     id  dropdownMenu-1（模态框需要）  √
    //span   id  dropdownMenu-1_inner（动态生成数据需要）√
    //input  id  add_choice_input-1  （表单收集用）√
    var cnt = 1;
    //对下拉框里的数据进行展示
    $.ajax({
        url: "http://106.14.125.136/acc//project/simple/list",
        type: "get",
        success: function (info) {
            console.log(info);

            var htmlstr = template("DpD", info);
            $("#dropdownMenu-"+cnt).html(htmlstr);
        }
    });

    //修改优惠卡项目模态框展示
    var my_id;
    $(".list_table").on("click", ".change_cardPro", function () {
        //获取用户id
        my_id = $(this).parent().data("id");
        console.log($(this).parent().data("id"));
        var $th = $(this);
        $(this).confirm({
            title: '修改优惠卡项目',
            content: '若此卡已被客户办理，则不会改变客户原先享受的服务！修改项目不会在原项目上叠加，请谨慎修改！',
            buttons: {
                '确认': {
                    btnClass: 'btn-primary',
                    action:function () {
                        var my_len = $th.parent().prev().prev().prev().prev().prev().prev().prev().children("ul").data("id");
                        var $here = $th.parent().prev().prev().prev().prev().prev().prev().prev().children("ul").children("li");
                        console.log($here.eq(0).data("id"));
                        if($here.eq(1).data("id")){
                            $("#add_choice_input-1").val($here.eq(0).data("id"));
                            $("#times-1").val($here.eq(2).data("id"));
                            $("#dropdownMenu-1_inner").text($here.eq(1).data("id"));
                            var j = 4;
                            for(var i = 2; i <= my_len; i++){
                                add();
                                $("#add_choice_input-"+i).val($here.eq(j).data("id"));
                                $("#dropdownMenu-"+i+"_inner").text($here.eq(++j).data("id"));
                                $("#times-"+i).val($here.eq(++j).data("id"));
                                j++;
                            }
                        }

                        $("#myModal_changeCardPro").modal({
                            show: true
                        })
                    }
                },
                '取消': {
                    btnClass: 'btn-primary'
                }
            }
        });
    });
    //增加项目
    $("#addPro_btn").on('click', function (e) {
        add();
    });
    function add(){
        cnt++;
        var tb1 = $("#dictTbl");
        var tempRow = $("#dictTbl tr").size();
        //编号
        var $tdNum = $("<td></td>");
        $tdNum.html(tempRow);

        //项目id
        //div    id  dropdown-1   （点击时需要） √  √
        //ul     id  dropdownMenu-1（模态框需要）  √  √
        //span   id  dropdownMenu-1_inner（动态生成数据需要）√ √
        //input  id  add_choice_input-1  （表单收集用）√  √

        /*
        * <td><div class="form-group" style="margin-bottom: 10px"><div class="dropdown" id="dropdown-1"><button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><span id="dropdownMenu-1_inner">项目</span><span class="caret"></span></button><ul class="dropdown-menu" aria-labelledby="dropdownMenu1" id="dropdownMenu-1"></ul></div><input type="hidden" name="projectId" id="add_choice_input-1"></div></td>*/
        var $tdID = $("<td><div class='form-group' style='margin-bottom: 10px'>" +
            "<div class='dropdown' id='"+tempRow+"'><button class='btn btn-default dropdown-toggle' type='button' data-toggle='dropdown'><span id='dropdownMenu-"+tempRow+"_inner'>项目</span>" +
            "<span class='caret'></span></button><ul class='dropdown-menu' aria-labelledby='dropdownMenu1' id='dropdownMenu-"+tempRow+"'></ul></div>" +
            "<input type='hidden' name='projectId' id='add_choice_input-"+tempRow+"'></div></td>");
        $.ajax({
            url: "http://106.14.125.136/acc//project/simple/list",
            type: "get",
            success: function (info) {
                console.log(info);
                if(!info.success){
                    $.alert(info.msg);
                }

                var htmlstr = template("DpD", info);
                $("#dropdownMenu-"+cnt).html(htmlstr);
            }
        });

        //项目次数
        var $tdTimes = $("<td><div class='form-group'></div></td>");
        $tdTimes.html("<input type='text' class='form-control' placeholder='请输入项目次数'" +
            " id='times-"+tempRow+"' name='Times-"+tempRow+"'>");

        //添加
        var $tr = $("<tr></tr>");
        $tr.append($tdNum);
        $tr.append($tdID);
        $tr.append($tdTimes);
        tb1.append($tr);
        $(".dropdown").on("click", ".dropdown-menu li a", function () {
            var len = $(this).parents(".dropdown").attr("id");
            console.log(len);
            $("#add_choice_input-"+len).val($(this).data("id"));
            console.log($(this).data("id"));
            console.log("需要的 val = "+ $("#add_choice_input-"+len).val());
            //$("#form_changeCardPro").data('bootstrapValidator').updateStatus('projectId', 'VALID', null);
            var showN = $(this).html();
            console.log(showN);
            $("#dropdownMenu-"+len+"_inner").text(showN);
        });
    }
    //对选择框中的隐藏表单进行实时更新
    $(".dropdown").on("click", ".dropdown-menu li a", function () {
        var len = $(this).parents(".dropdown").attr("id");
        console.log(len);
        $("#add_choice_input-"+len).val($(this).data("id"));
        console.log($(this).data("id"));
        console.log("需要的 val = "+ $("#add_choice_input-"+len).val());
        //$("#form_changeCardPro").data('bootstrapValidator').updateStatus('projectId', 'VALID', null);
        var showN = $(this).html();
        console.log(showN);
        $("#dropdownMenu-"+len+"_inner").text(showN);
    });

    //删除项目
    $("#delPro_btn").on('click', function (e) {
        dele();
    });
    function dele(){
        cnt--;
        $("#dictTbl tr:not(:first):not(:first):last").remove();//移除最后一行,并且保留之前的
    }

    //取消提交时
    $(".delcnt").on('click', function () {
        //    清除表中的内容
        $("[name='Times-1']").val("");
        var l = cnt;
        while(l != 1){
            dele();
            l--;
        }
        cnt = 1;

        //调整选择栏内容
        $("#dropdownMenu-1_inner").html("项目");
    });

    //数据处理及提交
    $("#changeCardPro_submit_btn").on('click', function (e) {
        e.preventDefault();

        //生成需求的对象
        var form_carId = my_id;
        var len = $("#dictTbl tr").size();
        var form_proDetails = new Array(len-1);
        for(var i = 0; i < len - 1; i++){
            form_proDetails[i] = new Object();
            form_proDetails[i].projectId = $("#add_choice_input-"+(i+1)).val();
            form_proDetails[i].times = $("#times-" + (i+1)).val();
        }

        obj = {
            cardId: form_carId,
            proDetails: form_proDetails
        };
        console.log(obj);
        json_str = JSON.stringify(obj);

        console.log(json_str);

        //使用ajax提交逻辑
        $.ajax({
            contentType: 'application/json',
            url: "http://106.14.125.136/acc/card/edit_pro",
            type: "put",
            dataType: "json",
            data: json_str,

            success: function (info) {
                console.log(info);
                if(!info.success){
                    $.alert(info.msg);
                }
                my_page = 1;
                render();
                //添加模态框隐藏
                $('#myModal_changeCardPro').modal('hide');
                //    清除表中的内容
                $("[name='Times-1']").val("");
                var l = cnt;
                while(l != 1){
                    dele();
                    l--;
                }
                cnt = 1;

                //调整选择栏内容
                $("#dropdownMenu-1_inner").html("项目");
                //    返回第一页
                my_page = 1;
            }
        })

    });
//---------------------------------------------------------------------------

    //删除优惠卡
    $(".list_table").on("click", ".btn_delete", function () {
        my_id = $(this).parent().data("id");
        function del() {
            console.log($(this).parent().data("id"));
            $.ajax({
                contentType: 'application/json',
                url: "http://106.14.125.136/acc/card/del/" + my_id,
                type: "delete",

                success: function (info) {
                    if(!info.success){
                        $.alert(info.msg);
                    }else{
                        console.log(info);
                        my_page = 1;
                        render();
                        $.alert('删除成功');
                    }
                }
            });
        }
        $(".btn_delete").confirm({
            title: '删除优惠卡',
            content: '是否删除优惠卡？',
            buttons: {
                '确认': {
                    btnClass: 'btn-danger',
                    action:function () {
                        del();

                    }
                },
                '取消': {
                    btnClass: 'btn-primary'
                }
            }
        });
    });

//----------------------------------------------------------------------------------

    //解冻或冻结优惠卡
    $(".list_table").on("click", ".btn_freeze", function () {
        my_id = $(this).parent().data("id");
        console.log($(this).parent().data("id"));
        $.ajax({
            contentType: 'application/json',
            url: "http://106.14.125.136/acc/card/freeze/" + my_id,
            type: "post",

            success: function (info) {
                console.log(info);
                if(!info.success){
                    $.alert(info.msg);
                }
                my_page = 1;
                render();
            }
        })
    });
//----------------------------------------------------------------------------------

    /*
    * id: my_id,
                name: form_Name,
                price: form_Price,
                percentage: form_Percentage,
                startTime: form_StartTime,
                endTime: form_EndTime,
                introduction: form_Introduction*/
    //修改优惠卡
    $(".list_table").on("click", ".change_card", function () {
        //获取用户id
        my_id = $(this).parent().data("id");
        console.log($(this).parent().data("id"));

        //简介
        form_Introduction = $(this).parent().prev().prev().data("id");
        console.log($(this).parent().prev().prev().data("id"));
        $("#form_changeCard .modal-body [name='Introduction']").val(form_Introduction);

        //提成
        form_Percentage = $(this).parent().prev().prev().prev().prev().prev().data("id");
        console.log(form_Percentage);
        $("#form_changeCard .modal-body [name='Percentage']").val(form_Percentage);

        //金额
        form_Price = $(this).parent().prev().prev().prev().prev().prev().prev().data("id");
        console.log(form_Price);
        $("#form_changeCard .modal-body [name='Price']").val(form_Price);

        //名称
        form_Name = $(this).parent().prev().prev().prev().prev().prev().prev().prev().prev().data("id");
        console.log(form_Name);
        $("#form_changeCard .modal-body [name='Name']").val(form_Name);

        $('#myModal_changeCard').modal({
            show: true
        });

        //起始时间
        form_StartTime = $(this).parent().prev().prev().prev().prev().data("id");
        console.log(form_StartTime);
        $("#form_changeCard .modal-body [name='startTime']").val(form_StartTime);

        //结束事件
        form_EndTime = $(this).parent().prev().prev().prev().data("id");
        console.log(form_EndTime);
        $("#form_changeCard .modal-body [name='endTime']").val(form_EndTime);

    });
    var form_StartTime;
    var form_EndTime;
    //对插入表单进行验证
    //起始时间及结束时间组件
    laydate.render({
        elem: '#change_card_startTime'
        ,type: 'datetime'
        ,format: 'yyyy-MM-dd HH:mm:ss'
        ,value: '2019-11-10 00:00:00'
        ,max: '2099-11-10 00:00:00'
        ,theme: '#A8A8A8'
        ,done: function(value, date, endDate){
            console.log(value); //得到日期生成的值，如：2017-08-18
            form_StartTime = value;
        }
    });
    laydate.render({
        elem: '#change_card_endTime'
        ,type: 'datetime'
        ,format: 'yyyy-MM-dd HH:mm:ss'
        ,value: '2019-11-10 00:00:00'
        ,max: '2099-11-10 00:00:00'
        ,theme: '#A8A8A8'
        ,done: function(value, date, endDate){
            console.log(value); //得到日期生成的值，如：2017-08-18
            form_EndTime = value;
        }
    });
    var form_01 = $("#form_changeCard");
    function bv1(){
        form_01.bootstrapValidator({
            excluded: [],
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },

            //2. 指定校验字段
            fields: {
                //校验用户名，对应表单的name属性
                Name: {
                    validators: {
                        //不能为空
                        notEmpty: {
                            message: '优惠卡类型不能为空'
                        }
                    }
                },
                Price: {
                    validators: {
                        //不能为空
                        notEmpty: {
                            message: '优惠卡金额不能为空'
                        }
                    }
                },

                Percentage: {
                    validators: {
                        //不能为空
                        notEmpty: {
                            message: '提成不能为空'
                        }
                    }
                },

                Introduction: {
                    validators: {
                        //不能为空
                        notEmpty: {
                            message: '介绍不能为空'
                        }
                    }
                }
            }
        });
    }
    bv1();

    var form_Name;
    var form_Price;
    var form_Percentage;
    var form_Introduction;
    //提交数据
    form_01.on('success.form.bv', function (e) {
        e.preventDefault();

        //生成需求的对象
        form_Name = $("#change_card_name").val();
        form_Price = $("[name='Price']").val();
        form_Percentage = $("[name='Percentage']").val();
        form_Introduction = $("[name='Introduction']").val();
        obj = {
            id: my_id,
            name: form_Name,
            price: form_Price,
            percentage: form_Percentage,
            startTime: form_StartTime,
            endTime: form_EndTime,
            introduction: form_Introduction
        };
        console.log(form_Name);
        json_str = JSON.stringify(obj);


        //使用ajax提交逻辑
        $.ajax({
            beforeSend: function (jqXHR, options) {
                jqXHR.setRequestHeader("content-Type", "application/json");  // 增加一个自定义请求头
            },

            processData: false,
            url: "http://106.14.125.136/acc/card/edit?id=" + my_id,
            type: "put",
            dataType: "json",
            data: json_str,
            success: function (info) {
                console.log(info);
                if(!info.success){
                    $.alert(info.msg);
                }
                my_page = 1;
                render();
                //添加模态框隐藏
                $('#myModal_changeCard').modal('hide');
                //    清除表中的内容
                //    清除表中的内容
                /*form[0].reset();
                var validator = form.data('bootstrapValidator');
                validator.resetForm(true);*/
                $("#change_card_name").val("");
                $("[name='Price']").val("");
                $("[name='Percentage']").val("");
                $("[name='Introduction']").val("");
                $("#form_changeCard").data('bootstrapValidator').destroy();
                $('#form_changeCard').data('bootstrapValidator',null);
                bv1();

                //    返回第一页
                my_page = 1;
            }
        })
    });


//--------------------------------------------------------------------------------------
    //搜索优惠卡

    //项目搜索
    //对下拉框里的数据进行展示
    $.ajax({
        url: "http://106.14.125.136/acc//project/simple/list",
        type: "get",
        success: function (info) {
            console.log(info);
            if(!info.success){
                alert(info.msg);
            }

            var htmlstr = template("SpD", info);
            $("#dropdownMenu").html(htmlstr);
        }
    });
    var my_proID="";
    //对选择框中的隐藏表单进行实时更新
    $("#search_dropdown").on("click", ".dropdown-menu li a", function () {
        my_proID=null;
        $("#search_choice_input").val($(this).data("id"));
        my_proID=$(this).data("id");
        console.log("搜索到的卡id为："+my_proID);
        //$("#form_changeCardPro").data('bootstrapValidator').updateStatus('projectId', 'VALID', null);
        var showN = $(this).html();
        console.log(showN);
        $("#dropdownMenu_inner").text(showN);
    });

    //状态
    var my_status="#";
    $("#search_status_dropdown").on("click", ".dropdown-menu li a", function () {
        $("#search_status_input").val($(this).data("id"));
        my_status=$(this).data("id");
        console.log("搜索到的卡状态为："+my_status);
        //$("#form_changeCardPro").data('bootstrapValidator').updateStatus('projectId', 'VALID', null);
        var showN = $(this).html();
        console.log(showN);
        $("#dropdownMenu_status_inner").text(showN);
    });

    //开始时间
    var my_startTime="";
    laydate.render({
        elem: '#search_startTime'
        ,type: 'datetime'
        ,format: 'yyyy-MM-dd HH:mm:ss'
        ,max: '2099-11-10 00:00:00'
        ,theme: '#A8A8A8'
        ,ready: function(date){
            console.log(date);
            my_startTime = date; //得到初始的日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
        }
        ,done: function(value, date, endDate){
            console.log(value); //得到日期生成的值，如：2017-08-18
            my_startTime = value;
        }
    });
    //结束时间
    var my_endTime="";
    laydate.render({
        elem: '#search_endTime'
        ,type: 'datetime'
        ,format: 'yyyy-MM-dd HH:mm:ss'
        ,max: '2099-11-10 00:00:00'
        ,theme: '#A8A8A8'
        ,ready: function(date){
            console.log(date);
            my_endTime = date; //得到初始的日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
        }
        ,done: function(value, date, endDate){
            console.log(value); //得到日期生成的值，如：2017-08-18
            my_endTime = value;
        }
    });

    $("#search_byId_btn").click(function () {
        var my_name = "";
        my_name = $("#search_byName").val();
        var str='?';
        var last;

        if(my_proID != '' && my_proID != '1000000'){
            str += "projectId=" + my_proID;
        }

        last = str[str.length - 1];
        if(last != '?' && my_status != "#" && my_status != 2){
            str += "&status=" + my_status;
        }
        if(last == '?' && my_status != "#" && my_status != 2){
            str += "status=" + my_status;
        }

        last = str[str.length - 1];
        if(last != '?' && my_startTime != ''){
            str += "&startTime=" + my_startTime;
        }
        if(last == '?' && my_startTime != ''){
            str += "startTime=" + my_startTime;
        }

        last = str[str.length - 1];
        if(last != '?' && my_endTime != ''){
            str += "&endTime=" + my_endTime;
        }
        if(last == '?' && my_endTime != ''){
            str += "endTime=" + my_endTime;
        }

        last = str[str.length - 1];
        if(last != '?' && my_name != ''){
            str += "&name=" + my_name;
        }
        if(last == '?' && my_name != ''){
            str += "name=" + my_name;
        }

        console.log(str);
        my_page = 1;
        $.ajax({
            url: "http://106.14.125.136/acc/card" + str,
            type: "get",
            data: {
                current: my_page + "",
                size: my_pagesize + ""
            },

            success: function (info) {
                $("#search_byId").val("");
                console.log(info);
                if(!info.data){
                    $.alert('未搜索到相应的卡！');
                }
                else if(!info.data.records.length){
                    $.alert('未搜索到相应的卡！');
                }
                else{
                    var htmlstr = template("tql", info);
                    $(".list_table").html(htmlstr);
                    inform_total = info.data.total;
                    my_page = 1;


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

                    /*my_startTime='';
                    my_proID='';
                    my_endTime='';
                    my_status='#';
                    my_name = "";*/
                }

            }
        })
    });


});