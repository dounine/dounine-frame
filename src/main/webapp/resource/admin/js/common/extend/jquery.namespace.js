(function($){ 
    $.extend({ 
        namespace: function(ns){ 
            if(typeof ns != 'string'){ 
                throw new Error('命名空间必须是字符串'); 
            } 
             
            var ns_arr = ns.split('.'); 
            var parent = window; 
            for(var i in ns_arr){ 
                parent[ns_arr[i]] = parent[ns_arr[i]] || {}; 
                parent = parent[ns_arr[i]]; 
            } 
        } 
    }); 
 })(jQuery) 