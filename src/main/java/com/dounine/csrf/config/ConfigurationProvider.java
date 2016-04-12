package com.dounine.csrf.config;

public interface ConfigurationProvider {

	public String getSessionKey();
	
	public String getProvider();
	
	public int getUUIDLength();
	
	public String getPrng();
	
	public String getTokenName();
}
