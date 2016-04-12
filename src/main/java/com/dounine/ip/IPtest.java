package com.dounine.ip;

public class IPtest {

	public static void main(String[] args) {
		IPSeeker ip=new IPSeeker("qqwry.dat","c:/cc");   
        //测试IP 58.20.43.13   
		System.out.println(ip.getIPLocation("127.0.0.1").getCountry()+":"+ip.getIPLocation("127.0.0.1").getArea()); 
	}
}
