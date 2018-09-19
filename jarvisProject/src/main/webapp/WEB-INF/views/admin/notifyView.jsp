<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${path }/resources/css/socialHome.css?ver=121">
<style>

</style>
<br><br><br><br>
	<div class="w3-col m1"><br></div>
	<div class="w3-col m7">
		<div class="container">
			<div class="row">
				<div class="col-sm-8">
					<table class="table">
						<tr>
							<th>신고번호</th>
							<td>${notify.notifyNo }</td>
							<th>신고자</th>
							<td>${notify.notifyWriter }</td>
						</tr>
						<tr>
							<th>신고날짜</th>
							<td colspan="3"><fmt:formatDate value="${notify.notifyDate }" pattern="yy-MM-dd HH:mm"/></td>
						</tr>
						<tr>
							<th>신고사유</th>
							<td colspan="3">${notify.notifyReason }</td>
						</tr>
						<tr>
							<th>게시자</th>
							<td colspan="3">${notify.postWriter }</td>
						</tr>
						<tr><th colspan="4" style="text-align:center">Post Content</th></tr>
					</table>
					<!-- POST 이미지, 게시글 출력 -->
			       <div class="panel-body">
			          <div id="postContentsContainer">
			             <pre>${post.getPostContents() }</pre>
			         </div>
			          <c:forEach items="${attachmentList }" var="attach" varStatus="vs">
			             <c:if test='${post.getPostNo() == attach.getPostNo() }'>
			                <div class="postAttachContainer">
			                    <img class="imgSize img-thumbnail" src="${path }/resources/upload/post/${attach.getRenamedFileName() }">
			                 </div>
			              </c:if>
			           </c:forEach>
			           <div style="clear: both"></div>
			       </div>
				
					<div class="container">
						<table class="table">
							<tr>
								<td><button class="btn btn-success">d</button></td>
								<td><button class="btn btn-primary">g</button></td>
								<td><button class="btn btn-danger">b</button></td>
								<td></td>
							</tr>
						</table>
					</div>
				</div>

			</div>
		
		</div>

	</div>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>