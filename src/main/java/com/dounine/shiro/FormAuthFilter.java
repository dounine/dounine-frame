package com.dounine.shiro;

import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dounine.domain.system.rbac.Login;
import com.dounine.domain.system.rbac.User;
import com.dounine.exception.ShiroAuthenticationException;
import com.dounine.finals.Finals;
import com.dounine.service.system.rbac.LoginService;
import com.dounine.service.system.rbac.UserService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.shiro ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:17:21 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ Shiro表单过滤 ]
 */
@SuppressWarnings("all")
public class FormAuthFilter extends FormAuthenticationFilter {
	private final Logger console = LoggerFactory.getLogger(this.getClass());

	private boolean development = false;
	
	protected void saveRequestAndRedirectToLogin(ServletRequest request,
			ServletResponse response) throws IOException {
		redirectToLogin(request, response);
	}

	protected boolean onLoginFailure(AuthenticationToken token,
			AuthenticationException e, ServletRequest request,
			ServletResponse response) {
		boolean result = super.onLoginFailure(token, e, request, response);
		if (!(e instanceof ShiroAuthenticationException)) {
			request.setAttribute(Finals.ADMIN_USER, new User(
					getUsername(request)));
			request.setAttribute(Finals.ERROR_MSG, e.getMessage());
		} else {
			request.setAttribute(Finals.ERROR_MSG, Finals.ERROR_MSG_CONTENT);
		}
		return result;
	}

	@Override
	protected UsernamePasswordToken createToken(ServletRequest request,
			ServletResponse response) {
		String userName = getUsername(request);// 获取用户名称
		String userPassword = getPassword(request);// 获取用户密码
		boolean rememberMe = isRememberMe(request);
		String host = getHost(request);
		return new UsernamePasswordToken(userName, userPassword,rememberMe, host);// 创建令牌
	}

	protected void doCaptchaValidate(HttpServletRequest request,
			UsernamePasswordToken token) {
	}

	@Override
	protected boolean executeLogin(ServletRequest request,
			ServletResponse response) throws Exception {// 后台登录的地址必需是admin/login.html与shiro:loginUrl配置一至,不然此方法不无法进入。
		UsernamePasswordToken token = createToken(request, response);// 获取用户令牌
		Subject subject = getSubject(request, response);
		String userName = token.getUsername();
		char[] userPassword = token.getPassword();
		try {
			if (null == userName || (null != userName && userName.trim().isEmpty())) {
				return onLoginFailure(token, new ShiroAuthenticationException(
						Finals.USER_NAME_NOT_EMPTY), request, response);
			}
			if (null == userPassword || (null != userPassword && String.valueOf(userPassword).trim().isEmpty())) {
				return onLoginFailure(token, new ShiroAuthenticationException(
						Finals.USER_PASSWORD_NOT_EMPTY), request, response);
			}
			boolean pass = true;
			try {
				subject.login(token);
			}catch(UnknownAccountException uae){ 
				uae.printStackTrace();
				pass = false;
	        }catch(IncorrectCredentialsException ice){  
	        	ice.printStackTrace();
	        	pass = false;
	        }catch(LockedAccountException lae){ 
	        	lae.printStackTrace();
	        	pass = false;
	        	return onLoginFailure(token, lae, request, response);
	        }catch(ExcessiveAttemptsException eae){  
	        	eae.printStackTrace();
	        	pass = false;
	        }catch (AuthenticationException e) {
	        	e.printStackTrace();
	        	pass = false;
			}
			if(pass){
				return onLoginSuccess(token, subject, request, response);
			}else{
				return onLoginFailure(token, new ShiroAuthenticationException(Finals.ERROR_MSG_CONTENT), request, response);
			}
		} catch (AuthenticationException e) {
			return onLoginFailure(token, e, request, response);
		}
	}

	public void setDevelopment(boolean development) {
		this.development = development;
	}
	

	/** 
     * 将一些数据放到ShiroSession中,以便于其它地方使用 
     * @see  比如Controller,使用时直接用HttpSession.getAttribute(key)就可以取到 
     */  
    private void setSession(Object key, Object value){  
        Subject currentUser = SecurityUtils.getSubject();  
        if(null != currentUser){  
            Session session = currentUser.getSession();  
            console.info("Session 默认超时时间为[" + session.getTimeout() + "]毫秒");  
            if(null != session){  
                session.setAttribute(key, value);  
            }  
        }  
    } 
}
