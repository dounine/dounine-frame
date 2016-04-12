<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

	<div id="lox-tabs-info" data-options="height:400">

		<div title="帐户安全" lox-data-options="href:'${base}/admin/system/rbac/user/info/safe/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-safety'"  style="height: 400px;overflow: hidden;"></div>
		
		<div title="登录信息" lox-data-options="href:'${base}/admin/system/rbac/user/info/login/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-login'"   style="height: 400px;overflow: hidden;"></div>
		
		<div title="我的权限" lox-data-options="href:'${base}/admin/system/rbac/user/info/rbac/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-role'" style="height: 400px;overflow: hidden;"></div>
		
		<div title="操作事务" lox-data-options="href:'${base}/admin/system/rbac/user/info/oper/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-work'" style="height: 400px;overflow: hidden;"></div>

	</div>

<script type="text/javascript">
		(new EasyuiTabs()).init($('#lox-tabs-info'));
</script>