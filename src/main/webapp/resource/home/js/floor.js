var $floors = null,$floors_list=null,$floor_cell_width=100,$floor_cell_height=100,$floor_init_row=3,$floor_init_cell=10,$floor_click_cells=[],$floor_click_index=null,$floor_cell_operator_div_width=0,$floor_cell_operator_div_height=0,border_weight=20,border_height=10;
		var content_html = '<div class="floor-list"><div class="floor-content-values" style="left:%{floor-content-values-left}px;"></div><div class="floor-column"><ul><li style="width:%{floor-cell-width}px;display:none;"></li></ul></div><div class="floor-row"><ul></ul></div><div class="floor-content" ><ul style="top:0px;height:%{floor-content-ul-height}px;"></ul></div></div>';
		$(function(){
			$floors = $("div.floors");
			inits_floors();
		});
		function inits_floors() {
			$('div.floors').empty();
			$.get(floor_all_action, function(data) {
				$("#product-floor").hide();
				var list = data;
				for (var ii in list) {
					var $item = list[ii];
					var _data = content_html.format({
						"floor-cell-width": $item.floor_cell_width,
						"floor-content-values-left": -20,
						"floor-content-ul-height": $item.floor_cell_height
					});
					var $floor = $(_data).appendTo($floors);
					var $ul = $floor.find('div.floor-column ul');
					var $ul_lis = $ul.find('li');
					var $content = $floor.find('div.floor-content');
					var $content_title = $floor.find('div.floor-row');
					for (var j = 1; j <= $item.floor_row_count; j++) {
						$('<li>' + j + '</li>').appendTo($content_title.find('ul')); //添加行序号
						if (j < $item.floor_row_count) { //此处判断是为了减少多增的一行
							var cont = ['<ul style="top:' + (($item.floor_cell_height * j) + j * border_height) + 'px;">'];
							cont.push('</ul>');
							$(cont.join('')).appendTo($content);
						}
					}
					for (var i = 1; i <= $item.floor_column_count; i++) {
						$('<li>' + $ul.find('li').length + '</li>').appendTo($ul); //添加列序号
						if ($item.floor_row_count > 0) {
							$content.find('ul').each(function() {
								$('<li onclick="floor_cell_click(this);" style="left:' + (($item.floor_cell_width * (i - 1)) + (i - 1) * border_weight) + 'px;width:' + $item.floor_cell_width + 'px;height:' + $item.floor_cell_height + 'px;"></li>').appendTo($(this)); //创建单元格
							});
						}
					}

					var row_count = $floor.find('div.floor-row li');
					var column_count = $floor.find('div.floor-column li');
					$floor.height(row_count.length * parseInt($item.floor_cell_height) + row_count.length * border_height);

					$floor.find('div.floor-content').width((column_count.length - 1) * parseInt($item.floor_cell_width) + (column_count.length - 2) * border_weight);
					$floor.find('div.floor-content').height(row_count.length * parseInt($item.floor_cell_height) + (row_count.length - 1) * border_height);

					$('#product-floor').width((column_count.length - 1) * parseInt($item.floor_cell_width) + (column_count.length - 2) * border_weight);
					$('#product-floor').height(row_count.length * parseInt($item.floor_cell_height) + (row_count.length - 1) * border_height);

					$.ajax({
						url: floor_cell_all_action,
						async: false,
						method: 'get',
						data: {
							'productFloor.floor_id': $item.floor_id
						},
						success: function(data) {
							for (var ii in data) {
								var oo_b = data[ii];
								var $add_div = $('<div style="background:#E8E8E8;width:' + ($item.floor_cell_width * oo_b.cell_column_count + (oo_b.cell_column_count - 1) * border_weight) + 'px;height:' + ($item.floor_cell_height * oo_b.cell_row_count + (oo_b.cell_row_count - 1) * border_height) + 'px;position: absolute;left:' + (($item.floor_cell_width * (oo_b.cell_column_index - 1)) + oo_b.cell_column_index * border_weight) + 'px;top:' + ($item.floor_cell_height * (oo_b.cell_row_index - 1) + (oo_b.cell_row_index - 1) * border_height) + 'px;"></div>').appendTo($floor.find("div.floor-content-values")); //添加处于顶层数据
								if (oo_b.cell_picture_or_color) {
									$('<img click="no" onclick="floor_img_click_operator(this);" width="' + ($item.floor_cell_width * oo_b.cell_column_count + (oo_b.cell_column_count - 1) * border_weight) + '" height="' + ($item.floor_cell_height * oo_b.cell_row_count + (oo_b.cell_row_count - 1) * border_height) + '" src="' + oo_b.cell_picture + '" />').appendTo($add_div);
								} else {
									if (oo_b.cell_vertical) { //文字是否竖显示
										var sArray = oo_b.text.split('');
										var afterArray = [];
										for (var s in sArray) {
											afterArray.push(sArray[s] + '<br/>');
										}
										$add_div.css({
											'background-color': oo_b.cell_bg_color,
											'text-align': 'center'
										}).html(afterArray.join(''));
									} else {
										$add_div.css('background-color', oo_b.cell_bg_color).html(oo_b.cell_text);
									}
								}
								if ($.trim(oo_b.cell_css_style) != '') {
									$add_div.attr('style', ($add_div.attr('style') + ";" + oo_b.cell_css_style));
								}
							}
						}
					});

					$floor = null;
				}
				$("#product-floor").fadeIn();
				$(".load-img").hide();
			});
		}