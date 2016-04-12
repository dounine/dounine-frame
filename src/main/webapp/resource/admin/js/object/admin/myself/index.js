
function d_admin_password_prompt_close(url){
	$.messager.confirm('温馨提示','关闭将跳转到登录页面。', function(r){
		if (r){
			window.location.href = url;
		}
	});
}
function logout(url){
	$.messager.confirm('温馨提示','您确定要退出后台么? 将跳到登录页面.',function(r){
		if(r){
			$.post(url,function(data){
				if(data=='success'){
					window.location.href=url;
				}else if(data.indexOf('login.html')>-1){
					window.location.href=url;
				}else if(data=='login'){
					window.location.href='/admin/login.html';
				}else{
					$.messager.alert('温馨提示',data,'info');
				}
			});
		}
	});
}
function d_admin_password_prompt(url){
	if($("#NoAuthentication")){
		$('#d-admin-password-prompt-form').form('submit', {
			url : url,
			type:'post',
			onSubmit : function() {
				var isValid = $('#d-admin-password-prompt-form').form('validate');
				if (isValid) {
					$.messager.progress('close');
					$.messager.progress();
					isSubmitForm = true;
				}
				return $(this).form('validate');
			},
			success : function(data) {
				$.messager.progress('close');
				if (data == 'success') {
					setTimeout(function(){
						$("#NoAuthentication").nextAll().remove();
						$("#NoAuthentication").dialog('destroy');
						$("#NoAuthentication").remove();
					});
					setTimeout(function(){
						msgShow('温馨提示', '密码认证成功。');
					});
				} else {
					$.messager.alert('温馨提示', data, 'error');
				}
			}
		});
	}
}

function show_info(url){
	try{
		if($("#admin_info_dialog").dialog('options')){
			$("#admin_info_dialog").dialog('destroy');
		}
	}catch(e){}
	$("#admin_info_dialog").remove();
	$("#system_msg_info").after("<div id='admin_info_dialog'></div>");
	$("#admin_info_dialog").dialog({
		title:'个人信息',
		width:800,
		height:400,
		method:'post',
		href :url,
		iconCls:'icon-d-info',
		modal:true
	});
}

function lox_lock_screen_down(self){
	var $self = $(self);
	$self.css({
		'background':'red'
	});
}

function lox_lock_screen_up(self){
	var $self = $(self);
	$self.css({
		'background':'#000'
	});
}

function lock_screen_click(self,url){//锁屏
	$('#lock_user_password').focus().val('');
	$.post(url,function(data){
		if(data=='success'){
			$('.lox-lock-screen-box').fadeIn();
		}else if(data.indexOf('admin/login.html')>-1&&data.indexOf('rememberMe=true')>-1){
			dataFilter("script>window.location.href='/admin/login.html';var rememberMe=true</script>");
		}
	});
}