<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<jsp:include page="/WEB-INF/views/common/firstHeader.jsp"/>
	<div class="m-auto w-lg-75 w-xl-50">
  			<h2 class="text-info font-weight-light mb-5"><i class="fa fa-diamond"></i>My Jarvis</h2>
  			
  			<!-- 로그인 form 시작 -->
  			<form action="${path }/member/login.do" method="post">
       		
       		<div class="form-group">
        		<label class="text-secondary">Email</label>
        		<input type="text" name='memberEmail' required class="form-control" />
       		</div>
  
       		<div class="form-group">
       			<label class="text-secondary">Password</label>
       			<input type="password" name="memberPw" required class="form-control" />
       		</div>
       		<button class="btn btn-info mt-2" type="submit">Log In</button>
      		</form>
 				<!-- 로그인 form 끝 -->
 				
 				<p class="mt-3 mb-0"><a href="${path }/member/memberEnroll.do" class="text-info small">아이디가 없으신가요?</a></p>
 				<p class="mt-3 mb-0 text-info">Forgot your 
  				<a href="${path }/member/forgotEmail.do" class="text-info ">email</a> 
  					or 
  				<a href="${path }/member/forgotPw.do" class="text-info ">password?</a>
  			</p>
	</div>
<jsp:include page="/WEB-INF/views/common/firstFooter.jsp"/>	