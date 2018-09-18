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
		
</style>
	    
	    
	    
	    
	    
<div class="w3-col m8"> <!-- 메인 컨텐츠 시작 -->
	
<div class="w3-card w3-round w3-white" style=" margin-left: 20px;">
<div class="container bootstrap snippet">
    <div class="row">
  		<div class="col-sm-10"><h1>프로필 정보</h1></div>
    </div>
    <div class="row">
  		<div class="col-sm-3"><!--left col-->
              

      <div class="text-center">
        <img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" class="avatar img-circle img-thumbnail" alt="avatar">
        
      </div></hr><br>

               
          
          
        
         
          
        </div><!--/col-3-->
    	<div class="col-sm-9">
            <ul class="nav nav-tabs">
                <li class="active"><a href="${path }/memberView.do">내 정보 </a></li> 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <li><a href="${path }/memberUpdateView.do">수정하기</a></li>
               
              </ul>

              
          <div class="tab-content">
            <div class="tab-pane active" id="home">
                <hr>
                  <form class="form" action="#" method="post" id="registrationForm">
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="first_name"><h4>이름</h4></label>
                              <input type="text" class="form-control" name="first_name" id="first_name" placeholder="first name" title="enter your first name if any." readonly>
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                            <label for="last_name"><h4>Last name</h4></label>
                              <input type="text" class="form-control" name="last_name" id="last_name" placeholder="last name" title="enter your last name if any.">
                          </div>
                      </div>
          
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="phone"><h4>Phone</h4></label>
                              <input type="text" class="form-control" name="phone" id="phone" placeholder="enter phone" title="enter your phone number if any.">
                          </div>
                      </div>
          
                      <div class="form-group">
                          <div class="col-xs-6">
                             <label for="mobile"><h4>Mobile</h4></label>
                              <input type="text" class="form-control" name="mobile" id="mobile" placeholder="enter mobile number" title="enter your mobile number if any.">
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="email"><h4>Email</h4></label>
                              <input type="email" class="form-control" name="email" id="email" placeholder="you@email.com" title="enter your email.">
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="email"><h4>Location</h4></label>
                              <input type="email" class="form-control" id="location" placeholder="somewhere" title="enter a location">
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="password"><h4>Password</h4></label>
                              <input type="password" class="form-control" name="password" id="password" placeholder="password" title="enter your password.">
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                            <label for="password2"><h4>Verify</h4></label>
                              <input type="password" class="form-control" name="password2" id="password2" placeholder="password2" title="enter your password2.">
                          </div>
                      </div>
                      <div class="form-group">
                           <div class="col-xs-12">
                                <br>
                              	<!-- <button class="btn btn-lg btn-success" type="submit"><i class="glyphicon glyphicon-ok-sign"></i> Save</button>
                               	<button class="btn btn-lg" type="reset"><i class="glyphicon glyphicon-repeat"></i> Reset</button> -->
                            </div>
                      </div>
              	</form>
              
              <hr>
              
            
          
               
              </div><!--/tab-pane-->
          </div><!--/tab-content-->

        </div><!--/col-9-->
    </div><!--/row-->	

</div>
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