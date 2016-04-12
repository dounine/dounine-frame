<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<shiro:hasPermission name="system:rbac:*">
	<li>
		<a class="lox-selected" data-url='${base}/admin/product/operator.html?USERNAME=<shiro:principal/>' onclick="dynamic_left_menu(this);" href="javascript:void(0);">框架管理</a>
	</li>
</shiro:hasPermission>

