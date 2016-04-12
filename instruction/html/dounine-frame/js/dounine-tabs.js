;(function($) {
	$.fn.dounine_tabs = function(o) {
		o = $.extend({
			select : 0,
			click : function() {
			}
		}, o || {});
		return this.each(function() {
			var self = $(this);
			var divs = self.find('> div'),selected_class='dtt-select';
			var tabs_title = $("<div class='dounine-tabs-title'></div>").appendTo(self);
			var tabs_content = $("<div class='dounine-tabs-content'></div>").appendTo(self);
			divs.each(function(){
				var item = $(this);
				$('<a href="javascript:void(0);">'+item.attr('title')+'</a>').appendTo(tabs_title).bind('click',function(){
					tab_click($(this));
				});
				$('<div>'+item.html()+'</div>').appendTo(tabs_content);
			});
			if(o.select<=divs.length-1){
				tabs_title.find('a').eq(o.select).addClass(selected_class);
				tabs_content.find('> div').hide();
				tabs_content.find('> div').eq(o.select).show();
			}
			divs.remove();
			
			function tab_click(self){
				tabs_title.find('a').removeClass(selected_class);
				self.addClass(selected_class);
				tabs_content.find('> div').hide();
				tabs_content.find('> div').eq(self.index()).show();
			}
		});
	}
})(jQuery);
