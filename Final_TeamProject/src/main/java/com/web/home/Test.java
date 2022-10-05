package com.web.home;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.fasterxml.jackson.core.exc.StreamWriteException;
import com.fasterxml.jackson.databind.DatabindException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Test {

	public static void main(String[] args) throws StreamWriteException, DatabindException, IOException{
		ObjectMapper objectMapper = new ObjectMapper();
		
		String jsons = "\"virtualAccount\":{\"accountNumber\":\"X3790133557310\",\"accountType\":\"일반\",\"bank\":\"신한\",\"customerName\":\"이토페\",\"dueDate\":\"2022-09-19T02:17:36+09:00\",\"expired\":false,\"settlementStatus\":\"INCOMPLETED\",\"refundStatus\":\"NONE\"}";
		
		objectMapper.writeValue(new File("jsons.json"), jsons);
		
		//System.out.println(jsons.json);
	}

}