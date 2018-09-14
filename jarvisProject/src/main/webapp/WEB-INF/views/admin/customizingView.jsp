<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
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
<div class="w3-col m8">
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
		커스터마이징 영역입니다2
	
	</div>
	<div class="container"><br></div>
	<div class="container area">
		커스터마이징 영역입니다3
	
	</div>
	<div class="container"><br></div>
	<div class="container area">
		커스터마이징 영역입니다4
	
	</div>
</div>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>