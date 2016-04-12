<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<table style="height:100%;" id="system_info_permission_treegrid"></table>

<script type="text/javascript">
	$(function(){
		$("#system_info_permission_treegrid").datagrid({
			url : '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/info/permission/find_by_admin_user.action" />&USERNAME=<shiro:principal/>&userName=<shiro:principal/>',
			rownumbers : true,
			lines:true,
			pagination : true,
			fitColumns : true,
			border:false,
			columns : [ [ {
				field : 'permissionName',
				title : '权限名称',
				width : 200
			}, {
				field : 'permissionResource',
				title : '权限资源',
				width : 200
			}, {
				field : 'permissionDescription',
				title : '权限资源描述',
				width : 100
			} ] ]
		});
	});

</script>