<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
.info_div{
	margin:10px;
}
.info_div li{
	height:24px;
	line-height:24px;
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
	background: url(${base_url}/resource/admin/images/index/ulist.png) no-repeat left center;
	padding-left: 10px;
	margin-right: 15px;
}
.umlist li a{
	color:#333333;
}
.umlist li a:hover{
	color:#00a4ac;
}
#sys_info_java li{
	width:100%;
	height:24px;
	line-height:24px;
	float:left;
}
.left_um li{
	width:100%;
	height:24px;
	line-height:24px;
	float:left;
}
</style>
<div class="easyui-layout" style="height:100%;overflow:auto;">
	<div data-options="region:'north'" border="false" style="height:60px;">
		<div class="place-nav">
			<ul>
		    	<li><a href="javascript:void(0);" style="cursor:default;font-weight:700;">位置：</a></li>
		    	<li><a href="#">首页</a></li>
		    	<li>></li>
		    	<li><a href="#">系统信息</a></li>
		    </ul>
		</div>
	</div>
	<div data-options="region:'center'" border="false">
	
		<div class="mainindex">
		 	<div class="welinfo">
		    	<span><img src="${base_url}/resource/admin/images/index/dp.png" alt="提醒"></span>
		    	<b>逗你呢(dounine) 系统架构</b>
		    </div>
		    <div class="umlist">
			    <ul>
			    	<li><span>SpringMVC-4.1.4</span></li>
			    	<li><span>Mybatis-3.2.8</span></li>
			    	<li><span>Shiro-1.2.3</span></li>
			    	<li><span>Easyui-1.4.1</span></li>
			    	<li><span>Redis-2.8.19</span></li>
			    </ul>
		    </div>
		    <div class="line"></div>
		    <div class="welinfo">
		    	<span><img src="${base_url}/resource/admin/images/index/dp.png" alt="提醒"></span>
		    	<b>逗你呢(dounine) 项目信息</b>
		    </div>
		    <div class="umlist left_um">
			    <ul>
			    	<li><span>项目下载地址：<a style="color:green;" target="_blank" href="https://git.oschina.net/huanghuanlai/dounine.git">https://git.oschina.net/huanghuanlai/dounine.git</a></span></li>
			    	<li><span>演示地址：<a style="color:green;" target="_blank" href="http://dounine.html">http://dounine.html</a></span></li>
			    	<li><span>管理员帐号：admin</span></li>
			    	<li><span>管理员密码：admin</span></li>
			    	<li><span>项目交流群：174481989</span></li>
			    </ul>
		    </div>
		    <div class="line"></div>
		    <div class="uimakerinfo"><b>逗你呢(dounine) 框架系統环境</b></div>
		    <div class="umlist">
			    <ul id="sys_info_java">
			    </ul>
		    </div>
		</div>
	</div>
</div>


<script>
	$(function(){
		$.post('<dounine-csrf:token-value uri="${base}/admin/index/content/javainfo.action" />'+_userUrl,function(data){
			for(var s in data){
				$("#sys_info_java").append('<li><span>'+s+' : </span>'+data[s]+'</li>');
			}
		});
	});
</script>