<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var="path" value="<%=request.getContextPath()%>"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="private" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${path }/resources/fullcalendar/fullcalendar.css">
<script src="${path }/resources/fullcalendar/moment.js"></script>
<script src="${path }/resources/fullcalendar/fullcalendar.js"></script>
<script src="${path }/resources/fullcalendar/gcal.js"></script>
<script src="${path }/resources/fullcalendar/ko.js"></script>
<style>
    .fc-sat { color:#0000FF; }     /* 토요일 */
    .fc-sun { color:#FF0000; }    /* 일요일 */
	.m8{
		margin-left: 5%;

	}
	@media ( max-width: 768px ){
		.m8{
			margin-left:0;
		}
	}
	
</style>
<div class="w3-col m8">
	<div id="calendar"></div>
</div>


<!-- 일정등록 Modal -->
<div class="modal" id="registration">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">일정 등록</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form action="${path }/schedule/insertSchedule.do" id="inputFrm">
        	<input type="hidden" name="userEmail" value="${memberLoggedIn.memberEmail }">
	        <table class="table">
	        	<tr >
	        		<th> 제목  </th>
	        		<td><input class="form-control" type="text" placeholder="일정을 입력하세요" name="title" id="title"></td>
	        	</tr>
	        	<tr>
	        		<th> 시작 날짜 </th>
	        		<td><input class="form-control" type="date" id="date_start" name = "startDate"></td>	        	
	        	</tr>
	        	<tr>
	        		<th> 종료 날짜 </th>
	        		<td><input class="form-control" type="date" id="date_end" name = "endDate"></td>
	        	</tr>
	        	<tr>
	        		<th> 내용  </th>
	        		<td> <textarea rows="5" name="content" id="content" class="form-control"></textarea></td>
	        	</tr>
	        	<tr>
	        		<th>색상</th>
	        		<td>
	        			<input type="radio" name="color" checked>일정
	        			<input type="radio" name="color" value="hotpink">할 일
							        		
	        		</td>
	        	</tr>
	        </table>
        </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button id="add" type="submit" class="btn btn-success" data-dismiss="modal" onclick="fn_validate()">등록</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>

<!-- 일정수정 Modal -->
<div class="modal" id="modify">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">일정</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form action="${path }/schedule/updateSchedule.do" id="modinputFrm">
        	<input type="hidden" name="sNo" id='sNo'>
	        <table class="table">
	        	<tr >
	        		<th> 제목  </th>
	        		<td><input class="form-control" type="text" placeholder="일정을 입력하세요" name="title" id="modtitle"></td>
	        	</tr>
	        	<tr>
	        		<th> 시작 날짜 </th>
	        		<td><input class="form-control" type="date" id="moddate_start" name = "startDate"></td>	        	
	        	</tr>
	        	<tr>
	        		<th> 종료 날짜 </th>
	        		<td><input class="form-control" type="date" id="moddate_end" name = "endDate"></td>
	        	</tr>
	        	<tr>
	        		<th> 내용  </th>
	        		<td> <textarea rows="5" name="content" id="modcontent" class="form-control"></textarea></td>
	        	</tr>
	        	<tr>
	        		<th>색상</th>
	        		<td>
	        			<input type="radio" name="color" id="default" checked>일정
	        			<input type="radio" name="color" id="color1" value="hotpink">할 일
							        		
	        		</td>
	        	</tr>
	        </table>
        </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" class="btn btn-success" data-dismiss="modal" onclick="fn_validateMod()">수정</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="fn_deleteEvent()">삭제</button>
        <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>
<script>
	//화면 호출과 동시에 달력을 불러오는 함수를 호출
	$(function(){
		calendarLoad();
	});
	//달력의 구성요소들을 로드하고 그에따라 달력을 출력한다.
	function calendarLoad(){
		$('#calendar').fullCalendar({
			//날짜 클릭이벤트 날짜를 클릭하면 일정등록가능
			dayClick: function(date){
				var year = date._d.getFullYear();
				var month = date._d.getMonth()<10 ? '0'+(date._d.getMonth()+1) : date._d.getMonth();
				var date1 = date._d.getDate()<10 ? '0'+date._d.getDate() : date._d.getDate();
				var day = year+"-"+month+"-"+date1;
				console.log(date);
				console.log(date._d.getHours());
				console.log(date._d.getMinutes());
				console.log(date._d.toISOString());
				$("#registration").modal("show");
				$("#date_start").val(day);
				$("#date_end").val(day);
				$("#content").val("");
				$("#title").val("");
			},
			//일정 클릭이벤트 일정을 클릭하면 내가 등록한 일정을 확인 할 수있고, 해당 일정을 삭제 할 수 있다.
			eventClick:function(event) {
				var userEmail = '${memberLoggedIn.memberEmail}';
				var title = event.title;
				var start = event.start._i;
				$.ajax({
	 				url:"${pageContext.request.contextPath}/schedule/selectOneEvent.do",
	 				data : {userEmail:userEmail,title:title,startDate:start},
	 				datatype: "json",
	 				type: "POST",
	 				success : function(data){
	 					console.log("ajax통신성공");
	 					var json = JSON.parse(data);
	 					console.log(json);
	 					console.log(json.end);
	 					var content = decodeURIComponent(json.content);
	 					$("#sNo").val(json.sNo);
	 					$("#moddate_end").val(json.end);
	 					$("#modcontent").val(content);
	 					if(json.color == "on"){
	 						$("#default").attr("checked",true);
	 					}
	 					else{
	 						$("#color1").attr("checked",true);
	 					}
	 				},
	 				error : function(xhr,status,errormsg){
	 					console.log(xhr);
	 					console.log(status);
	 					console.log(errormsg);
	 					console.log("ajax통신실패")
	 				}
				});
				$("#modtitle").val(event.title);
				$("#moddate_start").val(event.start._i);
				$("#modify").modal("show");
				
			},
			//일정 팝업창 일정이 어느정도 이상이면 more버튼을 클릭하여 일정을 확대하여 볼 수 있다.
			eventLimit: true, // for all non-agenda views
			  views: {
			    agenda: {
			      eventLimit: 6 // adjust to 6 only for agendaWeek/agendaDay
			    }
			 },
			googleCalendarApiKey:"AIzaSyB8U2-71YAEPsxssN8OG5hwI-64TLORxgQ",
			events:{
				googleCalendarId:"ko.south_korea#holiday@group.v.calendar.google.com",
				color:"#F5F7F8",
				textColor:"red"
			}
		});
		var e = ${events};
		$('#calendar').fullCalendar('addEventSource',e);
	}
	function fn_validate(){
		if($("#title").val().trim()==0){
			alert("일정 제목을 입력해주세요.");
			return false;
		}
		if($("#date_end").val() < $("#date_start").val()){
			alert("일정종료날짜가 시작날짜보다 작습니다.");
			return false;
		}
		console.log($("#date_start").val());
		console.log($("#date_end").val());
		
		$("#inputFrm").submit(); 
	};
	function fn_validateMod(){
		if($("#modtitle").val().trim()==0){
			alert("일정 제목을 입력해주세요.");
			return false;
		}
		if($("#moddate_end").val() < $("#moddate_start").val()){
			alert("일정종료날짜가 시작날짜보다 작습니다.");
			return false;
		}
		console.log($("#moddate_start").val());
		console.log($("#moddate_end").val());
		
		$("#modinputFrm").submit(); 
	};
	function fn_deleteEvent(){
		var sNo = $("#sNo").val();
		location.href="${path}/schedule/deleteEvent.do?sNo="+sNo;
	}
</script>