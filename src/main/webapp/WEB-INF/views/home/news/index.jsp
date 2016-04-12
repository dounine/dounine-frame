<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-tag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
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
		
		<style type="text/css">
			.article-type{
				min-height: 100px;
				margin-bottom:20px;
				float: left;
			}
			.article-type .article-t-title{
				width: 340px;
				height: 30px;
				line-height: 30px;
				border-bottom: 1px solid #ccc;
				position: relative;
			}
			.article-type .article-t-title .a-t-t-left{
				float: left;
			}
			.article-type .article-t-title .a-t-t-left a{
				font-size: 14px;
				color: #666666;
				font-family: "Microsoft YaHei", Verdana, sans-serif, "SimSun";
			}
			.article-type .article-t-title .a-t-t-right{
				width:100px;
				float: right;
			}
			.article-type .article-t-title .a-t-t-right .a-t-t-r-left{
				float: left;
			}
			.article-type .article-t-title .a-t-t-right .a-t-t-r-left li{
				float: left;
				width:8px;
				height:8px;
				margin:11px 4px;
				background: #CCCCCC;
				cursor: pointer;
			}
			.article-type .article-t-title .a-t-t-right .a-t-t-r-left li:hover{
				background: #40AA53;
			}
			.article-type .article-t-title .a-t-t-right .a-t-t-r-left .on{
				background: #40AA53;
			}
			.article-type .article-t-title .a-t-t-right .a-t-t-r-right{
				float: right;
			}
			.article-type .article-t-title .a-t-t-right .a-t-t-r-right a{
				font-family: "Microsoft YaHei", Verdana, sans-serif, "SimSun";
				color: #666666;
			}
			.article-type .article-t-content{
				width:336px;
				margin-left:2px;
			}
			.article-type .article-t-content li{
				text-indent: 10px;
				height:26px;
				line-height: 26px;
				font-size: 10pt;
				background: url(${base_url}/resource/home/img/common/list-type.gif) 0px -39px no-repeat;
				position: relative;
			}
			.article-type .a-t-c-2 li{
				background: url(${base_url}/resource/home/img/common/list-type.gif) 0px 12px no-repeat;
			}
			.article-type .article-t-content li a{
				color: #3E62A6;
			}
			.s-b-c-l-ul{
				float: left;
				width: 100%;
			}
			.article-type .article-t-content li span{
				font-size: 10pt;
				position: absolute;
				top:0px;
				right:0px;
				color: #666666;
			}
			.split-b-c-l{
				padding-top: 20px;
				width: 700px;
				min-height: 500px;
				position: relative;
				left:0px;
			}
			.split-b-c-r{
				padding-top: 20px;
				width: 280px;
				min-height: 500px;
				position: absolute;
				top:0px;
				right:0px;
			}
			.advert-bar{
				margin-bottom: 20px;
			}
			.advert-bar-new li{
				text-indent: 12px;
				height:26px;
				line-height: 26px;
				font-size: 14px;
				position: relative;
				background: url(${base_url}/resource/home/img/common/a2.gif) left center no-repeat;
				font-size: 10pt;
			}
			.advert-bar-new li span{
				font-size: 10pt;
				position: absolute;
				top:0px;
				right:0px;
				color: #666666;
			}
			.advert-bar-new li a{
				color: #3E62A6;
			}
			.a-b-w-tip strong{
				font-size: 16px;
				height: 40px;
				line-height: 40px;
				color: #40AA53;
			}
		</style>
	</head>
	<body>
		<div class="nav">
			<div class="nav-title">
				<div class="nav-t-center">
					<li style="padding-left: 6px;"><a href="/">奇可可官网</a></li>
					<li><a href="#">专注于服务</a></li>
					<li><a href="#">免费服务</a></li>
					<li style="border:0;"><a href="/news.html">新闻资讯</a></li>
				</div>
			</div>
			<div class="nav-menu-head">
				<div class="nav-logo">
					<a href="/"><div class="logo"><img src="${base_url}/resource/home/img/common/logo.png"/></div></a>
				</div>
				<div class="nav-bar">
					<li><a href=".">首页 <i class="iconfont select">&#xf029d;</i></a></li>
					<li><a href="#">产品<i class="iconfont"></i></a></li>
					<li><a href="#">服务 <i class="iconfont"></i></a></li>
					<li><a href="#" style="border: none;">帮助 <i class="iconfont"></i></a></li>
				</div>
			</div>
		</div>
		
		<div class="split-box" style="background: none;border-top: 1px solid #CCCCCC;">
			<div class="split-b-center" style="position: relative;margin-top:20px;min-height:700px;">
				<div class="split-b-c-l">
					
					<div class="s-b-c-l-ul">
						<div class="article-type">
							<div class="article-type-li">
								<div class="article-t-title">
									<div class="a-t-t-left">
										<a href="#"><strong>综合资讯</strong></a>
									</div>
									<div class="a-t-t-right">
										<div class="a-t-t-r-left">
											<li class="on"></li>
											<li></li>
											<li></li>
										</div>
										<div class="a-t-t-r-right">
											<a href="/news/list.html">更多»</a>
										</div>
									</div>
								</div>
								<div class="article-t-content">
									<ul>
										<li><a href="news/view.html">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="news/view.html">OSC 第 67 期高手问答 — MariaDB 原理和实现</a> <span>04/07</span></li>
										<li><a href="news/view.html">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="news/view.html">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="news/view.html">编程语言：变革创业思维的工具</a> <span>04/07</span></li>
										<li><a href="news/view.html">10个 iOS 用户暂可以嘲笑 Android 的特点</a> <span>04/07</span></li>
										<li><a href="news/view.html">ios-charts —— Swift 开发的 iOS 图表控件</a> <span>04/07</span></li>
										<li><a href="news/view.html">编程语言：变革创业思维的工具</a> <span>04/07</span></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="article-type" style="float: right;">
							<div class="article-type-li">
								<div class="article-t-title">
									<div class="a-t-t-left">
										<a href="#"><strong>软件更新资讯</strong></a>
									</div>
									<div class="a-t-t-right">
										<div class="a-t-t-r-left">
											<li class="on"></li>
											<li></li>
											<li></li>
										</div>
										<div class="a-t-t-r-right">
											<a href="#">更多»</a>
										</div>
									</div>
								</div>
								<div class="article-t-content a-t-c-2">
									<ul>
										<li><a href="#">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="#">OSC 第 67 期高手问答 — MariaDB 原理和实现</a> <span>04/07</span></li>
										<li><a href="#">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="#">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="#">编程语言：变革创业思维的工具</a> <span>04/07</span></li>
										<li><a href="#">Mybatis 分页插件 3.6.4 发布</a> <span>04/07</span></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					
					<div class="s-b-c-l-ul">
						<div class="article-type">
							<div class="article-type-li">
								<div class="article-t-title">
									<div class="a-t-t-left">
										<a href="#"><strong>综合资讯</strong></a>
									</div>
									<div class="a-t-t-right">
										<div class="a-t-t-r-left">
											<li class="on"></li>
											<li></li>
											<li></li>
										</div>
										<div class="a-t-t-r-right">
											<a href="#">更多»</a>
										</div>
									</div>
								</div>
								<div class="article-t-content">
									<ul>
										<li><a href="#">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="#">OSC 第 67 期高手问答 — MariaDB 原理和实现</a> <span>04/07</span></li>
										<li><a href="#">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="#">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="#">编程语言：变革创业思维的工具</a> <span>04/07</span></li>
										<li><a href="#">10个 iOS 用户暂可以嘲笑 Android 的特点</a> <span>04/07</span></li>
										<li><a href="#">ios-charts —— Swift 开发的 iOS 图表控件</a> <span>04/07</span></li>
										<li><a href="#">编程语言：变革创业思维的工具</a> <span>04/07</span></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="article-type" style="float: right;">
							<div class="article-type-li">
								<div class="article-t-title">
									<div class="a-t-t-left">
										<a href="#"><strong>软件更新资讯</strong></a>
									</div>
									<div class="a-t-t-right">
										<div class="a-t-t-r-left">
											<li class="on"></li>
											<li></li>
											<li></li>
										</div>
										<div class="a-t-t-r-right">
											<a href="#">更多»</a>
										</div>
									</div>
								</div>
								<div class="article-t-content a-t-c-2">
									<ul>
										<li><a href="#">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="#">OSC 第 67 期高手问答 — MariaDB 原理和实现</a> <span>04/07</span></li>
										<li><a href="#">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="#">2015年4月最新 15 个免费 jQuery 插件推荐</a> <span>04/07</span></li>
										<li><a href="#">编程语言：变革创业思维的工具</a> <span>04/07</span></li>
										<li><a href="#">Mybatis 分页插件 3.6.4 发布</a> <span>04/07</span></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="split-b-c-r">
					<div class="advert-bar">
						<img src="${base_url}/resource/home/img/common/index_banner_five_280x50_meIHX.jpg"/>
					</div>
					<div class="advert-bar-new">
						<ul class="a-b-w-tip">
							<strong>本周热讯</strong>
						</ul>
						<ul>
							<li><a href="#">5 个免费 jQuery 插件推荐</a> <span>5天前</span></li>
							<li><a href="#">手问答 — MariaDB 原理和实现</a> <span>5天前</span></li>
							<li><a href="#">最新 15 个免费 jQuery 插件推荐</a> <span>5天前</span></li>
							<li><a href="#">最新 15 个免费 jQuery 插件推荐</a> <span>1小时前</span></li>
							<li><a href="#">编程语言：变革创业思维的工具</a> <span>5天前</span></li>
							<li><a href="#">Mybatis 分页插件 3.6.4 发布</a> <span>3天前</span></li>
						</ul>
					</div>
					<div class="advert-bar" style="margin-top:10px;">
						<img src="${base_url}/resource/home/img/common/index_banner_five_280x50_meIHX.jpg"/>
					</div>
					<div class="advert-bar-new">
						<ul class="a-b-w-tip">
							<strong>本站最新资讯</strong>
						</ul>
						<ul>
							<li><a href="#">5 个免费 jQuery 插件推荐</a> <span>5天前</span></li>
							<li><a href="#">手问答 — MariaDB 原理和实现</a> <span>5天前</span></li>
							<li><a href="#">最新 15 个免费 jQuery 插件推荐</a> <span>5天前</span></li>
							<li><a href="#">最新 15 个免费 jQuery 插件推荐</a> <span>1小时前</span></li>
							<li><a href="#">编程语言：变革创业思维的工具</a> <span>5天前</span></li>
							<li><a href="#">Mybatis 分页插件 3.6.4 发布</a> <span>3天前</span></li>
						</ul>
					</div>
				</div>
			</div>
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
						<a href="/">奇可可</a>
						<a href="#">招贤纳士</a>
						<a href="#">服务协议</a>
						<a href="#">联系我们</a>
					</div>
				</div>
			</div>
		</div>
		
	</body>
</html>
