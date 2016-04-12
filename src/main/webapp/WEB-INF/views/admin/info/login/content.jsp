<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<table style="height:100%;" id="system_info_login_treegrid"></table>

<script type="text/javascript">
	var info_login_url ='<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/info/login/find_by_admin_user.action"/>&USERNAME=<shiro:principal/>&userName=<shiro:principal/>';
	
	$(function(){
		$("#system_info_login_treegrid").datagrid({
			url : info_login_url,
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			fitColumns : true,
			border:false,
			columns : [ [ {
				field : 'loginIp',
				title : '登录IP',
				width : 200
			}, {
				field : 'area',
				title : '登录地址',
				width : 200
			}, {
				field : 'loginTimeC',
				title : '登录时间',
				width : 200
			}] ]
		});
	});

</script>