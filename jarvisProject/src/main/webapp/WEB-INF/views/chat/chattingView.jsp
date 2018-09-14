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
<script>
$(document).ready(function(){
    $("#searchBtn").click(function(){
        $("#m_search").slideToggle();
    });
});
</script>
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
						<a href="#" class="list-group-item list-group-item-action">
							채팅방1
						</a>
						<a href="#" class="list-group-item list-group-item-action">
							채팅방2
						</a>
					</div>
				</div>

			</div>
			<!-- 친구목록 -->
			<div class="chatting-cintainer col-4 pl-2 pr-2 pt-3" style="overflow:auto; height:760px;">
				<form action="${path}/friend/selectOneFriend.do">
					<input type="text" id="friendSearch"
						class="form-control form-control-sm mb-2" placeholder="친구검색">
					<input type="submit" value="검색" />
				</form>
				<div class="list-group">
					<c:forEach items="${friendList}" var="f">
						<a href="${path}/chat/createRoom?fEmail=${f}" class="list-group-item list-group-item-action">
							<img src="${path}/resources/upload/profileImg/defaultmen.PNG" class="w3-circle" style="height: 23px; width: 23px" alt="Avatar">&nbsp;
							${f}
						</a>
					</c:forEach>
				</div>
			</div>

		</div>
	</div>
</div>
</div>


</body>
</html>