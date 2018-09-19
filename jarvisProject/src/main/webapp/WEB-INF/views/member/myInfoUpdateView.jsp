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
	
<div class="w3-card w3-round w3-white" >
<div class="container bootstrap snippet">
    <div class="row">
  		<div class="col-sm-10"><h1>프로필 수정</h1></div>
    </div><br>
   
    	<div class="col-sm-9">
          <ul class="nav nav-tabs" role="tablist">
                <li >
                	<a  href="${path }/myInfoView.do?member_email=${memberLoggedIn.memberEmail}">내 정보 </a>
                </li> 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <li class="nav-item"> 
                	<a class="nav-link active" data-toggle="tab" href="${path }/myInfoUpdateView.do?member_email=${memberLoggedIn.memberEmail}">정보수정</a>
                </li>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <li>
               		<a href="${path }/myInfoPFP.do?member_email=${memberLoggedIn.memberEmail}">프로필사진 </a>
               </li>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <li>
                	<a href="${path }/myinfoPwView.do?member_email=${memberLoggedIn.memberEmail}">비밀번호 변경 </a>
                </li>
              </ul>

              
          <div class="tab-content">
            <div class="tab-pane active" id="home">
                <hr>
                  <form class="form" action="${path }/myinfoUpdate.do" method="post" id="registrationForm">
                     
                      <div class="form-group">
                          <div class="col-xs-6">
                            <div class="form-group">
	            				<label class="text-secondary">이메일</label>       													
	            				<input type="text" required class="form-control" name="memberEmail" id="memberEmail" readonly="readonly"  placeholder="" value="${memberLoggedIn.memberEmail }"/> 
	            			</div>
                          </div>
                      </div> 
                       
                      <div class="form-group">
                          <div class="col-xs-6">
                            <div class="form-group">
	            			<label class="text-secondary">이름</label>       													
	            			<input type="text" required class="form-control" name="memberName" value="${memberLoggedIn.memberName }" pattern="^[a-zA-Z가-힣]*$" placeholder="한글or영문"/> 
	            		</div>
                          </div>
                      </div>
                      
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                            <label class="text-secondary">닉네임</label>
	            			<input type="text" required class="form-control" name="memberNickname" id="memberNickname" value="${memberLoggedIn.memberNickname }"  placeholder=""/>
                          </div>
                      </div>
          
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label class="text-secondary">휴대폰</label>
	            			<input type="tel" required  name="phone" id="phone" maxlength="11" class="form-control" pattern=".{11,}" value="${memberLoggedIn.phone }" placeholder="ex)01000000000"/>
                          </div>
                      </div>
         
          
                    <%--   <div class="form-group">
                        
                          
                          <div class="col-xs-6">
                            <label class="text-secondary">성별</label>
	            			<input type="text" required class="form-control" name="memberNickname" id="nickname"  placeholder="${memberLoggedIn.memberGender }자"/>
                          </div>
                    
                      </div>
                      --%>
    
                      
                      <div class="form-group">    
                          <div class="col-xs-6">
                                <hr>
                       <h3 class="text-secondary">관심분야</h3>
                    <div class="form-row">
                       <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck" name="memberConcern" value="여행" <%=concernList!=null && concernList.contains("여행")?"checked":""%>>
                        	
                        <label class="custom-control-label" for="customCheck">여행</label>
                   		
                   </div>
                   
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck1" name="memberConcern" value="예술"  <%=concernList!=null && concernList.contains("예술")?"checked":""%>>
                       		 
                        <label class="custom-control-label" for="customCheck1">예술</label>
                   </div>
                   &nbsp;&nbsp;
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck2" name="memberConcern" value="문화" <%=concernList!=null && concernList.contains("문화")?"checked":""%>>
                        	  
                        <label class="custom-control-label" for="customCheck2">문화</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck3" name="memberConcern" value="건강"  <%=concernList!=null && concernList.contains("건강")?"checked":""%>>
                        	 
                        <label class="custom-control-label" for="customCheck3">건강</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck4" name="memberConcern" value="패션"  <%=concernList!=null && concernList.contains("패션")?"checked":""%>>
                       		 
                        <label class="custom-control-label" for="customCheck4">패션</label>
                   </div>
                   &nbsp;&nbsp;
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck5" name="memberConcern" value="뷰티"  <%=concernList!=null && concernList.contains("뷰티")?"checked":""%>>
                        	 
                        <label class="custom-control-label" for="customCheck5">뷰티</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck6" name="memberConcern" value="스포츠"  <%=concernList!=null && concernList.contains("스포츠")?"checked":""%>>
                       		 
                        <label class="custom-control-label" for="customCheck6">스포츠</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck7" name="memberConcern" value="푸드" <%=concernList!=null && concernList.contains("푸드")?"checked":""%>>
                        	  
                        <label class="custom-control-label" for="customCheck7">푸드</label>
                   </div> <br>
                        &nbsp;&nbsp; 
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck8" name="memberConcern" value="리빙" <%=concernList!=null && concernList.contains("리빙")?"checked":""%>>
                        	  
                        <label class="custom-control-label" for="customCheck8">리빙</label>
                   </div> <br>
                        &nbsp;&nbsp;
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck9" name="memberConcern" value="재태크" <%=concernList!=null && concernList.contains("재태크")?"checked":""%>>
                        	  
                        <label class="custom-control-label" for="customCheck9">재태크</label>
                   </div> <br>
                        &nbsp;&nbsp;     
                         </div> 
                          </div>
                      </div>
                      
                      
                       <div class="form-group">
                          <div class="col-xs-6">
                              <label class="text-secondary">생년월일 </label>
		                       <input class="form-control" type="date" max="today" min="1900-01-01" autocomplete="off" required  name="memberBirthday" value="${memberLoggedIn.memberBirthday}" placeholder="">
                             
                          </div>
                      </div>
                      
					  <div class="form-group">                   
							<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="addr1" id="addr1" type="text" readonly="readonly" value="${memberLoggedIn.addr1 }" >
						    <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
						</div>
						<div class="form-group">
						    <input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="addr2" id="addr2" type="text" readonly="readonly" value="${memberLoggedIn.addr2 }" />
						</div>
						<div class="form-group">
						    <input class="form-control" placeholder="상세주소" name="addr3" id="addr3" type="text" value="${memberLoggedIn.addr3 }" />
						</div>
                     
                      
                      <div class="form-group">
                           <div class="col-xs-12">
                                <br>
                              	<button class="btn btn-info mt-2" type="submit">수정하기</button>
                               <!-- 	<button class="btn btn-lg" type="reset"><i class="glyphicon glyphicon-repeat" onclick="member_cancel();"></i> 취소하기</button> -->
                            </div>
                      </div>
              	</form>
              
              <hr>
              
             </div><!--/tab-pane-->
            
    
              </div><!--/tab-pane-->
          </div><!--/tab-content-->

        </div><!--/col-9-->
  

</div>
</div> <!-- 메인 컨텐트 끝  -->

<script>
function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           
           $("[name=addr1]").val(data.zonecode);
           $("[name=addr2]").val(fullRoadAddr);
           
           /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
           document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
       }
    }).open();
}

</script>

	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>