<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-tag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head> 
		<meta charset="utf-8" />
		<title>奇可可-专注于体验软件研发.</title>
		<meta name="keywords" content="奇可可,互联网软件,客户体验产品,安全软件,免费软件,定制服务">
		<meta name="description" content="在这里,您可以免费使用我们的各种类型的互联网产品,专业的指导使用,专业的定制化服务供您选择,您的工作效率由我们的服务来提高.">
		<link rel="shortcut icon" href="${base_url}/resource/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" type="text/css" href="${base_url}/resource/home/css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="${base_url}/resource/home/css/iconfont.css"/>
		<link rel="stylesheet" type="text/css" href="${base_url}/resource/home/css/index.css"/>
		<link rel="stylesheet" type="text/css" href="${base_url}/resource/home/css/floor.css"/>
		<script src="${base_url}/resource/home/js/jquery-1.8.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="${base_url}/resource/home/js/jquery.corner.js" type="text/javascript" charset="utf-8"></script>
		<script src="${base_url}/resource/home/js/dounine-tools.js" type="text/javascript" charset="utf-8"></script>
	</head>
	<body>
		<div class="nav">
			<div class="nav-title">
				<div class="nav-t-center">
					<li style="padding-left: 6px;"><a href="/" title="qikeke-company">奇可可官网</a></li>
					<li><a href="javascript:void(0);" title="service">专注于服务</a></li>
					<li><a href="javascript:void(0);" title="free service">免费服务</a></li>
					<li style="border:0;"><a href="/news.html" title="news">新闻资讯</a></li>
				</div>
			</div>
			<div class="nav-menu-head">
				<div class="nav-logo">
					<a href="/" title="qikeke"><div class="logo"><img alt="qikeke奇可可官方网站" src="${base_url}/resource/home/img/common/logo.png"/></div></a>
				</div>
				<div class="nav-bar">
					<li><a href="/" title="index">首页 <i class="iconfont select">&#xf029d;</i></a></li>
					<li><a href="javascript:void(0);" title="product">产品<i class="iconfont"></i></a></li>
					<li><a href="javascript:void(0);" title="service">服务 <i class="iconfont"></i></a></li>
					<li><a href="javascript:void(0);" style="border: none;" title="help">帮助 <i class="iconfont"></i></a></li>
				</div>
			</div>
		</div>
		
		<div class="banner">
			<div class="banner-center">
				<div class="pointed">
					<div class="arrow-rectangle">
						<i class="iconfont one">&#xe67a;</i>
					</div>
					
					<div class="center-center">
						<i class="iconfont one">&#x3444;</i>
						<i class="iconfont second">&#xe601;</i>
					</div>
					
					<div class="left-top pointed-circle">
						<i class="iconfont one">&#x3444;</i>
						<i class="iconfont second">&#xf00ae;</i>
					</div>
					<div class="right-top pointed-circle">
						<i class="iconfont one" style="color: #4384D6;">&#x3444;</i>
						<i class="iconfont second">&#xe604;</i>
					</div>
					<div class="right-bottom pointed-circle">
						<i class="iconfont one" style="color: #4384D6;">&#x3444;</i>
						<i class="iconfont second">&#xe60b;</i>
					</div>
					<div class="left-bottom pointed-circle">
						<i class="iconfont one">&#x3444;</i>
						<i class="iconfont second">&#xf0046;</i>
					</div>
					<div class="left-left pointed-circle">
						<i class="iconfont one">&#x3444;</i>
						<i class="iconfont second">&#x343f;</i>
					</div>
					<div class="right-right pointed-circle">
						<i class="iconfont one" style="color: #4384D6;">&#x3444;</i>
						<i class="iconfont second">&#xe645;</i>
					</div>
					
					<div class="p-point">
						<div style="left:106px;top:186px;"></div>
						<div style="left:122px;top:186px;"></div>
						<div style="left:140px;top:186px;"></div>
						<div style="left:328px;top:186px;"></div>
						<div style="left:344px;top:186px;"></div>
						<div style="left:360px;top:186px;"></div>
						<div style="left:360px;top:186px;"></div>
						
						<div style="left:168px;top:88px;width: 6px;"></div>
						<div style="left:174px;top:97px;width: 6px;"></div>
						<div style="left:180px;top:106px;width: 6px;"></div>
						<div style="left:188px;top:115px;width: 6px;"></div>
						
						<div style="left:290px;top:115px;width: 6px;"></div>
						<div style="left:298px;top:106px;width: 6px;"></div>
						<div style="left:306px;top:99px;width: 6px;"></div>
						<div style="left:314px;top:90px;width: 6px;"></div>
						
						<div style="left:170px;top:294px;width: 6px;"></div>
						<div style="left:178px;top:284px;width: 6px;"></div>
						<div style="left:186px;top:276px;width: 6px;"></div>
						<div style="left:194px;top:268px;width: 6px;"></div>
						
						<div style="left:280px;top:268px;width: 6px;"></div>
						<div style="left:286px;top:276px;width: 6px;"></div>
						<div style="left:293px;top:284px;width: 6px;"></div>
						<div style="left:300px;top:292px;width: 6px;"></div>
					</div>
					
				</div>
				<div class="banner-text">
					<li style="color: #C3CCD3;font-size: 24px;">我们用心服务 , 诚比金贵</li>
					<li style="color: #FFFFFF;font-size: 36px;">免费使用 , 全程指导</li>
					<li style="color: #FFFFFF;font-size: 20px;margin:10px 0;">企业OA , 管理助手 , B2C , APP</li>
					<li style="color: #FFFFFF;font-size: 26px;">专业定制服务 , 您的好助手</li>
					<li>
						<div class="banner-box">
							安全 Security
						</div>
						<div class="banner-box">
							体验 Practice
						</div>
						<div class="banner-box">
							功能 Function
						</div>
					</li>
				</div>
				
			</div>
		</div>
		
		<div class="split-box" style="border: none;background: none;">
		</div>
		
		<div class="split-box">
			<div class="box-tip">软件产品分类</div>
			<div id="product-floor">
				<img class="load-img" alt="loading" src="${base_url}/resource/home/img/common/loading.gif" />
				<div class="floors"></div>
			</div>
		</div>
		
		<div class="split-box">
			<div class="box-tip">软件产品优势</div>
		</div>
		
		
		
		<div class="footer-box">
			<div class="footer">
				<div class="footer-t-b">
					
				</div>
				<div class="footer-content">
					<div class="footer-left">
						&copy; 2015. All Rights Reserved.
					</div>
					<div class="footer-right">
						<a href="/" title="keke">可可</a>
						<c:forEach var="bl" items="${indexBottomObjs}">
							<a title="${bl.alias}" href="${base}/<dounine-tag:article-alias id='${bl.id}'></dounine-tag:article-alias>">${bl.title}</a>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		
	</body>
	<script type="text/javascript">
		$(function(){
			$('.pointed-circle').css('opacity',0.95);
			$('.arrow-left,.arrow-rectangle,.arrow-right').css('opacity',0.8);
			$('div.banner-box').corner('2px');
		});
	</script>
	<script>
		var floor_all_action = '${base_url}/resource/home/floor-alls.json';
		var floor_cell_all_action = '${base_url}/resource/home/floor-cell.json';
		eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('1q(M.3){3.Q();L 1=["  [[   O N I t H K J 4 P    ]] "];3.V(1.7("\\n"));1.9=0;1.2("      m k 6 g h f U 4 p X");1.2("      g h f W 4 R p ");3.c(1.7("\\n"));1.9=0;1.2("      v a 8 q l [ j ] T w 5");1.2("      m k 6 l b S  G , y q a 8 C B");3.c(1.7("\\n"));1.9=0;1.2("      d 5 A F E 4 16 D x r z 1n 1m 1p , d 1o 1j 1i 1l");1.2("      1k w d 5 e o 6 、v r e o 6");1.2("      1w 1x 1y 1v 1s 1r j , 1u 1t 4 14 13 17 15 u a 12 Z Y 11 10 5");1.2("      18 1f 1e 1h b i 1g 1d 1a 19 u 8 t 1c 1b b i s s 5 ! ! !");3.c(1.7("\\n"))}',62,97,'|join_this_warning|push|console|的|了|你|join|要|length|不|世|info|除|调|强|没|有|界|here|果|入|如||戏|体|加|是|看|到|也|就|们|全|更|T*D|boss|来|进|个|余|其|深|任|将|行|同|var|window|即|致|信|clear|身|未|他|壮|error|健|魄|往|道|飞|哪|知|目|项|金||资|突|我|大|面|外|么|觉|然|那|得|阿|地|她|姨|狸|狐|扫|精|if|离|远|好|说|命|珍|爱|生'.split('|'),0,{}))

	</script>
	<script src="${base_url}/resource/home/js/floor.js" type="text/javascript" charset="utf-8"></script>
</html>
