<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
.info_div{
	margin:10px;
}
.info_div li{
	height:40px;
	line-height:40px;
	text-indent:10px;
	list-style-type: circle;
}
.place-nav{
	padding-left:10px;
	height:40px;
	background:#EDF6FA;
	border-bottom:1px solid #D7E4EA;
}
.place-nav ul li{
	float: left;
	margin-right:10px;
	height:40px;
	line-height: 40px;
}
.place-nav a{
	float:left;
	font-size: 12px;
	text-decoration: none;
	color:#0F0F0F;
}
.place-nav a:hover{
	color:red;
}
.mainindex{
	padding:20px;
	overflow:hidden;
}
.mainindex div{
	width:100%;
	float:left;
}
.welinfo{
	margin:4px 0;
}
.welinfo span img{
	vertical-align:middle;
}
.line{
	margin:10px 0;
	float:left;
	width:100%;
	height:2px;
	border-bottom:1px solid #dfe9ee;
}
.iconlist{
	padding:10px;
	padding-left:20px;
}
.iconlist li{
	text-align:center;
	float:left;
	padding:10px;
}
.iconlist a{
	color:#333333;
}
.iconlist a:hover{
	cursor:pointer;
	color:#00a4ac;
}
a.ibtn:hover{
	color:#00a4ac;
}
.ibtn{
	background: url(${base_url}/resource/admin/images/index/ibtnbg.png) repeat-x;
	border: solid 1px #bfcfe1;
	height: 23px;
	line-height: 23px;
	display: block;
	float: left;
	padding: 0 15px;
	cursor: pointer;
	margin-left:28px;
}
.ibtn img{
	margin-right:0px;
	vertical-align:middle;
}
.quickh{
	padding-left:36px;
}
.quickh li{
	line-height: 23px;
	height: 23px;
	margin-bottom: 8px;
}
.quickh li span{
	float: left;
	margin-right: 10px;
}
.uimakerinfo{
	padding-left: 40px;
	background: url(${base_url}/resource/admin/images/index/search.png) no-repeat 10px 15px;
	padding-top: 15px;
	padding-bottom: 20px;
}
.umlist{
	padding-left:38px;
}
.umlist li{
	float: left;
	background: url(${base_url}/resource/admin/images/index/ulist.png) no-repeat 0 5px;
	padding-left: 10px;
	margin-right: 15px;
}
.umlist li a{
	color:#333333;
}
.umlist li a:hover{
	color:#00a4ac;
}
.ibox a{
	color:#666666;
}
</style>
<div id="system_keyboard_dialog_content_b"></div>
<div class="easyui-layout" style="height:100%;overflow:auto;">
	<div data-options="region:'north'" border="false" style="height:60px;">
		<div class="place-nav">
			<ul>
		    	<li><a href="javascript:void(0);" style="cursor:default;font-weight:700;">位置：</a></li>
		    	<li><a href="#">首页</a></li>
		    	<li>></li>
		    	<li><a href="#">工作台</a></li>
		    </ul>
		</div>
	</div>
	<div data-options="region:'center'" border="false">
	
		<div class="mainindex">
			<div class="welinfo">
			    <span>
			    	<img src="${base_url}/resource/admin/css/themes/icons/${current_time_icon}" alt="时间" />
			    </span>
			    <font style="font-size:14px;"><b><shiro:principal/></b> ${current_time}好 [<font style="color:#666666;"> ${current_time_tip} </font>], 欢迎使用 逗你呢(dounine) 框架管理系统</font>
		    </div>
			<div class="welinfo">
		    	<span>
		    		<img src="${base_url}/resource/admin/images/index/time.png" alt="时间">
		    	</span>
		    	<i>您上次登录的时间：${current_login.loginTimeC}</i> [ <i>${current_login.area}</i> ] （不是您登录的？<a href="#">请点这里</a>）
		    </div>
		    <div class="line"></div>
	    	<div class="iconlist">
		    	<ul id="key_board_list">
		    	</ul>
		 	</div>
		 	<div class="ibox">
		 		<a class="ibtn" href="javascript:void(0);" onclick="show_keyboard();">
		 			<img src="${base_url}/resource/admin/images/index/iadd.png">
			 		快捷功能管理
		 		</a>
		 	</div>
	 		<div class="line"></div>
		 	<div class="welinfo">
		    	<span><img src="${base_url}/resource/admin/images/index/dp.png" alt="提醒"></span>
		    	<b>逗你呢(dounine) 框架管理系统使用指南</b>
		    </div>
		    <div class="infolist quickh">
			    <ul>
			    	<li><span>您可以快速进行框架发布管理操作</span><a class="ibtn">发布或管理框架</a></li>
			    	<li><span>您可以快速发布新bug</span><a class="ibtn">发布或管理bug</a></li>
			    	<li><span>您可以进行密码修改、账户设置等操作</span><a onclick="show_info('${base}/admin/system/rbac/user/info/admin_info.html?USERNAME=<shiro:principal/>');" class="ibtn">账户管理</a></li>
			    </ul>
		    </div>
		    <div class="line"></div>
		    <div class="uimakerinfo"><b>逗你呢(dounine) 框架系統使用指南</b></div>
		    <div class="umlist">
			    <ul>
			    	<li><a href="#">如何发布框架</a></li>
			    	<li><a href="#">如何访问网站</a></li>
			    	<li><a href="#">如何管理緩存</a></li>
			    	<li><a href="#">后台用户设置(权限)</a></li>
			    	<li><a href="#">系统设置</a></li>
			    </ul>
		    </div>
		</div>
	</div>
</div>


<script>
	function open_key_board_url(self){
		window.location.href=$(self).attr('key_board_url');
		window.location.reload();
	}

	function show_keyboard(){
		try{
			$("#system_keyboard_dialog_content").dialog('destroy');
		}catch(e){
		}
		$("#system_keyboard_dialog_content_b").append('<div id="system_keyboard_dialog_content" style="display:none;"></div>');
		$("#system_keyboard_dialog_content").show().dialog({
			title : '&nbsp;快捷键管理',
			height:300,
			method:'post',
			href:"${base}/admin/index/keyboard/content.html"
		});
	}
	
	$(function(){
		$.post('<dounine-csrf:token-value uri="${base}/admin/index/keyboard/all.action" />',function(data){
			var key_board_list = $("#key_board_list");
			for(var key_b in data){
				var ob = data[key_b];
				key_board_list.append('<a href="javascript:void(0);" onclick="open_key_board_url(this);" key_board_url="${base}'+ob.url+'"><li><img width="32" height="32" src="${base}'+ob.picture+'"><p>'+ob.name+'</p></li></a>')
			}
		})
	});
</script>