package com.dounine.csrf.listener;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

public class StatusExposingServletResponse extends HttpServletResponseWrapper{

	private int httpStatus;   
	
	@SuppressWarnings("unused")
	private PrintWriter writer = null; 
	private ByteArrayOutputStream buffer = null;
	   
    public StatusExposingServletResponse(HttpServletResponse response) {   
        super(response); 
        buffer = new ByteArrayOutputStream();
    }   
   
    @Override   
    public void sendError(int sc) throws IOException {   
        httpStatus = sc;   
        super.sendError(sc);   
    }   
   
    @Override   
    public void sendError(int sc, String msg) throws IOException {   
        httpStatus = sc;   
        super.sendError(sc, msg);   
    }   
   
   
    @Override   
    public void setStatus(int sc) {   
        httpStatus = sc;   
        super.setStatus(sc);   
    }   
      
    public int getStatus() {   
        return httpStatus;   
    }

	@Override
	public PrintWriter getWriter() throws IOException {
       return  new PrintWriter(new OutputStreamWriter(buffer,    
               getCharacterEncoding()));    
	}
    
}


