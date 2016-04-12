var User = (function() {

	function User() {
	}
	
	function getModuleName(){
		return "用户";
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
	
	User.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	User.prototype.success_refresh = true;//操作成功后刷新列表
	
	User.prototype.Data_Id = function (row){
		return {'userName':row['userName']};
	}

	User.prototype.load = function() {
		$User.departmentTree.tree({
			url : arguments.length == 0 ? null : $User.searchDepartmentUrl,
			lines:true,
			border:false,
			valueField : 'departmentId',
			textField : 'departmentName',
			onDblClick:dbClick,
			onBeforeExpand : function(node) {
				$User.departmentTree.tree('options').url = $User.searchDepartmentUrl
						+ '&departmentId=' + node.departmentId;
			}
		});
		
		$User.datagrid.datagrid({
			url : arguments.length==0?null:$User.loadUrl,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			singleSelect : true,
			nowrap : true,
			striped : true,
			onClickRow:rowClick,
			border:false,
			collapsible : true,
			columns : [ [ {
				field : 'userId',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'userName',
				title : '用户名',
				sortable:true,
				width : 100
			}, {
				field : 'createTimeT',
				title : '创建时间',
				sortable:true,
				width : 100
			}, {
				field : 'department',
				title : '所在部门',
				width : 100,
				formatter:function(val,row){
					if(val){
						return val.departmentName;
					}
				}
			}, {
				field : 'status',
				title : '用户状态',
				align: 'center',
				sortable:true,
				formatter : function(val, row) {
					if(val=='NORMAL'){
						return '正常';
					}else{
						return '<font style="color:red">冻结</font>';
					}
				},
				width : 100
			} ] ],
			onLoadSuccess:function(){
				if($User.datagrid.datagrid('getRows').length!=0){
					$($User.datagrid_menu).find('#qsdm-menu-sync').menubutton('enable');
				}
			},
			toolbar : $User.datagrid_menu
		});
		
		function dbClick(node){
			$User.datagrid.datagrid('reload',{'department.departmentId':node.departmentId});
		}
		
		function rowClick(rowIndex, row){
			if(row.status=='NORMAL'){
				$('#sudm-menu-edit').linkbutton('enable');
				$('#sudm-menu-remove').linkbutton('enable');
				$('#sudm-menu-congeal').linkbutton('enable');
				$('#sudm-menu-thaw').linkbutton('disable');
			}else{
				$('#sudm-menu-edit').linkbutton('disable');
				$('#sudm-menu-remove').linkbutton('disable');
				$('#sudm-menu-congeal').linkbutton('disable');
				$('#sudm-menu-thaw').linkbutton('enable');
			}
		}
	}
	
	User.prototype.search = function() {
		$User.datagrid.datagrid('reload', $User.searchForm.serializeObject());
	}

	User.prototype.del = function() {
		var row = $User.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($User.delUrl, $User.Data_Id(row), function(data) {
					if (data == "success") {
						msgShow('操作成功', getModuleName()+'删除成功.');
						reloadDatagrid();
					} else {
						$.messager.alert('删除错误', data, 'error');
					}
					$.messager.progress('close');
				});
			}
		});
	}


	User.prototype.add = function() {
		$("#userName").textbox({editable:true});
		$User.userPassword.textbox({required:true});
		dialogOpen('添加');
		$User.button = true;
		$.messager.progress('close');
		$($User.department).combotree('destroy').remove()
		$($User.userRoles).combotree('destroy').remove();
		$User.form.form('clear');
		
		addRoles();//重新添加combotree
		addParent();//重新添加combotree
	}

	User.prototype.edit = function() {
		$("#userName").textbox({editable:false});
		$User.userPassword.textbox({required:false});
		dialogOpen('编辑');
		$User.button = false;
		$.messager.progress('close');
		var row = $User.datagrid.datagrid('getSelected');
		$($User.department).combotree('destroy').remove();//清空原来的combotree对象
		$($User.userRoles).combotree('destroy').remove();//清空原来的combotree对象
		$User.form.form('load', row);
		
		addRoles(row.userId);//重新添加combotree
		addParent(row.department.departmentId);//重新添加combotree
	}
	
	User.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $User.datagrid.datagrid('getSelected');
		$.post($User.congealUrl,$User.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == "success") {
				msgShow('操作成功', getModuleName()+'冻结成功.');
				reloadDatagrid();
			} else {
				$.messager.alert('冻结错误', data, 'error');
			}
		});
	}

	User.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $User.datagrid.datagrid('getSelected');
		$.post($User.thawUrl,$User.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == "success") {
				msgShow('操作成功', getModuleName()+'解冻成功.');
				reloadDatagrid();
			} else {
				$.messager.alert('解冻错误', data, 'error');
			}
		});
	}

	User.prototype.search = function() {
		$User.datagrid.datagrid('reload', $User.searchForm.serializeObject());
	}

	function reloadDatagrid(){
		$User.datagrid.datagrid('reload');
		initButtons();
	}

	function initButtons() {
		$('#sudm-menu-edit').linkbutton('disable');
		$('#sudm-menu-remove').linkbutton('disable');
		$('#sudm-menu-congeal').linkbutton('disable');
		$('#sudm-menu-thaw').linkbutton('disable');
	}
	
	function addParent(id){
		var department = $('<table name="department.departmentId" id="department" style="width:494px;"></table>').appendTo($User.departmentBox);
		addLoadingCount();
		department.combotree({
			url:id?($User.findDepartmentUrl+'&id='+id):$User.departmentUrl,
			required:true,
			lines : true,
			valueField:'departmentId',
			textField:'departmentName',
			editable: false,
			onLoadSuccess:function(){
				if(id){
					department.combotree('setValue', id);
				}
				delLoadingCount();
			},
			onBeforeExpand:function (node) {
				department.combotree('tree').tree('options').url = $User.departmentUrl+'&departmentId='+node.departmentId;
	        }
		});
		return department;
	}
	
	function addRoles(id){
		var role = $('<table name="userRoles" multiple id="userRoles" style="width:494px;"></table>').appendTo($User.userRolesBox);
		var isFirst = true;
		addLoadingCount();
		role.combotree({
			url:id?($User.findRolesUrl+'&id='+id):$User.roleUrl,
			valueField:'roleId',
			textField:'roleName',
			lines : true,
			editable: false,
			onLoadSuccess:function(){
				var self = role;
				delLoadingCount();
				if(id&&isFirst){
					addLoadingCount();
					$.post($User.userRoleUrl,{'userName':$User.datagrid.datagrid('getSelected').userName},function(data){
						if(data.userRoles){
							self.combotree('setValues',data.userRoles);
						}
						delLoadingCount();
					});
				}
			},
			onBeforeExpand:function (node) {
				role.combotree('tree').tree('options').url = $User.roleUrl+'&roleId='+node.roleId;
				isFirst = false;
	        }
		});
		return role;
	}

	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($User.success_refresh){
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
					$User.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$User.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $User.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $User.close	
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
		$User.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$User.form.form('submit', {
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
					msgShow($User.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($User.success_refresh);
					if($User.success_refresh){//成功后刷新
						reloadDatagrid();
					}
				} else {
					dialogOpen(successInfo);
					if(dataFilter(data).length>0){
						$.messager.alert($User.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	User.prototype.save = function() {
		if ($User.button) {
			formSubmit($User.addUrl,'添加');// 表单添加
		} else {
			formSubmit($User.editUrl,'编辑');// 表单编辑
		}
	}

	User.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$User.dialog.dialog('close');
	}
	
	User.prototype.saveExport = function(url) {
		$User.exportDialogForm.form('submit',{
			url:null,
			onSubmit : function() {
				var isValid = $(this).form('validate');
				if (isValid) {
					$.messager.progress('close');
				}
				if (isValid) {
					$("#"+getModuleName()+"excel_download").remove();
					var iframe = document.createElement("iframe");
					iframe.id = getModuleName()+"excel_download";
					iframe.src = url+'&offSet='+$("#userOffset").numberspinner('getValue')+'&rows='+$("#exportCount").numberspinner('getValue');
					iframe.style="display:none"; //设置隐藏该iframe
					document.body.appendChild(iframe);  //构造一个对象。插入页面中。
				}
				return false;
			}
		})
	}
	User.prototype.closeExport = function(url) {
		$User.exportDialog.dialog('close');
	}
	User.prototype.export_excel = function(url) {
		$User.exportDialog.dialog('open');
		$.post($User.countUrl,function(data){
			$User.count.numberbox('setValue',data);
			$User.userOffset.numberspinner({
				min:0,
				value:0,
				max:parseInt(data)-1,
				onSpinUp:function(){
					$User.exportCount.numberspinner({
						min:1,
						value:0,
						max:parseInt(data)-parseInt($User.userOffset.numberspinner('getValue')),
						required:true
					});
				},
				onSpinDown:function(){
					$User.exportCount.numberspinner({
						min:1,
						value:0,
						max:parseInt(data)-parseInt($User.userOffset.numberspinner('getValue')),
						required:true
					});
				},
				required:true
			});
			$User.exportCount.numberspinner({
				min:1,
				value:0,
				max:parseInt(data),
				required:true
			});
		})
	}


	return User;
})();
