package com.dounine.csrf.tag;

public class AbstractUriTag extends AbstractTag {

	private static final long serialVersionUID = 4152702357883738844L;

	public String uri;

	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = buildUri(uri);
	}
}
