package com.dounine.shiro;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.dounine.domain.system.rbac.Permission;
import com.dounine.domain.system.rbac.Role;
import com.dounine.domain.system.rbac.User;
import com.dounine.enumtype.StatusType;
import com.dounine.finals.Finals;
import com.dounine.service.system.rbac.DepartmentService;
import com.dounine.service.system.rbac.PermissionService;
import com.dounine.service.system.rbac.RoleService;
import com.dounine.service.system.rbac.UserService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.shiro ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:17:41 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 自定义Realm读取数据库用户信息和授权信息 ]
 */
public class MyRealm extends AuthorizingRealm{
	
	private final Logger console = LoggerFactory.getLogger(this.getClass()); 
	@Autowired
	private UserService userService;
	@Autowired
	private PermissionService permissionService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private DepartmentService departmentService;
	
	
	/**
	 * SHIRO授权操作
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
		Subject subject = SecurityUtils.getSubject();
		if(subject.isAuthenticated()){
			Map<String, Object> map = getPermissions(subject);
			if(null!=map){
				simpleAuthorizationInfo = (SimpleAuthorizationInfo) map.get(Finals.SIMPLEAUTHORIZATIONINFO);
				return simpleAuthorizationInfo;
			}
		}
		console.info("shiro 授权操作");
		String userName = String.valueOf(super.getAvailablePrincipal(principals));//给当前用户设置角色
		Set<Permission> permissions = permissionService.findByUserName(Finals.PERMISSION_CACHE_SPLIT+userName);
		Set<Role> roles = roleService.findByUserName(Finals.ROLE_CACHE_SPLIT+userName);
		simpleAuthorizationInfo.setRoles(new HashSet<String>());
		for(Role role : roles){
			if(role.getStatus().equals(StatusType.CONGEAL)||!roleService.parentIsLocked(Finals.ROLE_PARENT_IS_LOCKED_CACHE+role.getRoleId())){//父级权限有冻结状态,则不加入。
				simpleAuthorizationInfo.getRoles().add(role.getRoleName());
			}
		}
		simpleAuthorizationInfo.setStringPermissions(new HashSet<String>());
		for(Permission permission : permissions){
			if(permission.getStatus().equals(StatusType.CONGEAL)||!permissionService.parentIsLocked(Finals.PERMISSION_PARENT_IS_LOCKED_CACHE+permission.getPermissionId())){//父级权限有冻结状态,则不加入。
				simpleAuthorizationInfo.getStringPermissions().add(permission.getPermissionResource());
			}
		}
		setPermissions(simpleAuthorizationInfo.getStringPermissions(),simpleAuthorizationInfo);
		return simpleAuthorizationInfo;
	}
	
	protected void setPermissions(Object value,SimpleAuthorizationInfo simpleAuthorizationInfo) {
		Subject subject = SecurityUtils.getSubject();
		if(null!=subject){
			subject.getSession().removeAttribute(Finals.ADMIN_PERMISSIONS_INFO);
			subject.getSession().removeAttribute(Finals.SIMPLEAUTHORIZATIONINFO);
			subject.getSession().setAttribute(Finals.ADMIN_PERMISSIONS_INFO, value);
			subject.getSession().setAttribute(Finals.SIMPLEAUTHORIZATIONINFO, simpleAuthorizationInfo);
		}
	}
	
	protected Map<String,Object> getPermissions(Subject subject) {
		if(null!=subject){
			final Object object = subject.getSession().getAttribute(Finals.ADMIN_PERMISSIONS_INFO);
			final Object sim = subject.getSession().getAttribute(Finals.SIMPLEAUTHORIZATIONINFO);
			if(null!=object&&null!=sim){
				return new HashMap<String, Object>(){
				private static final long serialVersionUID = -5802110260222944980L;
				{
					put(Finals.ADMIN_PERMISSIONS_INFO, object);
					put(Finals.SIMPLEAUTHORIZATIONINFO, sim);
				}};
			}
		}
		return null;
	}

	/**
	 * SHIRO认证操作
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authenticattionToken) throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authenticattionToken;
		String userName = token.getUsername();
		User user = userService.find(new User(userName));
		if(null!=user){
			if(!StringUtils.equals(user.getUserName(), Finals.ADMIN_NAME_STRING)){//非网站管理员要进行验证
				if(user.getStatus().equals(StatusType.CONGEAL)){
					throw new LockedAccountException(Finals.USER_LOCKED_MSG);
				}
				if(user.getDepartment().getStatus().equals(StatusType.CONGEAL)||departmentService.parentIsLocked(Finals.DEPARTMENT_PARENT_IS_LOCKED_CACHE+user.getDepartment().getDepartmentId())){
					throw new LockedAccountException(Finals.USER_DEPARTMENT_LOCKED_MSG);
				}
			}
			setSession(Finals.ADMIN_USER,user);
			return new SimpleAuthenticationInfo(userName, user.getUserPassword(), getName());
		}else{
			throw new UnknownAccountException();
		}
	}
	
	 public MyRealm() {
		// 该句作用是重写shiro的密码验证，让shiro用我自己的验证
		setCredentialsMatcher(new UserMatcher());
	}
	
	/** 
     * 将一些数据放到ShiroSession中,以便于其它地方使用 
     * @see  比如Controller,使用时直接用HttpSession.getAttribute(key)就可以取到 
     */  
    private void setSession(Object key, Object value){  
        Subject currentUser = SecurityUtils.getSubject();  
        if(null != currentUser){  
            Session session = currentUser.getSession();  
            if(null != session){  
                session.setAttribute(key, value);  
            }  
        }  
    }
    
    @Override
    @SuppressWarnings("unchecked")
    public boolean isPermitted(PrincipalCollection principals, String permission) {//重写Shiro的tag hasPermission标签
    	doGetAuthorizationInfo(principals);
    	Map<String, Object> map = getPermissions(SecurityUtils.getSubject());
		Set<String> permissions = (Set<String>) map.get(Finals.ADMIN_PERMISSIONS_INFO);
    	if(permissions!=null&&permissions.size()>0){
    		for(String _permission : permissions){
    			//System.out.print(_permission+" === "+permission+" 结果：");
    			if(super.isPermitted(principals, permission)){
    				return true;
    			}else{
    				if(StringUtils.equals(_permission, "/*")){
    					return true;
    				}
    				if(StringUtils.equals(_permission, permission)){
    					//System.out.println("true");
    					return true;
    				}
    				if(StringUtils.startsWith(_permission, StringUtils.substring(permission, 0,StringUtils.length(permission)-1))){// 
    					//System.out.println("true");
    					return true;
    				}
    				//System.out.println("false");
    			}
    		}
    	}
    	return super.isPermitted(principals, permission);
    }
}
