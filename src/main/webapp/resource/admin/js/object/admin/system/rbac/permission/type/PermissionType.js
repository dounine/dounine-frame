var PermissionType = (function() {

	function PermissionType() {
	}
	
	function getModuleName(){
		return "权限类型";
	}
	
	PermissionType.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	PermissionType.prototype.success_refresh = true;//操作成功后刷新列表
	
	PermissionType.prototype.Data_Id = function (row){
		return {'permissionTypeId':row['permissionTypeId']};
	}
	
	PermissionType.prototype.load = function() {
		$PermissionType.datagrid.datagrid({
			url : arguments.length==0?null:$PermissionType.loadUrl,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			singleSelect : true,
			border:false,
			nowrap : true,
			striped : true,
			onClickRow : rowClick,
			collapsible : true,
			columns : [ [ {
				field : 'permissionTypeId',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'permissionTypeName',
				title : '权限类型名称',
				sortable:true,
				width : 100
			}, {
				field : 'createTimeT',
				title : '创建时间',
				sortable:true,
				width : 100
			}, {
				field : 'status',
				title : '权限类型状态',
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
				field : 'permissionTypeDescription',
				title : '权限类型描述',
				width : 100
			} ] ],
			toolbar : $PermissionType.datagrid_menu
		});
		
		function rowClick(){
			var row = $PermissionType.datagrid.datagrid('getSelected');
			if(row.status=='NORMAL'){
				$('#supttm-menu-remove').menubutton('enable');
				$('#supttm-menu-edit').menubutton('enable');
				$('#supttm-menu-congeal').menubutton('enable');
				$('#supttm-menu-thaw').menubutton('disable');
			}else{
				$('#supttm-menu-remove').menubutton('disable');
				$('#supttm-menu-edit').menubutton('disable');
				$('#supttm-menu-congeal').menubutton('disable');
				$('#supttm-menu-thaw').menubutton('enable');
			}
		}
	}

	PermissionType.prototype.del = function() {
		var row = $PermissionType.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($PermissionType.delUrl, $PermissionType.Data_Id(row) , function(data) {
					if (data == "success") {
						msgShow('操作成功', getModuleName()+'删除成功.');
						$PermissionType.datagrid.datagrid('reload');
					} else {
						$.messager.alert('删除错误', data, 'error');
					}
					$.messager.progress('close');
				});
			}
		});
	}

	PermissionType.prototype.add = function() {
		dialogOpen('添加');
		$PermissionType.button = true;
		$.messager.progress('close');
		$PermissionType.form.form('clear');
	}

	PermissionType.prototype.edit = function() {
		dialogOpen('编辑');
		$PermissionType.button = false;
		$.messager.progress('close');
		var row = $PermissionType.datagrid.datagrid('getSelected');
		$PermissionType.form.form('load', row);
	}

	PermissionType.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $PermissionType.datagrid.datagrid('getSelected');
		$.post($PermissionType.congealUrl, $PermissionType.Data_Id(row) , function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('冻结成功', getModuleName()+'冻结成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	PermissionType.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $PermissionType.datagrid.datagrid('getSelected');
		$.post($PermissionType.thawUrl, $PermissionType.Data_Id(row) , function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('解冻成功', getModuleName()+'解冻成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	PermissionType.prototype.search = function() {
		$PermissionType.datagrid.datagrid('reload', $PermissionType.searchForm.serializeObject());
	}

	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($PermissionType.success_refresh){
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
					$PermissionType.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$PermissionType.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $PermissionType.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $PermissionType.close	
		};
		var buttons = [];
		if(read){
			$.extend(close_btn,{text:'关闭'});//克隆属性
		}else{
			buttons.push(ref_title);
			buttons.push(save_btn);
		}
		buttons.push(close_btn);
		$PermissionType.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$PermissionType.form.form('submit', {
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
					msgShow($PermissionType.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($PermissionType.success_refresh);
					if($PermissionType.success_refresh){//成功后刷新
						dataGridReload();
					}
				} else {
					dialogOpen(successInfo);
					if(dataFilter(data).length>0){
						$.messager.alert($PermissionType.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	PermissionType.prototype.save = function() {
		if ($PermissionType.button) {
			formSubmit($PermissionType.addUrl,'添加');// 表单添加
		} else {
			formSubmit($PermissionType.editUrl,'编辑');// 表单编辑
		}
	}

	PermissionType.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$PermissionType.dialog.dialog('close');
	}
	
	function dataGridReload(){
		$PermissionType.datagrid.datagrid('reload');
		initButtons();
	}
	
	function initButtons() {
		$('#supttm-menu-remove').menubutton('disable');
		$('#supttm-menu-edit').menubutton('disable');
		$('#supttm-menu-congeal').menubutton('disable');
		$('#supttm-menu-thaw').menubutton('disable');
	}

	return PermissionType;
})();
