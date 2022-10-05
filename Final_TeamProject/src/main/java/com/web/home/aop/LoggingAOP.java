package com.web.home.aop;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component //bean 등록용
@Aspect	   //AOP class 등록용
public class LoggingAOP {
	private static final Logger logger = LoggerFactory.getLogger(LoggingAOP.class);
	private SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss.SSS");
	
	//joinPoint 설정 (포인트 컷으로 설정, 접근제한자 생략 가능)
	@Pointcut(value = "execution(* com.web.home..*Controller.*(..))")
	private void logginControllerCut() {}
	
	@Pointcut(value = "execution(* com.web.home.*.service.*Service.*(..))")
	private void logginServiceCut() {}
	
	@Pointcut(value = "execution(* com.web.home.*.model.*DAO.*(..))")
	private void logginDaoCut() {}
	
	@Pointcut(value = "logginControllerCut() || logginServiceCut() || logginDaoCut()")
	private void logginMVCCut() {}
	
	
	//advice 작성(메서드와 동일)
	@Before(value = "logginMVCCut()") 
	public void beforeLogging(JoinPoint jp) throws Exception{
		this._logging(jp, "before");
		
//		System.out.println("조인포인트 대상 객체 ->" + jp.getTarget());
//		System.out.println("조인포인트 대상 메서드의 매개변수 정보 ->" + jp.getArgs());
//		System.out.println("조인포인트 포인트컷 식 정보 ->" + jp.getSignature().getName());
//		System.out.println("조인포인트 포인트컷 식 정보 ->" + jp.getSignature().toLongString());
//		 -> public java.lang.String com.web.home.course.controller.CourseController.courseMain(org.springframework.ui.Model,int)

//		System.out.println("조인포인트 포인트컷 식 정보 ->" + jp.getSignature().toShortString());
//		 -> CourseController.courseMain(..)

//		System.out.println("조인포인트 포인트컷 식 정보 ->" + jp.getSignature().getDeclaringTypeName());
//		 -> com.web.home.course.service.CourseService.getAll
	}
	@After(value = "logginMVCCut()") 
	public void afterLogging(JoinPoint jp) throws Exception{
		this._logging(jp, "after");
	}
	
	private void _logging(JoinPoint jp, String adviceType) throws Exception{
		Date date = new Date();
		String fullClassName = jp.getSignature().toShortString();
		String method = jp.getSignature().getName();
		
		logger.info("[{}] - <<{}>> {}.{}", sdf.format(date), adviceType.toUpperCase(), fullClassName, method);
		
		if(logger.isDebugEnabled()) {
			for(Object arg: jp.getArgs()) {
				//logger.DEBUG => log4j.xml에서 Application 로그 level값을 info -> debug로 변환
				logger.debug("[{}] - Argument Type  : {}", sdf.format(date), arg.getClass().getSimpleName());
				logger.debug("[{}] - Argument Value : {}", sdf.format(date), arg);
			}
		}
	}
}
