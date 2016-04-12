var Department = (function() {

	function Department() {
		
	}

	function getModuleName() {
		return "部门";
	}
	
	var loadingCount = 0;
	var loadingImg = $(loadingImgObj);
	
	function delLoadingCount(){
		loadingCount--;
		if(loadingCount<=0){
			loadingImg.hide();
		}
	}
	
	function addLoadingCount(){
		loadingCount++;
		if(loadingCount>0){
			loadingImg.show();
		}
	}
	
	Department.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	Department.prototype.success_refresh = true;//操作成功后刷新列表
	
	Department.prototype.Data_Id = function (row){
		return {'departmentId':row['departmentId']};
	}

	Department.prototype.load = function() {
		$Department.treegrid
				.treegrid({
					url : arguments.length == 0 ? null : $Department.loadUrl,
					rownumbers : true,
					lines : true,
					border:false,
					fitColumns : true,
					idField : 'departmentId',
					treeField : 'departmentName',
					onSelect : rowClick,
					columns : [ [ {
						field : 'departmentId',
						title : 'ID编号',
						hidden : true,
						width : 100
					}, {
						field : 'departmentName',
						title : '部门名称',
						width : 100
					}, {
						field : 'departmentParent',
						title : '上级部门',
						hidden : true,
						width : 100
					}, {
						field : 'createTimeT',
						title : '创建时间',
						width : 100
					}, {
						field : 'status',
						title : '部门状态',
						formatter : function(val, row) {
							if (val == 'NORMAL') {
								return '正常';
							} else {
								return '<font style="color:red">冻结</font>';
							}
						},
						width : 100
					}, {
						field : 'departmentDescription',
						title : '部门描述',
						width : 100
					} ] ],
					onBeforeExpand : function(node) {
						$Department.treegrid.treegrid('options').url = $Department.loadUrl
								+ '&departmentId=' + node.departmentId;
					},
					toolbar : $Department.treegrid_menu
				});

		function rowClick() {
			var row = $Department.treegrid.treegrid('getSelected');
			if (row.status == 'NORMAL') {
				$('#sudtm-menu-edit').menubutton('enable');
				$('#sudtm-menu-remove').menubutton('enable');
				$('#sudtm-menu-congeal').menubutton('enable');
				$('#sudtm-menu-thaw').menubutton('disable');
			} else {
				$('#sudtm-menu-edit').menubutton('disable');
				$('#sudtm-menu-remove').menubutton('disable');
				$('#sudtm-menu-congeal').menubutton('disable');
				$('#sudtm-menu-thaw').menubutton('enable');
			}
			if (row.departmentId == 1) {
				initButtons();
			}
		}
	}

	Department.prototype.del = function() {
		var row = $Department.treegrid.treegrid('getSelected');
		if (row) {
			$.messager.confirm('删除确认', "您确认要删除这条" + getModuleName() + "么?",
					function(r) {
						if (r) {
							$.messager.progress();
							$.post($Department.delUrl, $Department.Data_Id(row) , function(data) {
								if (data == "success") {
									msgShow('操作成功', getModuleName() + '删除成功.');
									treeGridReload();
									initButtons();
								} else {
									$.messager.alert('删除错误', data, 'error');
								}
								$.messager.progress('close');
							});
						}
					});
			return;
		}
		$.messager.alert('请选择', "请选择要删除的" + getModuleName() + ".", 'error');
	}

	Department.prototype.add = function() {
		dialogOpen('添加');
		$.messager.progress('close');
		$Department.button = true;
		$($Department.departmentParent).combotree('destroy').remove()
		$Department.form.form('clear');

		var departmentParent = addParent();// 重新添加combotree
		departmentParent.combotree('loadData',$Department.treegrid.treegrid('getRoots'));
		var node = null;
		if($Department.treegrid.treegrid('getSelected')){
			node = $Department.treegrid.treegrid('getSelected');
		}else{
			node = $Department.treegrid.treegrid('getRoot');
		}
		departmentParent.combotree('setValue',node.departmentId);
	}

	Department.prototype.edit = function() {
		dialogOpen('编辑');
		$.messager.progress('close');
		var row = $Department.treegrid.treegrid('getSelected');
		$Department.button = false;
		$($Department.departmentParent).combotree('destroy').remove();// 清空原来的combotree对象
		$Department.form.form('load', row);

		var departmentParent = addParent();// 重新添加combotree
		departmentParent.combotree('loadData', $Department.treegrid
				.treegrid('getRoots'));
		departmentParent.combotree('setValue',
				row.departmentParent.departmentId);
	}

	Department.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $Department.treegrid.treegrid('getSelected');
		$.post($Department.congealUrl, $Department.Data_Id(row) , function(data) {
			$.messager.progress('close');
			if (data == "success") {
				msgShow('操作成功', getModuleName() + '冻结成功.');
				treeGridReload();
			} else {
				$.messager.alert('冻结错误', data, 'error');
			}
		});
	}

	Department.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $Department.treegrid.treegrid('getSelected');
		$.post($Department.thawUrl, $Department.Data_Id(row) , function(data) {
			$.messager.progress('close');
			if (data == "success") {
				msgShow('操作成功', getModuleName() + '解冻成功.');
				treeGridReload();
			} else {
				$.messager.alert('解冻错误', data, 'error');
			}
		});
	}

	function treeGridReload() {
		$Department.treegrid.treegrid('options').url = $Department.loadUrl;
		$Department.treegrid.treegrid('reload');
		$Department.treegrid.treegrid('unselectAll');
		initButtons();
	}

	function addParent() {
		var departmentParent = $(
				'<table data-options="lines:true" name="departmentParent.departmentId" id="departmentParent" style="width:494px;"></table>')
				.appendTo($Department.departmentParentBox);
		addLoadingCount();
		departmentParent
				.combotree({
					url : arguments.length == 1 ? $Department.loadUrl : null,
					valueField : 'departmentId',
					textField : 'departmentName',
					editable : false,
					required : true,
					onLoadSuccess:function(){
						delLoadingCount();
					},
					onBeforeExpand : function(node) {
						departmentParent.combotree('tree').tree('options').url = $Department.loadUrl
								+ '&departmentId=' + node.departmentId;
					}
				});
		return departmentParent;
	}

	function initButtons() {
		$('#sudtm-menu-edit').linkbutton('disable');
		$('#sudtm-menu-remove').linkbutton('disable');
		$('#sudtm-menu-congeal').menubutton('disable');
		$('#sudtm-menu-thaw').menubutton('disable');
	}

	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($Department.success_refresh){
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
					$Department.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$Department.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $Department.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $Department.close	
		},loading_btn = {
			plain:true,
			text:loadingImg[0]
		};
		var buttons = [];
		buttons.push(loading_btn);
		if(read){
			$.extend(close_btn,{text:'关闭'});//克隆属性
		}else{
			buttons.push(ref_title);
			buttons.push(save_btn);
		}
		buttons.push(close_btn);
		$Department.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$Department.form.form('submit', {
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
					msgShow($Department.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($Department.success_refresh);
					if($Department.success_refresh){//成功后刷新
						treeGridReload();
					}
				} else {
					dialogOpen(successInfo);
					if(dataFilter(data).length>0){
						$.messager.alert($Department.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	Department.prototype.save = function() {
		if ($Department.button) {
			formSubmit($Department.addUrl,'添加');// 表单添加
		} else {
			formSubmit($Department.editUrl,'编辑');// 表单编辑
		}
	}

	Department.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$Department.dialog.dialog('close');
	}

	return Department;
})();
