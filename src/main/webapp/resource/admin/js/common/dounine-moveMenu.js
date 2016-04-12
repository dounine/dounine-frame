;(function($) {
	$.fn.moveMunu = function(o) {

		o = $.extend({
			fx : "linear",
			speed : 500,
			click : function() {
			}
		}, o || {});

		return this.each(function() {
			var b = $(this);
			noop = function() {
			};
			$back = $('<li class="selected"></li>').appendTo(b);
			$li = $("li", this);
			//curr = $li.find(".currentThis")[0];
			curr = $("li.currentThis", this)[0] || $li.addClass("currentThis")[0];
			//curr = b.find(".currentThis")[0];
			$li.not($back).hover(function() {
				move(this);
			}, noop);
			$(this).hover(noop, function() {
				move(curr);
			});
			$li.click(function(e) {
				//setCurr(this);
				return o.click.call(this, [e,this,setCurr])
			});
			setCurr(curr);
			function setCurr(a) {
				$back.css({
					"left" : a.offsetLeft-16 + "px",
					"width" : 130 + "px"
				});
				curr = a;
				$li.css('color','#EFFAFF');
				$(curr).css('color','#EFFAFF');
			};
			function move(a) {
				$back.each(function() {
					$(this).dequeue();
				}).animate({
					left : a.offsetLeft-16 + "px",
					width : 130 + "px"
				}, o.speed, o.fx);
			}

		});
	}
})(jQuery);
