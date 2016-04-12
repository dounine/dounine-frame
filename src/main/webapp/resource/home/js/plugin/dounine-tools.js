String.prototype.format = function(opts) {//use 'my name is %{name}'.format({name:'huanghuanlai'})
	var source = this,
		data = Array.prototype.slice.call(arguments, 0),
		toString = Object.prototype.toString;
	if (data.length) {
		data = data.length == 1 ?
			(opts !== null && (/\[object Array\]|\[object Object\]/.test(toString.call(opts))) ? opts : data) : data;
		return source.replace(/%\{(.+?)\}/g, function(match, key) {
			var replacer = data[key];
			// chrome 下 typeof /a/ == 'function'
			if ('[object Function]' == toString.call(replacer)) {
				replacer = replacer(key);
			}
			return ('undefined' == typeof replacer ? '' : replacer);
		});
	}
	return source;
}

$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [ o[this.name] ];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
}

function msgShow(title, msg) {
	$.messager.show({
		title : title,
		msg : msg,
		timeout : 1000,
		style : {
			right : '',
			top : window.innerHeight / 2,
			bottom : ''
		},
		showType : 'slide'
	});
}