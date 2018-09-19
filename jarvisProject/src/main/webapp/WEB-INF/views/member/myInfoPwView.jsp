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

 


<link rel="stylesheet" href="${path }/resources/css/socialHome.css?ver=1221">

 
<style>
	.subMenu-container {
		background-color: white;
		width: 20%;
		color: black;
		display: absolute;
		left: 50px;
	}
	.m8{
		margin-left: 5%;
	}	
</style>
	    
	    
	    
	    
	    
<div class="w3-col m8"> <!-- 메인 컨텐츠 시작 -->
	
<div class="w3-card w3-round w3-white">
<div class="container bootstrap snippet">
    <div class="row">
  		<div class="col-sm-10"><h1>비밀번호 변경</h1></div>
    </div><br>
   
    	<div class="col-sm-9">
            <ul class="nav nav-tabs" role="tablist">
                <li >
                	<a  href="${path }/myInfoView.do?member_email=${memberLoggedIn.memberEmail}">내 정보 </a>
                </li> 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <li > 
                	<a  href="${path }/myInfoUpdateView.do?member_email=${memberLoggedIn.memberEmail}">정보수정</a>
                </li>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <li >
               		<a  href="${path }/myInfoPFP.do?member_email=${memberLoggedIn.memberEmail}">프로필사진 </a>
               </li>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <li class="nav-item">
                	<a class="nav-link active" data-toggle="tab" href="${path }/myinfoPwView.do?member_email=${memberLoggedIn.memberEmail}">비밀번호 변경 </a>
                </li>
              </ul>

              
          <div class="tab-content">
            <div class="tab-pane active" id="home">
                <hr>
                  <form class="form" action="${path }/myinfoPwUpdate.do" method="post" id="registrationForm">
                      
                      <div class="form-group">
                          <div class="col-xs-6">
                            <div class="form-group">
	            				<label class="text-secondary"></label>       													
	            				<input type="hidden"  required class="form-control" name="memberEmail" id="memberEmail" readonly="readonly"  placeholder="" value="${memberLoggedIn.memberEmail }"/> 
	            			</div>
                          </div>
                      </div> 
                     
                     <div class="form-group">
	            			<label class="text-secondary">Password</label>
	            			<span class="pwGuide text-secondary">(영문/숫자 조합 10~15자리)</span>
	            			<input type="password" required class="form-control" name="memberPw" id="password_" pattern="(?=.*\d)(?=.*[A-Za-z]).{10,15}"/>
	            		</div> 
	            		<div class="form-group">
	            			<label class="text-secondary">Password 확인</label>
	            			<input type="password" required class="form-control" id="password2" />
	            		</div>
	            		
	            		<button class="btn btn-info mt-2" type="submit">변경하기</button>
                      
                     
              	</form>
              
              <hr>
              
             </div><!--/tab-pane-->
            
    
              </div><!--/tab-pane-->
          </div><!--/tab-content-->

        </div><!--/col-9-->
  

</div>
</div> <!-- 메인 컨텐트 끝  -->

<script>
$(function(){
	
	
	$("#password2").blur(function(){
		var p1=$("#password_").val();
		var p2=$("#password2").val();
		if (p1!=p2) 
		{
			alert("비밀번호가 일치하지 않습니다.");
			$("#password_").val("");
			$("#password2").val("");
			$("#password_").focus();
		}
		
	});
});
</script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>