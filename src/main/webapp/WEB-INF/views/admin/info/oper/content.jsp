<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<table style="height:100%;" id="system_info_oper_datagrid"></table>

<script type="text/javascript">
	$(function(){
		$("#system_info_oper_datagrid").datagrid({
			url : '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/info/operation/find_by_admin_user.action" />&USERNAME=<shiro:principal/>&userName=<shiro:principal/>',
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			fitColumns : true,
			border:false,
			columns : [ [ {
				field : 'story',
				title : '操作事务',
				width : 200
			}, {
				field : 'createTimeT',
				title : '操作时间',
				width : 200
			}] ]
		});
	});

</script>