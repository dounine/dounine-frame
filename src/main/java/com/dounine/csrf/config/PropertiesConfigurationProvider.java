package com.dounine.csrf.config;

import java.util.Properties;

import com.dounine.csrf.Finals;
import com.dounine.csrf.listener.DounineCSRFServletContextListener;

public class PropertiesConfigurationProvider implements ConfigurationProvider {

	private String sessionKey;// 会话名称
	private String provider;// 算法提供者
	private String prng;// 算法名称
	private int UUIDLength;// 生成uuid长度
	private String tokenName;// 令牌名称

	@SuppressWarnings("unused")
	private Properties properties=null;

	public PropertiesConfigurationProvider(Properties properties) {
		try {
			this.properties = properties;
			sessionKey = getPropertiesString(properties,
					"com.dounine.csrf.key.sessionKey", "DOUNINE_CSRF_GUARD");
			provider = getPropertiesString(properties,
					"com.dounine.csrf.key.provider", "SUN");
			prng = getPropertiesString(properties, "com.dounine.csrf.key.prng",
					"SHA1PRNG");
			UUIDLength = Integer.valueOf(getPropertiesString(properties,
					"com.dounine.csrf.key.UUIDLength", "30"));
			tokenName = getPropertiesString(properties,
					"com.dounine.csrf.key.tokenName", "DOUNINE_TOKEN");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static String getPropertiesString(Properties properties, String key,
			String defaultValue) {
		String value = properties.getProperty(key, defaultValue);
		return initContextUrl(value);
	}

	public static String initContextUrl(String context) {
		if (null == context || !context.contains(Finals.CONTEXT_PS_STRING)) {
			return context;
		}
		return context.replace(Finals.SERVLET_CONTEXT_STRING,
				DounineCSRFServletContextListener.getServletContext());
	}

	@Override
	public String getSessionKey() {
		return sessionKey;
	}

	@Override
	public String getProvider() {
		return provider;
	}

	@Override
	public int getUUIDLength() {
		return UUIDLength;
	}

	@Override
	public String getPrng() {
		return prng;
	}

	public String getTokenName() {
		return tokenName;
	}

}
