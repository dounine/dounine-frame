<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<shiro:hasPermission name="website:article:*">
	<li>
		<a class="lox-selected" data-url='${base}/admin/website/article/operator.html?USERNAME=<shiro:principal/>' onclick="dynamic_left_menu(this);" href="javascript:void(0);">文章管理</a>
	</li>
</shiro:hasPermission>
<shiro:hasPermission name="website:productFloor:*">
	<li>
		<a data-url='${base}/admin/website/news/operator.html?USERNAME=<shiro:principal/>' onclick="dynamic_left_menu(this);" href="javascript:void(0);">新闻管理</a>
	</li>
</shiro:hasPermission>
<shiro:hasPermission name="website:productFloor:*">
	<li>
		<a data-url='${base}/admin/website/productFloor/operator.html?USERNAME=<shiro:principal/>' onclick="dynamic_left_menu(this);" href="javascript:void(0);">楼层管理</a>
	</li>
</shiro:hasPermission>
