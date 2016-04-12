<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/product/info/Info.js" type="text/javascript" charset="utf-8"></script>
<div class="easyui-layout" style="height:100%;border-top:none;">
	<div region='center' id="articleCenter" style="border-top:none;position:relative;">
		<div class="nav-settab">
			<span class="nav-tab-one"></span> 
			<span class="nav-tabs">
				<font><a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/product/content.html'+userUrl);">框架列表</a></font>
				<font id="publish_frame_font"> | <a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/product/info.html'+userUrl)" class="nav-tabs-select">发布框架</a></font>
				<font> | <a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/productPicture/content.html'+userUrl)">图片列表</a></font>
				<font> | <a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/productDetail/content.html'+userUrl)">详细信息</a></font>
			</span>
			<span class="nav-tab-two"></span>
		</div>
	
		<form id="product_form" method="post">
			<table class="easyui-grid">
				<tr>
					<td colspan="2" style="border-left:none;text-align:left;font-size:14px;border-top:none;height:30px;"><b>发布新的框架</b></td>
				</tr>
				<tr>
					<td style="border-left:none;text-align:left;" colspan="2">
						<div class="publish_c" style="width:98%;margin:auto;">
							<li>
								<span style="float:left;">
									<input type="hidden" name="id" id="product_id" />
									<input type="text" required="true" id="product_name" class="easyui-textbox" name="name" style="width:300px;" />
								</span>
								<span id="nothis">
									<strong class="q"></strong>
									<strong class="w">标题：必填</strong>
									<strong class="c"></strong>
								</span>
							</li>
							<li>
								<span style="float:left;">
									<input type="text" id="product_sequence" required="true" data-options="min:0,editable:false" class="easyui-numberspinner" name="sequence" style="width:300px;" />
								</span>
								<span id="nothis">
									<strong class="q"></strong>
									<strong class="w">排序：值越高,排名显示越靠前,默认时间排序.</strong>
									<strong class="c"></strong>
								</span>
							</li>
							<li>
								<span style="float:left;">
									<input type="text" id="productClass" name="productClass.id" />
								</span>
								<span id="nothis">
									<strong class="q"></strong>
									<strong class="w">分类：必选</strong>
									<strong class="c"></strong>
								</span>
							</li>
							<li>
								<a href="javascript:void(0);" iconCls="icon-d-save" id="productButton" onclick="$Info.save($Product);" style="float:right;margin-top:10px;" class="easyui-linkbutton">&nbsp;&nbsp;发&nbsp;&nbsp;布&nbsp;&nbsp;</a>
							</li>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
	
<script>
	function delete_文章管理(){//命名规则  delete_(+)所在tab名称
	}
	var $Info = new Info();
	$Info.form = $("#product_form");
	$Info.type = $("#productClass");
	
	$Info.addUrl = '<dounine-csrf:token-value uri="${base}/admin/product/product/add.action" />'+_userUrl;//添加
	$Info.editUrl = '<dounine-csrf:token-value uri="${base}/admin/product/product/edit.action" />'+_userUrl;//编辑
	$Info.productClassUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productClass/all.action" />'+_userUrl;//列表
	$Info.findUrl = '<dounine-csrf:token-value uri="${base}/admin/product/product/find.action" />'+_userUrl;
	
	$Info.load($Product);
	$(function(){
		if(!$Product.row){
			$("#publish_frame_font").nextAll().hide();
		}
	});
	
	function return_tab(_tab_operator_url){
		var select_tab = $('#lox-tabs').tabs('getSelected');
		$(select_tab).attr("lox-data-options","href:'"+_tab_operator_url+"'").css('style','hidden');
		$('#lox-tabs').tabs('update',{
			tab:select_tab,
			options:{
				href:_tab_operator_url,
				method:'post'
			}
		});
	}
</script>
