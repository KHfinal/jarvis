<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="w3-col m1"><br></div>
	<div class="w3-col m7">
		<h2>신고 리스트</h2>
		<p>회원 검색 : 
		<select id="column">
			<option value="member_email">이메일</option>
			<option value="member_name">이름</option>
			<option value="addr2">주소</option>
		</select>		
		
		<input type="text" id="keyword">
		<button type="button" onclick="search()">검색</button>
		</p>
		<table class="table table-hover" id="table"></table>
	</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script>
	$(function(){
		var cPage = 1;
		$.ajax({
			url:"${pageContext.request.contextPath}/admin/notifyList.do",
			data:{cPage:cPage},
			datatype: "json",
			type: "POST",
			success : function(data){
				console.log("ajax통신성공");
				var json = JSON.parse(data);
				console.log(json);
				
			},
			error : function(xhr,status,errormsg){
				console.log(xhr);
				console.log(status);
				console.log(errormsg);
				console.log("ajax통신실패")
			}
		});
	});

</script>