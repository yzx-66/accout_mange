// 消费类型和支付类型接口数字转换
let exchange_fun = function(info) {
	let length = info.data.records.length;
	for (let i = 0; i < length; ++i) {
		//console.log(info.data.records[i].consumType);
		let consum_type = info.data.records[i].consumType;
		switch (consum_type){
			case 1:
				info.data.records[i].consumType = "收费项目";
				break;
			case 2:
				info.data.records[i].consumType = "办卡";
				break;
			case 3:
				info.data.records[i].consumType = "充值余额";
				break;
			case 4:
				info.data.records[i].consumType = "给卡的项目充值次数";
				break;
			case 5:
				info.data.records[i].consumType = "退还余额";
				break;
			case 6:
				info.data.records[i].consumType = "退卡";
				break;
			default:
				console.log("消费类型数据有误");
				break;
		}
		let pay_type = info.data.records[i].payType;
		switch (pay_type){
			case 0:
				info.data.records[i].payType = "给顾客退钱";
				break;
			case 1:
				info.data.records[i].payType = "从卡里扣除项目次数";
				break;
			case 2:
				info.data.records[i].payType = "从余额中扣除";
				break;
			case 3:
				info.data.records[i].payType = "花钱支付";
				break;
			default:
				console.log("支付类型数据有误");
				break;
		}
		//console.log(info.data.records[i].consumType);
	}
};

let exchange_fun2 = function(str) {
	let ret = -1;
	switch (str){
		case "收费项目":
			ret = 1;
			break;
		case "办卡":
			ret = 2;
			break;
		case "充值余额":
			ret = 3;
			break;
		case "给卡的项目充值次数":
			ret = 4;
			break;
		case "退还余额":
			ret = 5;
			break;
		case "退卡":
			ret = 6;
			break;
		case "给顾客退钱":
			ret = 0;
			break;
		case "从卡里扣除项目次数":
			ret = 1;
			break;
		case "从余额中扣除":
			ret = 2;
			break;
		case "花钱支付":
			ret = 3;
			break;
		default:
			console.log("数据有误");
			break;
	}
	return ret;
};

// 将员工姓名转换为员工id以便传回后台
let staff_name_to_id = function(name) {
	let id = -1;
	$.ajax({
		url: "http://localhost/api/staff/list",
		type: "GET",
		dataType:"json",
		data: {},
		success: function(info) {
			let length = info.data.length;
			for (let i = 0; i < length; ++i) {
				if (info.data[i].name === name) {
					id = info.data[i].id;
					break;
				}
			}
		}
	});
	return id;
};

// 将顾客姓名转换为员工id以便传回后台
let customer_name_to_id = function(name) {
	let id = -1;
	$.ajax({
		url: "http://localhost/api/customer/list",
		type: "GET",
		dataType:"json",
		data: {},
		success: function(info) {
			let length = info.data.records.length;
			for (let i = 0; i < length; ++i) {
				console.log(info.data.records[i]);
				console.log(info.data.records[i].name);
				console.log(name);
				if (info.data.records[i].name === name) {
					id = info.data.records[i].id;
					console.log(info.data.records[i].id);
					break;
				}
			}
		}
	});
	return id;
};

// 分页功能
let my_page = 1;
let my_pagesize = 8;
let inform_total;
let render = function() {
	$.ajax({
		url: "http://localhost/api/consum/list",
		type: "GET",
		dataType:"json",
		data: {
			current: my_page + "",
			size: my_pagesize + "",
		},
		success: function (info) {
			exchange_fun(info);
			let htmlstr = template("consum-list", info);
			$(".list_table").html(htmlstr);
			inform_total = info.data.total;
			//分页功能
			$("#page_classify").bootstrapPaginator({
				bootstrapMajorVersion: 3,//默认是2，如果是bootstrap3版本，这个参数必填
				currentPage: my_page,//当前页
				totalPages: Math.ceil(inform_total / my_pagesize),//总页数
				size: "small",//设置控件的大小，mini, small, normal,large
				onPageClicked: function(event, originalEvent, type, page) {
					my_page = page;
					render();
				}
			});
		}
	});
};
render();

// 根据顾客姓名搜索
let search_by_name = function() {
	let customer_name = $('#search_name').val();
	let search_by_name_render = function() {	
		$.ajax({
			url: "http://localhost/api/consum",
			type: "GET",
			data: {
				customerId: parseInt(customer_name_to_id(customer_name)),
				current: my_page + "",
				size:8 + "",
			},
			success: function (info) {
				//console.log(info);
				exchange_fun(info);
				let htmlstr = template("consum-list", info);
				$(".list_table").html(htmlstr);
				inform_total = info.data.total;
				$("#search_name").val("");
				$("#page_classify").bootstrapPaginator({
					bootstrapMajorVersion: 3,//默认是2，如果是bootstrap3版本，这个参数必填
					currentPage: my_page,//当前页
					totalPages: Math.ceil(inform_total / my_pagesize),//总页数
					size: "small",//设置控件的大小，mini, small, normal,large
					onPageClicked: function (event, originalEvent, type, page) {
						my_page = page;
						search_by_name_render();
					}
				});
			}
		});
	};
	my_page = 1;
	search_by_name_render();
};

// 根据支付时间搜索
let search_by_time = function() {
	let pay_time = $('#search_time').val();
	let search_by_time_render = function() {
		$.ajax({
			url: "http://localhost/api/consum",
			type: "GET",
			data: {
				current: my_page + "",
				size:8 + "",
			},
			success: function (info) {
				exchange_fun(info);
				let htmlstr = template("consum-list", info);
				$(".list_table").html(htmlstr);
				inform_total = info.data.total;
				$("#search_time").val("");
				$("#page_classify").bootstrapPaginator({
					bootstrapMajorVersion: 3,//默认是2，如果是bootstrap3版本，这个参数必填
					currentPage: my_page,//当前页
					totalPages: Math.ceil(inform_total / my_pagesize),//总页数
					size: "small",//设置控件的大小，mini, small, normal,large
					onPageClicked: function (event, originalEvent, type, page) {
						my_page = page;
						search_by_time_render();
					}
				});
			}
		});
	};
	my_page = 1;
	search_by_time_render();
};

// 清空输入
let clear_input = function() {
	$('#add_consum_type').val("");
	$('#add_pay_type').val("");
	$('#add_price').val("");
	$('#add_staff_name').val("");
	$('#change_customer_phone').val("");
	$('#change_consum_type').val("");
	$('#change_pay_type').val("");
	$('#change_price').val("");
	$('#change_staff_name').val("");
	$('#change_remark').val("");
};

// 获取员工姓名
let get_staff_name = function() {
	let add_staff_name_select = $('#add_staff_name');
	$.ajax({
		url: "http://localhost/api/staff/list",
		type: "GET",
		dataType:"json",
		data: {},
		success: function(info) {
			//console.log(info.data);
			let length = info.data.length;
			for (let i = 0; i < length; ++i) {
				let htmlstr = template("staff-name-add", info.data[i]);
				add_staff_name_select.append(htmlstr);
			}
		}
	});
};

//模态框动态验证 添加
$('#form_add_consum_record').bootstrapValidator({
	message: 'This value is not valid',
	feedbackIcons: {
		valid: 'glyphicon glyphicon-ok',
		invalid: 'glyphicon glyphicon-remove',
		validating: 'glyphicon glyphicon-refresh'
	},
	fields: {
		add_staff_name: {
			validators: {
				notEmpty: {
					message: '请选择用户'
				}
			}
		},
		add_consum_type: {
			validators: {
				notEmpty: {
					message: '请选择消费类型'
				}
			}
		},
		add_pay_type: {
			validators: {
				notEmpty: {
					message: '请选择支付类型'
				}
			}
		},
		add_price: {
			validators: {
				between: {
					min: 0,
					max: 9999,
					message: '价格不能为负值'
				},
				notEmpty: {
					message: '价格不能为空'
				}
			}
		},
	}
});

// 添加消费记录
let add_consum_record_fun = function() {
	let addConsumType = $('#add_consum_type').val(),
		addPayType = $('#add_pay_type').val(),
		addStaffName = $('#add_staff_name').val();
	if (addConsumType === "" || addPayType === "" || addStaffName === "") {
		alert("请将信息填完整");
		return;
	}
	$.ajax({
		url: "http://localhost/api/consum/add",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({
			payType: addPayType,
			consumType: addConsumType,
			staffId: staff_name_to_id(addStaffName),
		}),
		success: function(info) {
			console.log("添加消费记录：" + JSON.stringify(info));
			alert("添加消费记录：" + JSON.stringify(info.msg));
			exchange_fun(JSON.stringify(info));
			let htmlstr = template("consum-list", info);
			$(".list_table").append(htmlstr);
			inform_total = info.total;
			clear_input();
			$("#page_classify").bootstrapPaginator({
			    bootstrapMajorVersion: 3,//默认是2，如果是bootstrap3版本，这个参数必填
			    currentPage: my_page,//当前页
			    totalPages: Math.ceil(inform_total / my_pagesize),//总页数
			    size: "small",//设置控件的大小，mini, small, normal,large
			    onPageClicked: function (event, originalEvent, type, page) {
			        my_page = page;
			    }
			});
			render();
		},
		error: function(textStatus) {
			console.log(textStatus.responseText);
			alert("添加消费记录失败");
		}
	});
	render();
};

// 删除消费记录
let deleteId;
let getDeleteId = function(obj) {
	deleteId = $(obj).parent().parent().children("#delete-id").text();
}
let delete_consum_record_fun = function() {
	$.ajax({
		url: "http://localhost/api/consum/del/" + deleteId,
		type: "DELETE",
		contentType: "application/json",
		success: function (info) {
			console.log("删除消费记录：" + JSON.stringify(info.msg));
			alert("删除消费记录：" + JSON.stringify(info.msg));
			render();
		},
		error: function(textStatus) {
			console.log(textStatus.responseText);
			alert("删除消费记录失败");
		}
	});
	render();
};

// 获取消费记录id
let consumId = -1;
let getConsumId = function(obj) {
	consumId = $(obj).parent().parent().children('#hide-id').text();
};

// 修改界面填充数据
let prepare_change_data = function(obj) {
	let changeConsumType = $('#change_consum_type option'),
		changeCustomerName = $('#change_customer_name'),
		changePayType = $('#change_pay_type option'),
		changePrice = $('#change_price'),
		changeStaffName = $('#change_staff_name'),
		changeRemark = $('#change_remark'),
		par = $(obj).parent().parent();
	$(changeConsumType)[exchange_fun2(par.children('#consum-type').text()) - 1].selected = "selected";
	changeCustomerName.val(par.children("#customer-name").text());
	$(changePayType)[exchange_fun2(par.children('#pay-type').text())].selected = "selected";
	changePrice.val(par.children("#price").text());
	changeStaffName.val(par.children("#staff-name").text());
	changeRemark.val(par.children("#remark").text());
	getConsumId(obj);
	console.log(consumId);
};

// 修改消费记录
let change_consum_record_fun = function() {
	let changeConsumType = $('#change_consum_type').val(),
		changePayType = $('#change_pay_type').val(),
		changePrice = $('#change_price').val(),
		changeStaffName = $('#change_staff_name').val(),
		changeRemark = $('#change_remark').val();
	$.ajax({
		url: "http://localhost/api/consum/edit/" + consumId,
		type: "PUT",
		contentType: "application/json",
		data: JSON.stringify({
			consumType: changeConsumType,
			payType: changePayType,
			price: changePrice,
			staffId: staff_name_to_id(changeStaffName),
			remark: changeRemark,
		}),
		success: function(info) {
			console.log(info);
			console.log("修改消费记录：" + JSON.stringify(info.msg));
			alert("修改消费记录：" + JSON.stringify(info.msg));
			clear_input();
			render();
		},
		error: function(textStatus) {
			console.log(textStatus.responseText);
			alert("修改消费记录失败");
		}
	});
	render();
};




