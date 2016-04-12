package com.dounine.csrf;

import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dounine.csrf.config.ConfigurationProvider;
import com.dounine.csrf.config.PropertiesConfigurationProvider;
import com.dounine.csrf.utils.UUIDGenerator;
import com.dounine.exception.CustomException;

public class Csrf {
	
	private Properties properties=null;
	

	public static void load(Properties properties){
		getInstance().properties = properties;
	}
	
	private static class SingletonHolder{
		public static final Csrf CSRF = new Csrf();
	}
	
	public static Csrf getInstance(){
		return SingletonHolder.CSRF;
	}
	
	public void createToken(HttpSession session){
		String token = (String)session.getAttribute(getSessionKey());
		if(null==token){
			try {
				token = UUIDGenerator.generateGeneratorId(getPrng(), getProvider(), getUUIDLength());
				session.setAttribute(getSessionKey(), token);
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (NoSuchProviderException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 为请求创建令牌
	 * @param pageTokens
	 * @param uri
	 */
	private void createRequestToken(Map<String, String> pageTokens,String uri){
		if(null==pageTokens){
			return;
		}
		if(pageTokens.containsKey(uri)){
			return;
		}
		try {
			pageTokens.put(uri, UUIDGenerator.generateGeneratorId(getPrng(), getProvider(), getUUIDLength()));
		} catch (Exception e) {
			throw new RuntimeException(String.format("dounine-csrf 不能生成页面随机令牌 - %s", e.getLocalizedMessage()), e);
		}
	}
	
	/**
	 * 创建当前请求令牌
	 * @param request
	 */
	public void createRequestTokenMaster(HttpServletRequest request){
		HttpSession session = request.getSession(false);
		if(null!=session){
			
			/** 如果会话令牌不存在则创建 **/
			createSessionToken(session);
			
			@SuppressWarnings("unchecked")
			Map<String, String> pageTokens = (Map<String, String>) session.getAttribute(Finals.PAGE_TOKENS_KEY);

			/** 初始化 **/
			if (pageTokens == null) {
				pageTokens = new HashMap<String, String>();
				session.setAttribute(Finals.PAGE_TOKENS_KEY, pageTokens);
			}
			
			/** 创建页面令牌 **/
			createRequestToken(pageTokens,request.getRequestURI());
		}
	}
	
	/**
	 * 获取请求令牌
	 * @param request
	 * @return
	 */
	public String getRequestTokenValue(HttpServletRequest request,String uri){
		HttpSession session = request.getSession(false);
		if(null!=session){
			@SuppressWarnings("unchecked")
			Map<String, String> requestTokens =(Map<String, String>) session.getAttribute(Finals.PAGE_TOKENS_KEY);
			if(null!=requestTokens){
				createRequestToken(requestTokens, uri);
				return requestTokens.get(uri);
			}
		}
		return getSessionToken(session);//获取会话令牌
	}
	
	/**
	 * 如果不存在就创建会话令牌 
	 * @param request
	 */
	public void createSessionToken(HttpSession session){
		String tokenValue = (String)session.getAttribute(getSessionKey());
		if(null==tokenValue){
			try {
				tokenValue = UUIDGenerator.generateGeneratorId(getPrng(), getProvider(), getUUIDLength());
			} catch (Exception e) {
				throw new RuntimeException(String.format("dounine-csrf 不能创建随机会话令牌- %s",e.getLocalizedMessage()),e);
			}
			session.setAttribute(getSessionKey(), tokenValue);
		}
	}
	
	public String getSessionToken(HttpSession session){
		if(null!=session){
			return (String) session.getAttribute(getSessionKey());
		}
		return null;
	}
	
	public boolean isValidatorRequestToken(HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession(true);
		String tokenFromSession = (String) session.getAttribute(getSessionKey());
		
		if(null!=tokenFromSession){
			return verifyRequestToken(request);
		}
		throw new RuntimeException("请登录后再操作.");
	}
	
	public boolean verifyRequestToken(HttpServletRequest request) throws CustomException{
		HttpSession session = request.getSession(true);
		
		@SuppressWarnings("unchecked")
		Map<String, String> requestTokens = (Map<String, String>) session.getAttribute(Finals.PAGE_TOKENS_KEY);
		
		String tokenFromPages = (null!=requestTokens?requestTokens.get(request.getRequestURI()):null);
		String tokenFromSession = (String) session.getAttribute(getSessionKey());
		String tokenFromRequest = request.getParameter(getTokenName());
		if(tokenFromRequest==null){
			throw new CustomException(request.getRequestURI()+"请求中缺失令牌.");
		}else if(null!=tokenFromPages){
			if(!tokenFromPages.equals(tokenFromRequest)){
				throw new CustomException("请求中的令牌认证失败.");//与请求中的令牌不一至
			}
		}else if(!tokenFromSession.equals(tokenFromRequest)){
			throw new CustomException("请求中的令牌认证失败.");//与会话中的令牌不一至
		}
		return true;
	}
	
	public String getSessionKey(){
		return getConfig().getSessionKey();
	}
	
	public String getPrng() {
		return getConfig().getPrng();
	}
	
	public String getProvider() {
		return getConfig().getProvider();
	}
	
	public int getUUIDLength() {
		return getConfig().getUUIDLength();
	}
	
	public String getTokenName() {
		return getConfig().getTokenName();
	}
	
	protected ConfigurationProvider getConfig(){
		return new PropertiesConfigurationProvider(getInstance().properties);//配置文件提供者
	}
}
