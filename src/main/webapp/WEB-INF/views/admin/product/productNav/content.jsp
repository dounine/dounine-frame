<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/product/productNav/ProductNav.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="product_productNav_datagrid"></table>

<div id="product_productNav_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="product:productNav:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$ProductNav.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="product:productNav:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="ppndm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$ProductNav.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="product:productNav:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="ppndm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$ProductNav.del();">删除</a></shiro:hasPermission>
	</span>
</div>

<div id="product_productNav_dialog" style="display:none;">
	<form id="product_productNav_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>导航名称:</td>
				<td>
					<input style="width: 134px;" name="name" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="id" type="text" />
				</td>
				<td>排序:</td>
				<td>
					<input type="text" required="true" data-options="min:0,value:0,editable:false" class="easyui-numberspinner" name="sequence" style="width:134px;" />
				</td>
			</tr>
			<tr>
				<td>上级:</td>
				<td id="productNavParentBox">
				</td>
				<td>描述:</td>
				<td>
					<input style="width: 134px;" class="easyui-textbox" name="description" id="description" />
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_框架导航管理(){//命名规则  delete_(+)所在tab名称
		$('#product_productNav_dialog').dialog('destroy');//凡是easyui dialog,window,panel组件,必需调用其destroy销毁方法。
	}
	
	function switch_display_url(self){
		var $self = $(self);
		var $parent = $self.prev();
		if($parent.val()=='false'){
			$parent.val('true');
			$self.attr('src','${base_url}/resource/admin/images/no.jpg');
		}else{
			$parent.val('false');
			$self.attr('src','${base_url}/resource/admin/images/yes.jpg');
		}
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $ProductNav = new ProductNav();
	$ProductNav.treegrid = $("#product_productNav_datagrid");
	$ProductNav.treegrid_menu = "#product_productNav_datagrid_menu";
	$ProductNav.dialog = $("#product_productNav_dialog");
	$ProductNav.form = $("#product_productNav_dialog_form");
	
	$ProductNav.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productNav/all.action" />'+_userUrl;
	$ProductNav.parentUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productNav/list.action" />'+_userUrl;
	$ProductNav.addUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productNav/add.action" />'+_userUrl;//添加
	$ProductNav.delUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productNav/del.action" />'+_userUrl;//删除
	$ProductNav.editUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productNav/edit.action" />'+_userUrl;//编辑
	$ProductNav.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productNav/congeal.action" />'+_userUrl;//冻结
	$ProductNav.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productNav/thaw.action" />'+_userUrl;//解冻
	
	
	$ProductNav.yesUrl = '${base_url}/resource/admin/images/yes.jpg';
	$ProductNav.noUrl = '${base_url}/resource/admin/images/no.jpg';
	
	$ProductNav.load(<shiro:hasPermission name="product:productNav:list">true</shiro:hasPermission>);//加载显示列表信息

</script>