<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<jsp:include page="/WEB-INF/views/common/firstHeader.jsp"/>
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
	          			<button class="btn btn-info mt-2" onclick="cancel()">취소</button>
          				
          			</form>
   				</div>
<script>
	function cancel(){
		location.href="${path}";
	}

</script>
<jsp:include page="/WEB-INF/views/common/firstFooter.jsp"/>