package com.dounine.csrf.listener;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.dounine.csrf.Csrf;
import com.dounine.csrf.Finals;
import com.dounine.csrf.utils.InputStreamUtil;

public class DounineCSRFServletContextListener implements ServletContextListener {
	
	private final static String CONFIG_PARAM = "dounine.csrf_guard.config";

	private static String servletContext = null;
	
	public static String getServletContext() {
		return servletContext;
	}

	private static String configFileName = null;
	
	public static String getConfigFileName() {
		return configFileName;
	}
	
	@Override
	public void contextInitialized(ServletContextEvent event) {
		ServletContext context = event.getServletContext();
		servletContext = context.getContextPath();
		if (servletContext == null || "/".equals(servletContext)) {
			servletContext = "";
		}
		
		configFileName = context.getInitParameter(CONFIG_PARAM);

		if (configFileName == null) {
			configFileName = Finals.CSRF_GUARD_PROPERTIES;
		}

		InputStream is = null;
		Properties properties = new Properties();

		try {
			is = getResourceStream(configFileName, context, false);
			
			if (is == null) {
				is = getResourceStream(Finals.META_INF_CSRFGUARD_PROPERTIES, context, false);
			}

			if (is == null) {
				throw new RuntimeException("不能找到默认的 dounine csrf_guard 配置文件 : " + configFileName);
			}
			
			properties.load(is);
			Csrf.load(properties);
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			InputStreamUtil.close(is);
		}
		System.out.println("************CSRF-跨站点攻击器初始化完毕。************");
	}


	@Override
	public void contextDestroyed(ServletContextEvent event) {
		/** nothing to do **/
	}

	private InputStream getResourceStream(String resourceName, ServletContext context, boolean failIfNotFound) throws IOException {
		InputStream is = null;

		/** try classpath **/
		is = getClass().getClassLoader().getResourceAsStream(resourceName);

		/** 在容器找 **/
		if (is == null) {
			String fileName = context.getRealPath(resourceName);

			if ((new File(fileName)).exists()) {
				is = new FileInputStream(fileName);
			}
		}

		/** 在当前目录查找 **/
		if (is == null) {
			File file = new File(resourceName);

			if (file.exists()) {
				is = new FileInputStream(resourceName);
			}
		}

		/** 如果文件找不到 **/
		if (is == null && failIfNotFound) {
			throw new IOException(String.format("dounine-csrf不能加载本地资源文件 - %s", resourceName));
		}

		return is;
	}

}
