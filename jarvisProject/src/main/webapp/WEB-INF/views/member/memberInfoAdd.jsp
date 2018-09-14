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
   <link rel="stylesheet" href="${path }/resources/fonts/font-awesome.min.css">
   <link rel="stylesheet" href="${path }/resources/css/-Login-form-Page-BS4-.css">
      
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
   
   <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!--다음지도 api  -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
   <link rel="stylesheet" href="${path }/resources/css/socialHome.css?ver=11111">
</head>
<style>
	#profile{
		border-radius: 100px;
		width : 100px;
		height: 100px;
	}
</style>
<script>
function previewFile() {
	  var preview = document.querySelector('img');
	  var file    = document.querySelector('input[type=file]').files[0];
	  var reader  = new FileReader();
	  var ext = file.name.split(".").pop().toLowerCase();
	  if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
		  $('#profileFile').val("");
		  $('#profile').attr("src","${path }/resources/profileImg/profileDefault.png");
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
<body>
   <div class="container-fluid">
        <div class="row mh-100vh">
           <div class="col-10 col-sm-8 col-md-6 col-lg-6 offset-1 offset-sm-2 offset-md-3 offset-lg-0 align-self-center d-lg-flex align-items-lg-center align-self-lg-stretch bg-white p-5 rounded rounded-lg-0 my-5 my-lg-0" id="login-block">
             <div class="m-auto">
             <form action="${path }/member/addInfoUpdate.do" method="POST" enctype="multipart/form-data">
             <input type="hidden" name="memberEmail" value="${memberLoggedIn.memberEmail }">
                 <h2 class="text-info font-weight-light mb-5"><i class="fa fa-diamond"></i>추가정보</h2>
                 
                  <div class="form-row profile-row">
                <div class="col-md-8">
                	<h3>프로필 사진</h3>
                	<img src="${path }/resources/profileImg/profileDefault.png" height="200" alt="이미지 미리보기..." id="profile">
                	<input type="file" onchange="previewFile()" class="form-control" id="profileFile" name="profileFile1">
					
                </div>
                <div class="col-md-8">
                
                    <hr>
                       <h3>관심분야</h3>
                    <div class="form-row">
                       <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck" name="memberConcern" value="여행">
                        <label class="custom-control-label" for="customCheck">여행</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck1" name="memberConcern" value="예술">>
                        <label class="custom-control-label" for="customCheck1">예술</label>
                   </div>
                   &nbsp;&nbsp;
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck2" name="memberConcern" value="문화">>
                        <label class="custom-control-label" for="customCheck2">문화</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck3" name="memberConcern" value="건강">>
                        <label class="custom-control-label" for="customCheck3">건강</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck4" name="memberConcern" value="패션">>
                        <label class="custom-control-label" for="customCheck4">패션</label>
                   </div>
                   &nbsp;&nbsp;
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck5" name="memberConcern" value="뷰티">>
                        <label class="custom-control-label" for="customCheck5">뷰티</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck6" name="memberConcern" value="스포츠">>
                        <label class="custom-control-label" for="customCheck6">스포츠</label>
                   </div>
                   &nbsp;&nbsp;
                    <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck7" name="memberConcern" value="푸드">>
                        <label class="custom-control-label" for="customCheck7">푸드</label>
                   </div> <br>
                        &nbsp;&nbsp; 
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck8" name="memberConcern" value="리빙">>
                        <label class="custom-control-label" for="customCheck8">리빙</label>
                   </div> <br>
                        &nbsp;&nbsp;
                   <div class="custom-control custom-checkbox mb-3">
                        <input type="checkbox" class="custom-control-input" id="customCheck9" name="memberConcern" value="재태크">>
                        <label class="custom-control-label" for="customCheck9">재태크</label>
                   </div> <br>
                        &nbsp;&nbsp;     
                         </div> 
                         
                   <div class="form-row">
	                   <label>성별:</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                   <div class="custom-control custom-radio">
	                              <input type="radio" class="custom-control-input" id="gender0" name="memberGender" value="남">>
	                        <label class="custom-control-label" for="gender0">남</label>
	                   </div>    
	                   &nbsp;&nbsp;
	                    <div class="custom-control custom-radio">
	                              <input type="radio" class="custom-control-input" id="gender1" name="memberGender" value="여">>
	                        <label class="custom-control-label" for="gender1">여</label>
	                   </div>    
                  
                   	</div> <!-- 성별 위 form-row -->
                  
                     &nbsp;&nbsp;
                    <div class="form-row">
                       <label>생년월일 </label>
                       <input class="form-control" type="date" max="2020-12-31" min="1900-01-01" autocomplete="off" required="" name="memberBirthday">
                    </div>
                    
                    <br><br>
                    
                   
  
                   <div class="form-group">                   
<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="addr1" id="addr1" type="text" readonly="readonly" >
    <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
</div>
<div class="form-group">
    <input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="addr2" id="addr2" type="text" readonly="readonly" />
</div>
<div class="form-group">
    <input class="form-control" placeholder="상세주소" name="addr3" id="addr3" type="text"  />
</div>

                    <hr>
                    <div class="form-row">
                       <!--  <div class="col-md-12 content-right">    -->
                     <button class="btn btn-info mt-2" type="submit">등록</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <button class="btn btn-info mt-2" onclick="checkModal()">건너뛰기</button>
                   </div>
                   </form>
                    <!-- </div> -->      
                </div>
            </div>
               </div>
         </div>
            <div class="col-lg-6 d-flex align-items-end" id="bg-block" style="background-image:url(&quot;${path }/resources/img/mainImg.jpg&quot;);background-size:cover;background-position:center center;">
                <p class="ml-auto small text-dark mb-2"><em>My Jarvis&nbsp;</em><a href="https://unsplash.com/photos/v0zVmWULYTg?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText" target="_blank" class="text-dark"><em>Aldain Austria</em></a><br></p>
            </div>
        </div>
    </div>
<!-- 건너뛰기 확인 Modal -->
<div class="modal" id="checkMessage">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Warning!</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form action="${path }/member/notDoAddInfo.do" id="inputFrm">
        	<p>추가 정보를 입력하지 않으시면 사용자에게 맞는 추천서비스를 이용하실 수 없습니다.<br>
        	이후 내용은 개인정보수정 메뉴에서 작성이 가능합니다.<br> 건너뛰시겠습니까?
        </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      
      <button type="submit" class="btn btn-success" data-dismiss="modal" onclick="fn_next()">네,다음에할게요</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal">지금 하고갈게요</button>
       </div>
    </div>
  </div>
</div>
<script>
   function checkModal(){
	   $("#checkMessage").modal('show');
   }
    //다음 API
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
  
   

</body>
</html>