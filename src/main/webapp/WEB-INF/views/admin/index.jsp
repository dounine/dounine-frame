<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="utf-8">
		<title>逗你呢(dounine)-后台管理</title>
		<link rel="stylesheet" type="text/css" href="${base_url}/resource/admin/css/themes/bootstrap/easyui.css" />
		<link rel="stylesheet" type="text/css" href="${base_url}/resource/admin/css/admin.css"/>
		<link rel="stylesheet" type="text/css" href="${base_url}/resource/admin/css/themes/icon.css"/>
		<link rel="shortcut icon" href="${base}/resource/favicon.ico" type="image/x-icon" />
		<script src="${base_url}/resource/admin/js/object/admin/myself/index.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/common/jquery.min.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/common/jquery.easyui.min.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/common/extend/easyui-panel-overflow.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/common/dounine-moveMenu.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/common/cvi_busy_lib.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/common/loadingAjax.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/common/EasyuiTabs.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/common/extend/mask.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/common/extend/dounine-tools.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/common/clearTable.js" type="text/javascript"></script>
		<script src="${base}/resource/admin/js/ueditor/ueditor.config.js" type="text/javascript"></script>
		<script src="${base_url}/resource/admin/js/ueditor/ueditor.all.min.js" type="text/javascript"></script>
		
	</head>

	<body style="background-color:#FFFFFF;">
		<div id="lox-loading" style="position: absolute;top: -50%;left: -50%;width: 200%;height: 200%;background: #EEEEEE;z-index: 999;overflow: hidden;">
		<!--页面加载缓冲用--><img src="${base_url}/resource/admin/images/ajax-loader.gif" style="position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;"/>
		</div>
		<div class="lox-lock-screen-box" screen="true">
			<div class="lox-lock-screen-bg" onmousedown="lox_lock_screen_down(this)" onmouseup="lox_lock_screen_up(this);">
			</div>
			<div class="lox-lock-screen">
				<label><input type="password" id="lock_user_password" placeholder="请输入解锁密码" name="userPassword" value="" /></label>
				<font id="cancel_password_msg" style="position:absolute;right:-160px;color:#ffffff;font-size:16px;"></font>
			</div>
		</div>

		<div class="easyui-layout" data-options="fit:true,border:false">

			<div class="lox-head" data-options="region:'north',border:false,height:88">
				<div class="lox-top">
					<div class="admin_logo">
						<%-- <a href="${base}/admin/index.html" style="display:block;"><img style="margin-left:20px;" height="52" src="${base_url}/resource/admin/images/index/loginlogo.png" /></a> --%>
					</div>
					<div class="lox-top-nav-box">
						<div class="lox-top-nav">
							<li onclick="dynamic_menu(this);" class="currentThis icon-d-home" data-url='${base}/admin/index/index_menu.html?USERNAME=<shiro:principal/>'>后台首页</li>
							<shiro:hasPermission name="product:*"><li onclick="dynamic_menu(this);" class="icon-d-product" data-url='${base}/admin/product/product_menu.html?USERNAME=<shiro:principal/>'>框架管理</li></shiro:hasPermission>
							<li onclick="dynamic_menu(this);" class="icon-d-vip" data-url='${base}/admin/menu.html'>会员管理</li>
							<li onclick="dynamic_menu(this);" class="icon-d-statistics">统计管理</li>
							<shiro:hasPermission name="website:*"><li onclick="dynamic_menu(this);" class="icon-d-content" data-url='${base}/admin/website/website_menu.html?USERNAME=<shiro:principal/>'>内容管理</li></shiro:hasPermission>
							<shiro:hasPermission name="system:*"><li onclick="dynamic_menu(this);" class="icon-d-system" data-url='${base}/admin/system/system_menu.html?USERNAME=<shiro:principal/>'>系统管理</li></shiro:hasPermission>
						</div>
					</div>
					<div class="lox-top-member" style="top:16px;">
						<li>
							欢迎您 [ <shiro:principal/> ] , [ ${adminCurrentUserInfo.department.departmentName} ]&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:void(0);" onclick="show_info('${base}/admin/system/rbac/user/info/admin_info.html?USERNAME=<shiro:principal/>');"  style="padding-left: 18px;padding-top:2px;background-position:left" class="icon-d-data">个人资料</a>
							&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:void(0);" onclick="lock_screen_click(this,'<dounine-csrf:token-value uri='${base}/admin/system/rbac/user/lock_screen.action' />');" style="padding-left: 18px;padding-top:2px;background-position:left" class="icon-d-locked">锁屏</a>
							&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:void(0);" class="icon-d-shutdown" style="padding-left: 18px;padding-top:2px;background-position:left" onclick="logout('<dounine-csrf:token-value uri='${base}/admin/logout.action' />');">退出</a> 
						</li>
					</div>
					<div class="admin_header_right"></div>
				</div>
			</div>
			
			<div data-options="region:'west',width:180" id="lox-nav-left" style="border-top:1px solid #5AB8EF;border-right:1px solid #B7D5DF;border-left:none;">
				<ul class="lox-side">
					<li class="left-menu-bg"><i class="icon-d-menu"></i>功能菜单列表</li>
				</ul>
			</div>
			
			<!--主体部分-->
			<div data-options="region:'center',border:false" id="dounine-main-center" style="margin-top:1px auto;margin-left:2px;background: #fff;overflow:hidden;">
				<div id="lox-main" style="height:100%;overflow:hidden;margin:1px;background:#ffffff;">
					
				</div>
			</div>

		</div>


		<div id="system_msg_info" style="display:none;">恶意操作,系统停止响应.</div>
		
		<div id="admin_info_dialog" ></div>
	</body>
	<script type="text/javascript">
		/** 常量池 **/
		adminCurrentUserName = '<shiro:principal/>';//后台用户名称
		adminCurrentUserId = '${adminCurrentUserInfo.userId}';//后台用户编号
		base = '${base}';
		
		userUrl = '?USERNAME='+adminCurrentUserName;
		_userUrl = '&USERNAME='+adminCurrentUserName;
		
		var menuLeftAjaxTimeOut;
		var menuLeftAjaxTimeOutP = false;//菜单定时器是否可以点击
		var menuAjaxTimeOut;
		var menuAjaxTimeOutP = false;//菜单定时器是否可以点击
		var loadingImgObj = '<img style="position:relative;top:1px;" src="${base_url}/resource/admin/images/onLoad.gif" />';
		var lock_screen = "${lock_screen}";
		var long_time_auth = false;
	</script>
	
	<script type="text/javascript">
		function dynamic_menu(self){
			/* clearTimeout(menuAjaxTimeOut);
			menuAjaxTimeOut = setTimeout(function(){
				menuAjaxTimeOutP = false;
				$("#system_msg_info").hide();
				$self.css('cursor','pointer');
			},500); */
			var $self = $(self);
			if(!menuAjaxTimeOutP){
				$("#lox-nav-left").mask({'maskMsg':'菜单加载中...'});
				$.post($self.attr('data-url'),{'USERNAME':adminCurrentUserName},function(data){
					var result = dataFilter(data);
					if((new String(result)).length>0){
						$('li.left-menu-bg').nextAll().remove();
					}
					var $lmb = $(result).insertAfter($('li.left-menu-bg'));
					if($.trim(data)!=''){
						menu_current[2](menu_current[1]);
					}
					$("#lox-nav-left").mask('hide');
					//menuAjaxTimeOutP = true;
					var hash_str1 = window.location.hash;
					var current_li = null;
					var west_title = null;
					if(hash_str1.length>0){
						if(hash_str1.indexOf("#center:")>-1){
							west_title = hash_str1.substring(hash_str1.indexOf("west:")+"west:".length,hash_str1.indexOf("#center:"));
						}else{
							west_title = hash_str1.substring(hash_str1.indexOf("west:")+"west:".length);
						}
						current_li = $lmb.filter(":contains('"+west_title+"')").find('a').click();
					}
					window.location.hash="north:"+$self.text();//新增
					if(current_li&&current_li[0]){
						if(hash_str1.indexOf('north:')==-1){//去掉此判断会出现重复数据
							dynamic_left_menu(current_li);
						}
					}else{
						dynamic_left_menu($('.lox-side li:eq(1)').find('a'));
					}
				});
			}else{
				$self.css('cursor','not-allowed');
				$("#system_msg_info").show();
			}
		}
		
		function dynamic_left_menu(self){
			/* clearTimeout(menuLeftAjaxTimeOut);
			menuLeftAjaxTimeOut = setTimeout(function(){
				menuLeftAjaxTimeOutP = false;
				$("#system_msg_info").hide();
				$self.css('cursor','pointer');
			},500); */
			var $self = $(self);
			var hash_s = window.location.hash;
			if(!menuLeftAjaxTimeOutP){
				var $lox_main = $('#lox-main');
				var $self_url = $self.attr('data-url');
				$lox_main.empty();
				if($.trim($self_url)!=''){
					$("#dounine-main-center").mask({'maskMsg':'页面加载中...'});
					$.post($self_url,{'USERNAME':adminCurrentUserName},function(data){
						var result = dataFilter(data);
						if((new String(result)).length>0){
							if(!long_time_auth){
								$("#removeScript").nextAll().remove();
								long_time_auth = false;
							}
						}
						var select_tab_title = null;
						var divs = ($(result).find('#lox-tabs').find('div'));
						var center_title = hash_s.substring(hash_s.indexOf('#center:')+'#center:'.length);
						divs.each(function(){
							if($.trim($.trim($(this).attr('title')))==center_title){
								select_tab_title = center_title;//选中的tab 标题 
							}
						});
						$lox_main.html((result+"<input type='hidden' id='select_tab_title' value="+select_tab_title+" />"));
						$('a.lox-selected').removeClass('lox-selected').find('i').remove();
						$self.addClass('lox-selected').append('<i></i>');
						$("#dounine-main-center").mask('hide');
						//menuLeftAjaxTimeOutP = true;
						var _hash = window.location.hash;
						if(_hash.indexOf('#west:')>0){
							_hash = _hash.substring(0,_hash.indexOf('#west:'));
						}
						window.location.hash=(_hash+'#west:'+$self.text());
					});
				}
			}else{
				$self.css('cursor','not-allowed');
				$("#system_msg_info").show();
			}
		}
	</script>

	<script id="removeScript" type="text/javascript" language="JavaScript">
	
		function cancel_screen(){
			$("#cancel_password_msg").text('').hide();
			$.post('<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/cancel_screen.action" />',{'userPassword':$("#lock_user_password").val()},function(data){
				$("#lock_user_password").val('');
				if(data=='success'){
					$('.lox-lock-screen-box').hide();
				}else if(new String(data).indexOf('/admin/login.html')>-1){
					window.location.href='<dounine-csrf:token-value uri="${base}/admin/login.html" />';
				}else{
					$("#cancel_password_msg").show().text('密码不正确,解锁失败.');
				}
			});
		}
	
		$(function(){
			if(lock_screen=="true"){
				$('.lox-lock-screen-box').show();//锁定屏幕
				$("#lock_user_password").focus();
			}
			$.ajaxSetup ({
	   			cache: false
			});
			$('.lox-lock-screen-bg').css({
				'opacity':0.5
			});
			
			$(window).load(function(){
				$("#lox-loading").fadeOut();
			});
			if(!$(".lox-top-nav").find(".currentThis")[0]){
				$(".lox-top-nav li:first").addClass('currentThis');
			}
			var top_nav = $(".lox-top-nav").moveMunu({
				speed: 300, //缓动时间
				click:function(e){
					menu_current = e;
				}
			});
			var hash_str = window.location.hash;
			if(hash_str.length>0){
				var north_title = null;
				if(hash_str.indexOf("#west:")>-1){
					north_title = hash_str.substring("#north:".length,hash_str.indexOf("#west:"));
				}else{
					north_title = hash_str.substring("#north:".length);
				}
				$("div.lox-top-nav li:contains('"+north_title+"')").click();
			}else{
				top_nav.find('li.currentThis').click();
			}
			
			$(document).keydown(function(e){
				if(e.keyCode==13){
					if($('.lox-lock-screen-box:visible')[0]){
						cancel_screen();
					}
					d_admin_password_prompt('<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/user_check.action" />');
				}
			});
		});
		
		function dataFilter(data){//此方法在Easyui$.ajax回调数据内添加过滤
			if(new String(data).indexOf('/admin/login.html')>-1){//此判断兴取带有BUG
				try{
					$("#NoAuthentication").dialog('destroy');
				}catch(e){}
				$("#admin_info_dialog").after('<div id="NoAuthentication"></div>');
				var loginTimeNotOperation = "由于您长时间未操作,请输入您的确认密码。";
				
				if(new String(data).indexOf('rememberMe=true')>-1||new String(data).indexOf('自动登录')>-1){
					long_time_auth = true;
					loginTimeNotOperation="为保障安全,请输入确认密码。";
				}
				if(new String(data).indexOf('lock_screen=true')>-1){//锁屏状态,不验证
					return [];
				}
				$("#NoAuthentication").dialog({
					title:'温馨提示',
					width:360,
					buttons:'#d-admin-password-prompt-buttons',
					content:'<div style="margin:10px;text-align:center;"> <form onsubmit="return false;" method="post" id="d-admin-password-prompt-form" ><div style="height:30px;line-height:30px;" id="">'+loginTimeNotOperation+'</div><input class="easyui-textbox" type="password" id="password_timeout" style="width:220px;" required="required" name="userPassword" /><input type="hidden" name="userName" value="<shiro:principal/>" /></form></div>',
					height:170,
					buttons:[
					         {
					        	 text:'认证',
					        	 iconCls:'icon-d-save',
					        	 handler:function(){
					        		 d_admin_password_prompt('<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/user_check.action" />'); 
					        	 } 
					         },
					         {
					        	 text:'取消',
					        	 iconCls:'icon-d-close',
					        	 handler:function(){
					        		 d_admin_password_prompt_close('<dounine-csrf:token-value uri="${base}/admin/login.html" />'); 
					        	 }
					         }
					        ]
				});
				return [];
			}else{
				return data;
			}
		}
		eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('1q(M.3){3.Q();L 1=["  [[   O N I t H K J 4 P    ]] "];3.V(1.7("\\n"));1.9=0;1.2("      m k 6 g h f U 4 p X");1.2("      g h f W 4 R p ");3.c(1.7("\\n"));1.9=0;1.2("      v a 8 q l [ j ] T w 5");1.2("      m k 6 l b S  G , y q a 8 C B");3.c(1.7("\\n"));1.9=0;1.2("      d 5 A F E 4 16 D x r z 1n 1m 1p , d 1o 1j 1i 1l");1.2("      1k w d 5 e o 6 、v r e o 6");1.2("      1w 1x 1y 1v 1s 1r j , 1u 1t 4 14 13 17 15 u a 12 Z Y 11 10 5");1.2("      18 1f 1e 1h b i 1g 1d 1a 19 u 8 t 1c 1b b i s s 5 ! ! !");3.c(1.7("\\n"))}',62,97,'|join_this_warning|push|console|的|了|你|join|要|length|不|世|info|除|调|强|没|有|界|here|果|入|如||戏|体|加|是|看|到|也|就|们|全|更|T*D|boss|来|进|个|余|其|深|任|将|行|同|var|window|即|致|信|clear|身|未|他|壮|error|健|魄|往|道|飞|哪|知|目|项|金||资|突|我|大|面|外|么|觉|然|那|得|阿|地|她|姨|狸|狐|扫|精|if|离|远|好|说|命|珍|爱|生'.split('|'),0,{}))

	</script>
</html>