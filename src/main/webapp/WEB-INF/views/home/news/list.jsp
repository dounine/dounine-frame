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
		<link rel="shortcut icon" href="${base_url}/resource/home/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" type="text/css" href="${base_url}/resource/home/css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="${base_url}/resource/home/css/iconfont.css"/>
		<link rel="stylesheet" type="text/css" href="${base_url}/resource/home/css/index.css"/>
		<link rel="stylesheet" type="text/css" href="${base_url}/resource/home/css/floor.css"/>
		<script src="${base_url}/resource/home/js/jquery-1.8.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="${base_url}/resource/home/js/jquery.corner.js" type="text/javascript" charset="utf-8"></script>
		<script src="${base_url}/resource/home/js/dounine-tools.js" type="text/javascript" charset="utf-8"></script>
		
		<style type="text/css">
			.news-host{
				border: 1px solid #EEEEEE;
				width: 100%;
				background: #FAFCFF;
			}
			.news-host-bg{
				height: 34px;
				background: #EEEEEE;
				margin-bottom: 8px;
			}
			.news-host-bg li{
				float: left;
			}
			.news-host-bg li a{
				display: block;
				height: 34px;
				line-height: 34px;
				padding: 0 10px;
				font-size: 12pt;
				float: left;
				color: #008800;
				text-decoration: none;
				font-family: "Microsoft YaHei", Verdana, sans-serif, "SimSun";
			}
			.news-host-bg .active{
				background: #557DBA;
				color: white;
			}
			.news-list{
				margin-top:40px;
				border:1px solid #EEEEEE;
			}
			.news-host-l-list .li-data li{
				margin:10px;
				border-bottom: 1px solid #EEEEEE;
				padding-bottom: 6px;
			}
			.news-host-l-list .li-data li a{
				text-decoration: none;
				color: #3E62A6;
				outline: 0;
				font-size: 1.5em;
			}
			.news-host-l-list .li-data li a:hover{
				color: #c00;
			}
			.news-host-l-list .li-data li p.date{
				text-indent: 4px;
				height: 30px;
				line-height: 30px;
				font-size: 10pt;
				font-family: "Microsoft YaHei", Verdana, sans-serif, "SimSun";
				color: #666666;
			}
			.news-host-l-list .li-data li p.detail{
				color: #666666;
				line-height: 20px;
			}
			.news-host-l-list .li-data li p.more{
				text-indent: 4px;
				height: 30px;
				line-height: 30px;
				color: #3E62A6;
			}
			.news-host-l-list .li-data li p.more a{
				font-size: 10pt;
			}
			.news-host-l-list .li-data li p.newImg{
				margin-top:6px;
				overflow: hidden;
			}
			.news-host-l-list .pager{
				height: 30px;
				margin:20px 10px;
			}
			.news-host-l-list .pager li{
				float: left;
			}
			.news-host-l-list .pager li a{
				display: block;
				padding:4px 8px;
				background: #F2F2F2;
				margin-right:10px;
				color: #58597C;
				float: left;
				font-family: Courier New, Arial;
				font-size: 12pt;
				text-decoration: none;
			}
			.news-host-l-list .pager li a:hover{
				background: #58595B;
				color: white;
			}
			.news-host-l-list .pager .prev a{
				background: #cccccc;
			}
			.n-h-l-item li{
				margin-left:4px;
				text-indent: 12px;
				height:26px;
				line-height: 26px;
				font-size: 14px;
				position: relative;
				background: url(${base_url}/resource/home/img/common/a2.gif) left center no-repeat;
				font-size: 10pt;
			}
			.n-h-l-item li a{
				color: #3E62A6;
			}
			.n-h-l-item li span{
				font-size: 10pt;
				position: absolute;
				top:0px;
				right:6px;
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
					<li><a href="#">专注于软件</a></li>
					<li><a href="#">免费服务</a></li>
					<li style="border:0;"><a href=".">新闻资讯</a></li>
				</div>
			</div>
			<div class="nav-menu-head">
				<div class="nav-logo">
					<a href="/"><div class="logo"><img src="${base_url}/resource/home/img/common/logo.png"/></div></a>
				</div>
				<div class="nav-bar">
					<li><a href="/">首页 <i class="iconfont select">&#xf029d;</i></a></li>
					<li><a href="#">产品<i class="iconfont"></i></a></li>
					<li><a href="#">服务 <i class="iconfont"></i></a></li>
					<li><a href="#" style="border: none;">帮助 <i class="iconfont"></i></a></li>
				</div>
			</div>
		</div>
		
		<div class="split-box" style="background: none;border-top: 1px solid #CCCCCC;">
			<div class="split-b-center" style="position: relative;margin-top:20px;min-height:700px;">
				<div class="split-b-c-l">
					<div class="news-host">
						<div class="news-host-bg">
							<ul>
								<li><a class="active" onmouseenter="news_hots_enter(this);" href="#">本周热点</a></li>
								<li><a href="#" onmouseenter="news_hots_enter(this);">本周热点</a></li>
							</ul>
						</div>
						<div class="news-host-l">
							<div class="n-h-l-item">
								<ul>
									<li><a href="#">5 个免费 jQuery 插件推荐</a> <span>发布于 2015-04-03</span></li>
									<li><a href="#">手问答 — MariaDB 原理和实现</a> <span>发布于 2015-04-03</span></li>
									<li><a href="#">最新 15 个免费 jQuery 插件推荐</a> <span>发布于 2015-04-03</span></li>
									<li><a href="#">最新 15 个免费 jQuery 插件推荐</a> <span>发布于 2015-04-03</span></li>
									<li><a href="#">编程语言：变革创业思维的工具</a> <span>发布于 2015-04-03</span></li>
									<li><a href="#">Mybatis 分页插件 3.6.4 发布</a> <span>发布于 2015-04-03</span></li>
								</ul>
								<ul style="display: none;">
									<li><a href="#">234234</a> <span>发布于 2015-04-03</span></li>
									<li><a href="#">2222</a> <span>发布于 2015-04-03</span></li>
									<li><a href="#">最新 15 个免费 jQuery 插件推荐</a> <span>发布于 2015-04-03</span></li>
									<li><a href="#">最新 15 个免费 jQuery 插件推荐</a> <span>发布于 2015-04-03</span></li>
									<li><a href="#">编程语言：变革创业思维的工具</a> <span>发布于 2015-04-03</span></li>
									<li><a href="#">Mybatis 分页插件 3.6.4 发布</a> <span>发布于 2015-04-03</span></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="news-list">
						<div class="news-host-bg">
							<ul>
								<li><a href="#" >全部资讯</a></li>
								<li><a class="active" href="#">综合资讯</a></li>
								<li><a href="#" >软件资讯</a></li>
							</ul>
						</div>
						<div class="news-host-l">
							<div class="news-host-l-list">
								<ul class="li-data">
									<li>
										<h2><a href="#">Git@OSC 项目推荐 —— 基于Hadoop分布式爬虫</a></h2>
										<p class="date">发布于 10小时前</p>
										<p class="detail">zongtui-webcrawler 众推，开源版的今日头条！ 基于hadoop思维的分布式网络爬虫。 目前已经把webmagic的基础部分加入到工程中，下一步会根据这个继续修改，变成完全分布式的架构。</p>
										<p class="more"><a href="#">查看全文</a></p>
									</li>
									<li>
										<h2><a href="#">Git@OSC 项目推荐 —— 基于Hadoop分布式爬虫</a></h2>
										<p class="date">发布于 10小时前</p>
										<p class="detail">zongtui-webcrawler 众推，开源版的今日头条！ 基于hadoop思维的分布式网络爬虫。 目前已经把webmagic的基础部分加入到工程中，下一步会根据这个继续修改，变成完全分布式的架构。</p>
										<p class="newImg">
											<a href="#"><img src="${base_url}/resource/home/img/common/075141_wEWj_5189.jpg"/></a>
										</p>
										<p class="more"><a href="#">查看全文</a></p>
									</li>
									<li>
										<h2><a href="#">Git@OSC 项目推荐 —— 基于Hadoop分布式爬虫</a></h2>
										<p class="date">发布于 10小时前</p>
										<p class="detail">zongtui-webcrawler 众推，开源版的今日头条！ 基于hadoop思维的分布式网络爬虫。 目前已经把webmagic的基础部分加入到工程中，下一步会根据这个继续修改，变成完全分布式的架构。</p>
										<p class="more"><a href="#">查看全文</a></p>
									</li>
									<li>
										<h2><a href="#">Git@OSC 项目推荐 —— 基于Hadoop分布式爬虫</a></h2>
										<p class="date">发布于 10小时前</p>
										<p class="detail">zongtui-webcrawler 众推，开源版的今日头条！ 基于hadoop思维的分布式网络爬虫。 目前已经把webmagic的基础部分加入到工程中，下一步会根据这个继续修改，变成完全分布式的架构。</p>
										<p class="more"><a href="#">查看全文</a></p>
									</li>
									<li>
										<h2><a href="#">Git@OSC 项目推荐 —— 基于Hadoop分布式爬虫</a></h2>
										<p class="date">发布于 10小时前</p>
										<p class="detail">zongtui-webcrawler 众推，开源版的今日头条！ 基于hadoop思维的分布式网络爬虫。 目前已经把webmagic的基础部分加入到工程中，下一步会根据这个继续修改，变成完全分布式的架构。</p>
										<p class="more"><a href="#">查看全文</a></p>
									</li>
								</ul>
								<ul class="pager">
                            		<li class="page prev"><a href="?show=industry&amp;p=13">&lt;</a></li>            
                            		<li class="page"><a href="?show=industry&amp;">1</a></li>            		
                            		<li class="page"><a href="?show=industry&amp;p=11">2</a></li>   
                            		<li class="page"><a href="?show=industry&amp;p=11">3</a></li>
                            		<li class="page prev"><a href="?show=industry&amp;p=15">&gt;</a></li>  
                            	</ul>
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
						<a href="#">奇可可</a>
						<a href="#">招贤纳士</a>
						<a href="#">服务协议</a>
						<a href="#">联系我们</a>
					</div>
				</div>
			</div>
		</div>
		
	</body>
	<script type="text/javascript">
		function news_hots_enter(self){
			var $self = $(self);
			$self.parent().parent().find('.active').removeClass('active');
			var index = $self.addClass('active').parent().index();
			$('.news-host .n-h-l-item').find('ul').hide();
			$('.news-host .n-h-l-item').find('ul').eq(index).show();
		}
	</script>
</html>
