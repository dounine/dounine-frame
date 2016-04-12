var ScheduleJob_Group = (function() {

	function ScheduleJob_Group() {
	}
	
	function getModuleName(){
		return "定时器";
	}
	
	ScheduleJob_Group.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	ScheduleJob_Group.prototype.success_refresh = true;//操作成功后刷新列表
	
	ScheduleJob_Group.prototype.Data_Id = function (row){
		return {'scheduleJobGroupId':row['scheduleJobGroupId']};
	}
	
	ScheduleJob_Group.prototype.load = function() {
		$ScheduleJob_Group.datagrid.datagrid({
			url : arguments.length==0?null:$ScheduleJob_Group.loadUrl,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			singleSelect : true,
			nowrap : true,
			striped : true,
			border : false,
			onClickRow : rowClick,
			collapsible : true,
			columns : [ [ {
				field : 'scheduleJobGroupId',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'scheduleJobGroupName',
				title : '定时器分组名称',
				sortable:true,
				width : 100
			}, {
				field : 'createTimeT',
				title : '创建时间',
				sortable:true,
				width : 100
			}, {
				field : 'status',
				title : '定时器分组状态',
				sortable:true,
				formatter : function(val, row) {
					if (val=='NORMAL') {
						return '正常';
					} else {
						return '<font style="color:red">冻结</font>';
					}
				},
				width : 100
			}, {
				field : 'scheduleJobGroupDescription',
				title : '定时器分组描述',
				width : 100
			} ] ],
			toolbar : $ScheduleJob_Group.datagrid_menu
		});
		
		function rowClick(){
			var row = $ScheduleJob_Group.datagrid.datagrid('getSelected');
			if(row.status=='NORMAL'){
				$('#qsgdm-menu-remove').menubutton('enable');
				$('#qsgdm-menu-edit').menubutton('enable');
				$('#qsgdm-menu-congeal').menubutton('enable');
				$('#qsgdm-menu-thaw').menubutton('disable');
			}else{
				$('#qsgdm-menu-remove').menubutton('disable');
				$('#qsgdm-menu-edit').menubutton('disable');
				$('#qsgdm-menu-congeal').menubutton('disable');
				$('#qsgdm-menu-thaw').menubutton('enable');
			}
		}
	}

	ScheduleJob_Group.prototype.del = function() {
		var row = $ScheduleJob_Group.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($ScheduleJob_Group.delUrl, $ScheduleJob_Group.Data_Id(row), function(data) {
					if (data == "success") {
						msgShow('操作成功', getModuleName()+'删除成功.');
						dataGridReload();
					} else {
						if(dataFilter(data).length>0){
							$.messager.alert('删除错误', data, 'error');
						}
					}
					$.messager.progress('close');
				});
			}
		});
	}

	ScheduleJob_Group.prototype.add = function() {
		dialogOpen('添加');
		$.messager.progress('close');
		$ScheduleJob_Group.button = true;
		$ScheduleJob_Group.form.form('clear');
	}

	ScheduleJob_Group.prototype.edit = function() {
		dialogOpen('编辑');
		$.messager.progress('close');
		var row = $ScheduleJob_Group.datagrid.datagrid('getSelected');
		$ScheduleJob_Group.button = false;
		$ScheduleJob_Group.form.form('load', row);
	}

	ScheduleJob_Group.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $ScheduleJob_Group.datagrid.datagrid('getSelected');
		$.post($ScheduleJob_Group.congealUrl,$ScheduleJob_Group.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('冻结成功', getModuleName()+'冻结成功.');
				dataGridReload();
			} else {
				if(dataFilter(data).length>0){
					$.messager.alert('温馨提示', data, 'error');
				}
			}
		});
	}

	ScheduleJob_Group.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $ScheduleJob_Group.datagrid.datagrid('getSelected');
		$.post($ScheduleJob_Group.thawUrl, $ScheduleJob_Group.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('解冻成功', getModuleName()+'解冻成功.');
				dataGridReload();
			} else {
				if(dataFilter(data).length>0){
					$.messager.alert('温馨提示', data, 'error');
				}
			}
		});
	}

	ScheduleJob_Group.prototype.search = function() {
		$ScheduleJob_Group.datagrid.datagrid('reload', $ScheduleJob_Group.searchForm.serializeObject());
	}

	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($ScheduleJob_Group.success_refresh){
			tex = '<font style="color:#B1B1B1;" class="check_font_for_refresh">操作成功后刷新</font> <input class="check_input_for_refresh" type="checkbox" style="display:none;vertical-align: middle;" disabled="disabled" checked="checked"/>';
		}else{
			tex = '<font style="color:#B1B1B1;" class="check_font_for_refresh">操作成功后不刷新</font> <input class="check_input_for_refresh" type="checkbox" style="display:none;vertical-align: middle;" disabled="disabled"/>';
		}
		var ref_title = {
			plain:true,
			text : tex,
			handler:function(){
				var input1 = $(this).find('input');
				if(input1.attr('checked')){
					$ScheduleJob_Group.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$ScheduleJob_Group.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $ScheduleJob_Group.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $ScheduleJob_Group.close	
		};
		var buttons = [];
		if(read){
			$.extend(close_btn,{text:'关闭'});//克隆属性
		}else{
			buttons.push(ref_title);
			buttons.push(save_btn);
		}
		buttons.push(close_btn);
		$ScheduleJob_Group.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$ScheduleJob_Group.form.form('submit', {
			url : url,
			onSubmit : function() {
				var isValid = $(this).form('validate');
				if (isValid) {
					$.messager.progress('close');
				}
				if (isValid) {
					$.messager.progress();
				}
				return $(this).form('validate');
			},
			success : function(data) {
				$.messager.progress('close');
				if (data == 'success') {
					msgShow($ScheduleJob_Group.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($ScheduleJob_Group.success_refresh);
					if($ScheduleJob_Group.success_refresh){//成功后刷新
						dataGridReload();
					}
				} else {
					dialogOpen(successInfo);
					if(dataFilter(data).length>0){
						$.messager.alert($ScheduleJob_Group.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	ScheduleJob_Group.prototype.save = function() {
		if ($ScheduleJob_Group.button) {
			formSubmit($ScheduleJob_Group.addUrl,'添加');// 表单添加
		} else {
			formSubmit($ScheduleJob_Group.editUrl,'编辑');// 表单编辑
		}
	}

	ScheduleJob_Group.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$ScheduleJob_Group.dialog.dialog('close');
	}
	
	function dataGridReload(){
		$ScheduleJob_Group.datagrid.datagrid('reload');
		initButtons();
	}
	
	function initButtons() {
		$('#qsgdm-menu-remove').menubutton('disable');
		$('#qsgdm-menu-edit').menubutton('disable');
		$('#qsgdm-menu-congeal').menubutton('disable');
		$('#qsgdm-menu-thaw').menubutton('disable');
	}


	return ScheduleJob_Group;
})();
