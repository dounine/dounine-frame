package com.dounine.exception;

public class AuthenticationException extends RuntimeException{

	private static final long serialVersionUID = -5576547730499430024L;

	public AuthenticationException(){
		super();
	}

	public AuthenticationException(String message){
		super(message);
	}

	public AuthenticationException(Throwable throwable){
		super(throwable);
	}

	public AuthenticationException(String message, Throwable throwable){
		super(message, throwable);
	}
}
