package com.dounine.controller.system;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.context.ContextUtil;
import com.dounine.controller.BaseController;
import com.dounine.domain.system.KeyBoard;
import com.dounine.domain.system.rbac.User;
import com.dounine.exception.AuthenticationException;
import com.dounine.finals.Finals;
import com.dounine.service.system.KeyBoardService;
import com.dounine.service.system.rbac.UserService;

@Controller
@RequestMapping("admin/index/keyboard")
public class KeyBoardController extends BaseController<KeyBoard>{
	
	private static final String pathUrl = "admin/index/keyboard/";
	
	@Autowired
	private KeyBoardService keyBoardService;
	@Autowired
	private UserService userService;

	@RequestMapping(value = "content.html", method = RequestMethod.POST)
	public String content() {// 模块主内容
		return pathUrl+"content";
	}

	@Override
	public void add(KeyBoard t, HttpServletResponse response) {
		t.setUserId(authic(false).getUserId());
		super.add(t, response);
	}

	@Override
	public void edit(KeyBoard t, HttpServletResponse response) {
		t.setUserId(authic(false).getUserId());
		super.edit(t, response);
	}

	@Override
	public void del(KeyBoard t, HttpServletResponse response) {
		t.setUserId(authic(false).getUserId());
		try {
			keyBoardService.delete(t);
			response.getWriter().print(SUCCESS);
		} catch (IOException e) {
			try {
				response.getWriter().print(FAILURE);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}

	@Override
	public Map<String, Object> maps(KeyBoard t) {
		t.setUserId(authic(true).getUserId());
		return super.maps(t);
	}

	@Override
	public void count(KeyBoard t, HttpServletResponse response) {
		t.setUserId(authic(true).getUserId());
		super.count(t, response);
	}
	
	public User authic(boolean rememExtr){
		HttpServletRequest _request = ContextUtil.getRequest();
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
		Subject subject = SecurityUtils.getSubject();
		if(null!=subject){
			if(rememExtr&&subject.isRemembered()){//记住我与手动授权可操作
				return userService.find(new User(String.valueOf(subject.getPrincipal())));
			}
			if(subject.isRemembered()||!subject.isAuthenticated()){
				throw new AuthenticationException(String.valueOf(sb));
			}
		}else{
			throw new AuthenticationException(String.valueOf(sb));
		}
		return userService.find(new User(String.valueOf(subject.getPrincipal())));
	}
	
	
}
