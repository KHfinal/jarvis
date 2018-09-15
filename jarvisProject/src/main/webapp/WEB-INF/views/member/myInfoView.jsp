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
		
</style>
	    
	    
	    
	    
	    
<div class="w3-col m8"> <!-- 메인 컨텐츠 시작 -->
	

<div class="container bootstrap snippet">
    <div class="row">
  		<div class="col-sm-10"><h1>프로필 정보</h1></div>
    </div>
</hr><br>

               
          
          
        
         
          
        
    	<div class="col-sm-9">
            <ul class="nav nav-tabs">
                <li class="active"><a href="${path }/memberView.do">내 정보 </a></li> 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <li><a href="${path }/memberUpdateView.do">수정하기</a></li>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <li><a href="#">프로필사진 </a></li>
              </ul>
		

              
          <div class="tab-content">
            <div class="tab-pane active" id="home">
                <hr>
                  <form class="form" action="#" method="post" id="registrationForm">
                       
                
                 
                     
                      
                      <div class="form-group">
                          <div class="col-xs-6">
                            <div class="form-group">
	            			<label class="text-secondary">이름</label>       													
	            			<input type="text" required class="form-control" name="memberName" readonly="readonly" placeholder="${memberLoggedIn.memberName }"/> 
	            		</div>
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                            <label class="text-secondary">닉네임</label>
	            			<input type="text" required class="form-control" name="memberNickname" id="nickname" readonly="readonly" placeholder="${memberLoggedIn.memberNickname }"/>
                          </div>
                      </div>
          
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label class="text-secondary">휴대폰</label>
	            			<input type="tel" required  name="phone" id="phone" maxlength="11" class="form-control" pattern=".{11,}" readonly="readonly" placeholder="${memberLoggedIn.phone }"/>
                          </div>
                      </div>
          					
          
          
                      <div class="form-group">
                        
                          
                          <div class="col-xs-6">
                            <label class="text-secondary">성별</label>
	            			<input type="text" required class="form-control" name="memberNickname" id="nickname" readonly="readonly" placeholder="${memberLoggedIn.memberGender }자"/>
                          </div>
                    
                      </div>
                     
                     
                      
                      
                     
                      
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
		                       <input class="form-control" type="text"  autocomplete="off" required  name="memberBirthday" readonly="readonly" placeholder="${memberLoggedIn.memberBirthday}">
                          </div>
                      </div>
                      
                        <div class="form-group">
                          
                          <div class="col-xs-6">
                            <label class="text-secondary">주소</label>
	            			<input type="text" required class="form-control" name="addr1" id="addr1" readonly="readonly" readonly="readonly" placeholder="${memberLoggedIn.addr1 }"/>
                          </div>
                      </div>
                      
                      <div class="form-group">
					    	<input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="addr2" id="addr2" type="text" readonly="readonly" placeholder="${memberLoggedIn.addr2 }" />
					</div>
					
					<div class="form-group">
					    		<input class="form-control" placeholder="상세주소" name="addr3" id="addr3" type="text" readonly="readonly" placeholder="${memberLoggedIn.addr3 }"  />
					</div>
                     
                   
              	</form>
              
              <hr>
            
               
              </div><!--/tab-pane-->
          </div><!--/tab-content-->

        </div><!--/col-9-->
    </div><!--/row-->	


</div> <!-- 메인 컨텐트 끝  -->
<script>
$(document).ready(function(){
		ajax();
		var email2 = '${memberLoggedIn.memberEmail}';
		$.ajax({
			url:"${path}/friend/friednRecommendList.do",
			type:"POST",
			data:{email:email2},
			dataType:"json",
			success : function(data){
				console.log("friendList :"+friendList);
				var friendConcernTag;
				$.each(data.concernCompareList,function(i,item){
					var f_email2 = item;
					console.log("f_email2 : "+f_email2);
					for(var i =0; i<friendList.length;i++){
						if((friendList[i]==f_email2)){
							break;	
						}
						if(i==friendList.length-1){
							if(f_email2==email2){
								console.log("email2 : " + email2);
								break;
							}
							 friendConcernTag = "<tr><td>"+f_email2+"</td></tr>"; 
							 break;
						}	
					}
					$('.tablefriend').append(friendConcernTag);
					friendConcernTag;
				}); 
			}
		});
}); 
var userIdList=[] ;
var su =0;
var friendList=[];
var sock=new SockJS("<c:url value='/friendInList'/>")  /* (0) */
	/* sock.메소드 는 컨트롤러(핸들러)로 감 */
sock.onmessage = onMessage;
sock.onclose = onClose;
$(function() {
    $('.dropdown-toggle').click(function() {
        this.attr("border", none);
    })
});
function ajax() {
	var email = '${memberLoggedIn.memberEmail}';    /* (0) */
	$.ajax({
		url:"${path}/friend/selectFriendListJson.do",
		type:"POST",
		data:{email:email},
		dataType:"json",
		success : function(data){
	    	$('#myDropdown').append('<input type="text" placeholder="Search.." id="myInput" onkeyup="filterFunction()">');
	    	$('#myDropdown').append('<button id="refresh" onclick="reFresh()">새로고침</button><br>');
	    	su=0;
			var friendListTag;
			friendList=[];
			$.each(data.list,function(i,item){
				var f_email = item; 
				var size =userIdList.length;
				friendList.push(f_email);
				for(var k =0; k<size;k++){
					console.log("userIdList[k] : "+userIdList[k]);
				    if(f_email==userIdList[k]){
						friendListTag = "<a href='#' class='w3-bar-item w3-button'>"+f_email+"<i class='fa fa-cloud'/></a><br>";
						su++;
						break;
				    }else{
				    	friendListTag = "<a href='#' class='w3-bar-item w3-button'>"+f_email+"</a><br>";
				    }
				} 
				$('#myDropdown').append(friendListTag);
			});
			$("#su").empty();
			$('#su').append(su);
		}
	});
};
function onMessage(evt){
	var userId = evt.data;
	var flag=evt.data.split("|");
	console.log("구분 : " +userId[0]);
	if(flag[0]=="1"){
		console.log("스크립트 추가한 유저 : " + flag[1]);
		if(!(userIdList.indexOf(flag[1])>=0)){
			userIdList.push(flag[1]);
			su++;
		}
		console.log("스크립트 접속후 접속자 : "+userIdList);
		/* alert("포함?"+userIdList.contains(flag[1])); */
	}
	if(flag[0]=="2"){
		console.log("스크립트 나간 유저 : " + flag[1]);
		console.log("나간후 리스트 받아오기 전 사이즈"+userIdList.length);
		if(userIdList.length !=null){
			userIdList=[];	
		}
		userIdList.push(flag[1]);
		console.log("스크립트 나간후 접속자 : "+userIdList);
	}
};
function onClose() {
	/* 이동하고 close */
	location.href="${pageContext.request.contextPath}";
	self.close();
};	
/* function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
    ajax();
}; */

$(document).ready(function () {
	$('#fr').hover(
			function(){
				dell();
				ajax();
			},
			function() {
				dell();
			});
});
function reFresh() {
	dell();
};
function dell() {
    $("#myDropdown").empty();
};
function del() {
    $("#myDropdown").empty();
};
function filterFunction() {
    var input, filter, ul, li, a, i;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    div = document.getElementById("myDropdown");
    a = div.getElementsByTagName("a");
    for (i = 0; i < a.length; i++) {
        if (a[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
            a[i].style.display = "";
        } else {
            a[i].style.display = "none";
        }
    }
}	



//이미지 불러오기
$(document).ready(function() {

    var readURL = function(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('.avatar').attr('src', e.target.result);
            }
    
            reader.readAsDataURL(input.files[0]);
        }
    }
    

    $(".file-upload").on('change', function(){
        readURL(this);
    });
});
</script> 

	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>