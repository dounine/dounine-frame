package com.dounine.csrf.utils;

import java.io.IOException;
import java.io.InputStream;

public class InputStreamUtil {

	public static void close(InputStream inputStream){
		try {
			inputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
