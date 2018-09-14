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
        			<h3 class="text-info font-weight-light mb-5"><i class="fa fa-diamond"></i>아이디 찾기 결과</h3>
        			
	            		
	    				
          			
          			
          			<div class="form-group">
	            			<label class="text-secondary">검색 결과:</label>
	            			${emailSearch } 입니다.
	            	</div>
	            	<button class="btn btn-info mt-2" onclick="cancel()">돌아가기</button>
          			
    				
   				</div>
<jsp:include page="/WEB-INF/views/common/firstFooter.jsp"/>