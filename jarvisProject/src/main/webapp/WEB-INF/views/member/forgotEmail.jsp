<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<jsp:include page="/WEB-INF/views/common/firstHeader.jsp"/>
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
<jsp:include page="/WEB-INF/views/common/firstFooter.jsp"/>