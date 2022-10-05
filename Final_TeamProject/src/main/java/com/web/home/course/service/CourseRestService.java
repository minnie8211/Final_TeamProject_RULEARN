package com.web.home.course.service;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;


@Service
public class CourseRestService {
	
	public ResponseEntity<String> createFolder(String wid, String LessonName) {
		String createFolder = null;
		String folderId = null;
		String folderName = wid + "_" + LessonName;
		
		URI uri = UriComponentsBuilder
				.fromUriString("https://api.wecandeo.com")
				.path("/info/v1/folder/create.json")
				.queryParam("key", "8ef0bdca218f168aa4f254ba96c7cb6e")
				.queryParam("folder_name", "{folderName}")
				.build()
				.expand(folderName)
				.toUri();
		RestTemplate rest = new RestTemplate();
		
		ResponseEntity<String> response = rest.getForEntity(uri, String.class);
		
		return rest.getForEntity(uri, String.class);
	}

	public ResponseEntity<String> getUploadToken() {
		//v4버전 : 토큰을 받자마자 response 내보냄(아마 파일 하나씩밖에 안 올라갈듯, 변경필요)
		URI uri = UriComponentsBuilder
				.fromUriString("https://api.wecandeo.com")
				.path("/web/v4/uploadToken.json")
				.queryParam("key", "8ef0bdca218f168aa4f254ba96c7cb6e")
				.queryParam("folder_name", "{folderName}")
				.build()
				.toUri();
		
		RestTemplate rest = new RestTemplate();
		
		return rest.getForEntity(uri, String.class);
	}
	
	public Map<String, String> parsingToken(ResponseEntity<String> response) {
		String uploadInfo = null;
		String uploadUrl = null;
		String uploadCancelUrl = null;
		String thumbnailUploadUrl = null;
		String captionUploadUrl = null;
		String token = null;
		Map<String, String> info = new HashMap<String, String>();
		
		JSONParser jsonParser = new JSONParser();
		try {
			JSONObject json1 = (JSONObject)jsonParser.parse(response.getBody());
			uploadInfo = String.valueOf(json1.get("uploadInfo").toString());
			
			JSONObject json2 = (JSONObject)jsonParser.parse(uploadInfo);
			uploadUrl = String.valueOf(json2.get("uploadUrl"));
			uploadCancelUrl = String.valueOf(json2.get("uploadCancelUrl"));
			thumbnailUploadUrl = String.valueOf(json2.get("thumbnailUploadUrl"));
			captionUploadUrl = String.valueOf(json2.get("captionUploadUrl"));
			token = String.valueOf(json2.get("token"));
			
			info.put("uploadUrl", uploadUrl);
			info.put("uploadCancelUrl", uploadCancelUrl);
			info.put("thumbnailUploadUrl", thumbnailUploadUrl);
			info.put("captionUploadUrl", captionUploadUrl);
			info.put("token", token);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return info;
	}
}
