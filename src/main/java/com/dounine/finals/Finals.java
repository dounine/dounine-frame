package com.dounine.finals;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.finals ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:29:50 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 常量类 ]
 */
public final class Finals {
	public static final String TIMESTAMP = "yyyy-MM-dd HH:mm:ss";
	public static final String DATETIME = "yyyy-MM-dd";
	
	public static final int DEPARTMENT_ROOT_ID = 1;//部门根节点ID
	public static final int ROLE_ROOT_ID = 1;//角色根节点ID
	public static final int USER_ADMIN_ID = 1;//管理员ID
	public static final int PERMISSION_ROOT_ID = 1;//权限根节点ID
	public static final String BASE = "base";
	public static final String BASE_URL="base_url";
	public static final String TREE_OPEN = "open";//树形打开状态
	public static final String SUCCESS = "success";
	public static final String FAILURE = "failure";
	public static final String ADMIN_USER = "adminCurrentUserInfo";
	public static final String ERROR_MSG = "errorMsg";
	public static final String NOAUTHENTICATION = "NoAuthentication";
	public static String ADMIN_NAME_STRING = null;
	public static final String LOCK_SCREEN_STRING = "lock_screen";
	public static final String CURRENT_TIME_STRING = "current_time";
	public static final String CURRENT_TIME_TIP = "current_time_tip";
	public static final String CURRENT_TIME_ICON = "current_time_icon";
	public static final String CURRENT_LOGIN_STRING = "current_login";
	public static final String PERMISSION_CACHE_SPLIT = "per.";
	public static final String ROLE_CACHE_SPLIT = "role.";
	public static final String DEPARTMENT_PARENT_IS_LOCKED_CACHE = "dpLocked";
	public static final String PERMISSION_PARENT_IS_LOCKED_CACHE = "ppLocked";
	public static final String ROLE_PARENT_IS_LOCKED_CACHE = "rpLocked";
	public static final String ADMIN_PERMISSIONS_INFO = "ADMIN_PERMISSIONS_INFO";
	public static final String SIMPLEAUTHORIZATIONINFO = "SIMPLEAUTHORIZATIONINFO";
	public static boolean NOT_DELETE = false;
	
	public static final String VALUE_NOT_EMPTY_STRING = "值不能为空";
	public static final String ERROR_MSG_CONTENT = "用户名或者密码错误!!";
	public static final String USER_NAME_NOT_EMPTY = "用户名不能为空!!";
	public static final String USER_PASSWORD_NOT_EMPTY = "密码不能为空!!";
	public static final String PASSWORD_NOT_STANDARD = "密码不符合要求!!";
	public static final String USER_LOCKED_MSG = "您已经被冻结,无法进行操作!!";
	public static final String USER_DEPARTMENT_LOCKED_MSG = "您所在部门已冻结,无法操作!!";
	public static final String USER_PASSWORD_VERIFY = "密码验证失败!!";
	public static final String USERPASSWORD_NOT_EQUALS = "旧密码不正确,请重新输入!!";
	public static final String USER_REPEAT_LOGIN = "您已经登录,无须重复登录!!";
	public static final String PASSWORD_VERIFY_ERROR = "密码匹配异常!!";
	public static final String LOGIN_AFTER_OPERATOR = "请登录后再操作!!";
	public static final String ACCOUNT_STATUS_NOT_NORMAL = "您帐户处于非正常状态,无法操作!!";
	public static final String ROOT_NODE_NOT_DELETE = "根节点不能删除!!";
	public static final String TREE_NODE_NOT_MYSELF = "父级不能是自身,请重新选择!!";
	public static final String TREE_PARENT_NODE_NOTEMPTY = "父级不能为空!!";
	public static final String OPERATOR_FAILURE_STRING = "操作失败!!";
	public static final String VALUE_EXISTS_STRING = "已经存在相同的值!!";
	public static final String DATAINTEGRITY_STRING = "有数据与之相关联,不能删除!!";
	public static final String DATA_VALUE_NOT_EMPTY = "数据不能为空!!";
	public static final String BOX_PROGRAMMER = "盒子程序,禁止删除数据!!";
	public static final String BOX_PROGRAMMER_PASSWORD = "盒子程序,禁止修改管理员密码!!";
	public static final String ROOT_ADMIN_NOT_DELETE = "顶级管理员不能删除";
	public static final String ILLEGAL_OPERATOR = "违法操作！！";
	
	
	public static final String[] excludeUrl = {"menu","operator","content"};
}
