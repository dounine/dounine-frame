package com.dounine.controller.system.rbac;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.rbac.User;
import com.dounine.exception.CustomException;
import com.dounine.finals.Finals;
import com.dounine.service.system.rbac.UserService;

@Controller
@RequestMapping("admin/system/rbac/user")
public class UserController extends BaseController<User> {

	private static final String pathUrl = "admin/system/rbac/user/";

	@Autowired
	private UserService userService;

	@RequestMapping(value = "content.html", method = RequestMethod.POST)
	public String content() {

		return pathUrl + "content";

	}

	@RequestMapping(value = "user_check.action", method = RequestMethod.POST)
	public void check(User user, HttpServletResponse response,HttpServletRequest request) throws Exception {
		Subject subject = SecurityUtils.getSubject();
		if (null != subject && subject.isAuthenticated()) {
			response.getWriter().print(Finals.USER_REPEAT_LOGIN);
			return;
		}
		try {
			subject.login(new UsernamePasswordToken(user.getUserName(), user
					.getUserPassword(), getHost(request)));
			response.getWriter().print(SUCCESS);
		} catch (IncorrectCredentialsException ice) {
			response.getWriter().print(Finals.USER_PASSWORD_VERIFY);
		} catch (CustomException de) {
			response.getWriter().print(de.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print(e.getMessage());
		}
	}

	@RequestMapping(value = "update_password.action", method = RequestMethod.POST)
	public void update_password(String oldPassword, String userPassword,
			HttpServletResponse response) {
		if (SecurityUtils.getSubject().isAuthenticated()) {
			userService.updatePassword(oldPassword, userPassword);
			try {
				response.getWriter().print(SUCCESS);
				return;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		try {
			response.getWriter().print(Finals.LOGIN_AFTER_OPERATOR);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 锁定屏幕
	 * 
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "lock_screen.action", method = RequestMethod.POST)
	public void lock_screen(HttpServletResponse response) throws IOException {
		Subject subject = SecurityUtils.getSubject();
		if (null != subject) {
			if (subject.isAuthenticated()) {
				subject.getSession().setAttribute(Finals.LOCK_SCREEN_STRING,
						true);
				response.getWriter().print(SUCCESS);
				return;
			}
		}
		response.getWriter().print(FAILURE);
	}

	/**
	 * 解锁屏幕
	 * 
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "cancel_screen.action", method = RequestMethod.POST)
	public void cancel_screen(String userPassword, HttpServletResponse response)
			throws IOException {
		Subject subject = SecurityUtils.getSubject();
		if (null != subject) {
			if (subject.isAuthenticated()) {
				userService.check_password(userPassword);
				subject.getSession().setAttribute(Finals.LOCK_SCREEN_STRING,
						false);
				response.getWriter().print(SUCCESS);
			} else {
				response.getWriter().print(Finals.LOGIN_AFTER_OPERATOR);
			}
		} else {
			response.getWriter().print(FAILURE);
		}
	}

	public static String getHost(HttpServletRequest request) {
		String ipAdress = request.getHeader("X-Forwarded-For");
		if(ipAdress == null ||(ipAdress!=null&&ipAdress.length() == 0 || "unknown".equalsIgnoreCase(ipAdress))) { 
			ipAdress = request.getHeader("Proxy-Client-IP"); 
		} 
		if(ipAdress == null ||(ipAdress!=null&& ipAdress.length() == 0 || "unknown".equalsIgnoreCase(ipAdress))) { 
			ipAdress = request.getHeader("WL-Proxy-Client-IP"); 
		} 
		if(ipAdress == null ||(ipAdress!=null&& ipAdress.length() == 0 || "unknown".equalsIgnoreCase(ipAdress))) { 
			ipAdress = request.getRemoteAddr();
		}
		if(ipAdress == null ||(ipAdress!=null&&ipAdress.length()==0)){
			ipAdress = SecurityUtils.getSubject().getSession().getHost();
		}
		return ipAdress;
	}

}
