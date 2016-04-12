package com.dounine.csrf.listener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.dounine.csrf.Csrf;

public class DounineCSRFHttpSessionListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		Csrf csrfGuard = Csrf.getInstance();
		csrfGuard.createToken(session);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		/** nothing to do **/
	}

}
