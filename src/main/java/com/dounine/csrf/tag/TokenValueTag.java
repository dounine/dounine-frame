package com.dounine.csrf.tag;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import com.dounine.csrf.Csrf;

public class TokenValueTag extends AbstractUriTag{

	private static final long serialVersionUID = -6122410933521525559L;

	@Override
	public int doStartTag() throws JspException {
		Csrf csrf = Csrf.getInstance();
		if(null==getUri()){
			throw new IllegalStateException("dounine-csrf - [ uri paramter not empty. ]");
		}
		String tokenValue = csrf.getRequestTokenValue((HttpServletRequest)pageContext.getRequest(),getUri());
		String tokenName = csrf.getTokenName();
		
		try {
			pageContext.getOut().write(new StringBuffer().append(getUri()).append("?").append(tokenName).append("=").append(tokenValue).toString());
		} catch (IOException e) {
			pageContext.getServletContext().log(e.getLocalizedMessage(), e);
		}
		
		return SKIP_BODY;
		
	}

	
}
