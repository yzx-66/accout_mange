// //登陆拦截功能
// $(function () {
// 	if (location.href.indexOf("login.html") === -1) {
// 		$.ajax({
// 			url:"/employee/checkRootLogin",
// 			type:"get",
// 			success:function (info) {
// 				if(info.error===400){
// 					location.href="login.html"
// 				}
// 			}
// 		})
// 	}
// })

//左侧导航栏隐藏功能
$(".first").click(function () {
	console.log();
	$(this).siblings().slideToggle()
})

//点击导航栏左边的按钮实现侧边栏的变换
$(function () {
	$("#top_btn_left").click(function () {
		$(".left_aside").toggleClass("exchange");
		$(".main_top").toggleClass("exchange");
		$(".main_body").toggleClass("exchange")
	})
})

//退出模态框点击事件
$(function () {
	$("#top_btn_right").click(function () {
		$('#myModal').modal('toggle');
	})

})

//点击退出功能实现
$(function () {
	$("#logout_btn").click(function () {
		$.ajax({
			type: "get",
			url: "/api/logout",
			success: function (info) {
				if (info.success) {
					location.href = "login.html";
				} else {
					$("#logout_notify").html("退出失败请重试");
				}
			}
		})
	})
})
