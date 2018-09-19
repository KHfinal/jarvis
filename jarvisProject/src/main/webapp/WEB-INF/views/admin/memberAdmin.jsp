<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="w3-col m1"><br></div>
	<div class="w3-col m7">
		
		<p>회원 검색 : 
		<select id="column">
			<option value="member_email">이메일</option>
			<option value="member_name">이름</option>
			<option value="addr2">주소</option>
		</select>		
		
		<input type="text" id="keyword">
		<button type="button" onclick="search()">검색</button>
		</p>
		<table class="table table-hover" id="table">
		</table>
	</div>
	

<div class="modal" id="lock">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원 정지</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form action="${path }/admin/memberLock.do" id="inputFrm" onsubmit="return fn_validata();">
        	<input type="hidden" name="memberNo" id="memberNo">
	        <table class="table">
	        	<tr >
	        		<th> 정지 일 수  </th>
	        		<td><input class="form-control" type="number" name="inputNo" id="inputNo"></td>
	        	</tr>
	        	
	        </table>
        </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" class="btn btn-success" data-dismiss="modal" onclick="fn_submit();">수정</button>
        <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>
<script>
$(function(){
	//맨처음 들어오면 ajax통신을 통해 전체 회원을 조회한다.
	$.ajax({
		url:"${pageContext.request.contextPath}/admin/selectAllmember.do",
		datatype: "json",
		type: "POST",
		success : function(data){
			console.log("ajax통신성공");
			var json = JSON.parse(data);
			console.log(json);
			var content="<tr>"
				+"<th>회원이메일</th>"
				+"<th>회원이름</th>"
				+"<th>성별</th>"
				+"<th>전화번호</th>"
				+"<th>주소</th>"
				+"<th><button class='right-align btn' onclick='refresh()'>새로고침</button></th>"
			+"</tr>";
			for(var i=0;i<json.length;i++){
				if(json[i].memberEmail!='admin'){
					content+="<tr><td>"+json[i].memberEmail+"</td>";
					content+="<td>"+json[i].memberName+"</td>";
					content+="<td>"+json[i].memberGender+"</td>";
					content+="<td>"+json[i].phone+"</td>";
					content+="<td>"+json[i].addr2+"</td>";
					if(json[i].blockDate==null){
						content+="<td><button class='btn btn-success' onclick='lock("+json[i].memberNo+")'>회원정지</button></td>";
					}else{
						content+="<td><button class='btn btn-danger' onclick='unlock("+json[i].memberNo+")'>정지해제</button></td>";
					}
				}
			}
			
			$("#table").html(content);
		},
		error : function(xhr,status,errormsg){
			console.log(xhr);
			console.log(status);
			console.log(errormsg);
			console.log("ajax통신실패")
		}
	});
	
});
	function lock(no){
		$("#lock").modal();
		$("#memberNo").val(no);
	};
	function unlock(no){
		location.href="${path}/admin/memberUnlock.do?memberNo="+no;
	}
	function refresh(){
		location.href="${path}/admin/unlock.do";
	}
	function fn_validata(){
		if($("#inputNo").val()==0){
			alert("일 수를 입력해주세요");
			return false;
		}
		if($("#inputNo").val()<0){
			alert("양수를 입력해주세요");
			return false;
		}
		console.log($("#inputNo").val());
		console.log($("#memberNo").val());
		return true;
	};
	function fn_submit(){
		$("#inputFrm").submit(); 
	}
	
	function search(){
		var col = $("#column").val();
		var word= $("#keyword").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/admin/searchMember.do",
			data:{type:col,keyword:word},
			datatype: "json",
			type: "POST",
			success : function(data){
				console.log("ajax통신성공");
				var json = JSON.parse(data);
				console.log(json);
				var content="<tr>"
					+"<th>회원이메일</th>"
					+"<th>회원이름</th>"
					+"<th>성별</th>"
					+"<th>전화번호</th>"
					+"<th>주소</th>"
					+"<th><button class='right-align btn' onclick='refresh()'>새로고침</button></th>"
				+"</tr>";
				for(var i=0;i<json.length;i++){
					if(json[i].memberEmail!='admin'){
						content+="<tr><td>"+json[i].memberEmail+"</td>";
						content+="<td>"+json[i].memberName+"</td>";
						content+="<td>"+json[i].memberGender+"</td>";
						content+="<td>"+json[i].phone+"</td>";
						content+="<td>"+json[i].addr2+"</td>";
						if(json[i].blockDate==null){
							content+="<td><button class='btn btn-success' onclick='lock("+json[i].memberNo+")'>회원정지</button></td>";
						}else{
							content+="<td><button class='btn btn-danger' onclick='unlock("+json[i].memberNo+")'>정지해제</button></td>";
						}
					}
				}
				
				$("#table").html(content);
			},
			error : function(xhr,status,errormsg){
				console.log(xhr);
				console.log(status);
				console.log(errormsg);
				console.log("ajax통신실패")
			}
		});
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>