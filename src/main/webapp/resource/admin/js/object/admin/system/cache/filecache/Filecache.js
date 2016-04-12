var Filecache = (function() {

	function Filecache() {
	}
	
	function getModuleName(){
		return "文件缓存";
	}
	
	Filecache.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	Filecache.prototype.success_refresh = true;//操作成功后刷新列表
	
	Filecache.prototype.Data_Id = function (row){
		return {'fileCacheId':row['fileCacheId']};
	}
	
	Filecache.prototype.load = function() {
		$Filecache.datagrid.datagrid({
			url : $Filecache.loadUrl,
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
				field : 'fileCacheId',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'fileCacheName',
				title : '缓存名称',
				sortable:true,
				width : 100
			}, {
				field : 'fileCacheResource',
				title : '缓存链接',
				sortable:true,
				width : 100
			}, {
				field : 'createTimeT',
				title : '创建时间',
				sortable:true,
				hidden:true,
				width : 100
			}, {
				field : 'status',
				title : '缓存状态',
				sortable:true,
				formatter : function(val, row) {
					if (val=='NORMAL') {
						return '启动';
					} else {
						return '<font style="color:red">禁用</font>';
					}
				},
				width : 100
			}, {
				field : 'fileCacheDescription',
				title : '缓存描述',
				width : 100
			} ] ],
			toolbar : $Filecache.datagrid_menu
		});
		
		function rowClick(){
			var row = $Filecache.datagrid.datagrid('getSelected');
			if(row.status=='NORMAL'){
				$('#sfdm-menu-remove').menubutton('enable');
				$('#sfdm-menu-edit').menubutton('enable');
				$('#sfdm-menu-congeal').menubutton('enable');
				$('#sfdm-menu-thaw').menubutton('disable');
			}else{
				$('#sfdm-menu-remove').menubutton('disable');
				$('#sfdm-menu-edit').menubutton('disable');
				$('#sfdm-menu-congeal').menubutton('disable');
				$('#sfdm-menu-thaw').menubutton('enable');
			}
		}
	}

	Filecache.prototype.del = function() {
		var row = $Filecache.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($Filecache.delUrl, $Filecache.Data_Id(row), function(data) {
					if (data == "success") {
						msgShow('操作成功', getModuleName()+'删除成功.');
						dataGridReload();
					} else {
						$.messager.alert('删除错误', data, 'error');
					}
					$.messager.progress('close');
				});
			}
		});
	}

	Filecache.prototype.add = function() {
		dialogOpen('添加');
		$.messager.progress('close');
		$Filecache.button = true;
		$Filecache.form.form('clear');
	}

	Filecache.prototype.edit = function() {
		dialogOpen('编辑');
		$.messager.progress('close');
		var row = $Filecache.datagrid.datagrid('getSelected');
		$Filecache.button = false;
		$Filecache.form.form('load', row);
	}

	Filecache.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $Filecache.datagrid.datagrid('getSelected');
		$.post($Filecache.congealUrl,$Filecache.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('冻结成功', getModuleName()+'冻结成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	Filecache.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $Filecache.datagrid.datagrid('getSelected');
		$.post($Filecache.thawUrl, $Filecache.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('解冻成功', getModuleName()+'解冻成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	Filecache.prototype.search = function() {
		$Filecache.datagrid.datagrid('reload', $Filecache.searchForm.serializeObject());
	}

	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($Filecache.success_refresh){
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
					$Filecache.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$Filecache.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $Filecache.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $Filecache.close	
		};
		var buttons = [];
		if(read){
			$.extend(close_btn,{text:'关闭'});//克隆属性
		}else{
			buttons.push(ref_title);
			buttons.push(save_btn);
		}
		buttons.push(close_btn);
		$Filecache.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$Filecache.form.form('submit', {
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
					msgShow($Filecache.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($Filecache.success_refresh);
					if($Filecache.success_refresh){//成功后刷新
						dataGridReload();
					}
				} else {
					dialogOpen(successInfo);
					$.messager.alert($Filecache.Messager_Title(), data, 'error');
				}
			}
		});
	}

	Filecache.prototype.save = function() {
		if ($Filecache.button) {
			formSubmit($Filecache.addUrl,'添加');// 表单添加
		} else {
			formSubmit($Filecache.editUrl,'编辑');// 表单编辑
		}
	}

	Filecache.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$Filecache.dialog.dialog('close');
	}
	
	function dataGridReload(){
		$Filecache.datagrid.datagrid('reload');
		initButtons();
	}
	
	function initButtons() {
		$('#qsgdm-menu-remove').menubutton('disable');
		$('#qsgdm-menu-edit').menubutton('disable');
		$('#qsgdm-menu-congeal').menubutton('disable');
		$('#qsgdm-menu-thaw').menubutton('disable');
	}


	return Filecache;
})();
