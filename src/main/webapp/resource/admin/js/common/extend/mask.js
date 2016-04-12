(function($){
    function init(target,options){
        var wrap = $(target);
		if($("div.mask",wrap).length) wrap.mask("hide");
		
        wrap.attr("position",wrap.css("position"));
		wrap.attr("overflow",wrap.css("overflow"));
        wrap.css("position", "relative");
		wrap.css("overflow", "hidden");
        
        var maskCss = {
            position:"absolute",
            left:0,
            top:0,
			cursor: "wait",
            background:"#ccc",
            opacity:options.opacity,
            filter:"alpha(opacity="+options.opacity*100+")",
            display:"none"
        };
        
        var maskMsgCss = {
            position:"absolute",
            width:"auto",
            padding:"10px 18px",
            border:"2px solid #ccc",
            color:"white",
			cursor: "wait",
            display:"none",
            borderRadius:4,
            background:"#000000",
            opacity:0.5,
            filter:"alpha(opacity=50)"
        };
		var width,height,left,top;
		if(target == 'body'){
			width = Math.max(document.documentElement.clientWidth, document.body.clientWidth);
			height = Math.max(document.documentElement.clientHeight, document.body.clientHeight);
		}else{
			width = wrap.outerWidth() || "100%";
			height = wrap.outerHeight() || "100%";
		}
        $('<div class="mask"></div>').css($.extend({},maskCss,{
            display : 'block',
            width : width,
            height : height,
            zIndex:options.zIndex
        })).appendTo(wrap);

		var maskm= $('<div class="mask-msg"></div>').html('&nbsp;&nbsp;&nbsp;&nbsp;'+options.maskMsg).appendTo(wrap).css(maskMsgCss);
		
		if(target == 'body'){
			left = (Math.max(document.documentElement.clientWidth,document.body.clientWidth) - $('div.mask-msg', wrap).outerWidth())/ 2;
			if(document.documentElement.clientHeight > document.body.clientHeight){
				top = (Math.max(document.documentElement.clientHeight,document.body.clientHeight)  - $('div.mask-msg', wrap).outerHeight())/ 2;
			}else{
				top = (Math.min(document.documentElement.clientHeight,document.body.clientHeight)  - $('div.mask-msg', wrap).outerHeight())/ 2;
			}
			
		}else{
			left = (wrap.width() - $('div.mask-msg', wrap).outerWidth())/ 2;
			top = (wrap.height() - $('div.mask-msg', wrap).outerHeight())/ 2;
		}
		
        maskm.css({
            display : 'block',
            zIndex:options.zIndex+1,
            left : left,
            top :  top
        });
        maskm.append('<div style="position:absolute;left:14px;top:10px;height:16px;width:18px;background:url(../resource/admin/images/loading219.gif) no-repeat;"></div>');
        setTimeout(function(){
            wrap.mask("hide");
        }, options.timeout);
            
        return wrap;
    }
       
    $.fn.mask = function(options){   
        if (typeof options == 'string'){
            return $.fn.mask.methods[options](this);
        }
        options = $.extend({}, $.fn.mask.defaults,options);
        return init(this,options);
    };
    $.mask = function(options){  
        if (typeof options == 'string'){
            return $.fn.mask.methods[options]("body");
        }
        options = $.extend({}, $.fn.mask.defaults,options);
        return init("body",options);
    };
	
	$.mask.hide = function(){
		$("body").mask("hide");
	};
	
    $.fn.mask.methods = {
        hide : function(jq) {
            return jq.each(function() {
                var wrap = $(this);
                $("div.mask",wrap).fadeOut(function(){
                    $(this).remove();
                });
                $("div.mask-msg",wrap).fadeOut(function(){
                    $(this).remove();
                    wrap.css("position",  wrap.attr("position"));
					wrap.css("overflow", wrap.attr("overflow"));
                });
            });
        }
    };
    
    $.fn.mask.defaults = {
        maskMsg:'加载中...',
        zIndex:100000,
        timeout:30000,
        opacity:0.6
    };
})(jQuery);