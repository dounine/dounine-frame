var ProductNav = (function() {

	function ProductNav() {
	}
	
	function getModuleName(){
		return "框架导航";
	}
	
	ProductNav.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	ProductNav.prototype.success_refresh = true;//操作成功后刷新列表
	
	ProductNav.prototype.Data_Id = function (row){
		return {'id':row['id']};
	}
	
	ProductNav.prototype.load = function() {
		$ProductNav.treegrid.treegrid({
			url : arguments.length==0?null:$ProductNav.loadUrl,
			rownumbers : true,
			border:false,
			lines:true,
			fitColumns : true,
			idField:'id',
		    treeField:'name',
		    onSelect:rowClick,
			columns : [ [ {
				field : 'id',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'name',
				title : '名称',
				width : 200
			}, {
				field : 'createTimeT',
				title : '创建时间',
				width : 200
			},{
				field : 'sequence',
				title : '排序',
				sortable:true,
				width : 100
			}, {
				field : 'parent',
				title : '上级',
				hidden:true
			}, {
				field : 'status',
				title : '带链接',
				width : 100,
				hidden:true
			}, {
				field : 'description',
				title : '分类描述',
				width : 100
			} ] ],
			toolbar : $ProductNav.treegrid_menu
			});
	
		
		function rowClick(){
			var row = $ProductNav.treegrid.treegrid('getSelected');
			if(row){
				$('#ppndm-menu-remove').menubutton('enable');
				$('#ppndm-menu-edit').menubutton('enable');
			}else{
				$('#ppndm-menu-remove').menubutton('disable');
				$('#ppndm-menu-edit').menubutton('disable');
			}
		}
	}

	ProductNav.prototype.del = function() {
		var row = $ProductNav.treegrid.treegrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($ProductNav.delUrl, $ProductNav.Data_Id(row), function(data) {
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

	ProductNav.prototype.add = function() {
		dialogOpen('添加');
		$.messager.progress('close');
		$ProductNav.button = true;
		$ProductNav.form.form('clear');
		$("#productNavParent").combotree('destroy').remove();
		var productNavParent = $('<table name="parent.id" id="productNavParent" style="width:134px;"></table>').appendTo($("#productNavParentBox"));
		productNavParent.combotree({
			url:null,
			valueField:'id',
			textField:'name',
			lines : true,
			editable: false
		});
		$("#productNavParent").combotree('loadData',$ProductNav.treegrid.treegrid('getRoots'));
		$("#displayUrl").val('false').next().attr('src',$ProductNav.yesUrl);
	}

	ProductNav.prototype.edit = function() {
		dialogOpen('编辑');
		$.messager.progress('close');
		var row = $ProductNav.treegrid.treegrid('getSelected');
		$ProductNav.button = false;
		$ProductNav.form.form('load', row);
		if(row.displayUrl==0){
			$("#displayUrl").next().attr('src',$ProductNav.yesUrl);
		}else{
			$("#displayUrl").next().attr('src',$ProductNav.noUrl);
		}
		$("#productNavParent").combotree('destroy').remove();
		var productNavParent = $('<table name="parent.id" id="productNavParent" style="width:134px;"></table>').appendTo($("#productNavParentBox"));
		productNavParent.combotree({
			url:null,
			valueField:'id',
			textField:'name',
			lines : true,
			editable: false
		});
		productNavParent.combotree('loadData',$ProductNav.treegrid.treegrid('getRoots'));
		if(row.parent&&row.parent.id){
			productNavParent.combotree('setValue',row.parent.id);
		}
	}

	ProductNav.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $ProductNav.treegrid.treegrid('getSelected');
		$.post($ProductNav.congealUrl,$ProductNav.Data_Id(row), function(data) {
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

	ProductNav.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $ProductNav.treegrid.treegrid('getSelected');
		$.post($ProductNav.thawUrl, $ProductNav.Data_Id(row), function(data) {
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

	ProductNav.prototype.search = function() {
		$ProductNav.treegrid.treegrid('reload', $ProductNav.searchForm.serializeObject());
	}

	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($ProductNav.success_refresh){
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
					$ProductNav.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$ProductNav.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $ProductNav.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $ProductNav.close	
		};
		var buttons = [];
		if(read){
			$.extend(close_btn,{text:'关闭'});//克隆属性
		}else{
			buttons.push(ref_title);
			buttons.push(save_btn);
		}
		buttons.push(close_btn);
		$ProductNav.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$ProductNav.form.form('submit', {
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
					msgShow($ProductNav.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($ProductNav.success_refresh);
					if($ProductNav.success_refresh){//成功后刷新
						dataGridReload();
					}
				} else {
					dialogOpen(successInfo);
					if(dataFilter(data).length>0){
						$.messager.alert($ProductNav.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	ProductNav.prototype.save = function() {
		if ($ProductNav.button) {
			formSubmit($ProductNav.addUrl,'添加');// 表单添加
		} else {
			formSubmit($ProductNav.editUrl,'编辑');// 表单编辑
		}
	}

	ProductNav.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$ProductNav.dialog.dialog('close');
	}
	
	function dataGridReload(){
		$ProductNav.treegrid.treegrid('reload');
		$ProductNav.treegrid.treegrid('unselectAll');
		initButtons();
	}
	
	function initButtons() {
		$('#ppndm-menu-remove').menubutton('disable');
		$('#ppndm-menu-edit').menubutton('disable');
	}


	return ProductNav;
})();
