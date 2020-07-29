

$(function(){

    //对数据内容进行渲染
    var my_page = 1;
    var my_pagesize = 8;
    var inform_total;

    var render = function () {

        $.ajax({
            url: "http://localhost/api/project/list",
            type: "get",
            data: {
                current: my_page + "",
                size: my_pagesize + ""
            },
            success: function (info) {
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

// ----------------------------------------------------------------------

    
    //添加模态框显示
    $("#add_btn").click(function () {

        $('#myModal_add').modal({
            show: true
        });
    });
	
	
    //对插入表单进行验证
	
    var form = $("#form_add");
	
	
    form.bootstrapValidator({
        excluded: [],
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },

        //2. 指定校验字段
        fields: {
            
            name: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '项目名称不能为空'
                    }
                }
            },
            price: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '项目价格不能为空'
                    }
                }
            },

            percentage: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '项目提成不能为空'
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
	
	
   
   

   
    //提交数据
    $("#submit_btn").on('click', function (e) {
        e.preventDefault();

        //生成需求的对象
        var form_name = $("#add_project_name").val();
        var form_price = $("[name='price']").val();
        var form_percentage = $("[name='percentage']").val();
        var form_introduction = $("[name='introduction']").val();
      
	   
	   //包装数据
        obj = {
			id: 11,
            name: form_name,
            price: form_price,
            percentage: form_percentage,
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
			contentType: 'application/json',
            url: "http://localhost/api/project/add",
			
            type: "post",
            dataType: "json",
            data: json_str,
            success: function (info) {
                console.log(info);
				console.log(alert("添加成功！"));
                my_page = 1;
                render();
                //添加模态框隐藏
                $('#myModal_add').modal('hide');
                //    清除表中的内容
                var validator = form.data('bootstrapValidator');
                validator.resetForm(true);
                //    返回第一页
                my_page = 1;
            }
        })
    });

   
//---------------------------------------------------------------------------

    //删除项目
    $(".list_table").on("click", ".btn_delete", function () {
		
		//添加一个是否确认删除的选择，防手滑 哈哈哈哈
		var judge=confirm("确定删除吗？");
		if(judge==true )
		{
			 my_id = $(this).parent().data("id");
        console.log($(this).parent().data("id"));
        $.ajax({
            contentType: 'application/json',
            url: "http://localhost/api/project/del/" + my_id,
            type: "delete",

            success: function (info) {
				if(info.msg!="成功")
				alert(info.msg);
                console.log(info);
                my_page = 1;
                render();
            },
			
			 error:function(info){
				 alert(info.msg);
			 },
			 })
		}
		
       else if(judge==false)
	   {
		   alert("删除失败！");
	   }
        
    });
//----------------------------------------------------------------------------------

    //修改项目
    var my_num;
    $(".list_table").on("click", ".change_project", function () {
        //获取用户id
        my_id = $(this).parent().data("id");
        my_num = $(this).data("num");
        console.log($(this).parent().data("id"));
        console.log(my_id);

        $('#myModal_changeproject').modal({
            show: true
        });

        

        $.ajax({
            url: "http://localhost/api/project/list",
            type: "get",
            data: {
                current: my_page + "",
                size: my_pagesize + ""
            },
            success: function (info) {
                
                console.log(info.data.records[my_num]);
                var value=info.data.records[my_num];
                $("#lfd_add_project_name").val(value.name);
                $("#lfd_price").val(value.price);
                $("#lfd_add").val(value.percentage);
                $("#lfd_intro").val(value.introduction);
            }
        })

    });
    //对插入表单进行验证
    var form = $("#form_changeproject");
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
            Name: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '项目名称不能为空'
                    }
                }
            },
            Price: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '项目价格不能为空'
                    }
                }
            },

            Percentage: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '项目提成不能为空'
                    }
                }
            },

            Introduction: {
                validators: {
                    //不能为空
                    notEmpty: {
                        message: '项目介绍不能为空'
                    }
                }
            }
        }
    });

    //提交数据
    form.on('success.form.bv', function (e) {
        e.preventDefault();

        //生成需求的对象
        var form_Name = $("#lfd_add_project_name").val();
        var form_Price = $("#lfd_price").val();
        var form_Percentage = $("#lfd_add").val();
        var form_Introduction = $("#lfd_intro").val();
		
        obj = {
            id: my_id,
            name: form_Name,
            price: form_Price,
            percentage: form_Percentage,
			
            introduction: form_Introduction
        };
        json_str = JSON.stringify(obj);

console.log(json_str);
        //使用ajax提交逻辑
        $.ajax({
            beforeSend: function (jqXHR, options) {
                jqXHR.setRequestHeader("content-Type", "application/json");  // 增加一个自定义请求头
            },

            processData: false,
            url: "http://localhost/api/project/edit?id=" + my_id,
            type: "put",
            dataType: "json",
            data: json_str,
            success: function (info) {
                console.log(info);
                my_page = 1;
                render();
                //添加模态框隐藏
                $('#myModal_changeproject').modal('hide');
                //    清除表中的内容
                var validator = form.data('bootstrapValidator');
                validator.resetForm(true);
                //    返回第一页
                my_page = 1;
            }
        })
    });


//--------------------------------------------------------------------------------------


//    冻结解冻项目
    $(".list_table").on("click", ".btn_change", function () {
        my_id = $(this).parent().data("id");
        $.ajax({
            contentType: 'application/json',
            url: "http://localhost/api/project/freeze/" + my_id,
            type: "post",
            success: function (info) {
                console.log(info);
                render();
            }
        })
    });



    //返回上层
    $(".list_table").on("click", ".back_btn", function () {
        console.log("1");
        location.reload();
    });


});

