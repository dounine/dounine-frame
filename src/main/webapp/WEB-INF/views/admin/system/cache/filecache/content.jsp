<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/cache/filecache/Filecache.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="system_filecache_datagrid"></table>

<div id="system_filecache_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:cache:filecache:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$Filecache.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="system:cache:filecache:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sfdm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$Filecache.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="system:cache:filecache:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sfdm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$Filecache.del();">删除</a></shiro:hasPermission>
		<shiro:hasPermission name="system:cache:filecache:congeal"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sfdm-menu-congeal" data-options="iconCls:'icon-d-congeal'" onclick="$Filecache.congeal();">禁止</a></shiro:hasPermission>
		<shiro:hasPermission name="system:cache:filecache:thaw"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sfdm-menu-thaw" data-options="iconCls:'icon-d-thaw'" onclick="$Filecache.thaw();">启用</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="system_filecache_search_form" onsubmit="return false;">
			名称: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="fileCacheName" style="width: 140px;"/>
			&nbsp;状态: <select name="status" editable="false" class="easyui-combobox" panelHeight="auto" style="width: 100px;">
						<option value="">请选择</option>
						<option value="NORMAL">启动</option>
						<option value="CONGEAL">禁用</option>
					</select>
			<shiro:hasPermission name="system:cache:filecache:search"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$Filecache.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a></shiro:hasPermission>
		</form>
	</span>
</div>

<div id="system_filecache_dialog" >
	<form id="system_filecache_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>缓存名称:</td>
				<td>
					<input style="width: 134px;" name="fileCacheName" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="fileCacheId" type="text" />
				</td>
				<td>缓存链接:</td>
				<td>
					<input style="width: 134px;" name="fileCacheResource" type="text" class="easyui-textbox" required="required" />
				</td>
			</tr>
			<tr>
				<td>缓存描述:</td>
				<td>
					<input style="width: 134px;" name="fileCacheDescription" type="text" class="easyui-textbox" />
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_链接缓存(){//命名规则  delete_(+)所在tab名称
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $Filecache = new Filecache();
	$Filecache.datagrid = $("#system_filecache_datagrid");
	$Filecache.datagrid_menu = "#system_filecache_datagrid_menu";
	$Filecache.searchForm = $("#system_filecache_search_form");
	$Filecache.dialog = $("#system_filecache_dialog");
	$Filecache.form = $("#system_filecache_dialog_form");
	$Filecache.button;
	
	$Filecache.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/cache/filecache/maps.action" />'+_userUrl;//列表
	$Filecache.addUrl = '<dounine-csrf:token-value uri="${base}/admin/system/cache/filecache/add.action" />'+_userUrl;//添加
	$Filecache.editUrl = '<dounine-csrf:token-value uri="${base}/admin/system/cache/filecache/edit.action" />'+_userUrl;//编辑
	$Filecache.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/cache/filecache/del.action" />'+_userUrl;//删除
	$Filecache.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/system/cache/filecache/congeal.action" />'+_userUrl;//启用
	$Filecache.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/system/cache/filecache/thaw.action" />'+_userUrl;//禁用
	
	$Filecache.load(<shiro:hasPermission name="system:cache:filecache:maps">true</shiro:hasPermission>);//加载显示列表信息
	
</script>