<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/quartz/group/ScheduleJob_Group.js" type="text/javascript" charset="utf-8"></script>

<table style="height:100%;" id="quartz_schedulejob_group_datagrid"></table>

<div id="quartz_schedulejob_group_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:quartz:schedulejobgroup:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$ScheduleJob_Group.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="system:quartz:schedulejobgroup:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="qsgdm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$ScheduleJob_Group.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="system:quartz:schedulejobgroup:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="qsgdm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$ScheduleJob_Group.del();">删除</a></shiro:hasPermission>
		<shiro:hasPermission name="system:quartz:schedulejobgroup:congeal"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="qsgdm-menu-congeal" data-options="iconCls:'icon-d-congeal'" onclick="$ScheduleJob_Group.congeal();">冻结</a></shiro:hasPermission>
		<shiro:hasPermission name="system:quartz:schedulejobgroup:thaw"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="qsgdm-menu-thaw" data-options="iconCls:'icon-d-thaw'" onclick="$ScheduleJob_Group.thaw();">解冻</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="quartz_schedulejob_group_search_form" onsubmit="return false;">
			名称: <input iconCls="icon-d-name" type="text" class="easyui-textbox" name="scheduleJobGroupName" style="width: 140px;"/>
			&nbsp;状态: <select name="status" editable="false" class="easyui-combobox" panelHeight="auto" style="width: 100px;">
						<option value="">请选择</option>
						<option value="NORMAL">正常</option>
						<option value="CONGEAL">冻结</option>
					</select>
			<a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$ScheduleJob_Group.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a>
		</form>
	</span>
</div>

<div id="quartz_schedulejob_group_dialog" >
	<form id="quartz_schedulejob_group_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>定时器分组名称:</td>
				<td>
					<input style="width: 134px;" name="scheduleJobGroupName" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="scheduleJobGroupId" type="text" />
				</td>
				<td>定时器类型描述:</td>
				<td>
					<input style="width: 134px;" name="scheduleJobGroupDescription" type="text" class="easyui-textbox" />
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_定时器类型(){//命名规则  delete_(+)所在tab名称
		$('#quartz_schedulejob_group_dialog').dialog('destroy');//凡是easyui dialog组件,必需调用destroy销毁方法。
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $ScheduleJob_Group = new ScheduleJob_Group();
	$ScheduleJob_Group.datagrid = $("#quartz_schedulejob_group_datagrid");
	$ScheduleJob_Group.datagrid_menu = "#quartz_schedulejob_group_datagrid_menu";
	$ScheduleJob_Group.dialog = $("#quartz_schedulejob_group_dialog");
	$ScheduleJob_Group.form = $("#quartz_schedulejob_group_dialog_form");
	$ScheduleJob_Group.searchName = $('input[id=scheduleJob_GroupName][name=scheduleJobGroupName]');
	$ScheduleJob_Group.searchScheduleJob_GroupStatus = $('select[id=scheduleJob_GroupStatus][name=scheduleJobGroupStatus]');
	$ScheduleJob_Group.dialog_buttons_addedit = $('#quartz_schedulejob_group_dialog_buttons_addedit');
	$ScheduleJob_Group.searchForm = $('#quartz_schedulejob_group_search_form');
	
	
	$ScheduleJob_Group.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejobgroup/maps.action" />'+_userUrl;
	$ScheduleJob_Group.addUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejobgroup/add.action" />'+_userUrl;//添加
	$ScheduleJob_Group.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejobgroup/del.action" />'+_userUrl;//删除
	$ScheduleJob_Group.editUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejobgroup/edit.action" />'+_userUrl;//编辑
	$ScheduleJob_Group.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejobgroup/congeal.action" />'+_userUrl;//冻结
	$ScheduleJob_Group.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejobgroup/thaw.action" />'+_userUrl;//解冻
	
	$ScheduleJob_Group.load(<shiro:hasPermission name="system:quartz:schedulejobgroup:maps">true</shiro:hasPermission>);//加载显示列表信息
</script>