<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/bug/info/Info.js" type="text/javascript" charset="utf-8"></script>

<div class="easyui-layout" style="height:100%;border-top:none;">
	<div region='center' id="bugCenter" style="border-top:none;">
		<div class="nav-settab">
			<span class="nav-tab-one"></span> 
			<span class="nav-tabs">
				<a href="javascript:void(0);" onclick="return_bug_list();">BUG列表</a> | <a href="javascript:void(0);" class="nav-tabs-select">发布BUG</a> </span> 
			<span class="nav-tab-two"></span>
		</div>
	
		<form id="bug_form" method="post">
			<table class="easyui-grid">
				<tr>
					<td colspan="2" style="border-left:none;text-align:left;font-size:14px;border-top:none;height:40px;"><b>发布新BUG</b></td>
				</tr>
				<tr>
					<td style="border-left:none;text-align:left;" colspan="2">
						<div class="publish_c" style="width:98%;margin:auto;">
							<li>
								<span style="float:left;">
									<input type="hidden" name="bugId" />
									<input type="text" required="true" class="easyui-textbox" name="bugName" style="width:300px;" />
								</span>
								<span id="nothis">
									<strong class="q"></strong>
									<strong class="w">名称：必填</strong>
									<strong class="c"></strong>
								</span>
							</li>
							<li>
								<span style="float:left;">
									<input type="text" id="bugType" name="bugType.bugTypeId" />
								</span>
								<span id="nothis">
									<strong class="q"></strong>
									<strong class="w">类型：必选</strong>
									<strong class="c"></strong>
								</span>
							</li>
							<li>
								<p style="height:30px;line-height:30px;">内容</p>
								<script id="bugContent" type="text/plain" name="bugContent" style="width:100%;"></script>
								<a href="javascript:void(0);" iconCls="icon-d-save" id="bugButton" onclick="$Info.save($Bug);" style="float:right;margin-top:10px;background:green;color:white;" class="easyui-linkbutton">&nbsp;&nbsp;发&nbsp;&nbsp;布&nbsp;&nbsp;</a>
							</li>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
	
<script>
function delete_BUG管理(){//命名规则  delete_(+)所在tab名称
}
var $Info = new Info();
$Info.form = $("#bug_form");
$Info.type = $("#bugType");

$Info.addUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugm/add.action" />'+_userUrl;//添加
$Info.editUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugm/edit.action" />'+_userUrl;//编辑
$Info.bugTypeUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugType/all.action" />'+_userUrl;//列表
$Info.findUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugm/find.action" />'+_userUrl;

$Info.load($Bug);
$(function(){
	setTimeout(function(){//为了能获取到高度
		$("#bugContent").height($("#bugCenter").height()-($("#bugCenter").height()/2.4));
		var content = (new UE.ui.Editor());
		content.render('bugContent');
		if(!$Bug.button){
			content.addListener('ready', function( editor ) {
					$.post($Info.findUrl,{'bugId':$Bug.row.bugId},function(data){
						content.execCommand('clearDocs');
						content.execCommand('insertHtml', data.bugContent);
					});
			 } );
		}
	});
});

var _tab_operator_url = '${base}/admin/system/bug/bugm/content.html'+userUrl;
function return_bug_list(){
	var select_tab = $('#lox-tabs').tabs('getSelected');
	$(select_tab).attr("lox-data-options","href:'"+_tab_operator_url+"'").css('style','hidden');
	$('#lox-tabs').tabs('update',{
		tab:select_tab,
		title:'BUG管理',
		options:{
			href:_tab_operator_url,
			method:'post'
		}
	});
}
</script>
