package com.dounine.shiro;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.eis.AbstractSessionDAO;

public class SessionDao extends AbstractSessionDAO {
	private Map<Serializable,Session> maps = new HashMap<Serializable,Session>();

	@Override
	public void delete(Session session) {
		maps.remove(session.getId());
	}

	@Override
	public Collection<Session> getActiveSessions() {
		return maps.values();
	}

	@Override
	public void update(Session session) throws UnknownSessionException {
		
	}

	@Override
	protected Serializable doCreate(Session session) {
		//Serializable sessionId = generateSessionId(session);
		//assignSessionId(session, sessionId);
		//maps.put(session.getId(), session);
		return null;//sessionId;
	}

	@Override
	protected Session doReadSession(Serializable sessionId) {
		//System.out.println("会话ID:"+sessionId);
		return null;//maps.get(sessionId);
	}

}
