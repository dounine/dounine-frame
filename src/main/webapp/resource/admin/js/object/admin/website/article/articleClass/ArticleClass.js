var ArticleClass = (function() {

	function ArticleClass() {
	}
	
	function getModuleName(){
		return "文章分类";
	}
	
	ArticleClass.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	ArticleClass.prototype.success_refresh = true;//操作成功后刷新列表
	
	ArticleClass.prototype.Data_Id = function (row){
		return {'id':row['id']};
	}
	
	ArticleClass.prototype.load = function() {
		$ArticleClass.datagrid.datagrid({
			url : arguments.length==0?null:$ArticleClass.loadUrl,
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
			toolbar : $ArticleClass.datagrid_menu
		});
		
		function rowClick(){
			var row = $ArticleClass.datagrid.datagrid('getSelected');
			if(row){
				$('#waacdm-menu-remove').menubutton('enable');
				$('#waacdm-menu-edit').menubutton('enable');
			}else{
				$('#waacdm-menu-remove').menubutton('disable');
				$('#waacdm-menu-edit').menubutton('disable');
			}
		}
	}

	ArticleClass.prototype.del = function() {
		var row = $ArticleClass.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($ArticleClass.delUrl, $ArticleClass.Data_Id(row), function(data) {
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

	ArticleClass.prototype.add = function() {
		dialogOpen('添加');
		$.messager.progress('close');
		$ArticleClass.button = true;
		$ArticleClass.form.form('clear');
	}

	ArticleClass.prototype.edit = function() {
		dialogOpen('编辑');
		$.messager.progress('close');
		var row = $ArticleClass.datagrid.datagrid('getSelected');
		$ArticleClass.button = false;
		$ArticleClass.form.form('load', row);
	}

	ArticleClass.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $ArticleClass.datagrid.datagrid('getSelected');
		$.post($ArticleClass.congealUrl,$ArticleClass.Data_Id(row), function(data) {
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

	ArticleClass.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $ArticleClass.datagrid.datagrid('getSelected');
		$.post($ArticleClass.thawUrl, $ArticleClass.Data_Id(row), function(data) {
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

	ArticleClass.prototype.search = function() {
		$ArticleClass.datagrid.datagrid('reload', $ArticleClass.searchForm.serializeObject());
	}

	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($ArticleClass.success_refresh){
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
					$ArticleClass.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$ArticleClass.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $ArticleClass.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $ArticleClass.close	
		};
		var buttons = [];
		if(read){
			$.extend(close_btn,{text:'关闭'});//克隆属性
		}else{
			buttons.push(ref_title);
			buttons.push(save_btn);
		}
		buttons.push(close_btn);
		$ArticleClass.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$ArticleClass.form.form('submit', {
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
					msgShow($ArticleClass.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($ArticleClass.success_refresh);
					if($ArticleClass.success_refresh){//成功后刷新
						dataGridReload();
					}
				} else {
					dialogOpen(successInfo);
					if(dataFilter(data).length>0){
						$.messager.alert($ArticleClass.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	ArticleClass.prototype.save = function() {
		if ($ArticleClass.button) {
			formSubmit($ArticleClass.addUrl,'添加');// 表单添加
		} else {
			formSubmit($ArticleClass.editUrl,'编辑');// 表单编辑
		}
	}

	ArticleClass.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$ArticleClass.dialog.dialog('close');
	}
	
	function dataGridReload(){
		$ArticleClass.datagrid.datagrid('reload');
		initButtons();
	}
	
	function initButtons() {
		$('#waacdm-menu-remove').menubutton('disable');
		$('#waacdm-menu-edit').menubutton('disable');
	}


	return ArticleClass;
})();
