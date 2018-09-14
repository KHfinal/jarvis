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
        			<h2 class="text-info font-weight-light mb-5"><i class="fa fa-diamond"></i>비밀번호 찾기</h2>
        			<form name="memberEnrollFrm" action="${path }/PwSearch.do" method="post">
	            		   		            		
	            		<div class="form-group ">
		            		<label class="text-secondary">이메일 입력<small> 임시 비밀번호  </small> </label>
		            		<input type="email"  placeholder="가입 이메일" name="memberEmail" id="name" class="form-control" required />
	            		</div>
	            		
	            		<button class="btn btn-info mt-2" type="submit">확인</button>
          				<button class="btn btn-info mt-2" onclick="cancel()">취소</button>
          			</form>
    			
   				</div>
			</div>
            <div class="col-lg-6 d-flex align-items-end" id="bg-block" style="background-image:url(&quot;${path }/resources/img/mainImg.jpg&quot;);background-size:cover;background-position:center center;">
                <p class="ml-auto small text-dark mb-2"><em>My Jarvis&nbsp;</em><a href="https://unsplash.com/photos/v0zVmWULYTg?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText" target="_blank" class="text-dark"><em>Aldain Austria</em></a><br></p>
            </div>
        </div>
    </div>


	<script> 
				//메인 홈으로 돌아가기
				function cancel(){
					location.href="${path}";
				}
			
			</script>


</body>
</html>