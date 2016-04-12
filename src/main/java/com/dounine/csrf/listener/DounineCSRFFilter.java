package com.dounine.csrf.listener;
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dounine.csrf.Csrf;
public class DounineCSRFFilter implements Filter{
	
	@SuppressWarnings("unused")
	private FilterConfig filterConfig;
	private String chartEncoding;
	private final String attackRequest = "dounine-csrf check the request is attack.";

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		this.chartEncoding = filterConfig.getInitParameter("chartEncoding");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		request.setCharacterEncoding(chartEncoding);
		response.setCharacterEncoding(chartEncoding);
		
		if(request instanceof HttpServletRequest&&response instanceof HttpServletResponse){
			
			HttpServletRequest _request = (HttpServletRequest) request;
			HttpServletResponse _response = (HttpServletResponse) response;
			HttpSession session = _request.getSession(false);
            
            if(_request.getRequestURI().indexOf("/admin")==-1){
    			chain.doFilter(request, response);
				return;
			}
			
			StatusExposingServletResponse resp = new StatusExposingServletResponse(_response);
			
			if(null==session){
				chain.doFilter(request, response);
				return;
			}
			
			Csrf csrf = Csrf.getInstance();
			try {
				if(!csrf.isValidatorRequestToken(_request, _response)){
					resp.sendError(401, attackRequest);
				}
			} catch (Exception e) {
				resp.sendError(401, attackRequest);
			}
			Csrf.getInstance().createRequestTokenMaster(_request);
		}
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		this.filterConfig = null;
	}

}