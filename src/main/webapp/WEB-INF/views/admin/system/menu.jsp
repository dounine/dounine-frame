<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<li>
	<shiro:hasPermission name="system:rbac:*"><a class="lox-selected" data-url='${base}/admin/system/rbac/operator.html?USERNAME=<shiro:principal/>' onclick="dynamic_left_menu(this);" href="javascript:void(0);">权限管理</a></shiro:hasPermission>
</li>
<li>
	<shiro:hasPermission name="system:quartz:*"><a data-url='${base}/admin/system/quartz/schedulejob/operator.html?USERNAME=<shiro:principal/>' onclick="dynamic_left_menu(this);" href="javascript:void(0);">定时器管理</a></shiro:hasPermission>
</li>
<li>
	<shiro:hasPermission name="system:log:*"><a data-url='${base}/admin/system/log/operator.html?USERNAME=<shiro:principal/>' onclick="dynamic_left_menu(this);" href="javascript:void(0);">日志管理</a></shiro:hasPermission>
</li>
<li>
	<shiro:hasPermission name="system:bug:*"><a data-url='${base}/admin/system/bug/operator.html?USERNAME=<shiro:principal/>' onclick="dynamic_left_menu(this);" href="javascript:void(0);">BUG管理</a></shiro:hasPermission>
</li>
<li>
	<shiro:hasPermission name="system:ehcache:*"><a data-url='${base}/admin/system/cache/operator.html?USERNAME=<shiro:principal/>' onclick="dynamic_left_menu(this);" href="javascript:void(0);">缓存管理</a></shiro:hasPermission>
</li>

