package com.dounine.exception;

import org.apache.shiro.authc.AuthenticationException;

public class ShiroAuthenticationException extends AuthenticationException{

	private static final long serialVersionUID = -2324023958988172429L;

	public ShiroAuthenticationException() {
		super();
	}

	public ShiroAuthenticationException(String message, Throwable cause) {
		super(message, cause);
	}

	public ShiroAuthenticationException(String message) {
		super(message);
	}

	public ShiroAuthenticationException(Throwable cause) {
		super(cause);
	}
	
	
	
}
