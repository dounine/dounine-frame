var ScheduleJob = (function() {

	function ScheduleJob() {
	}
	
	function getModuleName(){
		return "定时器";
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
	
	ScheduleJob.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	ScheduleJob.prototype.success_refresh = true;//操作成功后刷新列表
	
	ScheduleJob.prototype.Data_Id = function (row){
		return {'scheduleJobId':row['scheduleJobId']};
	}
	
	ScheduleJob.prototype.load = function(load) {
		$ScheduleJob.datagrid.datagrid({
			url : arguments.length==0?null:$ScheduleJob.loadUrl,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			singleSelect : true,
			nowrap : true,
			striped : true,
			onClickRow:rowClick,
			border : false,
			collapsible : true,
			columns : [ [ {
				field : 'scheduleJobId',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'scheduleJobGroup',
				title : '定时器分组',
				hidden: true,
				width : 100
			}, {
				field : 'scheduleJobName',
				title : '定时器名称',
				sortable:true,
				width : 100
			}, {
				field : 'scheduleJobCronExpression',
				title : '表达式',
				sortable:true,
				width : 100
			}, {
				field : 'scheduleJobClass',
				title : '调用类',
				sortable:true,
				width : 100
			}, {
				field : 'scheduleJobMethod',
				title : '调用方法',
				sortable:true,
				width : 100
			}, {
				field : 'scheduleJobGroupName',
				title : '定时器类型',
				width : 100,
				formatter:function(val,row){
					return row.scheduleJobGroup.scheduleJobGroupName;
				}
			}, {
				field : 'createTimeT',
				title : '创建时间',
				sortable:true,
				width : 100
			}, {
				field : 'status',
				title : '定时器状态',
				sortable:true,
				align: 'center',
				formatter : function(val, row) {
					if(val=='CONGEAL'){
						return '<font style="color:red">停止</font>';
					}else if(val=='NORMAL'){
						return '<p style="color:green">运行中</p>';
					}
				},
				width : 100
			}, {
				field : 'scheduleJobDescription',
				title : '定时器分组描述',
				width : 100
			} ] ],
			onLoadSuccess:function(){
				if($ScheduleJob.datagrid.datagrid('getRows').length!=0){
					$($ScheduleJob.datagrid_menu).find('#qsdm-menu-sync').menubutton('enable');
				}
			},
			toolbar : $ScheduleJob.datagrid_menu
		});
		
		function rowClick(){
			var row = $ScheduleJob.datagrid.datagrid('getSelected');
			$($ScheduleJob.datagrid_menu).find('#qsdm-menu-edit').linkbutton('enable');
			$($ScheduleJob.datagrid_menu).find('#qsdm-menu-remove').linkbutton('enable');
			$($ScheduleJob.datagrid_menu).find('#qsdm-menu-operator').menubutton('enable');
		}
	}

	ScheduleJob.prototype.del = function() {
		var row = $ScheduleJob.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($ScheduleJob.delUrl, $ScheduleJob.Data_Id(row), function(data) {
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
	
	ScheduleJob.prototype.quartz = function() {
		$ScheduleJob.dialog_quartz.dialog('open');
	}
	
	ScheduleJob.prototype.ckAsync = function() {
		if(arguments.length==0)return;
		$.post($ScheduleJob.ckAsyncUrl,function(data){
			if(data=='success'){
				$ScheduleJob.ckAsyncId.empty().append('<img src="../resource/admin/css/themes/icons/dounine-icon-async.png">');
			}else{
				$ScheduleJob.ckAsyncId.empty().append('<img src="../resource/admin/css/themes/icons/dounine-icon-nsync.png">');;
			}
		});
	}

	ScheduleJob.prototype.add = function() {
		dialogOpen('添加');
		$ScheduleJob.button = true;
		$.messager.progress('close');
		$ScheduleJob.form.form('clear');
		addLoadingCount();
		$ScheduleJob.group.combogrid({
			panelWidth:134,
			editable:false,	
			onLoadSuccess:function(){
				delLoadingCount();
			},
			url:$ScheduleJob.groupUrl,
			idField:'scheduleJobGroupId',
			textField:'scheduleJobGroupName',
			columns:[[
			          {
			        	  field:'scheduleJobGroupName',
			        	  width:110
			          }
			    ]]
		});
	}

	ScheduleJob.prototype.edit = function() {
		dialogOpen('编辑');
		ScheduleJob.button = false;
		$.messager.progress('close');
		var row = $ScheduleJob.datagrid.datagrid('getSelected');
		$ScheduleJob.form.form('load', row);
		addLoadingCount();
		$ScheduleJob.group.combogrid({
			panelWidth:134,
			onLoadSuccess:function(){
				delLoadingCount();
			},
			url:$ScheduleJob.groupUrl,
			idField:'scheduleJobGroupId',
			textField:'scheduleJobGroupName',
			columns:[[
			          {
			        	  field:'scheduleJobGroupName',
			        	  width:110
			          }
			   ]]
		});
		$ScheduleJob.group.combogrid('setValue',row.scheduleJobGroup.scheduleJobGroupId);
	}

	ScheduleJob.prototype.stop = function() {// 停止 
		$.messager.progress('close');
		var row = $ScheduleJob.datagrid.datagrid('getSelected');
		if(row.status=='CONGEAL'){
			$.messager.alert('温馨提示', '此'+getModuleName()+'已经停止.', 'info');
			return;
		}
		$.messager.progress();
		$.post($ScheduleJob.stopUrl, $ScheduleJob.Data_Id(row), function(data) {
			$.messager.progress('close');
			if(data=='success'){
				msgShow('温馨提示',getModuleName()+'停止成功.');
				dataGridReload();
			}else{
				$.messager.alert('停止错误', data, 'error');
			}
		});
	}
	
	ScheduleJob.prototype.restart = function() {// 重启
		$.messager.progress('close');
		var row = $ScheduleJob.datagrid.datagrid('getSelected');
		$.messager.progress();
		$.post($ScheduleJob.restartUrl, $ScheduleJob.Data_Id(row) , function(data) {
			$.messager.progress('close');
			if(data=='success'){
				msgShow('温馨提示',getModuleName()+'重启成功.');
				dataGridReload();
			}else{
				$.messager.alert('重启错误', data, 'error');
			}
		});
	}
	
	ScheduleJob.prototype.async = function() {// 同步定时器
		$.messager.progress('close');
		$.messager.confirm('确认', '确定所有'+getModuleName()+'要与数据库同步吗?', function(r){
			if(r){
				$.messager.progress();
				$.post($ScheduleJob.asyncUrl,function(data){
					$.messager.progress('close');
					if(data=='success'){
						msgShow('操作成功', getModuleName()+'同步成功.');
						dataGridReload();
						$ScheduleJob.ckAsyncId.empty().append('<img src="../resource/admin/css/themes/icons/dounine-icon-async.png">');
					}else{
						$.messager.alert('同步错误', data, 'error');
					}
				});
			}
		});
	}

	ScheduleJob.prototype.run = function() {// 启动
		$.messager.progress('close');
		var row = $ScheduleJob.datagrid.datagrid('getSelected');
		$.messager.progress();
		$.post($ScheduleJob.runUrl, $ScheduleJob.Data_Id(row), function(data) {
			$.messager.progress('close');
			if(data=='success'){
				msgShow('温馨提示',getModuleName()+'启动成功.');
				dataGridReload();
			}else{
				$.messager.alert('运行错误', data, 'error');
			}
		});
	}

	ScheduleJob.prototype.search = function() {
		$ScheduleJob.datagrid.datagrid('reload', $ScheduleJob.searchForm.serializeObject());
	}

	function dataGridReload(){
		$ScheduleJob.datagrid.datagrid('reload');
		initButtons();
	}
	
	function initButtons() {
		$('#qsdm-menu-edit').linkbutton('disable');
		$('#qsdm-menu-remove').linkbutton('disable');
		$('#qsdm-menu-operator').menubutton('disable');
	}

	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($ScheduleJob.success_refresh){
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
					$ScheduleJob.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$ScheduleJob.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $ScheduleJob.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $ScheduleJob.close	
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
		$ScheduleJob.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$ScheduleJob.form.form('submit', {
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
					msgShow($ScheduleJob.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($ScheduleJob.success_refresh);
					if($ScheduleJob.success_refresh){//成功后刷新
						dataGridReload();
					}
				} else {
					dialogOpen(successInfo);
					if(dataFilter(data).length>0){
						$.messager.alert($ScheduleJob.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	ScheduleJob.prototype.save = function() {
		if ($ScheduleJob.button) {
			formSubmit($ScheduleJob.addUrl,'添加');// 表单添加
		} else {
			formSubmit($ScheduleJob.editUrl,'编辑');// 表单编辑
		}
	}

	ScheduleJob.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$ScheduleJob.dialog.dialog('close');
	}

	return ScheduleJob;
})();
