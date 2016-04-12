package com.dounine.domain.system.rbac;

import java.text.ParseException;
import java.util.Date;

import com.dounine.domain.BaseDomain;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:31:53 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 登录实体类 ]
 */
public class Login extends BaseDomain {

	private static final long serialVersionUID = 7275243919626302373L;

	private Long loginId;
	private String userName;
	private Integer userId;
	private String loginIp;
	private Date loginTime;
	private String area;

	public Login() {

	}

	public Login(String userName, String loginIp ,String area) {
		this.userName = userName;
		this.loginIp = loginIp;
		this.area = area;
	}
	
	public Login(Integer userId) {
		this.userId = userId;
	}
	
	public Login(String userName) {
		this.userName = userName;
	}

	public Long getLoginId() {
		return loginId;
	}

	public String getUserName() {
		return userName;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setLoginId(Long loginId) {
		this.loginId = loginId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getLoginIp() {
		return loginIp;
	}

	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}

	public Date getLoginTime() {
		return loginTime;
	}
	
	public String getLoginTimeC() {
		if(null!=loginTime){
			return TIMESTAMP.format(loginTime);
		}
		return null;
	}
	
	public String getLoginTimeD() {
		if(null!=loginTime){
			return DATETIME.format(loginTime);
		}
		return null;
	}

	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}
	
	public void setLoginTimeC(String loginTime) {
		if(loginTime!=null&&!loginTime.equals("")){
			try {
				this.loginTime = DATETIME.parse(loginTime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}

}
