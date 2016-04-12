var xval;
function cancleLoading(div) {
	try {
		window.clearInterval(xval.ntime);
		if (xval != undefined) {
			xval.remove();
		}
		div.hide();
	} catch (e) {
		div.hide();
	}
}
function loadingAjax(div, loadTitle) {// 中心数据加载等待
	try {
		window.clearInterval(xval.ntime);
		if (xval) {
			xval.remove();
		}
	} catch (e) {
	}
	xval = getBusyOverlay(div[0], {
		color : '#fff',
		opacity : 0.4,
		text : loadTitle == undefined ? '数据加载中' : loadTitle,
		style : 'text-decoration:blink;font-size:12px;color:#666666'
	}, {
		speed : 50,
		color : '#666666',
		size : 50,
		type : 't'
	});
	if (xval) {
		var c = 0, t = 100;
		xval.ntime = window.setInterval(function() {
			c++;
			if (c > t) {
				xval.settext("加载超时...");
				if (c > t * 2) {
					window.clearInterval(xval.ntime);
					div.hide();
					xval.remove();
				}
			}
		}, 1000);
	}
}