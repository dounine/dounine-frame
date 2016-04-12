/**
 * Project Name:cannikin
 * File Name:UUIDGenerator.java
 * Package Name:com.smcs.core.util
 * Date:2013-5-15下午3:45:22
 * Copyright (c) 2013, CANNIKIN(http://http://code.taobao.org/p/cannikin/src/) All Rights Reserved.
 *
*/
package com.dounine.csrf.utils;

import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.SecureRandom;
import java.util.Random;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.csrf ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月14日 下午12:44:25 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ UUID生成器 ]
 */
public final class UUIDGenerator {
	
	private final static char[] CHARSET = new char[] { 'A', 'B', 'C', 'D', 'E',
		'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
		'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4',
		'5', '6', '7', '8', '9'};

	public UUIDGenerator() {}

	@Override
	protected Object clone() throws CloneNotSupportedException {
		throw new CloneNotSupportedException();
	}
	
	public static String generateGeneratorId(String prng, String provider, int len) throws NoSuchAlgorithmException, NoSuchProviderException {
		return generateGeneratorId(SecureRandom.getInstance(prng, provider), len);
	}

	private static String generateGeneratorId(SecureRandom sr, int len) {
		StringBuilder sb = new StringBuilder();

		for (int i = 1; i < len + 1; i++) {
			int index = sr.nextInt(CHARSET.length);
			char c = CHARSET[index];
			if(sr.nextBoolean()&&c>='A'&&c<='Z'){
				//c = Character.toLowerCase(c);
			}
			sb.append(c);
			if ((i % (new Random().nextInt(len)+1) == 0 && i != 0 && i < len)) {
				sb.append('-');
			}
		}

		return sb.toString();
	}
	
	
	
	
	public static void main(String[] args) {
		try {
			System.out.println(generateGeneratorId("SHA1PRNG", "SUN",40));
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
