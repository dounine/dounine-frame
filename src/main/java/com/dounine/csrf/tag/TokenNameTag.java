package com.dounine.csrf.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.dounine.csrf.Csrf;


public class TokenNameTag extends TagSupport{

	private static final long serialVersionUID = -615636165250748116L;

	@Override
	public int doStartTag() throws JspException {
		String tokenName = Csrf.getInstance().getTokenName();
		try {
			pageContext.getOut().write(tokenName);
		} catch (IOException e) {
			pageContext.getServletContext().log(e.getLocalizedMessage(), e);
		}
		return SKIP_BODY;
	}
	
	

}
