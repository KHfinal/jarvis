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
	$('#email').blur(function(){
		var inputUserEmail = $(this).val().trim();
		if(inputUserEmail.length<5) {
			$('.guide').hide();
			$('#idDuplicateCheck').val(0);
			return; /* 끝냄 */
		}
		
		 // 1. response 객체에 문자열을 받는 방식
		$.ajax({
			url:"${pageContext.request.contextPath}/member/checkDuplicate.do",
			data:{userEmail: inputUserEmail}, // 데이타를 전송할 때는 key, value방식의 오브젝트를 보내야한다.(프론트에서 전송하므로 객체로 보낸다) 서버에서 키를 파라미터로 받아야 하므로. 
			success:function(data) { 
				
				if(data.trim() == 'false') { // id 중복이 없을 때. 문자열로 받아오므로 ''로 묶어준다.
					$('.guide.error').hide();
					$('.guide.ok').show();
					$('#idDuplicateCheck').val(1);
				} else { // id가 중복될 때
					$('.guide.error').show();
					$('.guide.ok').hide();
					$('#idDuplicateCheck').val(0);
				}
			},
			// error: function(xhr) // xml request객체이기 때문에 status, errormsg의 정보까지 갖고 있으므로 xhr만 선언해도 상관없다.
			error:function(xhr,status,errormsg) { // 변수의 명칭은 아무거나 상관이 없다. xhr => 전송했을 때 객체
				console.log(xhr);
				console.log(status);
				console.log(errormsg);
			}
		})  
	});
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

	function cancel(){
		location.href="${path}";
	}

	
</script>

    			<div class="m-auto w-lg-75 w-xl-50">
        			<h2 class="text-info font-weight-light mb-5"><i class="fa fa-diamond"></i>회원가입</h2>
        			<form name="memberEnrollFrm" action="${path }/memberEnrollEnd.do" method="post">
	            		<div class="form-group ">
		            		<label class="text-secondary">Email</label>
		            		<span class="guide ok">사용가능한 이메일 주소입니다.</span>
              				<span class="guide error">이미 가입된 이메일주소입니다.</span>
              				<input type="hidden" name="idDuplicateCheck" id="idDuplicateCheck" value=0/>
		            		<input type="text" id="email" name='memberEmail' required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,15}$" inputmode="email" class="form-control" placeholder="email@jarvis.com" />
	            		</div>
	            		<div class="form-group">
	            			<label class="text-secondary">Password</label>
	            			<span class="pwGuide text-secondary">(영문/숫자 조합 10~15자리)</span>
	            			<input type="password" required class="form-control" name="memberPw" id="password_" pattern="(?=.*\d)(?=.*[A-Za-z]).{10,15}"/>
	            		</div> 
	            		<div class="form-group">
	            			<label class="text-secondary">Password 확인</label>
	            			<input type="password" required class="form-control" id="password2" />
	            		</div>
	            		<div class="form-group">
	            			<label class="text-secondary">이름</label>
	            			<input type="text" required class="form-control" name="memberName" pattern="^[a-zA-Z가-힣]*$" placeholder="한글or영문"/>
	            		</div>
	            		<div class="form-group">
	            			<label class="text-secondary">닉네임</label>
	            			<input type="text" required class="form-control" name="memberNickname" id="nickname" />
	            		</div>

	            		<div class="form-group">
	            			<label class="text-secondary">휴대폰</label>
	            			<input type="tel" required placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" class="form-control" pattern=".{11,}" />
	            		</div>
	            		<button class="btn btn-info mt-2" type="submit">가입하기</button> &nbsp;&nbsp; 
	          			<button class="btn btn-info mt-2" onclick="cancel()">메인으로</button>
          				
          			</form>
   				</div>
<jsp:include page="/WEB-INF/views/common/firstFooter.jsp"/>