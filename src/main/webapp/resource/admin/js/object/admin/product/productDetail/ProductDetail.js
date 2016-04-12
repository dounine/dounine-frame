var ProductDetail = (function() {

	function ProductDetail() {
	}
	
	function getModuleName(){
		return "框架信息";
	}
	
	ProductDetail.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	ProductDetail.prototype.success_refresh = true;//操作成功后刷新列表
	
	ProductDetail.prototype.Data_Id = function (row){
		return {'id':row['id']};
	}
	
	ProductDetail.prototype.load = function() {
		$ProductDetail.datagrid.datagrid({
			url : arguments.length==0?null:$ProductDetail.loadUrl,
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
				field : 'id',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'name',
				title : '分类名称',
				sortable:true,
				width : 100
			}, {
				field : 'createTimeT',
				title : '创建时间',
				sortable:true,
				width : 100
			}, {
				field : 'description',
				title : '分类描述',
				width : 100
			} ] ],
			toolbar : $ProductDetail.datagrid_menu
		});
		
		function rowClick(){
			var row = $ProductDetail.datagrid.datagrid('getSelected');
			if(row){
				$('#ppcdm-menu-remove').menubutton('enable');
				$('#ppcdm-menu-edit').menubutton('enable');
			}else{
				$('#ppcdm-menu-remove').menubutton('disable');
				$('#ppcdm-menu-edit').menubutton('disable');
			}
		}
	}

	ProductDetail.prototype.del = function() {
		var row = $ProductDetail.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($ProductDetail.delUrl, $ProductDetail.Data_Id(row), function(data) {
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

	ProductDetail.prototype.add = function() {
		dialogOpen('添加');
		$.messager.progress('close');
		$ProductDetail.button = true;
		$ProductDetail.form.form('clear');
	}

	ProductDetail.prototype.edit = function() {
		dialogOpen('编辑');
		$.messager.progress('close');
		var row = $ProductDetail.datagrid.datagrid('getSelected');
		$ProductDetail.button = false;
		$ProductDetail.form.form('load', row);
	}

	ProductDetail.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $ProductDetail.datagrid.datagrid('getSelected');
		$.post($ProductDetail.congealUrl,$ProductDetail.Data_Id(row), function(data) {
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

	ProductDetail.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $ProductDetail.datagrid.datagrid('getSelected');
		$.post($ProductDetail.thawUrl, $ProductDetail.Data_Id(row), function(data) {
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

	ProductDetail.prototype.search = function() {
		$ProductDetail.datagrid.datagrid('reload', $ProductDetail.searchForm.serializeObject());
	}

	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($ProductDetail.success_refresh){
			tex = '<font style="color:#B1B1B1;" Detail="check_font_for_refresh">操作成功后刷新</font> <input Detail="check_input_for_refresh" type="checkbox" style="display:none;vertical-align: middle;" disabled="disabled" checked="checked"/>';
		}else{
			tex = '<font style="color:#B1B1B1;" Detail="check_font_for_refresh">操作成功后不刷新</font> <input Detail="check_input_for_refresh" type="checkbox" style="display:none;vertical-align: middle;" disabled="disabled"/>';
		}
		var ref_title = {
			plain:true,
			text : tex,
			handler:function(){
				var input1 = $(this).find('input');
				if(input1.attr('checked')){
					$ProductDetail.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$ProductDetail.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $ProductDetail.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $ProductDetail.close	
		};
		var buttons = [];
		if(read){
			$.extend(close_btn,{text:'关闭'});//克隆属性
		}else{
			buttons.push(ref_title);
			buttons.push(save_btn);
		}
		buttons.push(close_btn);
		$ProductDetail.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$ProductDetail.form.form('submit', {
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
					msgShow($ProductDetail.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($ProductDetail.success_refresh);
					if($ProductDetail.success_refresh){//成功后刷新
						dataGridReload();
					}
				} else {
					dialogOpen(successInfo);
					if(dataFilter(data).length>0){
						$.messager.alert($ProductDetail.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	ProductDetail.prototype.save = function() {
		if ($ProductDetail.button) {
			formSubmit($ProductDetail.addUrl,'添加');// 表单添加
		} else {
			formSubmit($ProductDetail.editUrl,'编辑');// 表单编辑
		}
	}

	ProductDetail.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$ProductDetail.dialog.dialog('close');
	}
	
	function dataGridReload(){
		$ProductDetail.datagrid.datagrid('reload');
		initButtons();
	}
	
	function initButtons() {
		$('#ppcdm-menu-remove').menubutton('disable');
		$('#ppcdm-menu-edit').menubutton('disable');
	}


	return ProductDetail;
})();
