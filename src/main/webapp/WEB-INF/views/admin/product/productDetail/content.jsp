<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/product/productDetail/ProductDetail.js" type="text/javascript" charset="utf-8"></script>
<style>
.product-nav{
	padding-top: 20px;
	border-right: 1px solid #EEEEEE;
	height: 500px;
	color: #555;
	overflow-x: auto;
}
.product-nav li{
	margin:4px 0;
	color: #777777;
	height: 30px;
	line-height: 30px;
	font-size: 14px;
	cursor: pointer;
	white-space: nowrap;
}
.product-nav li a{
	display: block;
	color: #777777;
	text-decoration: none;
}
.product-nav a:hover{
	background: #EEEEEE;
}
.product_nav_selected{
	background: #EEEEEE;
}
.product-nav div{
	text-indent: 24px;
	margin-left:20px;
}
.product-nav .nav-parent{
	border-left: 4px solid #3BB4F2;
	text-indent: 10px;
	padding: 2px 0;
	font-weight: 700;
	font-size: 14px;
}
.product-nav-title{
	height:36px;
	width:170px;
	margin:4px auto;
	line-height:36px;
	text-align:center;
	font-weight:700;
	font-size:14px;
	color:#666666;
	background:#F7F7F7;
	border:1px solid #DEDEDE;
	border-radius:2px;
}
#product-nav-box{
	width:200px;
}
</style>
<div class="easyui-layout" style="height:100%;border-top:none;">
	<div region='center' id="articleCenter" style="border-top:none;position:relative;">
		<div class="nav-settab">
			<span class="nav-tab-one"></span> 
			<span class="nav-tabs">
				<a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/product/content.html'+userUrl);">框架列表</a> | <a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/product/info.html'+userUrl)" id="publish_frame_a">发布框架</a> | <a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/productPicture/content.html'+userUrl)">图片列表</a> | <a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/productDetail/content.html'+userUrl)" class="nav-tabs-select">详细信息</a> </span>
			<span class="nav-tab-two"></span>
		</div>
	
		<table class="easyui-grid">
			<tr>
				<td colspan="2" style="border-left:none;text-align:left;font-size:14px;border-top:none;height:30px;"><b>框架详细信息</b></td>
			</tr>
		</table>
		<div class="easyui-layout" style="height:100%;">
			<div data-options="region:'west',width:200">
				<div class="product-nav-title">位 置 导 航</div>
				<div id="product-nav-box">
					<div class="product-nav">
						
					</div>
				</div>
			</div>
			<div data-options="region:'center'" id="productDetailCenter">
				<form id="productDetailContentForm" method="post">
					<script id="productDetailContent" type="text/plain" name="content" style="width:99%;margin:4px auto;"></script>
				</form>
				<a href="javascript:void(0);" iconCls="icon-d-save" onclick="product_detail_content_commit();" style="float:right;margin:10px;" class="easyui-linkbutton">&nbsp;&nbsp;提&nbsp;&nbsp;交&nbsp;&nbsp;</a>
			</div>
		</div>
	</div>
</div>
<script>

	var product_nav_url = '<dounine-csrf:token-value uri="${base}/admin/product/productNav/all.action" />'+_userUrl;
	var product_detail_url = '<dounine-csrf:token-value uri="${base}/admin/product/productDetail/find.action" />'+_userUrl;
	var product_detail_add = '<dounine-csrf:token-value uri="${base}/admin/product/productDetail/add.action" />'+_userUrl;
	var product_detail_edit = '<dounine-csrf:token-value uri="${base}/admin/product/productDetail/edit.action" />'+_userUrl;
	var _product_click_json = null;//点击导航位置获取的json数据
	var _product_click_data = null;//点击导航位置后台获取的数据
	
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
	
	$(function(){
		$("#productId").val($Product.row.id);
	});
	
	var product_detail_content = null;
	
	setTimeout(function(){
		$("#productDetailContent").height($("#productDetailCenter").height()-$("#productDetailCenter").height()/2);
		product_detail_content = (new UE.ui.Editor());
		product_detail_content.render('productDetailContent');
	});
	
	function set_product_detail_content(self){//位置导航点击方法
		product_detail_content.setContent('');
		var p_obj = $(self).parent();
		$("#product-nav-box").find('.product_nav_selected').removeClass('product_nav_selected');
		$(self).addClass('product_nav_selected');
		$("#productDetailCenter").mask({'maskMsg':'内容加载中...'});
		_product_click_data = null;
		_product_click_json = null;
		_product_click_json = eval('('+'{'+p_obj.attr('dounine-options')+'}'+')');
		$.post(product_detail_url,{'product.id':$Product.row.id,'productNav.id':_product_click_json.id},function(data){
			_product_click_data = data;
			$("#productDetailCenter").mask('hide');
			if(_product_click_data!=''){
				product_detail_content.execCommand('insertHtml', data.content);
			}
		});
	}
	
	function product_detail_content_commit(){
		var ajax_par = '&product.id='+$Product.row.id+'&productNav.id='+_product_click_json.id;
		$("#productDetailContentForm").form('submit', {
			url : (_product_click_data==''?product_detail_add+ajax_par:product_detail_edit)+ajax_par,
			onSubmit : function() {
				$.messager.progress();
				return true;
			},
			success : function(data) {
				$.messager.progress('close');
				if (data == 'success') {
					msgShow('温馨提示','操作成功.');
				} else {
					if(dataFilter(data).length>0){
						$.messager.alert($ProductDetail.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}
</script>

<script type="text/javascript">
var product_nav_obj = null;
$(function(){
	product_nav_obj = $('div.product-nav');
	$("#product-nav-box").mask({'maskMsg':'数据加载中...'});
	$.post(product_nav_url,function(data){
		$("#product-nav-box").mask('hide');
		var lists = data;
		if(lists.length>0){//判断有对象
			for(var index in lists){
				var obj = lists[index];
				children_tree_operator(obj);
				if(obj.children&&obj.children.length>0){
					for(var _i in obj.children){
						each_children_tree(obj.children[_i]);
					}
				}
			}
		}
	});
});

function children_tree_operator(obj){
	if(obj.parent){
		var curr_par = $("#nav_product_id_"+obj.parent.id).parent();
		var curr_ul = null;
		if(!curr_par.next().is('ul')){
			curr_ul = $('<ul></ul>').appendTo(curr_par.parent());
		}else{
			curr_ul = curr_par.next();
		}
		if(obj.children&&obj.children.length>0){
			$("<div><ul class='nav-parent'><p id='nav_product_id_"+obj.id+"' >"+obj.name+"</p></ul></div>").appendTo(curr_par.parent());
		}else{
			$("<li id='nav_product_id_"+obj.id+"' ><p id='nav_product_id_"+obj.id+"' dounine-options='id:"+obj.id+",parent:"+obj.parent.id+",displayUrl:"+obj.displayUrl+"'><a href='javascript:void(0);' onclick='set_product_detail_content(this);'>"+obj.name+"</a><p></li>").appendTo(curr_ul);
		}
	}else{
		$("<div><ul class='nav-parent'><p id='nav_product_id_"+obj.id+"' >"+obj.name+"</p></ul></div>").appendTo(product_nav_obj);
	}
}

function each_children_tree(obj){//循环子节点
	children_tree_operator(obj);
	if(obj.children&&obj.children.length>0){
		for(var _i in obj.children){
			each_children_tree(obj.children[_i]);
		}
	}
}

</script>

