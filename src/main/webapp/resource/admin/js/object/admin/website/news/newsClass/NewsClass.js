var NewsClass = (function() {

	function NewsClass() {
	}
	
	function getModuleName(){
		return "版块";
	}
	
	NewsClass.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	NewsClass.prototype.success_refresh = true;//操作成功后刷新列表
	
	NewsClass.prototype.Data_Id = function (row){
		return {'id':row['id']};
	}
	
	NewsClass.prototype.load = function() {
		$NewsClass.datagrid.datagrid({
			url : arguments.length==0?null:$NewsClass.loadUrl,
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
				field : 'title',
				title : '分类名称',
				sortable:true,
				width : 100
			}, {
				field : 'createTimeT',
				title : '创建时间',
				sortable:true,
				width : 100
			},{
				field : 'timeType',
				title : '时间格式',
				width : 100,
				formatter:function(val){
					switch(val){
						case 'DATETIME':return '日期'
						case 'TIMESTAMP':return '日期+时间'
						case 'TIME':return '精确到分'
					}
				}
			}, {
				field : 'sortType',
				title : '显示方式',
				width : 100,
				formatter:function(val){
					switch(val){
						case 'DAY':return '天'
						case 'WEEK':return '周'
						case 'MONTH':return '月'
						case 'SEASON':return '季'
						case 'YEAR':return '年'
						case 'SEQUENCE':return '序号'
						case 'ID':return '编号'
						case 'HITS':return '热度'
						case 'NAME':return '名称'
						case 'NONE':return '随机'
					}
				}
			}, {
				field : 'pagingCount',
				title : '每页条数',
				sortable:true,
				width : 100
			}, {
				field : 'description',
				title : '版块描述',
				width : 100
			} ] ],
			toolbar : $NewsClass.datagrid_menu
		});
		
		function rowClick(){
			var row = $NewsClass.datagrid.datagrid('getSelected');
			if(row){
				$('#wnncdm-menu-remove').menubutton('enable');
				$('#wnncdm-menu-edit').menubutton('enable');
			}else{
				$('#wnncdm-menu-remove').menubutton('disable');
				$('#wnncdm-menu-edit').menubutton('disable');
			}
		}
	}

	NewsClass.prototype.del = function() {
		var row = $NewsClass.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($NewsClass.delUrl, $NewsClass.Data_Id(row), function(data) {
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

	NewsClass.prototype.add = function() {
		dialogOpen('添加');
		$.messager.progress('close');
		$NewsClass.button = true;
		$NewsClass.form.form('clear');
		$('input[name=showPaging]').val('false');
		$('#pagingCount').textbox('setValue',10);
	}

	NewsClass.prototype.edit = function() {
		dialogOpen('编辑');
		$.messager.progress('close');
		var row = $NewsClass.datagrid.datagrid('getSelected');
		$NewsClass.button = false;
		$NewsClass.form.form('load', row);
		var showPagingObj = $("#showPaging").prev();
		if(!row.showPaging){
			showPagingObj.attr('src',$("#showPaging").attr('url')+'/resource/admin/images/no.jpg');
		}else{
			showPagingObj.attr('src',$("#showPaging").attr('url')+'/resource/admin/images/yes.jpg');
		}
	}

	NewsClass.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $NewsClass.datagrid.datagrid('getSelected');
		$.post($NewsClass.congealUrl,$NewsClass.Data_Id(row), function(data) {
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

	NewsClass.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $NewsClass.datagrid.datagrid('getSelected');
		$.post($NewsClass.thawUrl, $NewsClass.Data_Id(row), function(data) {
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

	NewsClass.prototype.search = function() {
		$NewsClass.datagrid.datagrid('reload', $NewsClass.searchForm.serializeObject());
	}

	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($NewsClass.success_refresh){
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
					$NewsClass.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$NewsClass.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $NewsClass.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $NewsClass.close	
		};
		var buttons = [];
		if(read){
			$.extend(close_btn,{text:'关闭'});//克隆属性
		}else{
			buttons.push(ref_title);
			buttons.push(save_btn);
		}
		buttons.push(close_btn);
		$NewsClass.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$NewsClass.form.form('submit', {
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
					msgShow($NewsClass.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($NewsClass.success_refresh);
					if($NewsClass.success_refresh){//成功后刷新
						dataGridReload();
					}
				} else {
					dialogOpen(successInfo);
					if(dataFilter(data).length>0){
						$.messager.alert($NewsClass.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	NewsClass.prototype.save = function() {
		if ($NewsClass.button) {
			formSubmit($NewsClass.addUrl,'添加');// 表单添加
		} else {
			formSubmit($NewsClass.editUrl,'编辑');// 表单编辑
		}
	}

	NewsClass.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$NewsClass.dialog.dialog('close');
	}
	
	function dataGridReload(){
		$NewsClass.datagrid.datagrid('reload');
		initButtons();
	}
	
	function initButtons() {
		$('#wnncdm-menu-remove').menubutton('disable');
		$('#wnncdm-menu-edit').menubutton('disable');
	}


	return NewsClass;
})();
