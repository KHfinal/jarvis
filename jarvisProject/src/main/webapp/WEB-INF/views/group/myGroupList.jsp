<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="kh.mark.jarvis.member.model.vo.Member"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<%-- <%
	Member memberLoggedIn = (Member) request.getAttribute("memberLoggedIn");
%> --%>

<c:set value="${pageContext.request.contextPath}" var="path"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="social" name="title"/>	
</jsp:include>
<title>Agency - Start Bootstrap Theme</title>

<link href="${path }/resources/css/agency.min.css" rel="stylesheet">

<style>

</style>
<script>

   	$(document).ready(function() 
			{
				$("#lista1").als({
					visible_items: 4,
					scrolling_items: 1,
					orientation: "horizontal",
					circular: "yes",
					autoscroll: "no",
					interval: 5000,
					speed: 500,
					easing: "linear",
					direction: "right",
					start_from: 0
				});
								
				//logo hover
				$("#logo_img").hover(function()
				{
					$(this).attr("src","${path }/resources/groupJs/images/als_logo_hover212x110.png");
				},function()
				{
					$(this).attr("src","${path }/resources/groupJs/images/als_logo212x110.png");
				});
				
				//logo click
				$("#logo_img").click(function()
				{
					location.href = "http://als.musings.it/index.php";
				});
				
				$("a[href^='http://']").attr("target","_blank");
				$("a[href^='http://als']").attr("target","_self");
			});
 
</script>

<div class="w3-col m8 ml-4">
    <section class="row pt-0">
        <div class="container mt-2" style="height: 3000px;">					
       		<div id="portfolio">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading text-uppercase mt-3">MY그룹</h2>
					<h3 class="section-subheading text-muted" style="margin-bottom: 30px;">그룹 활동에 참여하세요~!</h3>
				</div>
				<div class="row">
					<c:if test="${list!=null }">
						<c:forEach var="g" items="${list}">				
							<div class="col-md-4 col-sm-6 portfolio-item" onclick="fn_view(${g.g_no})" style="z-index: 0;">
								<%-- <a class="portfolio-link" data-toggle="modal" href="${path }/group/groupView.do?groupNo=${g.g_no}"> --%>
								<a class="portfolio-link" data-toggle="modal" href="${path }/group/groupView.do?groupNo=${g.g_no}">
								
									<div class="portfolio-hover">
						                <div class="portfolio-hover-content">
						                  	<p>${g.g_intro}</p>
						                </div>
					                </div>
									<img class="img-fluid" src="${path }/resources/upload/group/${g.g_renamedFilename}" style="width: 340px; height: 250px;"/>
								</a>
								<div class="portfolio-caption">
									<h3>${g.g_name }</h3>
									
									<p class="text-muted">
										<c:forEach var="cate" items="${cateList }">
											<c:if test="${g.g_no==cate.G_NO }">
												${cate.C_VALUE }&nbsp;
											</c:if>
										</c:forEach>
									</p>
									
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
		<script>
			function fn_view(data){
				location.href="${path }/group/groupView.do?groupNo="+data;
			}
		</script>
	</section>		
</div>
          