
function clearTable(){
	$('table.easyui-grid').each(function(){
		var $table = $(this);
		if($table.attr('class').indexOf('not-t')==-1){
			$table.find('tr:first td').css({
				'border-top':'none'
			});
		}else if($table.attr('class').indexOf('not-b')==-1){
			$table.find('tr:last td').css({
				'border-bottom':'none'
			})
		}
	});
}