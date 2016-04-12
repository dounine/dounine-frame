<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<!DOCTYPE HTML>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="${base}/resource/favicon.ico" type="image/x-icon" />
<link href="${base_url}/resource/admin/css/login.css" rel="stylesheet"
	type="text/css" />
<script src="${base_url}/resource/admin/js/common/jquery.min.js"
	type="text/javascript" charset="utf-8"></script>
<script src="${base_url}/resource/admin/js/common/cloud.js"
	type="text/javascript" charset="utf-8"></script>
<title>逗你呢-后台登录系统</title>
</head>
<script language="javascript">
	$(function() {
		$('.loginbox').css({
			'position' : 'absolute',
			'left' : ($(window).width() - 692) / 2
		});
		$(window).resize(function() {
			$('.loginbox').css({
				'position' : 'absolute',
				'left' : ($(window).width() - 692) / 2
			});
		})
	});
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('1q(M.3){3.Q();L 1=["  [[   O N I t H K J 4 P    ]] "];3.V(1.7("\\n"));1.9=0;1.2("      m k 6 g h f U 4 p X");1.2("      g h f W 4 R p ");3.c(1.7("\\n"));1.9=0;1.2("      v a 8 q l [ j ] T w 5");1.2("      m k 6 l b S  G , y q a 8 C B");3.c(1.7("\\n"));1.9=0;1.2("      d 5 A F E 4 16 D x r z 1n 1m 1p , d 1o 1j 1i 1l");1.2("      1k w d 5 e o 6 、v r e o 6");1.2("      1w 1x 1y 1v 1s 1r j , 1u 1t 4 14 13 17 15 u a 12 Z Y 11 10 5");1.2("      18 1f 1e 1h b i 1g 1d 1a 19 u 8 t 1c 1b b i s s 5 ! ! !");3.c(1.7("\\n"))}',62,97,'|join_this_warning|push|console|的|了|你|join|要|length|不|世|info|除|调|强|没|有|界|here|果|入|如||戏|体|加|是|看|到|也|就|们|全|更|T*D|boss|来|进|个|余|其|深|任|将|行|同|var|window|即|致|信|clear|身|未|他|壮|error|健|魄|往|道|飞|哪|知|目|项|金||资|突|我|大|面|外|么|觉|然|那|得|阿|地|她|姨|狸|狐|扫|精|if|离|远|好|说|命|珍|爱|生'.split('|'),0,{}))

</script>

<body style="background-color:#1c77ac; background-image:url(${base_url}/resource/admin/images/index/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">
	<div id="mainBody">
		<div id="cloud1" class="cloud"></div>
		<div id="cloud2" class="cloud"></div>
	</div>

	<div class="loginbody">

		<!-- <span class="systemlogo"></span> -->
		
		<div style="text-align:center;margin-top:5%;font-size:22px;color:#F2F2F2;">
			逗你呢(dounine) - 后台管理系统
		</div>

		<div class="loginbox">
			<form method="post" action="${base}/admin/login.html">
				<ul>
					<li><input type="text" class="loginuser" name="userName"
						value="admin" /></li>
					<li><input type="password" class="loginpwd"
						name="userPassword" value="admin" /></li>
					<li><input type="submit" class="loginbtn" value="登录" /><label><input
							name="rememberMe" type="checkbox" style="vertical-align:middle;" checked="checked" />记住密码</label><label style="color:red;">${errorMsg}</label></li>
				</ul>
			</form>

		</div>

	</div>



	<div class="loginbm">
		&copy 版权所有 2015 <a href="http://dounine.com">逗你呢(dounine) - 后台管理系统</a>
	</div>


</body>

</html>
