<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ page import="kh.mark.jarvis.member.model.vo.Member" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var="path" value="<%=request.getContextPath()%>"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="social" name="title"/>
</jsp:include>

<style>
	#profile{
		border-radius: 200px;
		width : 200px;
		height: 200px;
	}
</style>



<link rel="stylesheet" href="${path }/resources/css/socialHome.css?ver=1221">

 
<style>
	.subMenu-container {
		background-color: white;
		width: 20%;
		color: black;
		display: absolute;
		left: 50px;
	}
		
</style>
	    
	    
	    
	    
	    
<div class="w3-col m8"> <!-- 메인 컨텐츠 시작 -->
	

<div class="container bootstrap snippet">
    <div class="row">
  		<div class="col-sm-10"><h1>프로필 수정</h1></div>
    </div><br>
   
    	<div class="col-sm-9">
            <ul class="nav nav-tabs">
                  <li class="active"><a href="${path }/myInfoView.do?member_email=${memberLoggedIn.memberEmail}">내 정보 </a></li> 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <li><a href="${path }/myInfoUpdateView.do?member_email=${memberLoggedIn.memberEmail}">정보수정</a></li>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <li><a href="${path }/myInfoPFP.do?member_email=${memberLoggedIn.memberEmail}">프로필사진 </a></li>
             	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <li><a href="#">비밀번호 변경 </a></li>
              </ul>

              
          <div class="tab-content">
            <div class="tab-pane active" id="home">
                <hr>
                  <form class="form" action="${path }/myInfoPFPupdate.do" method="post" id="registrationForm" enctype="multipart/form-data">
                      <input type="hidden" name="memberEmail" value="${memberLoggedIn.memberEmail }">
                      <div class="form-group">
                         <div class="col-md-8">
                				<h3>프로필 사진</h3>
                				<img src="${path}/resources/profileImg/${memberLoggedIn.memberPFP}" height="200" alt="이미지 미리보기..." id="profile">
                				<input type="file" onchange="previewFile()" class="form-control" id="profileFile" name="profileFile1">
                		</div>
                      </div> 
                       
                     
                     
                      
                      <div class="form-group">
                           <div class="col-xs-12">
                                <br>
                              	<button class="btn btn-lg btn-success" type="submit"><i class="glyphicon glyphicon-ok-sign"></i> 수정</button>
                               <!-- 	<button class="btn btn-lg" type="reset"><i class="glyphicon glyphicon-repeat" onclick="member_cancel();"></i> 취소하기</button> -->
                            </div>
                      </div>
              	</form>
              
              <hr>
              
             </div><!--/tab-pane-->
            
    
              </div><!--/tab-pane-->
          </div><!--/tab-content-->

        </div><!--/col-9-->
  


</div> <!-- 메인 컨텐트 끝  -->

<script>
function previewFile() {
	
	  var preview = document.querySelector('#profile');
	  var file    = document.querySelector('input[type=file]').files[0];
	  var reader  = new FileReader();
	  var ext = file.name.split(".").pop().toLowerCase();
	  console.log(preview);
	  if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
		  $('#profileFile').val("");
		  $('#profile').attr("src","${path }/resources/profileImg/profileDefault.png");
          alert('이미지 파일이 아닙니다.');
      }
	  else{
		  reader.addEventListener("load", function () {
		    preview.src = reader.result;
		    console.log("이미지파일맞다")
		  }, false);
	
		  if (file) {
		    reader.readAsDataURL(file);
		  }
	  }
}
</script>

	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>