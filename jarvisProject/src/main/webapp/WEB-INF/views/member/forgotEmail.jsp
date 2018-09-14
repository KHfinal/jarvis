<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="${path }/resources/fonts/font-awesome.min.css">
	<link rel="stylesheet" href="${path }/resources/css/-Login-form-Page-BS4-.css">
	<link rel="stylesheet" href="${path }/resources/css/styles.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container-fluid">
        <div class="row mh-100vh">
        	<div class="col-10 col-sm-8 col-md-6 col-lg-6 offset-1 offset-sm-2 offset-md-3 offset-lg-0 align-self-center d-lg-flex align-items-lg-center align-self-lg-stretch bg-white p-5 rounded rounded-lg-0 my-5 my-lg-0" id="login-block">
    			<div class="m-auto w-lg-75 w-xl-50">
        			<h2 class="text-info font-weight-light mb-5"><i class="fa fa-diamond"></i>아이디 찾기</h2>
        			<form name="memberEnrollFrm" action="${path }/emailSearch.do" method="post">
	            		   		
	            		<%-- <p class="mt-3 mb-0"><a href="${path }/member/memberInfoAdd.do" class="text-info small">추가 정보입력(임시)</a></p> --%>
	            		
	            		
		           		<!-- <label class="text-secondary">내 정보에 등록된 휴대폰으로 찾기</label> -->
	            		
		            	<div class="form-group">
	            			<label class="text-secondary">이름</label>
	            			<input type="text" required class="form-control" name="memberName" placeholder="가입시 사용한 이름을 입력해주세요" />
	            		</div>
	            		
	            		<div class="form-group">
	            			<label class="text-secondary">휴대폰</label>
	            			<input type="tel" required placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" class="form-control" />
	            		</div>
	            		<button class="btn btn-info mt-2" type="submit">제출</button>
          				<button class="btn btn-info mt-2" type="submit">취소</button>
          			</form>
    				
   				</div>
			</div>
            <div class="col-lg-6 d-flex align-items-end" id="bg-block" style="background-image:url(&quot;${path }/resources/img/mainImg.jpg&quot;);background-size:cover;background-position:center center;">
                <p class="ml-auto small text-dark mb-2"><em>My Jarvis&nbsp;</em><a href="https://unsplash.com/photos/v0zVmWULYTg?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText" target="_blank" class="text-dark"><em>Aldain Austria</em></a><br></p>
            </div>
        </div>
    </div>

</body>
</html>