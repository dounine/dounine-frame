<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/log/login/Login.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="system_log_login_datagrid"></table>

<div id="system_log_login_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:log:login:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="slldm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$Login.del();">删除</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="system_log_login_search_form" onsubmit="return false;">
			操作者: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="userName" style="width: 140px;"/>
			&nbsp;登录IP: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="loginIp" style="width: 140px;"/>
			&nbsp;登录时间: <input type="text" class="easyui-datebox" editable="false" name="loginTimeC" style="width: 140px;"/>
			<shiro:hasPermission name="system:log:login:search"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$Login.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a></shiro:hasPermission>
		</form>
	</span>
</div>

<script type="text/javascript">
	function delete_登录日志(){//命名规则  delete_(+)所在tab名称
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $Login = new Login();
	$Login.datagrid = $("#system_log_login_datagrid");
	$Login.datagrid_menu = "#system_log_login_datagrid_menu";
	$Login.searchForm = $("#system_log_login_search_form");
	
	$Login.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/log/login/maps.action" />'+_userUrl;
	$Login.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/log/login/del.action" />'+_userUrl;//删除
	
	$Login.load(<shiro:hasPermission name="system:log:login:list">true</shiro:hasPermission>);//加载显示列表信息

</script>