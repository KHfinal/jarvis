<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<jsp:include page="/WEB-INF/views/common/firstHeader.jsp"/>
	<script> 
		//메인 홈으로 돌아가기
		function cancel(){
			location.href="${path}";
		}
	
	</script>
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
<jsp:include page="/WEB-INF/views/common/firstFooter.jsp"/>