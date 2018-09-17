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
		/* console.log('${selectRoom}'); */
		/* var msg = $("#message").val();
		if(msg != ""){
			  message = {};
		  	  message.room_no = ${selectRoom.room_no};
			  message.message_contents = $("#message").val();
		  } */
		var message = new Array();
		message[0] = $("#message").val();
		message[1] = ${selectRoom.room_no};
		sock.send(message);
		/* if('${memberLoggedIn.getMemberEmail()}'=='${selectRoom.getMy_email()}'||'${memberLoggedIn.getMemberEmail()}'=='${selectRoom.getFriend_email()}'){ */
			/* sock.send($('#message').val()); */
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
					var printHTML="<div class='outgoing_msg'>";
					printHTML+="<div class='sent_msg'>";
					printHTML+="<p>"+message+"</p>";
					printHTML+="<span class='time_date'> "+ printHour+" | "+printDate+"</span>";
					printHTML+="</div></div>";
					$("#chatdata").append(printHTML);
				}
				else alert("메세지를 입력하세요");
			}
			else
			{
				if(message!=null && message!=""){
					//타인의 메세지
					var printHTML="<div class='incoming_msg'>"
					printHTML+="<div class='incoming_msg_img'>";
					printHTML+="<img src='${path}/resources/profileImg/profileDefault.png' class='rounded-circle' title='"+userName+"'>";
					printHTML+="<div class='received_msg'>";
					printHTML+="<div class='received_withd_msg'>";
					printHTML+="<p>"+message+"</p>";
					printHTML+="<span class='time_date'> "+ printHour+" | "+printDate+"</span>";
					printHTML+="</div></div></div>";
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
		}
	};
	function onClose()
	{
		location.href='${pageContext.request.contextPath}';
		self.close();
	}
</script>
<style>
.container{max-width:1170px; margin:auto;}
img{ max-width:100%;}
.inbox_people {
  background: #f8f8f8 none repeat scroll 0 0;
  float: left;
  overflow: hidden;
  width: 40%; border-right:1px solid #c4c4c4;
  border-left:1px solid #c4c4c4;
}
.inbox_msg {
  border: 1px solid #c4c4c4;
  clear: both;
  overflow: hidden;
}
.top_spac{ margin: 20px 0 0;}


.recent_heading {float: left; width:40%;}
.srch_bar {
  display: inline-block;
  text-align: right;
  width: 60%; padding:
}
.headind_srch{ padding:10px 29px 10px 20px; overflow:hidden; border-bottom:1px solid #c4c4c4;}

.recent_heading h4 {
  color: #05728f;
  font-size: 21px;
  margin: auto;
}
.srch_bar input{ border:1px solid #cdcdcd; border-width:0 0 1px 0; width:80%; padding:2px 0 4px 6px; background:none;}
.srch_bar .input-group-addon button {
  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
  border: medium none;
  padding: 0;
  color: #707070;
  font-size: 18px;
}
.srch_bar .input-group-addon { margin: 0 0 0 -27px;}

.chat_ib h5{ font-size:15px; color:#464646; margin:0 0 8px 0;}
.chat_ib h5 span{ font-size:13px; float:right;}
.chat_ib p{ font-size:14px; color:#989898; margin:auto}
.chat_img {
  float: left;
  width: 11%;
}
.chat_ib {
  float: left;
  padding: 0 0 0 15px;
  width: 88%;
}

.chat_people{ overflow:hidden; clear:both;}
.chat_list {
  border-bottom: 1px solid #c4c4c4;
  margin: 0;
  padding: 18px 16px 10px;
}
.inbox_chat { height: 550px; overflow-y: scroll;}

.active_chat{ background:#ebebeb;}

.incoming_msg_img {
  display: inline-block;
  width: 6%;
}
.received_msg {
  display: inline-block;
  padding: 0 0 0 10px;
  vertical-align: top;
  width: 92%;
 }
 .received_withd_msg p {
  background: #ebebeb none repeat scroll 0 0;
  border-radius: 3px;
  color: #646464;
  font-size: 14px;
  margin: 0;
  padding: 5px 10px 5px 12px;
  width: 100%;
}
.time_date {
  color: #747474;
  display: block;
  font-size: 12px;
  margin: 8px 0 0;
}
.received_withd_msg { width: 57%;}
.mesgs {
  float: left;
  padding: 30px 15px 0 25px;
  width: 60%;
}

 .sent_msg p {
  background: #05728f none repeat scroll 0 0;
  border-radius: 3px;
  font-size: 14px;
  margin: 0; color:#fff;
  padding: 5px 10px 5px 12px;
  width:100%;
}
.outgoing_msg{ overflow:hidden; margin:26px 0 26px;}
.sent_msg {
  float: right;
  width: 46%;
}
.input_msg_write input {
  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
  border: medium none;
  color: #4c4c4c;
  font-size: 15px;
  min-height: 48px;
  width: 100%;
}

.type_msg {border-top: 1px solid #c4c4c4;position: relative;}
.msg_send_btn {
  background: #05728f none repeat scroll 0 0;
  border: medium none;
  border-radius: 50%;
  color: #fff;
  cursor: pointer;
  font-size: 17px;
  height: 33px;
  position: absolute;
  right: 0;
  top: 11px;
  width: 33px;
}
.messaging { padding: 0 0 50px 0;}
.msg_history {
  height: 516px;
  overflow-y: auto;
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
			<div class="row" style="padding: 10px; height: 40px;">
				<div class="col-2">
					<strong>Messenger</strong>
				</div>
				<div id="friend_join" class="col-10"></div>
			</div>
			<div class="messaging">
				<div class="inbox_msg">
					
					
					<!-- 채팅창 -->
					<div class="mesgs">
						<div class="msg_history">
							<div id="chatdata" class="panel-body">
								<div class="incoming_msg">
									<div class="incoming_msg_img">
										<img src="https://ptetutorials.com/images/user-profile.png" alt="sunil">
									</div>
									<div class="received_msg">
										<div class="received_withd_msg">
											<p>Test which is a new approach to have all solutions</p>
											<span class="time_date"> 11:01 AM | June 9</span>
										</div>
									</div>
								</div>
								<div class="outgoing_msg">
									<div class="sent_msg">
										<p>Test which is a new approach to have all solutions</p>
										<span class="time_date"> 11:01 AM | June 9</span>
									</div>
								</div>
							</div>
						</div>
						<div class="type_msg">
							<div class="input_msg_write">
								<input type="text" class="write_msg" id="message" placeholder="메세지를 입력하세요..." />
								<button class="msg_send_btn" type="button" id="sendBtn">
									<i class="fa fa-paper-plane-o" aria-hidden="true"></i>
								</button>
							</div>
						</div>
					</div>

					<!-- 친구목록 -->
					<div class="inbox_people">
						<div class="headind_srch">
							<div class="recent_heading">
								<h4>Friend</h4>
							</div>
							<div class="srch_bar">
								<div class="stylish-input-group">
									<input type="text" class="search-bar" placeholder="Search">
									<span class="input-group-addon">
										<button type="button">
											<i class="fa fa-search" aria-hidden="true"></i>
										</button>
									</span>
								</div>
							</div>
						</div>
						<div class="inbox_chat p-0">
							<c:forEach items="${roomList }" var="r">
								<div class="chat_list active_chat p-0">
									<a href="${path}/chat/createRoom?fEmail=${r.MEMBER_EMAIL}" class="p-0">
										<div class="chat_list active_chat">
											<div class="chat_people">
												<div class="chat_img">
													<img src="${path}/resources/profileImg/${r.MEMBER_PFP}" class="w3-circle" title="${r.MEMBER_NAME }">
												</div>
												<div class="chat_ib">
													<h5>${r.MEMBER_NAME}
														<span class="chat_date">Dec 25</span>
													</h5>
													<p>Test, which is a new approach to have all solutions
														astrology under one roof.</p>
												</div>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
							<c:forEach items="${roomList1 }" var="r1">
								<div class="chat_list p-0">
									<a href="${path}/chat/createRoom?fEmail=${r1.MEMBER_EMAIL}" class="p-0">
										<div class="chat_list active_chat">
											<div class="chat_people">
												<div class="chat_img">
													<img src="${path}/resources/profileImg/${r1.MEMBER_PFP}" class="w3-circle" title="${r1.MEMBER_NAME }">
												</div>
												<div class="chat_ib">
													<h5>${r1.MEMBER_NAME}
														<span class="chat_date">Dec 25</span>
													</h5>
													<p>Test, which is a new approach to have all solutions
														astrology under one roof.</p>
												</div>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>

							<c:forEach items="${friendList}" var="f">
								<div class="chat_list p-0">
									<a href="${path}/chat/createRoom?fEmail=${f.MEMBER_EMAIL}" class="p-0">
										<div class="chat_list active_chat">
											<div class="chat_people">
												<div class="chat_img">
													<img src="${path}/resources/profileImg/${f.MEMBER_PFP}" class="w3-circle" title="${f.MEMBER_NAME }">
												</div>
												<div class="chat_ib">
													<h5>${f.MEMBER_NAME}
														<span class="chat_date">Dec 25</span>
													</h5>
													<p>Test, which is a new approach to have all solutions
														astrology under one roof.</p>
												</div>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
							<c:forEach items="${friendList1}" var="f1">
								<div class="chat_list p-0">
									<a href="${path}/chat/createRoom?fEmail=${f1.MEMBER_EMAIL}" class="p-0">
										<div class="chat_list active_chat">
											<div class="chat_people">
												<div class="chat_img">
													<img src="${path}/resources/profileImg/${f1.MEMBER_PFP}" class="w3-circle" title="${f1.MEMBER_NAME }">
												</div>
												<div class="chat_ib">
													<h5>${f1.MEMBER_NAME}
														<span class="chat_date">Dec 25</span>
													</h5>
													<p>Test, which is a new approach to have all solutions
														astrology under one roof.</p>
												</div>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


</body>
</html>