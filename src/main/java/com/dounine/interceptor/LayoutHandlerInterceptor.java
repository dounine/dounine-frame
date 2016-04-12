package com.dounine.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.resource.ResourceHttpRequestHandler;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.interceptor ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:26:35 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 控制器过滤器 ]
 */
public class LayoutHandlerInterceptor implements HandlerInterceptor{
	
	private final Logger console = LoggerFactory.getLogger(this.getClass());
	private List<String> excludeUrls;
	
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse response, Object object, Exception exception)
			throws Exception {
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object object, org.springframework.web.servlet.ModelAndView modelAndView)
			throws Exception {
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object object) throws Exception {
		if(object instanceof ResourceHttpRequestHandler){
			return true;
		}
		String requestUri = request.getRequestURI();
	    String contextPath = request.getContextPath();
	    String url = requestUri.substring(contextPath.length());
		HandlerMethod handlerMethod = (HandlerMethod)object;
		String controllerName = handlerMethod.getBeanType().getSimpleName();
		console.info("访问：Controller====>"+controllerName+"  Method===>"+request.getMethod().toLowerCase()+"  Url===>"+request.getRequestURI()+"\t\t\t");
		
		if (this.excludeUrls.contains(url)) {
	      return true;
	    }
		return true;
		
	}
	
	public void setExcludeUrls(List<String> excludeUrls) {
	    this.excludeUrls = excludeUrls;
	  }

}
