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

<div class="row">
	<div class="col-8">
	<h3>전체회원목록</h3>
		<div class="list-group">
			<table id="tbl-board" class="table table-striped table-hover">
            <tr>
                <th>ID</th>
                <th>이름</th>
                <th>닉네임</th>
                <th>연락처</th>
                <th></th>
            </tr>
            <c:forEach items="${list}" var="m"> 
            <%-- <c:forEach items="${requestList }" var="re"> || m.memberEmail!=re.f_friend_email --%>
            <c:if test="${m.memberEmail!=memberLoggedIn.memberEmail&&m.memberEmail!='admin' }">
            <tr>
                <td>${m.memberEmail}<input type="hidden" class="fri" value="${m.memberEmail}"/></td>
                <td>${m.memberName}</td>
                <td>${m.memberNickname}</td>
                <td>${m.phone}</td>
                <td><button type="button" id="friend_add" onclick="friend_request('${m.memberEmail}')">친구추가</button></td>
	              	<%-- <c:if test="${m.memberEmail!=requestList1 }">
	                	<td><button type="button" id="friend_add" onclick="friend_request('${m.memberEmail}')">친구추가</button></td>
	             	</c:if> 
	                <c:if test="${m.memberEmail==requestList1 }">
	                	<td>요청중</td>
	            	</c:if>   --%>
            </tr>
            </c:if>
            <%-- </c:forEach> --%>
            </c:forEach>
        	</table>
		</div>
	</div>
	<div class="col-4">
		<div class="list-group">
			<table id="tbl-board" class="table table-striped table-hover">
            <tr>
                <th colspan="2">친구목록</th>
            </tr>
            <c:if test="${friendList.size()==0 }">
            	<tr>
            		<td colspan="2">친구가 없습니다</td>
            	</tr>
            </c:if>
            <c:forEach items="${friendList}" var="f"> 
            <tr>
                <td>${f}</td>
                <td><button type="button" id="friend_delete" onclick="friend_refuse('${f}');">친구삭제</button></td>
            </tr>
            </c:forEach>
        	</table>
		</div>

		<div class="list-group">
			<table id="tbl-board" class="table table-striped table-hover">
            <tr>
                <th>친구요청</th>
                <th></th>
                <th></th>
            </tr>
            <c:if test="${requestList1!=null }">
            <c:forEach items="${requestList1}" var="r1">		<!-- f_friend_email일때 -->
	            <tr>
	                <td>${r1}</td>
	                <td><button type="button" id="friend_agree" onclick="friend_agree('${r1}');">수락</button></td>
	                <td><button type="button" id="friend_refuse1" onclick="friend_refuse('${r1}');">거절</button></td>
	            </tr>
            </c:forEach>
            </c:if>
            <c:if test="${requestList!=null }">
            <c:forEach items="${requestList}" var="r"> 			<!-- f_member_email일때 -->
	            <tr>
	                <td>${r}</td>
	                <td><button type="button" id="friend_refuse2" onclick="friend_refuse('${r}');">요청취소</button></td>
	            </tr>
            </c:forEach>
            </c:if>
        	</table>
		</div>
	</div>
</div>
</body>
</html>