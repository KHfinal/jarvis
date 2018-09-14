<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set value="<%=request.getContextPath()%>" var="path"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="social" name="title"/>
</jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script>
//SocketJS 채팅구현
var sock=new SockJS("<c:url value='/chatting'/>")
	sock.onmessage=onMessage;
	sock.onclose=onClose;
	
var today=null;

	$(function(){
		//전송버튼을 눌렀을때 이벤트 처리
		$('#sendBtn').click(function(){
			sendMessage();//우리가 구현할 함수
			$('#message').val('');
			$("#message").focus();
			$("#chatdata").animate({
				scrollTop: $('#chatdata').get(0).scrollHeight
			}, 10);
		});
		$('#exitBtn').click(function(){
			sock.onclose();
		});
	});
	function leadingZeros(n, digits) {
		   var zero = '';
		   n = n.toString();

		   if (n.length < digits) {
		     for (i = 0; i < digits - n.length; i++)
		       zero += '0';
		   }
		   return zero + n;
	}

	function sendMessage()
	{
		console.log('${selectRoom}');
		
		/* if('${memberLoggedIn.getMemberEmail()}'=='${selectRoom.getMy_email()}'||'${memberLoggedIn.getMemberEmail()}'=='${selectRoom.getFriend_email()}'){ */
			sock.send($('#message').val());
		/* } */
		
		//handler객체 거기의 handlerTextMessage메소드가 실행
	};
	function onMessage(evt)
	{
		console.log("----------------------");
		var data=evt.data;//TextMessage생성 매게변수(아이디|값|아이피)
		var host=null;
		var strArray=data.split("|");
		var userName=null;
		var message=null;
		for(i=0;i<strArray.length;i++)
		{
			console.log("strArray["+i+"] : "+strArray[i]);	
		}
		
		if(strArray.length>1)
		{
			//실제 채팅메세지
			userName=strArray[0];//접속자 아이디
			message=strArray[1];//전송내용
			host=strArray[2].substr(1,strArray[2].indexOf(":")-1);//실제아이피주소만 남기기
			today=new Date();
			printDate=today.getFullYear()+"년 "+leadingZeros(today.getMonth(),2)+"월 "+today.getDate()+"일";
			printHour=leadingZeros(today.getHours(),2)+":"+leadingZeros(today.getMinutes(),2);
			console.log(printDate);
			
			var ck_host='${host}';
			console.log("host"+host);
			console.log("ck_host"+ck_host);
			
			if(host==ck_host||(host==0&&ck_host.includes('0:0:')))
			{
				if(message!=null && message!=""){
					var printDate="<div class='messageDate' style='margin-left:45%;'><sub>"+printDate+"</sub></div>";					
					var printHTML="<div class='well' style='float: right;'>";
					printHTML+="<div style='display:inline-block;'><sub>"+printHour+"</sub></div>";
					printHTML+="<div class='alert alert-primary p-1 mb-1 mr-2 ml-2' style='display:inline-block;'>";
					printHTML+="<strong>"+message+"</strong>";
					printHTML+="</div>";
					printHTML+="</div><br/><br/>";
					
					$("#chatdata").append(printDate);
					$("#chatdata").append(printHTML);
				}
				else alert("메세지를 입력하세요");
			}
			else
			{
				if(message!=null && message!=""){
					//타인의 메세지
					var printDate="<div class='messageDate' style='margin-left:45%;'><sub>"+printDate+"</sub></div>";
					var printHTML="<img style='width:50px;height:50px;float: left;' src='${path}/resources/upload/profileImg/defaultmen.PNG' class='rounded-circle' data-toggle='tooltip' title='"+userName+"'>"
					printHTML+="<div class='well' style='float: left;'>";
					printHTML+="<div class='alert alert-secondary p-1 mb-1 ml-2 mr-2' style='display:inline-block;'>";
					printHTML+="<strong>"+message+"</strong>";
					printHTML+="</div>";
					printHTML+="<div style='display:inline-block;'><sub>"+printHour+"</sub></div>";
					printHTML+="</div><br/><br/>";
					$("#chatdata").append(printDate);
					$("#chatdata").append(printHTML);
				}
				else alert("메세지를 입력하세요");
			}
		}
		else
		{
			message=strArray[0];
			var printHTML="<strong>"+message+"</strong>";
			if(message==userName+"님이 접속중입니다")
				$("#friend_join").html(printHTML).css("color","green");
			else
				$("#friend_join").html(printHTML).css("color","red");
			//나가기 들어온 사람 알리기
			
			/* today=new Date();
			printDate=today.getFullYear()+"/"+today.getMonth()+"/"+today.getDate()+" "+today.getHours()+":"+today.getMinutes()+":"+today.getSeconds();
			message=strArray[0];
			var printHTML="<div class='well' style='margin-left:0%;margin-right:30%'>";
			printHTML+="<div class='alert alert-danger'>";
			printHTML+="<sub>"+printDate+"</sub><br/>";
			printHTML+="<strong>[서버관리자] : "+message+"</strong>";
			printHTML+="</div>";
			printHTML+="</div>";
			$("#chatdata").append(printHTML); */
		}
	};
	function onClose()
	{
		location.href='${pageContext.request.contextPath}';
		self.close();
	}
</script>
<style>
	div#chatdata{
		height:650px;
		overflow-x:hidden;
		overflow-y:auto;
	}
	div.chatting-cintainer{
		height:770px;
		border:1px solid lightgray;
		padding:0px;
	}
	div.chatContents{
		height: 87%;
	}
	div.chatInput-container{
		height: 9%;
		magin:0px;
		padding:0px;
	}
	textarea.chatInput{
		width:100%;
		height: 100%;
	}
</style>
<script>
$(document).ready(function(){
    $("#searchBtn").click(function(){
        $("#m_search").slideToggle();
    });
});
</script>
<div class="w3-col m9">
<div class="w3-card w3-round w3-white">
	<div class="w3-container">
		<div class="row"
			style="border: 1px solid lightgray; padding: 10px; height: 40px;">
			<div class="col-2">
				<strong>Messenger</strong>
			</div>
			<div id="friend_join" class="col-10"></div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<!-- 채팅창 -->
			<div class="chatting-cintainer col-9">
				<input id="m_search" class="ml-5 mt-3" type="text" placeholder="메세지 검색" style="width: 80%;">
				<button id="searchBtn" style="padding: 0;">
					<img src="${path }/resources/img/searchIcon.PNG" style="width: 30px; height: 30px;">
				</button>
				<div class="chatInput-container">
					<div class="panel panel-default" id="chat_panel">
						<div id="chatdata" class="panel-body"></div>
					</div>
					<div class="input-group">
						<textarea name="message" id="message" class="chatInput form-control" placeholder="메세지를 입력하세요.."></textarea>
						<div class="input-group-append">
							<%-- <button class="btn" style="background-color: white;" type="button">
								<img class="btn-img" src="${path }/resources/img/camera.png" style="width: 50px; height: 50px;">
							</button> --%>
							<button class="btn btn-primary" type="button" id='sendBtn'>보내기</button>
						</div>
					</div>
				</div>

			</div>
			<!-- 친구목록 -->
			<div class="chatting-cintainer col-3 pl-2 pr-2 pt-3" style="overflow:auto; height:760px;">
				<form action="${path}/friend/selectOneFriend.do">
					<input type="text" id="friendSearch"
						class="form-control form-control-sm mb-2" placeholder="친구검색">
					<input type="submit" value="검색" />
				</form>
				<div class="list-group">
					<c:forEach items="${friendList}" var="f">
						<a href="${path}/chat/chattingFriend?fEmail=${f}" class="list-group-item list-group-item-action">
							<img src="${path}/resources/upload/profileImg/defaultmen.PNG" class="w3-circle" style="height: 23px; width: 23px" alt="Avatar">&nbsp;
							${f}
						</a>
					</c:forEach>
				</div>
			</div>

		</div>
	</div>
</div>
</div>


</body>
</html>