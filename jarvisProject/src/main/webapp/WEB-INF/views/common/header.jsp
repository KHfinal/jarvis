<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Jarvis social header</title>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<link rel="stylesheet" href="${path }/resources/css/common.css?ver=1">
<link href="https://fonts.googleapis.com/css?family=Audiowide|Cabin+Sketch|Monoton|Orbitron" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Gamja+Flower" rel="stylesheet">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 다음 주소 API -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
</head>
<style>
	html,body,h1,h2,h3,h4,h5 {font-family: "Open Sans", sans-serif}
</style>
<body class="w3-theme-l5">
<header>
	<!-- 상담 헤더  -->
	<div class="w3-top">
	 <div class="w3-bar w3-left-align w3-large" style="background-color:${siteInfo.HEADER_COLOR }; color:${siteInfo.ICON_COLOR};">
	  <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large w3-theme-d2" href="javascript:void(0);" onclick="openNav()"><i class="fa fa-bars"></i></a>
	  <a href="#" class="w3-bar-item w3-button w3-padding-large" style="background-color:${siteInfo.LOGO_BAGROUND};font-family:${siteInfo.LOGO_FONT}; font-size:${siteInfo.LOGO_FONTSIZE}px;"><i class="fa fa-home w3-margin-right"></i>JARVIS</a>
	  <a href="${path }/post/socialHomeView.do" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="News"><i class="fa fa-globe"></i></a>
	  <div id='fr' class="w3-dropdown-hover w3-hide-small">
	    <button class="w3-button w3-padding-large" title="Notifications"><i class="fa fa-user"></i><span id='su' class="w3-badge w3-right w3-small w3-green">0</span></button>     
	    <div class="w3-dropdown-content w3-card-4 w3-bar-block dropdown" style="width:300px" id="myDropdown" >
	   
	    </div>
	  </div>
	  <a href="${path }/chat/chattingView.do" id="messanger" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Messages"><i class="fa fa-envelope"></i></a>
	  <c:if test="${memberLoggedIn.memberEmail  eq 'admin'}">
	  <div class="w3-dropdown-hover w3-hide-small">
	  <button class="w3-button w3-padding-large" title="Notifications">
	    	<i class="fas fa-edit"></i>
	   </button>
	  <div class="w3-dropdown-content w3-card-4 w3-bar-block">
	      <a href="${path }/admin/customizing.do" class="w3-bar-item w3-button">홈페이지 커스터마이징</a>
	      <a href="${path }/admin/warningContent.do" class="w3-bar-item w3-button">신고 내역보기</a>
	      <a href="${path }/admin/memberAdministration.do" class="w3-bar-item w3-button">회원관리</a>
	    </div>
	   </div>
	  </c:if>
	  <div class="w3-dropdown-hover w3-hide-small">
	    <button class="w3-button w3-padding-large" title="Notifications">
	    	<i class="fa fa-bell"></i><span class="w3-badge w3-right w3-small w3-green">4</span>
	    </button>     
	    <div class="w3-dropdown-content w3-card-4 w3-bar-block" style="width:300px">
	    <c:forEach items="${requestList1}" var="r1">
	      <a href="#" class="w3-bar-item w3-button">
	      	${r1 }
	      	<button type="button" id="friend_agree" onclick="friend_agree('${r1 }');">수락</button>
	      	<button type="button" id="friend_refuse1" onclick="friend_refuse('${r1 }');">거절</button>
	      </a>
	    </c:forEach>
	    </div>
	  </div>
	  <a href="${path }/myInfoView.do?member_email=${memberLoggedIn.memberEmail}" class="w3-bar-item w3-button w3-hide-small w3-right w3-padding-large w3-hover-white" title="My Account">
	    <img src="${path}/resources/profileImg/${memberLoggedIn.memberPFP}" class="w3-circle" style="height:23px;width:23px" alt="Avatar">
	  </a>
	  <a href="${path }/member/logout.do" class="w3-bar-item w3-button w3-hide-small w3-right w3-padding-large w3-hover-white" title="logout">
	   	<i class="fas fa-sign-out-alt"></i>
	  </a>
	 </div>
	</div>
	
	<!-- Navbar on small screens 화면이 작아졌을 때의 상단 헤더 메뉴목록 형태로 바뀜-->
	<div id="navDemo" class="w3-bar-block w3-hide w3-hide-large w3-hide-medium w3-large">
	  <a href="#" class="w3-bar-item w3-button w3-padding-large" title="News"><i class="fa fa-globe"></i></a>
	  <a href="${path }/post/socialHomeView.do" class="w3-bar-item w3-button w3-padding-large" title="News"><i class="fa fa-globe"></i>  FriendNews</a>
	  <a href="${path }/chat/chattingView.do" class="w3-bar-item w3-button w3-padding-large" title="Messages"><i class="far fa-comments"></i>  Chatting With Friends</a>
	</div>
</header>


<!-- Page Container -->
<div class="w3-container w3-content" style="max-width:1400px;margin-top:80px">
  <!-- The Grid -->
  <div class="w3-row">
    <!-- 사이드 메뉴들 div 시작부분 -->
    <div class="w3-col m3">
      <!-- 프로필 div-->
      <div class="w3-card w3-round w3-white">
        <div class="w3-container" style="font-family:${siteInfo.PROFILE_FONT}">
         <h4 class="w3-center" style="font-family: ${siteInfo.PROFILE_FONT}">${memberLoggedIn.memberName }님의 Profile</h4>
         <p class="w3-center"><img src="${path}/resources/profileImg/${memberLoggedIn.memberPFP}" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
         <hr>
         <p><i class="fas fa-id-card-alt fa-fw w3-margin-right w3-text-theme"></i>${memberLoggedIn.memberName }</p>
         <p><i class="fa fa-home fa-fw w3-margin-right w3-text-theme" id="addr2"></i></p>
         <p><i class="fa fa-birthday-cake fa-fw w3-margin-right w3-text-theme"></i> ${memberLoggedIn.memberBirthday }</p>
        </div>
      </div>
      <br>
      
      <!-- 메뉴 DIV -->
      <div class="w3-card w3-round" style="background-color:${siteInfo.MENU_BCOL};color:${siteInfo.MENU_FONTCOL};font-family:${siteInfo.MENU_FONT};">
        <div>
          <button onclick="selectGroup('selectGroup');" class="w3-button w3-block w3-left-align"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i> Groups</button>
          <div id="selectGroup" class="w3-hide w3-container" style="padding-left: 0; padding-right: 0;">
            <button onclick="goGroup();" class="btn btn-outline-secondary w3-block w3-left-align" style="background-color:${siteInfo.DROPDOWN_BCOL}"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i> Group List</button>
            <button onclick="goMyGroup();" class="btn btn-outline-secondary w3-block w3-left-align" style="background-color:${siteInfo.DROPDOWN_BCOL}"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i> My Group</button>
          </div>
          <button onclick="goCalendar()" class="w3-button w3-block w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i>  My Events</button>
          <div id="Demo2" class="w3-hide w3-container">
            <p>Some other text..</p>
          </div>
          <button onclick="goMyPage(this)" title="${memberLoggedIn.memberEmail }" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fas fa-atlas fa-fw w3-margin-right"></i> My Page</button>
          <button onclick="goFriend()" class="w3-button w3-block w3-theme-l1 w3-left-align"><i class="fa fa-users fa-fw w3-margin-right"></i> My Friends</button>

        </div>      
      </div>
      <br>
      
      <!-- Interests --> 
      <div class="w3-card w3-round w3-white w3-hide-small">
        <div class="w3-container">
          <p>Interests</p>
          <p>
          <c:forEach items="${categoryList }" var="c">
          	<span class="w3-tag w3-small w3-theme-d5"><a href="${path}/group/groupFilter.do?category=${c.C_KEY}">${c.C_VALUE }</a></span>
          </c:forEach>
          </p>
        </div>
      </div>
      <br>
    
    <!-- 사이드 메뉴 부분 종료 DIV -->
    </div>
<script>
	var addr = '${memberLoggedIn.addr2}';
	var addrList = addr.split(' ');
	var addr2 = addrList[0]+' '+addrList[1];
	console.log(addr2);
	$("#addr2").after(addr2);
	function goCalendar(){
		location.href="${path}/schedule/privateHome.do";
	}
	function goFriend(){
		location.href="${path}/friend/friendView.do";
	}
	function goGroup(){
	      location.href="${path}/group/groupList.do";
	   }
    function goMyGroup(){
      location.href="${path}/group/myGroupList.do"
    }
	function selectGroup(id) {
	    var x = document.getElementById(id);
	    if (x.className.indexOf("w3-show") == -1) {
	        x.className += " w3-show";
	        x.previousElementSibling.className += " w3-theme-d1";
	    } else { 
	        x.className = x.className.replace("w3-show", "");
	        x.previousElementSibling.className = 
	        x.previousElementSibling.className.replace(" w3-theme-d1", "");
	    }
	}
	var userIdList=[] ;
	var su =0;
	var friendList=[];
	var sock=new SockJS("<c:url value='/friendInList'/>")  /* (0) */
	sock.onmessage = onMessage;
	sock.onclose = onClose;

	function ajax() {
	var email = '${memberLoggedIn.memberEmail}';    /* (0) */
	$.ajax({
		url:"${path}/friend/selectFriendListJson.do",
		type:"get",
		data:{email:email},
		dataType:"json",
		success : function(data){
			
	    	$('#myDropdown').append('<input type="text" placeholder="Search.." id="myInput" onkeyup="filterFunction()" style="width:100%">');
	    	su=0;
			var friendListTag;
			friendList=[];
			var size =userIdList.length;
			$.each(data,function(i,item){
				var fList= item.memberEmail;
				friendList.push(item.memberEmail);
				for(var k =0; k<size;k++){
					console.log("userIdList[k] : "+userIdList[k]);
				    if(fList==userIdList[k]){																																			
						friendListTag = "<a href='javascript:void(0)' onclick='goMyPage(this)'title='"+item.memberEmail+"' class='w3-bar-item w3-button' style='text-decoration:none'><img src='${path}/resources/profileImg/"+item.memberPFP+"' class='w3-circle' style='height:3%;width:15%' alt='Avatar'>&nbsp;&nbsp;&nbsp;"+item.memberEmail+"&nbsp;&nbsp;&nbsp;&nbsp;<span aria-label='현재 활동 중' style='text-align: right;background: rgb(66, 183, 42); border-radius: 50%; display: inline-block; height: 6px; margin-left: 4px; width: 6px;'></span></a><br>";
						su++;
						break;
				    }else{
				    	friendListTag = "<a href='javascript:void(0)' onclick='goMyPage(this)'title='"+item.memberEmail+"' class='w3-bar-item w3-button' style='text-decoration:none'><img src='${path}/resources/profileImg/"+item.memberPFP+"' class='w3-circle' style='height:3%;width:15%' alt='Avatar'>&nbsp;&nbsp;&nbsp;"+item.memberEmail+"</a><br>";
				    }
				} 
				$('#myDropdown').append(friendListTag);
			});
			$("#su").empty();
			$('#su').append(su);
		}
	});
	$.ajax({
		url:"${path}/chat/countRead",
		type:"get",
		data:{email:email},
		dataType:"json",
		success : function(data){
			$('#messanger').html("<i class='fa fa-envelope'></i><span id='su' class='w3-badge w3-right w3-small w3-green'>"+data+"</span>");
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
			if(flag[1]!='${memberLoggedIn.memberEmail}'){
				$("#su").empty();
				$('#su').append(su);
				
			}	
		}
		
		console.log("스크립트 접속후 접속자 : "+userIdList);
		/* alert("포함?"+userIdList.contains(flag[1])); */
	}
	if(flag[0]=="2"){
		console.log("스크립트 나간 유저 : " + flag[1]);
		console.log("나간후 리스트 받아오기 전 사이즈"+userIdList.length);
		if(userIdList.length !=null){
			su=0;		
			userIdList=[];	
		}
		userIdList.push(flag[1]);
		su++;
		if(flag[1]!='${memberLoggedIn.memberEmail}'){
			$("#su").empty();
			$('#su').append(su);
		}
		console.log("스크립트 나간후 접속자 : "+userIdList);
	}
	};
	function onClose() {
	/* 이동하고 close */
	location.href="${pageContext.request.contextPath}";
	self.close();
	};	


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
	function fn_friendAdd(data){
		location.href="${path}/friend/friendRequest.do?fEmail="+data;
	};
	function fn_submit() {
		submit();
	};

	
	function goMyPage(e) {
		var btn = $(e);
		var memberEmail;

		memberEmail = btn.attr('title');
		console.log('btn memberEmail = ' + memberEmail);
		location.href="${pageContext.request.contextPath}/post/myPage?memberEmail=" + memberEmail;
		
	}
	function openNav() {
	    var x = document.getElementById("navDemo");
	    if (x.className.indexOf("w3-show") == -1) {
	        x.className += " w3-show";
	    } else { 
	        x.className = x.className.replace(" w3-show", "");
	    }
	}

</script>

