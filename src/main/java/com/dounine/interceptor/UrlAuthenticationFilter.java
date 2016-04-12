package com.dounine.interceptor;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.dounine.controller.system.rbac.UserController;
import com.dounine.finals.Finals;
import com.dounine.shiro.MyRealm;
import com.dounine.utils.PatternUtils;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.interceptor ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:27:57 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ Shiro过滤器 ]
 */
public class UrlAuthenticationFilter extends AuthorizationFilter {
	
	protected static final String[] blackUrlPathPattern = new String[] { "*.aspx*", "*.asp*", "*.php*", "*.exe*", 	 "*.pl*", "*.py*", "*.groovy*", "*.sh*", "*.rb*", "*.dll*", "*.bat*", "*.bin*", "*.dat*",  
        "*.bas*", "*.c*", "*.cmd*", "*.com*", "*.cpp*", "*.jar*", "*.class*", "*.lnk*" }; //防文件攻击
	
	private static final Logger log = LoggerFactory.getLogger(UrlAuthenticationFilter.class);
	
	private List<String> excludeUrls;
	
	
	@Autowired
	private MyRealm myRealm;

	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
    	if (!isLoginRequest(request, response)) {
    		
            HttpServletRequest httpRequest = WebUtils.toHttp(request);
            String requestUrl = WebUtils.getPathWithinApplication(httpRequest);
            for (String pattern : blackUrlPathPattern) {  
                if (PatternUtils.simpleMatch(pattern, requestUrl)) {  
                    log.error(new StringBuffer().append("unsafe request >>> ").append(" request time: ").append( //不安全的请求 
                            new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())).append("; request ip: ")  
                            .append(UserController.getHost(httpRequest)).append("; request url: ").append(httpRequest.getRequestURI())  
                            .toString());  
                    return false;  
                }  
            }  
            
            Subject subject = SecurityUtils.getSubject();
            if(excludeUrls.contains(requestUrl)){//交给authc来判断
            	return true;
            }
        	for(String url : excludeUrls){
        		if(StringUtils.indexOf(url, ".")==-1){
        			if(StringUtils.startsWith(requestUrl, url)){
        				return true;
        			}
        		}
        	}
            if (!subject.isAuthenticated()) {
  		      	return false;
  		    }
            Object screen_object = subject.getSession().getAttribute(Finals.LOCK_SCREEN_STRING);
            if(null!=screen_object&&!requestUrl.contains("admin/system/rbac/user/cancel_screen.action")){
            	if(Boolean.valueOf(String.valueOf(screen_object))){//锁屏状态不给予操作
            		return false;
            	}
            }
            for(String _s : Finals.excludeUrl){
            	if(StringUtils.indexOf(requestUrl, _s)>-1){
            		return true;
            	}
            }
            String exu_url = StringUtils.replaceOnce(requestUrl, "/admin/", StringUtils.EMPTY);
            return myRealm.isPermitted(SecurityUtils.getSubject().getPrincipals(), StringUtils.replace(StringUtils.substring(exu_url,0,StringUtils.indexOf(exu_url, ".")), "/", ":"));
        }
        return true;
    }
	
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws IOException {
		if (isLoginRequest(request, response)) {
			return true;
		} else {
			HttpServletResponse _response = (HttpServletResponse) response;
			HttpServletRequest _request = (HttpServletRequest) request;
			String projectName = _request.getContextPath();
			StringBuilder sb = new StringBuilder();
			sb.append("<script>window.location.href='");
			sb.append(projectName.isEmpty()?StringUtils.EMPTY:("/"+projectName));
			sb.append("/admin/login.html';");
			sb.append("var rememberMe=");
			sb.append(SecurityUtils.getSubject().isRemembered());//记住我登录
			sb.append(";");
			sb.append("var lock_screen=");
			sb.append(_request.getSession().getAttribute(Finals.LOCK_SCREEN_STRING));
			sb.append(";");
			sb.append("</script>");
			_response.getWriter().print(String.valueOf(sb));
			return false;
		}
	}

	public void setExcludeUrls(List<String> excludeUrls) {
		this.excludeUrls = excludeUrls;
	}
}
