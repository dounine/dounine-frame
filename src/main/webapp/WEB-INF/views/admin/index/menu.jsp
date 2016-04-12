<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<li>
	<a class="lox-selected" data-url='${base}/admin/index/bench/content.html?USERNAME=<shiro:principal/>' onclick="dynamic_left_menu(this);" href="javascript:void(0);">工作台</a>
</li>
<li>
	<a data-url='${base}/admin/index/content.html?USERNAME=<shiro:principal/>' onclick="dynamic_left_menu(this);" href="javascript:void(0);">系统信息</a>
</li>

