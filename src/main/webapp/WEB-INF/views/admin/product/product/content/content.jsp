<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/product/product/Product.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="product_datagrid"></table>

<div id="product_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="product:product:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$Product.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="product:product:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="pdm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$Product.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="product:product:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="pdm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$Product.del();">删除</a></shiro:hasPermission>
		<shiro:hasPermission name="product:product:congeal"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="pdm-menu-congeal" data-options="iconCls:'icon-d-congeal'" onclick="$Product.congeal();">冻结</a></shiro:hasPermission>
		<shiro:hasPermission name="product:product:thaw"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="pdm-menu-thaw" data-options="iconCls:'icon-d-thaw'" onclick="$Product.thaw();">解冻</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="product_search_form" onsubmit="return false;">
			名称: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="articleName" style="width: 140px;"/>
			&nbsp;状态: <select name="status" editable="false" class="easyui-combobox" panelHeight="auto" style="width: 100px;">
						<option value="">请选择</option>
						<option value="NORMAL">解冻</option>
						<option value="CONGEAL">冻结</option>
					</select>
			<shiro:hasPermission name="product:product:search"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$Product.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a></shiro:hasPermission>
		</form>
	</span>
</div>

<script type="text/javascript">
	function delete_框架管理(){//命名规则  delete_(+)所在tab名称
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $Product = new Product();
	$Product.datagrid = $("#product_datagrid");
	$Product.datagrid_menu = "#product_datagrid_menu";
	$Product.searchForm = $("#product_search_form");
	$Product.button;
	
	$Product.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/product/product/maps.action" />'+_userUrl;//列表
	$Product.addUrl = '<dounine-csrf:token-value uri="${base}/admin/product/product/add.action" />'+_userUrl;//添加
	$Product.editUrl = '<dounine-csrf:token-value uri="${base}/admin/product/product/edit.actio" />'+_userUrl;//编辑
	$Product.delUrl = '<dounine-csrf:token-value uri="${base}/admin/product/product/del.action" />'+_userUrl;//删除
	$Product.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/product/product/congeal.action" />'+_userUrl;//未解决
	$Product.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/product/product/thaw.action" />'+_userUrl;//已解决
	
	$Product.load(<shiro:hasPermission name="product:product:list">true</shiro:hasPermission>);//加载显示列表信息

	var me_tab_children_url = '${base}/admin/product/product/info.html'+userUrl;
	
	$Product.show_editor = function(){
		var select_tab = $('#lox-tabs').tabs('getSelected');
		$(select_tab).attr("lox-data-options","href:'"+me_tab_children_url+"'").css('style','hidden');
		$('#lox-tabs').tabs('update',{
			tab:select_tab,
			title:'框架管理',
			options:{
				href:me_tab_children_url,
				method:'post'
			}
		});
	}
</script>