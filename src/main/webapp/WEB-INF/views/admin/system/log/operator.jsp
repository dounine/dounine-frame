<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div class="easyui-layout" id="asdf" style="height: 100%;">

	<div data-options="region:'center',fit:true" style="height: 100%;">

		<div id="lox-tabs" data-options="fit:true">

			<shiro:hasPermission name="system:log:login:*"><div title="登录日志" lox-data-options="href:'${base}/admin/system/log/login/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-login'" style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
			<shiro:hasPermission name="system:log:operation:*"><div title="操作日志" lox-data-options="href:'${base}/admin/system/log/operation/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-work'" style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
		</div>

	</div>

</div>
<script type="text/javascript">
	if($("#lox-tabs div").length){
		(new EasyuiTabs()).init($('#lox-tabs'));
	}
</script>

