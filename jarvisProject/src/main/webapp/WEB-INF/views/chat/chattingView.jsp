<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set value="<%=request.getContextPath()%>" var="path"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="social" name="title"/>
</jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script>

</script>
<style>
	div#chatdata{
		height:650px;
		overflow-x:hidden;
		overflow-y:auto;
	}
	div.chatting-cintainer{
		height:770px;
		border:1px solid lightgray;
		padding:0px;
	}
	div.chatContents{
		height: 87%;
	}
	div.chatInput-container{
		height: 9%;
		magin:0px;
		padding:0px;
	}
	textarea.chatInput{
		width:100%;
		height: 100%;
	}
</style>
<div class="w3-col m9">
<div class="w3-card w3-round w3-white">
	<div class="w3-container">
		<div class="row" style="border: 1px solid lightgray; padding: 10px; height: 40px;">
			<div class="col-2">
				<strong>Messenger</strong>
			</div>
			<div id="friend_join" class="col-10"></div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<!-- 채팅창 -->
			<div class="chatting-cintainer col-8">
				<div class="chatInput-container">
					<div class="list-group">
						<c:forEach items="${roomList }" var="r">
							<a href="${path}/chat/createRoom?fEmail=${r.MEMBER_EMAIL}" class="list-group-item list-group-item-action">
								<img src="${path}/resources/profileImg/${r.MEMBER_PFP}" class="w3-circle" style="height: 40px; width: 40px" title="${r.MEMBER_NAME }">
								${r.MEMBER_NAME}
							</a>
						</c:forEach>
						<c:forEach items="${roomList1 }" var="r1">
							<a href="${path}/chat/createRoom?fEmail=${r1.MEMBER_EMAIL}" class="list-group-item list-group-item-action">
								<img src="${path}/resources/profileImg/${r1.MEMBER_PFP}" class="w3-circle" style="height: 40px; width: 40px" title="${r1.MEMBER_NAME }">
								${r1.MEMBER_NAME}
							</a>
						</c:forEach>
					</div>
				</div>

			</div>
			<!-- 채팅방, 친구목록 -->
			<div class="chatting-cintainer col-4 pl-2 pr-2 pt-3" style="overflow:auto; height:760px;">
				<form action="${path}/friend/selectOneFriend.do">
					<input type="text" id="friendSearch" class="form-control form-control-sm mb-2" placeholder="친구검색">
				</form>
				<div class="list-group">
					<c:forEach items="${roomList }" var="r">
						<a href="${path}/chat/createRoom?fEmail=${r.MEMBER_EMAIL}" class="list-group-item list-group-item-action">
							<img src="${path}/resources/profileImg/${r.MEMBER_PFP}" class="w3-circle" style="height: 40px; width: 40px" title="${r.MEMBER_NAME }">
							${r.MEMBER_NAME}
						</a>
					</c:forEach>
					<c:forEach items="${roomList1 }" var="r1">
						<a href="${path}/chat/createRoom?fEmail=${r1.MEMBER_EMAIL}" class="list-group-item list-group-item-action">
							<img src="${path}/resources/profileImg/${r1.MEMBER_PFP}" class="w3-circle" style="height: 40px; width: 40px" title="${r1.MEMBER_NAME }">
							${r1.MEMBER_NAME}
						</a>
					</c:forEach>
					
					<!-- 친구리스트 -->
					<%-- <c:if test="${roomList.MEMBER_EMAIL!=friendList.MEMBER_EMAIL }"> --%>
					<c:forEach items="${friendList}" var="f">
						<a href="${path}/chat/createRoom?fEmail=${f.MEMBER_EMAIL}" class="list-group-item list-group-item-action">
							<img src="${path}/resources/profileImg/${f.MEMBER_PFP}" class="w3-circle" style="height: 40px; width: 40px" alt="Avatar">&nbsp;
							${f.MEMBER_NAME}
						</a>
					</c:forEach>
					<c:forEach items="${friendList1}" var="f1">
						<a href="${path}/chat/createRoom?fEmail=${f1.MEMBER_EMAIL}" class="list-group-item list-group-item-action">
							<img src="${path}/resources/profileImg/${f1.MEMBER_PFP}" class="w3-circle" style="height: 40px; width: 40px" alt="Avatar">&nbsp;
							${f1.MEMBER_NAME}
						</a>
					</c:forEach>
					<%-- </c:if> --%>
					
				</div>
			</div>

		</div>
	</div>
</div>
</div>


</body>
</html>