package com.cykj.domestic.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util {

	public static String mdgStr;

	public static String MakeMd5(String text) {
		byte[] securiByte = null;
		try {
			securiByte = MessageDigest.getInstance("md5").digest(text.getBytes());
		    mdgStr = new BigInteger(1,securiByte).toString(16);
		    for (int i = 0; i < 32-securiByte.length; i++) {
		    	mdgStr = "0"+mdgStr;
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return mdgStr;
	}
}
