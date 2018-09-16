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
<link rel="stylesheet" href="${path }/resources/css/socialHome.css?ver=15">
<style>

</style>
<script>
	/* $(document).ready(function() {      
	   $('#categoryCarousel').carousel('pause');
	}); */
	
   	$(function(){
   		$('#btn1').on("click",function(){
   			var name=$("[name=g_name]").val();
   			var intro=$("[name=g_intro]").val();
   			var category=$("[name=g_category]").val();
   			console.log(category);
   			
   			if(name.trim().length==0){
   				alert("그룹 명을 입력하세요");
   				return false;
   			}
   			else if(intro.trim().length==0){
   				alert("소개글을 입력하세요");
   				return false;
   			}
   			else if(category.trim().length<0){
   				alert("1가지 이상 체크하세요");
   				return false;
   			}
   			else{
   				fmt.submit();
   				
   			}
   		});
   	});
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
   	
  
   	function previewFile() {
  	  var preview = document.querySelector('#preViewImg');
  	  var file    = document.querySelector('#imgInput').files[0];
  	  var reader  = new FileReader();
  	  
  	  var ext = file.name.split(".").pop().toLowerCase();
  	  if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
  		  $('#imgInput').val("");
  		  
            alert('이미지 파일이 아닙니다.');
        }
  	  else{
		  reader.addEventListener("load", function () {
		    preview.src = reader.result;
		  }, false);
	
		  if (file) {
		    reader.readAsDataURL(file);
		  }
  	  }
  }
 
</script>

<div class="w3-col m8 ml-4">
            <div class="container">
                <table class="table">
	                <tbody>
		                <tr>
		                	<td>
		                		<button type="button" class="btn btn-secondary btn" data-toggle="modal" data-target="#createGroup">그룹 만들기</button>
		                		<button type="button" class="btn btn-secondary" data-toggle="collapse" data-target="#demo">분야별</button>
		                	</td>
		                	<td>
		                		<form action="${path }/group/groupSearch.do" method="post">
									<div>
										<div class="input-group">
											<input type="text" class="form-control" name="titleSearch" placeholder="그룹 이름을 입력하세요...">
											<div class="input-group-append">
												<button class="btn btn-secondary" type="submit" style="z-index: 0;">Go</button> 
											</div>	
										</div>
									</div>
								</form>
		                	</td>
		                </tr>
	                </tbody>     
                </table>
            </div>
			<div id="demo" class="collapse">
				
				<ul class="nav nav-pills justify-content-center">
					<li class="nav-item">
						<button type="button" class="btn btn-light ml-2 mr-2 t" name="travle" value="c1">여행</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-light ml-2 mr-2 t" name="arts" value="c2">예술</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-light ml-2 mr-2 t" name="culture" value="c3">문화</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-light ml-2 mr-2 t" name="health" value="c4">건강</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-light ml-2 mr-2 t" name="fashion" value="c5">패션</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-light ml-2 mr-2 t" name="beauty" value="c6">뷰티</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-light ml-2 mr-2 t" name="sports" value="c7">스포츠</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-light ml-2 mr-2 t" name="food" value="c8">푸드</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-light ml-2 mr-2 t" name="living" value="c9">리빙</button>
					</li>
					<li class="nav-item">
						<button type="button" class="btn btn-light ml-2 mr-2 t" name="invest" value="c10">재테크</button>
					</li>
				</ul>
							    
			</div> 	
	
	<script>
	$(function(){
		$('.t').on('click',function(){
			var data=$(this).val();
			location.href="${path}/group/groupFilter.do?category="+data;
		});
	});
	</script>  
    

    <section class="row pt-0">
     
        <div class="modal fade" id="createGroup">
        
            <div class="modal-dialog">
                <div class="modal-content"> 
                <div class="modal-header" style="background-color: #f8f9fa">
                    <h4 class="modal-title">새 그룹 만들기</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <form name="fmt" action="${path }/group/groupInsert.do?m=${memberLoggedIn.getMemberEmail()}" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <label for="groupName">그룹 이름 입력</label>
                        <input type="text" class="form-control form-control-lg" id="groupName" name="g_name"/>
                        <label for="comment">그룹 소개 글</label>
						<textarea class="form-control" name="g_intro" rows="5" id="comment" placeholder="간단한 소개 글을 입력해 주세요."></textarea>
						<label for="upFile1">그룹 이미지</label>
	                	<div>
	                		<img id="preViewImg" src="" height="200" alt="이미지 미리보기...">
	                		<div style="float: right;">
			                	<div class="filebox" style="float: none">
			                		<label for="imgInput">업로드</label>
			                		<input type="file" onchange="previewFile()" id="imgInput" name="upFile">
		                		</div>
	                		</div>
	                	</div>
		                <hr>
		  
                    	<span>그룹 분류</span>
                    	<div class="form-control-lg">
	                    	<div class="row">
		                        <div class="custom-control custom-checkbox mr-3">
								    <input type="checkbox" class="custom-control-input" id="category1" name="g_category" value="c1"/>
								    <label class="custom-control-label" for="category1">여행</label>
							    </div>
							    <div class="custom-control custom-checkbox mr-3">
								    <input type="checkbox" class="custom-control-input" id="category2" name="g_category" value="c2"/>
								    <label class="custom-control-label" for="category2">예술</label>
							    </div>
							    <div class="custom-control custom-checkbox mr-3">
								    <input type="checkbox" class="custom-control-input" id="category3" name="g_category" value="c3"/>
								    <label class="custom-control-label" for="category3">문화</label>
							    </div>
							    <div class="custom-control custom-checkbox mr-3">
								    <input type="checkbox" class="custom-control-input" id="category4" name="g_category" value="c4"/>
								    <label class="custom-control-label" for="category4">건강</label>
							    </div>
							    <div class="custom-control custom-checkbox mr-3">
								    <input type="checkbox" class="custom-control-input" id="category5" name="g_category" value="c5"/>
								    <label class="custom-control-label" for="category5">패션</label>
							    </div>
							    <div class="custom-control custom-checkbox mr-3">
								    <input type="checkbox" class="custom-control-input" id="category6" name="g_category" value="c6"/>
								    <label class="custom-control-label" for="category6">뷰티</label>
							    </div>
							    <div class="custom-control custom-checkbox mr-3">
								    <input type="checkbox" class="custom-control-input" id="category7" name="g_category" value="c7"/>
								    <label class="custom-control-label" for="category7">스포츠</label>
							    </div>
							    <div class="custom-control custom-checkbox mr-3">
								    <input type="checkbox" class="custom-control-input" id="category8" name="g_category" value="c8"/>
								    <label class="custom-control-label" for="category8">푸드</label>
							    </div>
							    <div class="custom-control custom-checkbox mr-3">
								    <input type="checkbox" class="custom-control-input" id="category9" name="g_category" value="c9"/>
								    <label class="custom-control-label" for="category9">리빙</label>
							    </div>
							    <div class="custom-control custom-checkbox mr-3">
								    <input type="checkbox" class="custom-control-input" id="category10" name="g_category" value="c10"/>
								    <label class="custom-control-label" for="category10">재테크</label>
							    </div>
						    </div>
					    </div>
					    
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="btn1" class="btn btn-primary" data-dismiss="modal">생성</button>
                        <button type="reset" class="btn btn-primary" data-dismiss="modal">취소</button>
                    </div>
                </form>
               	</div>
            </div>  
        </div>
        
        <div class="container mt-2" style="height: 3000px;">					
       		<div id="portfolio">
				<div class="col-lg-12 text-center" style="z-index: 0;">
					<h2 class="section-heading text-uppercase mt-3">그룹</h2>
					<h3 class="section-subheading text-muted" style="margin-bottom: 30px;">자신에게 어울리는 그룹을 찾아보세요.</h3>
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
          
<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/> --%>

