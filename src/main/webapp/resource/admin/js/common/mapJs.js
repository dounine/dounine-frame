function HashMap() {
	/** Map 大小 **/
	var size = 0;
	/** 对象 **/
	var entry = new Object();//主键
	var auths = new Object();//作者
	var infos = new Object();//信息
	
	this.name = arguments.length==1?arguments[0]:null;

	/** 存 **/
	this.put = function(key, value) {
		if (!this.containsKey(key)) {
			size++;
		}
		entry[key] = value;
		if(arguments.length==3){
			auths[key] = arguments[2];
		}else if(arguments.length==4){
			auths[key] = arguments[2];
			infos[key] = arguments[3];
		}
	};
	
	/** 取 **/
	this.get = function(key) {
		if (this.containsKey(key)) {
			return entry[key];
		} else {
			return null;
		}
	};

	/** 取 **/
	this.getValue = function(key) {
		if (this.containsKey(key)) {
			return entry[key];
		} else {
			return null;
		}
	};
	
	/** 取 **/
	this.getInfo = function(key) {
		if (this.containsKey(key)) {
			return infos[key];
		} else {
			return null;
		}
	};
	
	/** 取 **/
	this.getAuth = function(key) {
		if (this.containsKey(key)) {
			return auths[key];
		} else {
			return null;
		}
	};

	/** 删除 **/
	this.remove = function(key) {
		if (delete entry[key]) {
			size--;
		}
		delete infos[key];
		delete auths[key];
	};

	/** 是否包含 Key **/
	this.containsKey = function(key) {
		return (key in entry);
	};

	/** 是否包含 Value **/
	this.containsValue = function(value) {
		for (var prop in entry) {
			if (entry[prop] == value) {
				return true;
			}
		}
		return false;
	};
	
	/** 是否包含 Info **/
	this.containsInfo = function(value) {
		for (var prop in infos) {
			if (infos[prop] == value) {
				return true;
			}
		}
		return false;
	};
	
	/** 是否包含 Auth **/
	this.containsAuth = function(value) {
		for (var prop in auths) {
			if (auths[prop] == value) {
				return true;
			}
		}
		return false;
	};

	/** 所有 Value **/
	this.values = function() {
		var values = new Array(size);
		for (var prop in entry) {
			values.push(entry[prop]);
		}
		return values;
	};

	/** 所有 Key **/
	this.keys = function() {
		var keys = new Array(size);
		for (var prop in entry) {
			keys.push(prop);
		}
		return keys;
	};

	/** Map Size **/
	this.size = function() {
		return size;
	};
}