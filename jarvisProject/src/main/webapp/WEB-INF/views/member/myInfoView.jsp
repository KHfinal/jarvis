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

 <% 
        /* List.contains메소드를 사용하기 위해 String[] => List로 형변환함. memberConcern */
        List<String> concernList = null;
        String[] concern = ((Member)request.getAttribute("member")).getMemberConcern();
        if(concern != null)//이 조건이 없다면,취미체크박스에 하나도 체크하지 않았다면, Array.asList(null)=>NullPointerException 
        concernList = Arrays.asList(concern); 
		
        
       
 %>

<script>
	var arr = ${memberLoggedIn.memberEmail};
	console.log(arr);

</script>



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
  		<div class="col-sm-10"><h1>프로필 정보</h1></div>
    </div>
<br>


        
        
    	<div class="col-sm-9">
            <ul class="nav nav-tabs">
                <li class="active"><a href="${path }/myInfoView.do?member_email=${memberLoggedIn.memberEmail}">내 정보 </a></li> 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <li><a href="${path }/myInfoUpdateView.do?member_email=${memberLoggedIn.memberEmail}">정보수정</a></li>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <li><a href="${path }/myInfoPFP.do?member_email=${memberLoggedIn.memberEmail}">프로필사진 </a></li>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <li><a href="${path }/myinfoPwView.do?member_email=${memberLoggedIn.memberEmail}">비밀번호 변경 </a></li>
              </ul>
				
		

              
          <div class="tab-content">
            <div class="tab-pane active" id="home">
                <hr>
                  <form class="form" action="#" method="post" id="registrationForm">
                       
                
                 
                     <div class="form-group">
                          <div class="col-xs-6">
                            <div class="form-group">
	            			<label class="text-secondary">이메일</label>       													
	            			<input type="text" required class="form-control" name="memberName" readonly="readonly" value="${memberLoggedIn.memberEmail }" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" /> 
	            		</div>
                          </div>
                      </div>
                      
                      <div class="form-group">
                          <div class="col-xs-6">
                            <div class="form-group">
	            			<label class="text-secondary">이름</label>       													
	            			<input type="text" required class="form-control" name="memberName" readonly="readonly" value="${memberLoggedIn.memberName }" pattern=""/> 
	            		</div>
                          </div>
                      </div>
                      
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                            <label class="text-secondary">닉네임</label>
	            			<input type="text" required class="form-control" name="memberNickname" id="nickname" readonly="readonly" value="${memberLoggedIn.memberNickname }" placeholder=""/>
                          </div>
                      </div>
          
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label class="text-secondary">휴대폰</label>
	            			<input type="tel" required  name="phone" id="phone" maxlength="11" class="form-control" pattern=".{11,}" readonly="readonly" value="${memberLoggedIn.phone }" placeholder=""/>
                          </div>
                      </div>
          					
          
          
                      <div class="form-group">
                        
                          
                          <div class="col-xs-6">
                            <label class="text-secondary">성별</label>
	            			<input type="text" required class="form-control" name="memberNickname" id="nickname" readonly="readonly" value="${memberLoggedIn.memberGender }자"" placeholder=""/>
                          </div>
                    
                      </div>
                     
                     
                      
                      
                     
                      
                      <div class="form-group">    
                          <div class="col-xs-6">
                                <hr>
                       <h3 class="text-secondary">관심분야</h3>
                    <div class="form-row">
                       <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck" name="memberConcern" value="여행" <%=concernList!=null && concernList.contains("여행")?"checked":""%> onclick="return false">
                        	
                        <label class="custom-control-label" for="customCheck">여행</label>
                   		
                   </div>
                   
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck1" name="memberConcern" value="예술"  <%=concernList!=null && concernList.contains("예술")?"checked":""%> onclick="return false">
                       		 
                        <label class="custom-control-label" for="customCheck1">예술</label>
                   </div>
                   &nbsp;&nbsp;
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck2" name="memberConcern" value="문화" <%=concernList!=null && concernList.contains("문화")?"checked":""%> onclick="return false">
                        	  
                        <label class="custom-control-label" for="customCheck2">문화</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck3" name="memberConcern" value="건강"  <%=concernList!=null && concernList.contains("건강")?"checked":""%> onclick="return false">
                        	 
                        <label class="custom-control-label" for="customCheck3">건강</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck4" name="memberConcern" value="패션"  <%=concernList!=null && concernList.contains("패션")?"checked":""%> onclick="return false">
                       		 
                        <label class="custom-control-label" for="customCheck4">패션</label>
                   </div>
                   &nbsp;&nbsp;
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck5" name="memberConcern" value="뷰티"  <%=concernList!=null && concernList.contains("뷰티")?"checked":""%> onclick="return false">
                        	 
                        <label class="custom-control-label" for="customCheck5">뷰티</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck6" name="memberConcern" value="스포츠"  <%=concernList!=null && concernList.contains("스포츠")?"checked":""%> onclick="return false">
                       		 
                        <label class="custom-control-label" for="customCheck6">스포츠</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck7" name="memberConcern" value="푸드" <%=concernList!=null && concernList.contains("푸드")?"checked":""%> onclick="return false">
                        	  
                        <label class="custom-control-label" for="customCheck7">푸드</label>
                   </div> <br>
                        &nbsp;&nbsp; 
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck8" name="memberConcern" value="리빙" <%=concernList!=null && concernList.contains("리빙")?"checked":""%> onclick="return false">
                        	  
                        <label class="custom-control-label" for="customCheck8">리빙</label>
                   </div> <br>
                        &nbsp;&nbsp;
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck9" name="memberConcern" value="재태크" <%=concernList!=null && concernList.contains("재태크")?"checked":""%> onclick="return false">
                        	  
                        <label class="custom-control-label" for="customCheck9">재태크</label>
                   </div> <br>
                        &nbsp;&nbsp;     
                         </div> 
                          </div>
                      </div>
                      
                      
                       <div class="form-group">
                          <div class="col-xs-6">
                              <label class="text-secondary">생년월일 </label>
		                       <input class="form-control" type="text"  autocomplete="off" required  name="memberBirthday" readonly="readonly" placeholder="${memberLoggedIn.memberBirthday}">
                          </div>
                      </div>
                      
                        <div class="form-group">
                          
                          <div class="col-xs-6">
                            <label class="text-secondary">주소</label>
	            			<input type="text" required class="form-control" name="addr1" id="addr1" readonly="readonly" readonly="readonly" value="${memberLoggedIn.addr1 }" placeholder=""/>
                          </div>
                      </div>
                      
                      <div class="form-group">
					    	<input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="addr2" id="addr2" type="text" readonly="readonly" value="${memberLoggedIn.addr2}" placeholder="" />
					</div>
					
					<div class="form-group">
					    		<input class="form-control" placeholder="상세주소" name="addr3" id="addr3" type="text" readonly="readonly" value="${memberLoggedIn.addr3 }" placeholder=""  />
					</div>
                     
                   
              	</form>
              
              <hr>
            
               
              </div><!--/tab-pane-->
          </div><!--/tab-content-->

        </div><!--/col-9-->
    </div><!--/row-->	


</div> <!-- 메인 컨텐트 끝  -->

	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>