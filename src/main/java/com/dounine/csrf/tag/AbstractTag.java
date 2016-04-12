package com.dounine.csrf.tag;

import javax.servlet.jsp.tagext.TagSupport;

public class AbstractTag extends TagSupport {

	private static final long serialVersionUID = 3378348568966299826L;
	
	public String buildUri(String page) {
		String uri = page;

		if (!page.startsWith("/")) {
			uri = pageContext.getServletContext().getContextPath() + "/" + page;
		}

		return uri;
	}

}
