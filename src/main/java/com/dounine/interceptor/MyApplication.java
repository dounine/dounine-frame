package com.dounine.interceptor;

import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.commons.lang.StringUtils;
import org.springframework.core.io.support.PropertiesLoaderUtils;

import com.dounine.finals.Finals;
import com.dounine.utils.DateUtil;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.interceptor ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:26:44 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 应用程序启动初始化类 ]
 */
public class MyApplication extends HttpServlet {

	private static final long serialVersionUID = -4341014989196661463L;

	@SuppressWarnings("all")
	@Override
	public void init() throws ServletException {
		Properties properties = null;
		try {
			properties = PropertiesLoaderUtils.loadAllProperties("config.properties");
		} catch (Exception e) {
			e.printStackTrace();
		}
		ServletContext application = getServletContext();
		application.setAttribute(Finals.BASE, application.getContextPath());
		
		Finals.ADMIN_NAME_STRING = properties.getProperty("admin_name", "admin");//顶级管理员默认用户名
		Finals.NOT_DELETE = Boolean.valueOf(properties.getProperty("not_delete"));
		
		(new DateUtil(application)).start();//启动更新时间段线程
		String base_url = properties.getProperty(Finals.BASE_URL);
		if(StringUtils.isNotEmpty(base_url)){
			application.setAttribute(Finals.BASE_URL, base_url);
		}else{
			application.setAttribute(Finals.BASE_URL, application.getContextPath());
		}
		super.init();
	}

}
