var EasyuiTabs = (function() {

	function EasyuiTabs() {
	}
	
	EasyuiTabs.prototype.init = function(self){
		var tabTitle = '';
		
		$(self).find('div').each(function(){
			if($(this).attr('title')==$("#select_tab_title").val()&&!$(this).attr('selected')){
				$(this).attr('selected',true);
			}
		});
		
		$(self).tabs({
			fit:true,
			tools:[
			       {
			    	   iconCls:'icon-d-refresh',
			    	   text: '刷新',
			    	   id:'asdf',
			    	   handler:function(){
			    		   $("#dounine-main-center").mask({'maskMsg':'页面加载中...'});
			    		   var select_tab = $(self).tabs('getSelected');
			    		   this.id = 'refresh-id-'+tabTitle;
			    		   $(this).linkbutton('disable').css('cursor','not-allowed');
			    		   try{
			    			   if($.isFunction(window['delete_'+select_tab.panel('options').title])){//判断是不是方法,是方法则执行删除方法
			    				   window['delete_'+select_tab.panel('options').title]();
			    			   }
			    		   }catch(e){
			    		   }
			    		   
			    		   try{
			    			   var lox_tab = eval('({' + select_tab.attr('lox-data-options') + '})');
			    			   $(self).tabs('update',{
			    				   tab:select_tab,
			    				   options:{
			    					   href:lox_tab.href,
			    					   method:'post'
			    				   }
			    			   });
			    		   }catch(e){
			    			   alert('对不起,您的tab选项卡配置有问题,无法为请求数据。');
			    		   }
			    	   }
			       }
			       ],
			       onLoad:function(){
			    	   $("#lox-main-center").mask('hide');
			    	   $("#lox-main").nextAll().fadeOut();
		    		   $(this).id = 'refresh-id-'+tabTitle;
		    		   setTimeout(function(){
		    			   $('#refresh-id-'+tabTitle).linkbutton('enable').css('cursor','auto');
		    		   },500);
		    		   var _hash = window.location.hash;
					   if(_hash.indexOf('#center:')>0){
						  _hash = _hash.substring(0,_hash.indexOf('#center:'));
					   }
					   window.location.hash=_hash+'#center:'+tabTitle;
		    		   clearTable();//清除table的上下边框
			       },
			       onSelect:function(title,index){
			    	   var select_tab = $(self).tabs('getSelected');
			    	   tabTitle = select_tab.panel('options').title;
			    	   if(select_tab.attr('lox-data-options')!=null){
			    		   try{
			    			   var lox_tab = eval('({' + select_tab.attr('lox-data-options') + '})');
			    			   if($(select_tab)[0].innerHTML.replace(/\s+/g,'').length==0){
			    				   $(self).tabs('update',{
			    					   tab:select_tab,
			    					   options:{
			    						   href:lox_tab.href,
			    						   method:'post'
			    					   }
			    				   });
			    			   }
			    		   }catch(e){
			    			   alert('对不起,您的tab选项卡配置有问题,无法为请求数据。');
			    		   }
			    	   }
			    	   var _hash = window.location.hash;
					   if(_hash.indexOf('#center:')>0){
						 _hash = _hash.substring(0,_hash.indexOf('#center:'));
						 window.location.hash=_hash+'#center:'+tabTitle;
					   }
			       }
		});
	}


	return EasyuiTabs;
})();
