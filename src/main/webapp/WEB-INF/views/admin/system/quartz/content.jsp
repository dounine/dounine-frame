<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/quartz/ScheduleJob.js" type="text/javascript" charset="utf-8"></script>

<table style="height:100%;" id="quartz_schedulejob_datagrid"></table>

<div id="quartz_schedulejob_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:quartz:schedulejob:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$ScheduleJob.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="system:quartz:schedulejob:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="qsdm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$ScheduleJob.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="system:quartz:schedulejob:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="qsdm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$ScheduleJob.del();">删除</a></shiro:hasPermission>
		<a href="javascript:void(0)" disabled="true" class="easyui-menubutton" id="qsdm-menu-operator"    
       		data-options="menu:'#d-operator',iconCls:'icon-d-operator'">操作</a>
		<div id="d-operator" style='width:150px;'>   
		    <shiro:hasPermission name="system:quartz:schedulejob:thaw"><div data-options="iconCls:'icon-d-run'" id="qsdm-operator-menu-run" onclick="$ScheduleJob.run();">运&nbsp;行</div></shiro:hasPermission>   
		    <shiro:hasPermission name="system:quartz:schedulejob:congeal"><div data-options="iconCls:'icon-d-stop'" id="qsdm-operator-menu-stop" onclick="$ScheduleJob.stop();">停&nbsp;止</div></shiro:hasPermission>   
		    <shiro:hasPermission name="system:quartz:schedulejob:restart"><div data-options="iconCls:'icon-d-restart'" onclick="$ScheduleJob.restart();">重&nbsp;启</div></shiro:hasPermission>   
		</div> 
		<a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-read'" onclick="$ScheduleJob.quartz();">表达式</a>
		<shiro:hasPermission name="system:quartz:schedulejob:async"><a href="javascript:void(0);" plain="true" disabled="true" id="qsdm-menu-sync" class="easyui-linkbutton" data-options="iconCls:'icon-d-sync'" onclick="$ScheduleJob.async();">同步定时器</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="quartz_schedulejob_search_form" onsubmit="return false;">
			同步：<font id="async_id"><img src="${base_url}/resource/admin/css/themes/icons/dounine-icon-async.png"></font>
			名称: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="scheduleJobName" style="width: 140px;"/>
			&nbsp;状态: <select name="status" editable="false" class="easyui-combobox" panelHeight="auto" style="width: 100px;">
						<option value="">请选择</option>
						<option value="NORMAL">运行中</option>
						<option value="CONGEAL">停止</option>
					</select>
			<shiro:hasPermission name="system:quartz:schedulejob:search"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$ScheduleJob.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a></shiro:hasPermission>
		</form>
	</span>
</div>

<div id="quartz_schedulejob_dialog" style="display:none;">
	<form id="quartz_schedulejob_quartz_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>定时器名称:</td>
				<td>
					<input style="width: 134px;" name="scheduleJobName" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="scheduleJobId" type="text" />
				</td>
				<td>表达式:</td>
				<td>
					<input style="width: 134px;" name="scheduleJobCronExpression" type="text" class="easyui-textbox" required="required" />
				</td>
			</tr>
			<tr>
				<td>调用类:</td>
				<td>
					<input style="width: 134px;" name="scheduleJobClass" type="text" class="easyui-textbox" required="required" />
				</td>
				<td>执行方法:</td>
				<td>
					<input style="width: 134px;" name="scheduleJobMethod" type="text" class="easyui-textbox" required="required" />
				</td>
			</tr>
			<tr>
				<td>分组类型:</td>
				<td>
					<input style="width: 134px;" name="scheduleJobGroup.scheduleJobGroupId" class="form-for-data" id="scheduleJobGroupId" required="required" />
				</td>
				<td>定时器描述:</td>
				<td>
					<input style="width: 134px;" name="scheduleJobDescription" type="text" class="easyui-textbox" />
				</td>
			</tr>
		</table>
	</form>
</div>
<div class="easyui-dialog" id="quartz_schedulejob_quartz_dialog" title="&nbsp;定时器信息" data-options="width:800,closed:true,iconCls:'icon-d-info',modal:true">
	<table class="easyui-grid">
			<tr>
				<td>秒 0-59 , – * /</td>
				<td>分 0-59 , – * /</td>
				<td>小时 0-23 , – * /</td>
				<td>日期 1-31 , – * ? / L W C</td>
			</tr>
			<tr>
				<td>月份 1-12 或者 JAN-DEC , – * /</td>
				<td>
				星期 1-7 或者 SUN-SAT , – * ? / L C #
				</td>
				<td colspan="2">年（可选） 留空, 1970-2099 , – * /</td>
			</tr>
			<tr>
				<td colspan="4">表达式意义</td>
			</tr>
			<tr>
				<td>0 0 12 * * ?</td>
				<td>每天中午12点触发</td>
				<td>0 15 10 ? * *</td>
				<td>每天上午10:15触发</td>
			</tr>
			<tr>
				<td>0 15 10 * * ? 2005</td>
				<td>2005年的每天上午10:15触发</td>
				<td>0 * 14 * * ?</td>
				<td>在每天下午2点到下午2:59期间的每1分钟触发</td>
			</tr>
			<tr>
				<td>0 0/5 14 * * ?</td>
				<td>在每天下午2点到下午2:55期间的每5分钟触发</td>
				<td>0 0/5 14,18 * * ?</td>
				<td>在每天下午2点到2:55期间和下午6点到6:55期间的每5分钟触发</td>
			</tr>
			<tr>
				<td>0 0-5 14 * * ?</td>
				<td>在每天下午2点到下午2:05期间的每1分钟触发</td>
				<td>0 10,44 14 ? 3 WED</td>
				<td>每年三月的星期三的下午2:10和2:44触发</td>
			</tr>
			<tr>
				<td>0 15 10 ? * MON-FRI</td>
				<td>周一至周五的上午10:15触发</td>
				<td>0 15 10 15 * ?</td>
				<td>每月15日上午10:15触发</td>
			</tr>
			<tr>
				<td>0 15 10 L * ?</td>
				<td>每月最后一日的上午10:15触发</td>
				<td>0 15 10 ? * 6L</td>
				<td>每月的最后一个星期五上午10:15触发</td>
			</tr>
			<tr>
				<td>0 15 10 ? * 6L 2002-2005</td>
				<td>2002年至2005年的每月的最后一个星期五上午10:15触发</td>
				<td>0 15 10 ? * 6#3</td>
				<td>每月的第三个星期五上午10:15触发</td>
			</tr>
			<tr>
				<td>0 6 * * *</td>
				<td>每天早上6点</td>
				<td>0 * /2 * * *</td>
				<td>每两个小时</td>
			</tr>
			<tr>
				<td>0 23-7/2，8 * * *</td>
				<td>晚上11点到早上8点之间每两个小时，早上八点</td>
				<td>0 11 4 * 1-3</td>
				<td>每个月的4号和每个礼拜的礼拜一到礼拜三的早上11点</td>
			</tr>
			<tr>
				<td>0 4 1 1 * */</td>
				<td>1月1日早上4点</td>
			</tr>
		</table>
</div>

<script type="text/javascript">
	function delete_定时器列表(){//命名规则  delete_(+)所在tab名称
		$('#quartz_schedulejob_dialog').dialog('destroy');//凡是easyui dialog组件,必需调用destroy销毁方法。
		$('#quartz_schedulejob_quartz_dialog').dialog('destroy');
	}

	var $ScheduleJob = new ScheduleJob();
	$ScheduleJob.datagrid = $("#quartz_schedulejob_datagrid");
	$ScheduleJob.datagrid_menu = "#quartz_schedulejob_datagrid_menu";
	$ScheduleJob.dialog = $("#quartz_schedulejob_dialog");
	$ScheduleJob.dialog_quartz = $("#quartz_schedulejob_quartz_dialog");
	$ScheduleJob.form = $("#quartz_schedulejob_quartz_form");
	$ScheduleJob.ckAsyncId = $("#async_id");
	$ScheduleJob.group = $("input[class=form-for-data][id=scheduleJobGroupId]");
	$ScheduleJob.searchName = $('input[id=scheduleJobName][name=scheduleJobName]');
	$ScheduleJob.searchScheduleJobStatus = $('select[id=scheduleJobStatus][name=scheduleJobStatus]');
	$ScheduleJob.dialog_buttons_addedit = $('#quartz_schedulejob_dialog_buttons_addedit');
	$ScheduleJob.searchForm = $('#quartz_schedulejob_search_form');
	
	$ScheduleJob.groupUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejobgroup/all.action" />'+_userUrl;
	$ScheduleJob.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejob/maps.action" />'+_userUrl;
	$ScheduleJob.addUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejob/add.action" />'+_userUrl;//添加
	$ScheduleJob.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejob/del.action" />'+_userUrl;//删除
	$ScheduleJob.editUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejob/edit.action" />'+_userUrl;//编辑
	$ScheduleJob.stopUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejob/congeal.action" />'+_userUrl;//停止 
	$ScheduleJob.runUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejob/thaw.action" />'+_userUrl;//运行
	$ScheduleJob.restartUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejob/restart.action" />'+_userUrl;//重启
	$ScheduleJob.asyncUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejob/async.action" />'+_userUrl;//同步定时器
	$ScheduleJob.ckAsyncUrl = '<dounine-csrf:token-value uri="${base}/admin/system/quartz/schedulejob/ckasync.action" />'+_userUrl;//检查同步
	
	$ScheduleJob.load(<shiro:hasPermission name="system:quartz:schedulejob:maps">true</shiro:hasPermission>);//加载显示列表信息
	$ScheduleJob.ckAsync(<shiro:hasPermission name="system:quartz:schedulejob:ckasync">true</shiro:hasPermission>);//检测是否同步
	
</script>