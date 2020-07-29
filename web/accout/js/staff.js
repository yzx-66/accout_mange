// refresh方法大大的影响了用户的体验但未找到更好的替代方法
// window.location.href = "staff.html";使用实在为下下策 但是有没有更好的方法 想要实现象在hbuildx中打开一样能够动态变化且不会影响内容
//界面大小控制 能不能根据父div来进行显示的子div固定
//表格显示左部分



// 设置后台需要的参数直接将返回值 进行遍历显示
function set_data(url, url_status) {

	var urll = "http://localhost/api";

	// 删除staff_body_ul_js中所有li(不消失的除外)
	$("#staff_body_ul_js").find(".body_main_li_css_js").remove();
	$("#staff_body_ul_js").find(".body_main_li_css_js_fren").remove();

	// ajax请求获取数据 并对获取数据进行处理 在其中进行显示出来
	$.ajax({
		type: 'get',

		url: url,

		success: function(result) {

			var data = result.data.records;
			var new_data_array = new Array(5);

			for (i = 0; i < data.length; i++) {
				var new_data_li = document.createElement("li");
				new_data_li.id = "li_data" + data[i].id;

				// 判断给与什么样的class
				if (data[i].status != 0) {
					new_data_li.className = "body_main_li_css_js";
				} else {
					new_data_li.className = "body_main_li_css_js_fren";
				}

				// 判断是否显示冻结
				if (url_status == "false" && data[i].status == 0) {
					new_data_li.className = "body_main_li_css_js_fren unava";
				} else if (url_status == "fren" && data[i].status != 0) {
					new_data_li.className = "body_main_li_css_js unava";
				}

				// 创建并显示
				document.getElementById("staff_body_ul_js").appendChild(new_data_li);
				for (var t = 0; t < new_data_array.length; t++) {

					new_data_array[t] = document.createElement("div");

					switch (t) {
						case 0:
							new_data_array[t].innerHTML = data[i].id;
							new_data_array[t].className = "body_main_li_first_css_js unava";
							break;
						case 1:
							new_data_array[t].innerHTML = data[i].name;
							new_data_array[t].className = "body_main_li_second_css_js";
							break;
						case 2:
							if (data[i].sex == 1) {
								new_data_array[t].innerHTML = "男";
							} else {
								new_data_array[t].innerHTML = "女";
							}
							new_data_array[t].className = "body_main_li_third_css_js";
							break;
						case 3:
							new_data_array[t].innerHTML = data[i].phone;
							new_data_array[t].className = "body_main_li_forth_css_js";
							break;
						case 4:
							if (data[i].entryTime) {
								data[i].entryTime = data[i].entryTime.slice(0, 11);
								new_data_array[t].innerHTML = data[i].entryTime;
							}
							new_data_array[t].className = "body_main_li_fifth_css_js";
							break;
					}
					document.getElementById("li_data" + data[i].id).appendChild(new_data_array[t]);
				}

				// 点击操作
				document.getElementById("li_data" + data[i].id).onclick = function() {
					id = $(this).find(".body_main_li_first_css_js").text();
					set_xiangxi_data(urll + '/user/u_r/' + id);
					// 控制div变色的操作
					id_name = document.getElementById("body_main_right_xiangxi");
					if (id_name.classList.contains('body_main_right_xiangxi')) {
						id_name.className = 'body_main_right_xiangxi_next';
					} else {
						id_name.className = 'body_main_right_xiangxi';
					}
				}
			}
		},
	})
}

// 根据两个下拉框的变化与值的不同执行的方法
function set_data_get_url() {

	var urll = "http://localhost/api";

	var value_roleId = $("#body_main_left_top_select_roleId").val();
	var value_status = $("#body_main_left_top_select_status").val();

	switch (value_roleId) {
		case "every":
			set_data(urll + '/user/list', value_status);
			break;
		case "boss":
			set_data(urll + '/user/r_list/1', value_status);
			break;
		case "root":
			set_data(urll + '/user/r_list/2', value_status);
			break;
		case "manger":
			set_data(urll + '/user/r_list/3', value_status);
			break;
		case "staff":
			set_data(urll + '/user/r_list/4', value_status);
			break;
	}
}

// 对下拉选择框的控制  当选取不同的时候执行的不同方法
$("#body_main_left_top_select_roleId").change(function() {
	set_data_get_url();
})

// 对下拉选择框的控制  当选取不同的时候执行的不同方法
$("#body_main_left_top_select_status").change(function() {
	set_data_get_url();
})

//需要获得已有数据 将数据在框中显示出来
function set_xiangxi_data(url) {
	var urll = "http://106.14.125.136";

	$.ajax({
		type: 'get',

		url: url,

		success: function(result) {
			data = result.data;
			var new_data_array = new Array(9);

			//当div下还存在子节点时 循环继续 删除子节点
			while (document.getElementById("data_xiangxi_ul").hasChildNodes()) {
				document.getElementById("data_xiangxi_ul").removeChild(document.getElementById("data_xiangxi_ul").firstChild);
			};

			// 创建 美化 显示
			for (var t = 0; t < new_data_array.length; t++) {
				new_data_array[t] = document.createElement("li");
				switch (t) {
					case 0:
						new_data_array[t].innerHTML = " 序号 : " + data.id;
						break;
					case 1:
						new_data_array[t].innerHTML = " 姓名 : " + data.name;
						break;
					case 2:
						if (data.sex == 1) {
							new_data_array[t].innerHTML = " 性别 : 男";
						} else {
							new_data_array[t].innerHTML = " 性别 : 女";
						}
						break;
					case 3:
						new_data_array[t].innerHTML = " 联系方式 : \n&nbsp;&nbsp;&nbsp;&nbsp;" + data.phone;
						break;
					case 4:
						new_data_array[t].innerHTML = " 入职时间 : \n&nbsp;&nbsp;&nbsp;&nbsp;" + data.entryTime;
						break;
					case 5:
						new_data_array[t].innerHTML = " 密码 : " + "***" + data.password.slice(-4);
						break;
					case 6:
						if (data.status == 1) {
							new_data_array[t].innerHTML = " 是否可用 : 可用";
						} else {
							new_data_array[t].innerHTML = " 是否可用 : 不可用";
						}
						break;
					case 7:
						new_data_array[t].innerHTML = " 基础工资 : " + data.baseSalary;
						break;
					case 8:
						switch (data.roleId) {
							case 1:
								new_data_array[t].innerHTML = " 员工类型 : 超级管理员";
								break;
							case 2:
								new_data_array[t].innerHTML = " 员工类型 : 老板";
								break;
							case 3:
								new_data_array[t].innerHTML = " 员工类型 : 经理";
								break;
							case 4:
								new_data_array[t].innerHTML = " 员工类型 : 员工";
								break;
						}
						break;
				}
				new_data_array[t].className = "xiangxi_li";

				// 设置不显示的部分
				if (t == 0 || t == 5) {
					new_data_array[t].className = "xiangxi_li unava";
				}

				document.getElementById("data_xiangxi_ul").appendChild(new_data_array[t]);
			}

			// 按钮操作 创建 美化 功能实现

			var del_button = document.createElement("button");
			var fren_button = document.createElement("button");
			var change_button = document.createElement("button");

			del_button.innerHTML = "删除";
			if (data.status == 1) {
				fren_button.innerHTML = "冻结";
			} else {
				fren_button.innerHTML = "解冻";
			}
			change_button.innerHTML = "修改";

			del_button.className = "btn btn_del";
			fren_button.className = "btn btn_fren";
			change_button.className = "btn btn_change";

			document.getElementById("data_xiangxi_ul").appendChild(del_button);
			document.getElementById("data_xiangxi_ul").appendChild(fren_button);
			document.getElementById("data_xiangxi_ul").appendChild(change_button);

			// 删除按钮的功能实现
			del_button.onclick = function() {
				modal_5_true("确认删除  " + data.name + "  ?", data.id, "xiangxi_dele");
			}

			// 冻结按钮的功能实现
			fren_button.onclick = function() {
				if (data.status == 1) {
					modal_5_true("确认冻结  " + data.name + "  ?", data.id, "xiangxi_fren");
				} else {
					modal_5_true("确认解冻  " + data.name + "  ?", data.id, "xiangxi_fren");
				}
			}

			// 修改按钮的功能实现
			change_button.onclick = function() {
				$("#modal_2").modal();
				$("#change_staff_eve_input_id").attr("value", data.id);
				$("#change_staff_eve_input_roleId").val(data.roleId);
				$("#change_staff_eve_input_name").attr("value", data.name);
				$("#change_staff_eve_input_sex").val(data.sex);
				$("#change_staff_eve_input_phone").attr("value", data.phone);
				// $("#change_staff_eve_input_password").attr("value", data.password);
				// 密码不能被修改
				$("#change_staff_eve_input_baseSalary").attr("value", data.baseSalary);
				$("#change_staff_eve_input_id").attr("disabled", "disabled");
				$("#change_staff_eve_input_id").addClass("input_never_change");
			}
		},

		error: function(textStatus, errorThrown) {
			modal_4_true(textStatus.responseText);
		}
	})
}

function modal_true() {
	$("#modal_3").modal();
}

// 修改功能实现要产生的模态框
function change_modal_data() {

	var urll = "http://localhost/api";

	var jsons = {
		id: Number($("#change_staff_eve_input_id").val()),
		name: $("#change_staff_eve_input_name").val(),
		password: "不修改",
		// 虽然password不会修改 但是password为必不可少的参数
		roleId: $("#change_staff_eve_input_roleId").val(),
		phone: $("#change_staff_eve_input_phone").val(),
		sex: Number($("#change_staff_eve_input_sex").val()),
		baseSalary: Number($("#change_staff_eve_input_baseSalary").val())
	}

	//表单检查
	if (jsons.name === "") {
		modal_4_true("用户名为空");
	} else if (jsons.phone.length != 11) {
		modal_4_true("联系方式需要为11位手机号码");
	} else if (jsons.baseSalary < 0) {
		modal_4_true("底薪不能为负值");
	} else if (jsons.baseSalary === "") {
		modal_4_true("底薪不能为空");
	} else {
		$.ajax({
			type: 'PUT',
			url: urll + '/user',
			contentType: "application/json",
			dataType: "json",
			data: JSON.stringify(jsons),
			success: function(result) {
				modal_6_true(result.msg);
			},
			error: function(textStatus, errorThrown) {
				modal_4_true(textStatus.responseText);
			}
		})
	}
}

// 增加功能实现要产生的模态框
function add_modal_data() {

	var urll = "http://localhost/api";

	var jsons = {
		name: $("#add_staff_eve_input_name").val(),
		password: $("#add_staff_eve_input_password").val(),
		roleId: $("#add_staff_eve_input_roleId").val(),
		phone: $("#add_staff_eve_input_phone").val(),
		sex: Number($("#add_staff_eve_input_sex").val()),
		baseSalary: Number($("#add_staff_eve_input_baseSalary").val()),
		// 后台应该存在问题 初始设置为不可用之后  '/user/list status值为1  而'/user/u_r/' + id 中为不可用
		status: Number($("#add_staff_eve_input_status").val())
	}

	//表单检查
	if (jsons.name === "") {
		modal_4_true("用户名为空");
	} else if (jsons.phone.length != 11) {
		modal_4_true("联系方式需要为11位手机号码");
	} else if (jsons.baseSalary < 0) {
		modal_4_true("底薪不能为负值");
	} else if (jsons.baseSalary === "") {
		modal_4_true("底薪不能为空");
	} else if (jsons.password === "") {
		modal_4_true("密码不能为空");
	} else {
		$.ajax({
			type: 'POST',
			url: urll + '/user',
			contentType: "application/json",
			dataType: "json",
			data: JSON.stringify(jsons),
			success: function(result) {
				modal_6_true(result.msg);
			},
			error: function(textStatus, errorThrown) {
				modal_4_true(textStatus.responseText);
			}
		})
	}
}

//模态框动态验证 修改
$('#form_moal_2').bootstrapValidator({
	message: 'This value is not valid',
	feedbackIcons: {
		valid: 'glyphicon glyphicon-ok',
		invalid: 'glyphicon glyphicon-remove',
		validating: 'glyphicon glyphicon-refresh'
	},
	fields: {
		change_staff_eve_input_name: {
			validators: {
				notEmpty: {
					message: '用户名不能为空'
				}
			}
		},
		change_staff_eve_input_phone: {
			validators: {
				stringLength: {
					min: 11,
					max: 11,
					message: '手机号码需要为11位'
				},
				notEmpty: {
					message: '联系方式不能为空'
				}
			}
		},
		change_staff_eve_input_baseSalary: {
			validators: {
				between: {
					min: 0,
					max: 999999,
					message: '底薪不能为负值'
				},
				notEmpty: {
					message: '底薪不能为空'
				}
			}
		},
	}
});

//模态框动态验证 增加
$('#form_moal_3').bootstrapValidator({
	message: 'This value is not valid',
	feedbackIcons: {
		valid: 'glyphicon glyphicon-ok',
		invalid: 'glyphicon glyphicon-remove',
		validating: 'glyphicon glyphicon-refresh'
	},
	fields: {
		add_staff_eve_input_name: {
			validators: {
				notEmpty: {
					message: '用户名不能为空'
				}
			}
		},
		add_staff_eve_input_phone: {
			validators: {
				stringLength: {
					min: 11,
					max: 11,
					message: '手机号码需要为11位'
				},
				notEmpty: {
					message: '联系方式不能为空'
				}
			}
		},
		add_staff_eve_input_baseSalary: {
			validators: {
				between: {
					min: 0,
					max: 999999,
					message: '底薪不能为负值'
				},
				notEmpty: {
					message: '底薪不能为空'
				}
			}
		},
		add_staff_eve_input_password: {
			validators: {
				notEmpty: {
					message: '密码不能为空'
				}
			}
		}
	}
});

// 数据变化后需要进行页面刷新
function refresh() {
	window.location.href = "staff.html";
}

// alert的替代
function modal_4_true(value) {
	$("#modal_4").modal();
	$("#modal_4_value").text(value);
}

//alert并刷新
function modal_6_true(value) {
	$("#modal_6").modal();
	$("#modal_6_value").text(value);
}

//confirm的替代
function modal_5_true(value, val_id, funct) {
	$("#modal_5").modal();
	$("#modal_5_value").text(value);
	if (funct === "xiangxi_dele") {
		document.getElementById("modal_5_button1").onclick = function() {
			xiangxi_dele(val_id);
		}
	} else if (funct === "xiangxi_fren") {
		document.getElementById("modal_5_button1").onclick = function() {
			xiangxi_fren(val_id);
		}
	} else {

	}
}
// 删除操作
function xiangxi_dele(val_id) {
	var urll = "http://localhost/api";
	$.ajax({
		type: 'DELETE',

		url: urll + '/user/' + val_id,

		success: function(result) {
			modal_6_true(result.msg);
		},

		error: function(textStatus, errorThrown) {
			modal_4_true(textStatus.responseText);
		}
	})
}

// 冻结操作
function xiangxi_fren(val_id) {
	var urll = "http://localhost/api";

	$.ajax({
		type: 'get',

		url: urll + '/user/u_r/' + val_id,

		success: function(result) {
			data = result.data;
			if (data.status == 1) {
				var sta_fren = 0;
			} else {
				var sta_fren = 1;
			}

			var jsons = {
				id: Number(data.id),
				name: data.name,
				password: data.password,
				roleId: data.roleId,
				phone: data.phone,
				sex: Number(data.sex),
				status: sta_fren,
				baseSalary: Number(data.baseSalary)
			}

			$.ajax({
				type: 'PUT',
				url: urll + '/user',
				contentType: "application/json",
				dataType: "json",
				data: JSON.stringify(jsons),
				success: function(result) {
					modal_6_true(result.msg);
				},
				error: function(textStatus, errorThrown) {
					modal_4_true(textStatus.responseText);
				}
			})

		},

		error: function(textStatus, errorThrown) {
			modal_4_true(textStatus.responseText);
		}
	})
}
