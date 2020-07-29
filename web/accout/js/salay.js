   
//获取下拉表
   var getvollist = function () {
    $.ajax({
            url: "http://localhost/api/staff/all/list",
            type: "get",
            success: function (info) 
            {
            	  console.log("员工下拉表"+JSON.stringify(info.msg));
            	for(var i=0;i<info.data.length;i++)
            	{
            		var get='<option  value="'+info.data[i].id+'" >'+info.data[i].name+"</option>";
            		$("#staffname").append(get);
            	}
            	
            }
            })
   }
  getvollist();
//对数据内容进行渲染
    var my_page = 1;
    var my_pagesize = 8;
    var inform_total;
 
    var render = function () {
        
    	var staffid=$("#staffname option:selected").val();       			
     if(staffid=="全体员工")
     staffid=null;
    
        $("#salarlist").empty();
        $.ajax({
            url: "http://localhost/api/salary",
            type: "get",
            dataType:"json",
            data: {
                current: my_page + "",
                size: my_pagesize + "",
                staffId: staffid,
            },
            success: function (info) 
            {
               console.log("渲染数据"+JSON.stringify(info.msg)); 
             
	 		        var htmlstr = template('my_template',info.data);
                    $("#salarlist").append(htmlstr);
                    for(var i=0;i<info.data.records.length;i++)
                    {
                    	$("#"+i).find("td[name^='remark']").html(info.data.records[i].remark);
                    }
                inform_total = info.data.total;
                //分页功能
                $("#page_classify").bootstrapPaginator({
                    bootstrapMajorVersion: 3,//默认是2，如果是bootstrap3版本，这个参数必填
                    currentPage: my_page,//当前页
                    totalPages: Math.ceil(inform_total / my_pagesize),//总页数
                    size: "small",//设置控件的大小，mini, small, normal,large
                     shouldShowPage:true,//是否显示该按钮
                    onPageClicked: function (event, originalEvent, type, page) {
                        my_page = page;
                        render();
                    }
                    });

            },
   
        })   
    };
   
    render();
//出账状态
var pay_state=function (){

	 $.ajax({
            url: "http://localhost/api/salary/salary_time",
            type: "get",
            success: function (info) 
            {
            console.log('出账状态查询'+JSON.stringify(info.msg)); 
            var date=new Date(info.data);
		 	var now=new Date();
            if(now.getDate()>date.getDate())
            	$("#msgbox span").html("本月已出帐");
            else
                $("#msgbox span").html("本月未出帐");
            },
             error: function(textStatus,errorThrown)
            {
            	alert(textStatus.responseText);
            }
            })
}
 pay_state();
//以时间筛选
var update_table = function(){
	var staffid=$("#staffname option:selected").val();
	$("#inputerror").empty();
	 var starttime=new Date($("#user_date_start").val());
     if($("#user_date_start").val()==null)
     alert("开始为空")
	 var endtime=new Date($("#user_date_end").val());
	 if((endtime<starttime))
	{
		$("#inputerror").html("请输入正确时间段！");
    }      
	else
	{	      
		$.ajax({
            url: "http://localhost/api/salary",
            type: "get",
            dataType:"json",
            data: {
                current: "1",
                size: inform_total + "",
                staffId: staffid,
            },
            success: function (info)
            {
               console.log("获得筛选数据"+JSON.stringify(info.msg)); 
		 for(var i=0;i<info.data.records.length;i++)
		 {
		 	
		 	var settledata=new Date(info.data.records[i].settleDate);
		 	
		 if((settledata.getTime()<starttime.getTime())||(settledata.getTime()>endtime.getTime()))
             {   
             	info.data.records.splice(i,1);
             	i--;
             	 
             }
         }
		    $("#salarlist").empty();
		    var data={"records":[{}]};
               for(var i=my_pagesize*(my_page-1),n=0;i<my_pagesize*my_page;i++,n++)
	 	          { 
	 		        data.records[n]=info.data.records[i];

	 	          }
	 	           var htmlstr = template('my_template',data);
                    $("#salarlist").append(htmlstr);
                   
                    for(var j=0;j< data.records.length;j++)
                    {

                    	$("#"+j).find("td[name^='remark']").html(data.records[j].remark);
                    }

                inform_total = info.data.records.length;
                //分页功能
                $("#page_classify").bootstrapPaginator({
                    bootstrapMajorVersion: 3,//默认是2，如果是bootstrap3版本，这个参数必填
                    currentPage: my_page,//当前页
                    totalPages: Math.ceil(inform_total / my_pagesize),//总页数
                    size: "small",//设置控件的大小，mini, small, normal,large
                     shouldShowPage:true,//是否显示该按钮
                    onPageClicked: function (event, originalEvent, type, page) {
                        my_page = page;
                       update_table();
                    }
                    });
            },
             error: function(textStatus,errorThrown)
            {
            	alert(textStatus.responseText);
            }
            })
    
            
		 
	}
}
//不能选取超过当前时间
$(function(){
     
	var date_now = new Date();
	var year = date_now.getFullYear();
	var month = date_now.getMonth()+1 < 10 ? "0"+(date_now.getMonth()+1) : (date_now.getMonth()+1);
	var date = date_now.getDate() < 10 ? "0"+date_now.getDate() : date_now.getDate();
	$("#user_date_end").attr("max",year+"-"+month+"-"+date);
	$("#user_date_start").attr("max",year+"-"+month+"-"+date);
})
//修改结算日期
 var setTime = function () {
 	if(!$("#salaryday").val())
 	{
 		alert("请选择日期");
 		return;
 	}
 	var salaryday=new Date($("#salaryday").val());
 	if(salaryday.getMonth()>9&&salaryday.getDate()>9)
    var temp = salaryday.getFullYear().toString()+"-"+salaryday.getMonth().toString()+"-"+salaryday.getDate().toString()+" 00:00:00";  
    else if(salaryday.getMonth()>9)
    var temp = salaryday.getFullYear().toString()+"-"+salaryday.getMonth().toString()+"-"+"0"+salaryday.getDate().toString()+" 00:00:00";  
    else
    var temp = salaryday.getFullYear().toString()+"-"+"0"+salaryday.getMonth().toString()+"-"+"0"+salaryday.getDate().toString()+" 00:00:00";  
    $.ajax({
            url: "http://localhost/api/salary/set",
            type: "post",
            dataType:"json",
            data: {
                salaryTime:temp,
            },
            success: function (info) 
            {
            	  console.log('修改结算日期'+JSON.stringify(info));
            	  alert("修改成功");
            	
            },
            error: function(textStatus)
            {
            	 console.log('修改结算日期'+textStatus.responseText);
            	  alert("修改失败");
            }
            })
   }
  //修改总体工资
 var updateid;
 var get_updateid=function(obj)
 {
 	 updateid=$(obj).parent().parent().parent().children("td:last-child").text();
 	 
 }
 var changesalary=function(){
 	var salarydate=$("#salary_change").val();
 	var reason=$("#change_reason").val();
 	$.ajax({
            url: "http://localhost/api/salary/edit/"+updateid,
            type: "PUT",
            contentType: "application/json;charset=UTF-8",
            data:JSON.stringify( {
                change:salarydate,
                remark:reason,
            }),
            success: function (info) 
            {
            	  alert('修改工资'+JSON.stringify(info.msg));
            	  render();
            },
            error: function(textStatus)
            {
            	console.log(textStatus.responseText);
            	alert("修改失败");
            }
            })

   }
 //删除工资记录条
 var delete_note=function(obj){
 	 $.ajax({
            url: "http://localhost/api/salary/del/"+updateid,
            type: "DELETE",
            contentType: "application/json;charset=UTF-8",
            success: function (info) 
            {
            	  console.log('删除'+JSON.stringify(info.msg));
            	  alert("删除成功");
            	   render();  	
            },
            error: function(textStatus)
            {
            	alert('操作失败');
            	console.log('删除'+textStatus.responseText)
            }
          })
 }



