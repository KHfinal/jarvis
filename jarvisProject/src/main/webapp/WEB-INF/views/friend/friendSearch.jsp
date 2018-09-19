<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set value="${pageContext.request.contextPath }" var="path"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="social" name="title"/>
</jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	function friend_request(data){
		location.href="${path}/friend/friendRequest.do?fEmail="+data;
	}
	function friend_agree(data){
		location.href="${path}/friend/friendAgree.do?mEmail="+data;
	}
	function friend_refuse(data){
		location.href="${path}/friend/friendRefuse.do?mEmail="+data;
	}
</script>
<style>
		
</style>
<div class="w3-col m9">
<div class="w3-card w3-round w3-white">
<div class="row">
	<div class="col-8 mb-5">
	<h3>My Friend List</h3>
		<div class="list-group" style="overflow:auto; height:900px;">
			<table id="tbl-board" class="table table-striped table-hover">
            <tr>
                <th></th>
                <th>ID</th>
                <th>이름</th>
                <th>닉네임</th>
                <th></th>
            </tr>
            <c:if test="${friendList.size()==0 && friendList1.size()==0}">
            	<tr>
            		<td colspan="5">친구가 없습니다</td>
            	</tr>
	        </c:if>
            <c:if test="${friendList!=null }">
	            <c:forEach items="${friendList}" var="f">
			            <tr>
			                <td><img src="${path}/resources/profileImg/${f.MEMBER_PFP}" class="w3-circle" style="height: 40px; width: 40px" title="${m.memberName }"></td>
			                <td>${f.MEMBER_EMAIL}</td>
			                <td>${f.MEMBER_NAME}</td>
			                <td>${f.MEMBER_NICKNAME}</td>
			                <td><button type="button" id="friend_delete" class="btn btn-primary" onclick="friend_refuse('${f.MEMBER_EMAIL}');">친구삭제</button></td>
			            </tr>
	            </c:forEach>
            </c:if>
            <c:if test="${friendList1!=null }">
	            <c:forEach items="${friendList1}" var="f1">
			            <tr>
			                <td><img src="${path}/resources/profileImg/${f1.MEMBER_PFP}" class="w3-circle" style="height: 40px; width: 40px" title="${m.memberName }"></td>
			                <td>${f1.MEMBER_EMAIL}</td>
			                <td>${f1.MEMBER_NAME}</td>
			                <td>${f1.MEMBER_NICKNAME}</td>
			                <td><button type="button" id="friend_delete" class="btn btn-primary" onclick="friend_refuse('${f1.MEMBER_EMAIL}');">친구삭제</button></td>
			            </tr>
	            </c:forEach>
            </c:if>
        	</table>
		</div>
	</div>
	<div class="col-4">
	<h3>전체회원</h3>
		<div class="list-group" style="overflow:auto; height:450px;">
			<table id="tbl-board" class="table table-striped table-hover">
	            <tr>
	                <th colspan="3">친구목록</th>
	            </tr>
	            <c:forEach items="${list}" var="m">
	            <c:if test="${m.memberEmail!=memberLoggedIn.memberEmail&&m.memberEmail!='admin' }">
		            <tr>
		                <td><img src="${path}/resources/profileImg/${m.memberPFP}" class="w3-circle" style="height: 40px; width: 40px" title="${m.memberName }"></td>
		                <td>${m.memberName}</td>
		                <td><button type="button" class="btn btn-primary" id="friend_add" onclick="friend_request('${m.memberEmail}')">친구추가</button></td>
		            </tr>
	            </c:if>
            	</c:forEach>
        	</table>
		</div>

		<div class="list-group">
			<table id="tbl-board" class="table table-striped table-hover">
            <tr>
                <th>친구요청</th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
            <c:if test="${requestList.size()==0 && requestList1.size()==0}">
            	<tr>
            		<td colspan="3">요청이 없습니다</td>
            	</tr>
            </c:if>
            <c:if test="${requestList1!=null }">
            <c:forEach items="${requestList1}" var="r1">		<!-- f_friend_email일때 -->
	            <tr>
	            	<td><img src="${path}/resources/profileImg/${r1.MEMBER_PFP}" class="w3-circle" style="height: 40px; width: 40px" title="${r1.MEMBER_NAME }"></td>
	                <td>${r1.MEMBER_NAME}</td>
	                <td><button type="button" id="friend_agree" class="btn btn-primary" onclick="friend_agree('${r1.MEMBER_EMAIL}');">수락</button></td>
	                <td><button type="button" id="friend_refuse1" class="btn btn-primary" onclick="friend_refuse('${r1}');">거절</button></td>
	            </tr>
            </c:forEach>
            <hr>
            </c:if>
            <c:if test="${requestList!=null }">
            <c:forEach items="${requestList}" var="r"> 			<!-- f_member_email일때 -->
	            <tr>
	            	<td><img src="${path}/resources/profileImg/${r.MEMBER_PFP}" class="w3-circle" style="height: 40px; width: 40px" title="${r.MEMBER_NAME }"></td>
	                <td>${r.MEMBER_NAME}</td>
	                <td colspan='2'><button type="button" id="friend_refuse2" class="btn btn-primary" onclick="friend_refuse('${r.MEMBER_EMAIL}');">요청취소</button></td>
	            </tr>
            </c:forEach>
            </c:if>
        	</table>
		</div>
	</div>
</div>
</div>
</div>
</body>
</html>