package com.web.home.course.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.web.home.course.model.CourseDAO;
import com.web.home.course.model.CourseDTO;
import com.web.home.course.model.Curriculum_bigDTO;
import com.web.home.course.model.Curriculum_smallDTO;
import com.web.home.course.model.FileInfoDTO;

@Service
public class LessonUploadService {

	@Autowired
	CourseDAO dao;

	public FileInfoDTO uploadFiles(MultipartFile file, String realPath, String url) {
		FileInfoDTO fileInfo = new FileInfoDTO();
		File folder = new File(realPath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		try {
			UUID uuid = UUID.nameUUIDFromBytes(file.getBytes());
			fileInfo.setLu_name(file.getOriginalFilename());
			fileInfo.setLu_uuidName(uuid.toString());
			fileInfo.setLu_location(realPath); //realPath +"/img/board/" + file.getOriginalFilename() 저장된 파일 위치
			fileInfo.setLu_url(url + file.getOriginalFilename());//request.getContextPath() + "/static/img/board/" + file.getOriginalFilename()
			fileInfo.setLu_fileSize((int)file.getSize());
			fileInfo.setLu_contentType(file.getContentType());
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fileInfo;
	}

	public boolean uploadLessonInfo(CourseDTO lessonData, 
									MultipartFile thumbnail, 
									HttpServletRequest request) {
		String realPath = request.getServletContext().getRealPath("/resources/course/thumbnail");
		String url = request.getServletContext() +"/static/img/course/thumbnail";
		File folder = new File(realPath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		CourseDTO courseDto = new CourseDTO();
		try {
			//로컬에 저장
			thumbnail.transferTo(new File(realPath + thumbnail.getOriginalFilename()));
			//서버 주소 저장
			courseDto.setL_thumbnail(url + thumbnail.getOriginalFilename());
			boolean result = dao.insertLesson(courseDto);
			if(result) {
				return true;
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	public int uploadCurriInfo(List<Curriculum_bigDTO> curri_big_list, List<Curriculum_smallDTO> curri_small_list) {
		//chapter DB에 저장하기
		boolean resultBig = dao.insertBigCurri(curri_big_list);
		//소강의 DB에 저장하기
		boolean resultSmall = dao.insertSmallCurri(curri_big_list);
		
		if(resultBig && resultSmall) {
			return 1;
		}else if(!resultBig && resultSmall){
			return 2;
		}else if(resultBig && !resultSmall){
			return 3;
		}else {
			return -1;
		}
	}

	public boolean uploadFileInfo(List<FileInfoDTO> aLL_files, CourseDTO lessonData) {
		// 파일 로컬에 저장하기
			//multipartFile을 세션에 저장하는게 가능한가?
		
		//강의 번호 불러오기
		int lid = dao.selectLidCount(lessonData.getL_title());
		
		// DB에 저장하기
		for(FileInfoDTO files : aLL_files) {
			boolean result = dao.insertFileInfo(files);
		}
		return false;
	}

}
