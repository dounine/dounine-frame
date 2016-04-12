package com.dounine.context;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.context ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月14日 下午3:45:31 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 上下文获取 ]
 */
public class ContextUtil {

	private static ThreadLocal<ServletRequest> requestLocal = new ThreadLocal<ServletRequest>();
	private static ThreadLocal<ServletResponse> responseLocal = new ThreadLocal<ServletResponse>();

	public static HttpServletRequest getRequest() {
		return (HttpServletRequest) requestLocal.get();
	}

	public static void setRequest(ServletRequest request) {
		requestLocal.set(request);
	}

	public static HttpServletResponse getResponse() {
		return (HttpServletResponse) responseLocal.get();
	}

	public static void setResponse(ServletResponse response) {
		responseLocal.set(response);
	}

	public static HttpSession getSession() {
		return (HttpSession) ((HttpServletRequest) requestLocal.get())
				.getSession();
	}
}
