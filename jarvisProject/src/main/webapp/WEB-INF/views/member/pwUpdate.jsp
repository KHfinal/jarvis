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
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</head>
<style>
	.guide{
		display: none;
		font-size: 5px;
	}
	.ok{
		color: blue;
	}
	.error{
		color: red;
	}
	.pwGuide{
		font-size: 5px;
	}
</style>
<script>
$(function(){
	
	
	$("#password2").blur(function(){
		var p1=$("#password_").val();
		var p2=$("#password2").val();
		if (p1!=p2) 
		{
			alert("비밀번호가 일치하지 않습니다.");
			$("#password_").val("");
			$("#password2").val("");
			$("#password_").focus();
		}
		
	});
});
</script>
<body>
	<div class="container-fluid">
        <div class="row mh-100vh">
        	<div class="col-10 col-sm-8 col-md-6 col-lg-6 offset-1 offset-sm-2 offset-md-3 offset-lg-0 align-self-center d-lg-flex align-items-lg-center align-self-lg-stretch bg-white p-5 rounded rounded-lg-0 my-5 my-lg-0" id="login-block">
    			<div class="m-auto w-lg-75 w-xl-50">
        			<h2 class="text-info font-weight-light mb-5"><i class="fa fa-diamond"></i>패스워드 변경</h2>
        			<form name="memberEnrollFrm" action="${path }/member/pwUpdate.do" method="post">
	            		
	            		<input type="hidden" name="memberEmail" value="${memberEmail }">
	            		<div class="form-group">
	            			<label class="text-secondary">Password</label>
	            			<span class="pwGuide text-secondary">(영문/숫자 조합 10~15자리)</span>
	            			<input type="password" required class="form-control" name="memberPw" id="password_" pattern="(?=.*\d)(?=.*[A-Za-z]).{10,15}"/>
	            		</div> 
	            		<div class="form-group">
	            			<label class="text-secondary">Password 확인</label>
	            			<input type="password" required class="form-control" id="password2" />
	            		</div>
	            		
	            		<button class="btn btn-info mt-2" type="submit">변경하기</button>
          				
          			</form>
          			<button class="btn btn-info mt-2" onclick="cancel()">취소</button>
   				</div>
			</div>
            <div class="col-lg-6 d-flex align-items-end" id="bg-block" style="background-image:url(&quot;${path }/resources/img/mainImg.jpg&quot;);background-size:cover;background-position:center center;">
                <p class="ml-auto small text-dark mb-2"><em>My Jarvis&nbsp;</em><a href="https://unsplash.com/photos/v0zVmWULYTg?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText" target="_blank" class="text-dark"><em>Aldain Austria</em></a><br></p>
            </div>
        </div>
    </div>
<script>
	function cancel(){
		location.href="${path}";
	}

</script>

</body>
</html>