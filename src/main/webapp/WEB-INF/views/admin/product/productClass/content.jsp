<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/product/productClass/ProductClass.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="product_productClass_datagrid"></table>

<div id="product_productClass_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="product:productClass:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$ProductClass.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="product:productClass:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="ppcdm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$ProductClass.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="product:productClass:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="ppcdm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$ProductClass.del();">删除</a></shiro:hasPermission>
	</span>
</div>

<div id="product_productClass_dialog" style="display:none;">
	<form id="product_productClass_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>分类名称:</td>
				<td>
					<input style="width: 134px;" name="name" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="id" type="text" />
				</td>
				<td>分类描述:</td>
				<td>
					<input style="width: 134px;" name="description" type="text" class="easyui-textbox" />
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_文章分类管理(){//命名规则  delete_(+)所在tab名称
		$('#product_productClass_dialog').dialog('destroy');//凡是easyui dialog,window,panel组件,必需调用其destroy销毁方法。
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $ProductClass = new ProductClass();
	$ProductClass.datagrid = $("#product_productClass_datagrid");
	$ProductClass.datagrid_menu = "#product_productClass_datagrid_menu";
	$ProductClass.dialog = $("#product_productClass_dialog");
	$ProductClass.form = $("#product_productClass_dialog_form");
	
	$ProductClass.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productClass/maps.action" />'+_userUrl;
	$ProductClass.addUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productClass/add.action" />'+_userUrl;//添加
	$ProductClass.delUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productClass/del.action" />'+_userUrl;//删除
	$ProductClass.editUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productClass/edit.action" />'+_userUrl;//编辑
	$ProductClass.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productClass/congeal.action" />'+_userUrl;//冻结
	$ProductClass.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productClass/thaw.action" />'+_userUrl;//解冻
	
	$ProductClass.load(<shiro:hasPermission name="product:productClass:list">true</shiro:hasPermission>);//加载显示列表信息

</script>