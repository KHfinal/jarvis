<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>

<style>
	.m8{
		margin-left: 5%;
	}
	.area{

	    border: 2px solid lightgrey;
	    border-radius: 8px;
	    box-shadow: 1px 1px 1px lightgrey;
	}
	.loginImg{
		height : 200px;
		width : 90%;
	}
	.row{
		text-align: center;
		padding : auto;
	}
	.changeDiv{
		overflow: hidden;
	}
</style>
<script>
	function previewFile() {
		  var preview = document.querySelector('#afterImg');
		  var file    = document.querySelector('input[type=file]').files[0];
		  var reader  = new FileReader();
		  var ext = file.name.split(".").pop().toLowerCase();
		  if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
			  $('#customFile').val("");
			  $('#afterImg').attr("src","${path}/resources/img/mainImg.jpg");
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
		  $("#customFileLabel").text($('#customFile').val());
	}
	function fn_validata(){

		if($("#customFile").val()==""){
			alert("이미지파일을 선택해주세요");
			return false;
		}
		return true;
	}
</script>
<div class="w3-col m8" ng-app="" ng-init="headerCol='${siteInfo.HEADER_COLOR }';logoBagCol='${siteInfo.LOGO_BAGROUND}';logoFont='${siteInfo.LOGO_FONT}';logoFontSize=${siteInfo.LOGO_FONTSIZE};iconCol='${siteInfo.ICON_COLOR}'">
	<div class="container"><br></div>
	<div class="container area">
		<div class="container title"><h3>로그인 이미지 변경</h3></div>
		<div class="row">
			<div class="col-sm-1"><br></div>
			<div class="imgdiv col-sm-5"><img src = "${path }/resources/img/mainImg.jpg" class="loginImg"><br>[변경 전]</div>
			<div class="changeDiv col-sm-5"><img src="${path}/resources/img/mainImg.jpg" class="loginImg" id="afterImg"><br>[변경 후]</div>
			<div class="col-sm-1"><br></div>
		</div>
		
			<form action="${path }/admin/changeMainImg.do" method="POST" enctype="multipart/form-data" onsubmit="return fn_validata();">
			  <div class="custom-file">
			    <input type="file" class="custom-file-input" id="customFile" onchange="previewFile()" name="mainImg">
			    <label class="custom-file-label" for="customFile" id="customFileLabel">Choose File</label>
			    <p align="right"><br><button type="submit" class="btn btn-success">변경</button></p>
			  </div>
			</form>
			<br>
	</div>
	<div class="container"><br></div>
	
	<div class="container area">
		<div class="container title" ><h3>헤더 커스터마이징</h3><br>

				 <div class="w3-bar w3-left-align w3-large" style="background-color:{{headerCol}}; color:{{iconCol}};">
				  <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large" href="#"><i class="fa fa-bars"></i></a>
				  <a href="#" class="w3-bar-item w3-button w3-padding-large" style="background-color:{{logoBagCol}};font-family: {{logoFont}}; font-size: {{logoFontSize}}px;"><i class="fa fa-home w3-margin-right"></i>JARVIS</a>
				  <a href="#" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="News"><i class="fa fa-globe"></i></a>
				  <div id='fr' class="w3-dropdown-hover w3-hide-small">
				    <button class="w3-button w3-padding-large" title="Notifications"><i class="fa fa-user"></i><span id='su' class="w3-badge w3-right w3-small w3-green">0</span></button>     
				    <div class="w3-dropdown-content w3-card-4 w3-bar-block dropdown" style="width:300px" id="myDropdown" >
				   
				    </div>
				  </div>
				  <a href="#" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Messages"><i class="fa fa-envelope"></i></a>
				  <div class="w3-dropdown-hover w3-hide-small">
				    <button class="w3-button w3-padding-large" title="Notifications">
				    	<i class="fa fa-bell"></i><span class="w3-badge w3-right w3-small w3-green"></span>
				    </button>     
				    <div class="w3-dropdown-content w3-card-4 w3-bar-block" style="width:300px">
				    </div>
				  </div>
				  <a href="#" class="w3-bar-item w3-button w3-hide-small w3-right w3-padding-large w3-hover-white" title="My Account">
				    <img src="${path}/resources/profileImg/${memberLoggedIn.memberPFP}" class="w3-circle" style="height:23px;width:23px" alt="Avatar">
				  </a>
				  <a href="#" class="w3-bar-item w3-button w3-hide-small w3-right w3-padding-large w3-hover-white" title="logout">
				   	<i class="fas fa-sign-out-alt"></i>
				  </a>
				 </div>
		</div>
	<br>
			<form class="row" action="${path }/admin/updateHeader.do">
			
				<div class="col-sm-6">

					<p>헤더 영역 색상 : <input type="color" ng-model="headerCol" name="headerCol" ></p>
					
					<p>헤더 로고 폰트 :
					<select name="logoFont" ng-model="logoFont">
					    <option value="Nanum Gothic">나눔고딕</option>
					    <option value="Noto Sans KR">KR</option>
					    <option value="Do Hyeon">두현체</option>
					    <option value="Nanum Pen Script">나눔펜</option>
					    <option value="Gamja Flower">감자꽃</option>
					    <option value="Nanum Brush Script">나눔솔</option>
					    <option value="Black Han Sans">한산체</option>
					    <option value="Gaegu">개구체</option>
					    <option value="East Sea Dokdo">동해독도체</option>
					    <option value="Hi Melody">멜로디</option>
					    <option value="Dokdo">독도</option>
					</select>
					</p>
					<p>헤더 아이콘 색상 : <input type="color" ng-model="iconCol" name="iconCol"></p>
				</div>
				<div class="col-sm-6">
					<p>헤더 로고 영역 색상 : <input type="color" ng-model="logoBagCol" name="logoBagCol"></p>
					<p>헤더 로고 폰트 크기 <input type="number" ng-model="logoFontSize" min="18" max=30 name="logoFontSize"></p>
					<p align="right"><br><button type="submit" class="btn btn-success">변경</button></p>
				</div>
			</form>
		
	</div>
	<div class="container"><br></div>
	<div class="container area" ng-init="menuCol='${siteInfo.MENU_FONTCOL}';menuBcol='${siteInfo.MENU_BCOL}';profileFont='${siteInfo.PROFILE_FONT}';dropdownBcol='${siteInfo.DROPDOWN_BCOL}';menuFont='${siteInfo.MENU_FONT}'">
		<div class="container title"><h3>사이드 메뉴 커스터마이징</h3></div>
		<div class="row">
			<div class="col-sm-6">
				<div class="w3-card w3-round w3-white">
			        <div class="w3-container w3-left-align" style="font-family: {{profileFont}}">
			         <h4 class="w3-center" style="font-family: {{profileFont}}">${memberLoggedIn.memberName }님의 Profile</h4>
			         <p class="w3-center"><img src="${path}/resources/profileImg/${memberLoggedIn.memberPFP}" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
			         <hr>
			         <p><i class="fa fa-pencil fa-fw w3-margin-right w3-text-theme"></i>${memberLoggedIn.memberName }</p>
			         <p><i class="fa fa-home fa-fw w3-margin-right w3-text-theme" id="addr2"></i>경기도 남양주시</p>
			         <p><i class="fa fa-birthday-cake fa-fw w3-margin-right w3-text-theme"></i> ${memberLoggedIn.memberBirthday }</p>
			        </div>
		        </div>
			      <br>
			      
			      <!-- 메뉴 DIV -->
			      <div class="w3-card w3-round" style="background-color:{{menuBcol}};color:{{menuCol}};font-family:{{menuFont}}">
			        <div>
			          <button onclick="selectGroup('selectGroup2');" class="w3-button w3-block w3-left-align" ><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i>Groups</button>
			          <div id="selectGroup2" class="w3-hide w3-container" style="padding-left: 0; padding-right: 0;">
			            <button class="btn btn-outline-secondary w3-block w3-left-align" style="background-color:{{dropdownBcol}}"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i> Group List</button>
			            <button  class="btn btn-outline-secondary w3-block w3-left-align" style="background-color:{{dropdownBcol}}"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i> My Group</button>
			          </div>
			          <button class="w3-button w3-block w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i>  My Events</button>
			          <button class="w3-button w3-block w3-left-align"><i class="fas fa-user-circle fa-fw w3-margin-right"></i> My Post</button>
			          <button class="w3-button w3-block w3-left-align"><i class="fa fa-users fa-fw w3-margin-right"></i> My Friends</button>
			
			        </div>      
			      </div>
			      <br>
			
			
			
			</div>
			<div class="col-sm-6">
				<form class="row" action="${path }/admin/updateSide.do">
			
				
						<p>메뉴 폰트 색상<input type="color" ng-model="menuCol" name="menuCol" ></p>
						<p>프로필 영역 폰트 :
							<select name="profileFont" ng-model="profileFont">
							    <option value="Nanum Gothic">나눔고딕</option>
							    <option value="Noto Sans KR">KR</option>
							    <option value="Do Hyeon">두현체</option>
							    <option value="Nanum Pen Script">나눔펜</option>
							    <option value="Gamja Flower">감자꽃</option>
							    <option value="Nanum Brush Script">나눔솔</option>
							    <option value="Black Han Sans">한산체</option>
							    <option value="Gaegu">개구체</option>
							    <option value="East Sea Dokdo">동해독도체</option>
							    <option value="Hi Melody">멜로디</option>
							    <option value="Dokdo">독도</option>
							</select>
						</p>
						<p>메뉴 영역 폰트 :
							<select name="menuFont" ng-model="menuFont">
							    <option value="Nanum Gothic">나눔고딕</option>
							    <option value="Noto Sans KR">KR</option>
							    <option value="Do Hyeon">두현체</option>
							    <option value="Nanum Pen Script">나눔펜</option>
							    <option value="Gamja Flower">감자꽃</option>
							    <option value="Nanum Brush Script">나눔솔</option>
							    <option value="Black Han Sans">한산체</option>
							    <option value="Gaegu">개구체</option>
							    <option value="East Sea Dokdo">동해독도체</option>
							    <option value="Hi Melody">멜로디</option>
							    <option value="Dokdo">독도</option>
							</select>
						</p>
						<p>메뉴 배경색 : <input type="color" ng-model="menuBcol" name="menuBcol"></p>
						<p>드롭다운 배경색 : <input type="color" ng-model="dropdownBcol" name="dropdownBcol"></p>
						<p align="right"><br><button type="submit" class="btn btn-success">변경</button></p>
				</form>
			</div>
		
		</div>
	
	</div>
</div>

<script>
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

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>