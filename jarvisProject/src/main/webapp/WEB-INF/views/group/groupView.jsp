<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ page import="kh.mark.jarvis.member.model.vo.Member" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var="path" value="<%=request.getContextPath()%>"/>
<c:set var="loopFlag" value="false"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="social" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${path }/resources/css/socialHome.css?ver=15">


<script>

var sock=new SockJS("<c:url value='/groupchatting'/>")
sock.onmessage = onMessage;
sock.onclose = onClose;
sock.sendmessage=sendMessage;

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
		/* $('#exitBtn').click(function(){
			sock.onclose();
		}); */
		
		$('#search').keyup(function(){
			$.ajax({
				url:"${path}/friend/autoFriendList",
				type : "post",
				data : "search=" + $("#search").val(),
				dataType : "json",
				success : function(data) {
					var emailList=data.emailList;
					var emailList1=data.emailList1;
					var friendListTag="";
					if(emailList!=null)
					{
						for (var i = 0; i < emailList.length; i++) {
							friendListTag += "<div class='chat_list p-0'><a href='${path}/chat/createRoom?fEmail="+emailList[i].MEMBER_EMAIL+"' class='p-0'><div class='chat_list'><div class='chat_people'><div class='chat_img'><img src='${path}/resources/profileImg/"+emailList[i].MEMBER_PFP+"' class='w3-circle' title='"+emailList[i].MEMBER_NAME+"'></div><div class='chat_ib'><h5>"+emailList[i].MEMBER_NAME+"<span class='chat_date'></span></h5><p>"+emailList[i].MEMBER_NAME+"님과 Messenger에서 메시지를 주고받을 수 있습니다.</p></div></div></div></a></div>";
						}
					}
					if(emailList1!=null)
					{
						for (var i = 0; i < emailList1.length; i++) {
							friendListTag += "<div class='chat_list p-0'><a href='${path}/chat/createRoom?fEmail="+emailList1[i].MEMBER_EMAIL+"' class='p-0'><div class='chat_list'><div class='chat_people'><div class='chat_img'><img src='${path}/resources/profileImg/"+emailList1[i].MEMBER_PFP+"' class='w3-circle' title='"+emailList1[i].MEMBER_NAME+"'></div><div class='chat_ib'><h5>"+emailList1[i].MEMBER_NAME+"<span class='chat_date'></span></h5><p>"+emailList1[i].MEMBER_NAME+"님과 Messenger에서 메시지를 주고받을 수 있습니다.</p></div></div></div></a></div>";
						}
					}
					$('#inbox_chat').html(friendListTag);
				}
			});
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

	function sendMessage() {
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
		console.log("message : " + $("#message").val());
		console.log("message1" + message[0]);
		console.log("message2" + message[1]);
		console.log("${selectRoom.room_no}");
		sock.send(message);
		/* if('${memberLoggedIn.getMemberEmail()}'=='${selectRoom.getMy_email()}'||'${memberLoggedIn.getMemberEmail()}'=='${selectRoom.getFriend_email()}'){ */
		/* sock.send($('#message').val()); */
		/* } */

		//handler객체 거기의 handlerTextMessage메소드가 실행
	};
	function onMessage(evt) {
		console.log("----------------------");
		var data = evt.data;//TextMessage생성 매게변수(아이디|값|아이피)
		var host = null;
		var strArray = data.split("|");
		var userName = null;
		var message = null;
		var room_no = null;
		for (i = 0; i < strArray.length; i++) {
			console.log("strArray[" + i + "] : " + strArray[i]);
		}

		if (strArray.length > 1) {
			//실제 채팅메세지
			userName = strArray[0];//접속자 아이디
			message = strArray[1];//전송내용
			host = strArray[2].substr(1, strArray[2].indexOf(":") - 1);//실제아이피주소만 남기기
			room_no = strArray[3];//방번호
			today = new Date();
			printDate = today.getFullYear() + "년 "
					+ leadingZeros(today.getMonth(), 2) + "월 "
					+ today.getDate() + "일";
			printHour = leadingZeros(today.getHours(), 2) + ":"
					+ leadingZeros(today.getMinutes(), 2);
			console.log(printDate);

			var ck_host = '${host}';
			console.log("host" + host);
			console.log("ck_host" + ck_host);

			if (host == ck_host || (host == 0 && ck_host.includes('0:0:'))) {
				if (message != null && message != "") {
					if ('${selectRoom.room_no}' == room_no) {
						var printHTML = "<div class='outgoing_msg m-1'>";
						printHTML += "<div class='sent_msg'>";
						printHTML += "<p>" + message + "</p>";
						printHTML += "<span class='time_date'> " + printHour
								+ " | " + printDate + "</span>";
						printHTML += "</div></div>";
						$("#chatdata").append(printHTML);
					}
					/* var printHTML="<c:if test='"+room_no+"=="+${selectRoom.room_no}+"'>"
					printHTML+="<div class='outgoing_msg'>";
					printHTML+="<div class='sent_msg'>";
					printHTML+="<p>"+message+"</p>";
					printHTML+="<span class='time_date'> "+ printHour+" | "+printDate+"</span>";
					printHTML+="</div></div></c:if>";
					$("#chatdata").append(printHTML); */
				} else
					alert("메세지를 입력하세요");
			} else {
				if (message != null && message != "") {
					//타인의 메세지
					if ('${selectRoom.room_no}' == room_no) {
						var printHTML = "<div class='incoming_msg m-1'>"
						printHTML += "<div class='incoming_msg_img'>";
						printHTML += "<img src='${path}/resources/profileImg/profileDefault.png' class='rounded-circle' title='"+userName+"'></div>";
						printHTML += "<div class='received_msg'>";
						printHTML += "<div class='received_withd_msg'>";
						printHTML += "<p>" + message + "</p>";
						printHTML += "<span class='time_date'> " + printHour
								+ " | " + printDate + "</span>";
						printHTML += "</div></div></div>";
						$("#chatdata").append(printHTML);
					}
					/* var printHTML="<c:if test='"+room_no+"=="+${selectRoom.room_no}+"'>"
					printHTML+="<div class='incoming_msg'>"
					printHTML+="<div class='incoming_msg_img'>";
					printHTML+="<img src='${path}/resources/profileImg/profileDefault.png' class='rounded-circle' title='"+userName+"'>";
					printHTML+="<div class='received_msg'>";
					printHTML+="<div class='received_withd_msg'>";
					printHTML+="<p>"+message+"</p>";
					printHTML+="<span class='time_date'> "+ printHour+" | "+printDate+"</span>";
					printHTML+="</div></div></div></c:if>";
					$("#chatdata").append(printHTML); */
				} else
					alert("메세지를 입력하세요");
			}
		} else {
			message = strArray[0];
			var printHTML = "<strong>" + message + "</strong>";
			if (message == userName + "님이 접속중입니다")
				$("#friend_join").html(printHTML).css("color", "green");
			else
				$("#friend_join").html(printHTML).css("color", "red");
		}
	};
	function onClose() {
		location.href = '${pageContext.request.contextPath}';
		self.close();
	}

function readURL(input) {
   for(var i=0; i<input.files.length; i++) {
       if (input.files[i]) {
          var reader = new FileReader();
   
          reader.onload = function (e) {
             var img = $('<img id="imgDisplay" class="img-thumbnail">');
             img.attr('src', e.target.result);
             img.appendTo('#imgDisplayContainer');
          }
          reader.readAsDataURL(input.files[i]);
       }
   }
}

//게시글 수정
function updateReadURL(input) {
   for(var i=0; i<input.files.length; i++) {
       if (input.files[i]) {
          var reader = new FileReader();
   
          reader.onload = function (e) {
             var img = $('<img id="imgDisplayUpdate" class="img-thumbnail">');
             img.attr('src', e.target.result);
             img.appendTo('#imgDisplayUpdateContainer');
          }
          reader.readAsDataURL(input.files[i]);
       }
   }
}


$(function() {
	 // 게시글 등록
	 $("#imgInput").on('change', function(){
	    ext = $(this).val().split(".").pop().toLowerCase(); 
	    
	    if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
	       resetFormElement($(this)) // resetFormElement실행
	       alert('이미지 파일이 아닙니다.');
	    } else {
	       readURL(this);   
	    }
	 });
	 
	// 게시글 수정
    $("#imgUpdateInput").on('change', function(){
       ext = $(this).val().split(".").pop().toLowerCase(); 
       
       if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
          resetFormElement($(this)) // resetFormElement실행
          alert('이미지 파일이 아닙니다.');
       } else {
          updateReadURL(this);   
       }
    });
	
	/* 댓글 input 엔터 이벤트 */
	$('.inputCommentTxt').keydown(function(e) {
	   if(e.keyCode == 13) {
	      $('.createCommentFrm').submit();
	   }
	});
	
	/* reply 아이콘 클릭. 답글 달기! */ 
	$('.replyDisplay').hide();
	$('.inputReplyIcon').click(function() {
	 $('.replyDisplay').show();
	   
	   /* var replyPostRef = $('#reply_postRef').val(); */
	   var replyPostRef = $(this).attr("title");
	   var replyCommentRef = $(this).val();
	   
	   var div = $("<div class='replyInput'></div>");
	   
	   console.log(replyPostRef);
	   console.log(replyCommentRef);
	   
	   /* 답글 입력 */
	   var html = "<form class='createCommentFrm' method='post' action='${path }/group/postCommentInsert.do?groupNo=${groupNo}'>";
	   html += "<input type='hidden' name='g_comment_writer' value='${memberLoggedIn.getMemberEmail() }'/>";
	   html += "<input type='hidden' name='g_post_ref' value='" + replyPostRef + "'/>";
	   html += "<input type='hidden' name='g_comment_level' value='2'/>";
	   html += "<input type='hidden' name='g_comment_ref' value='" + replyCommentRef + "'/>";
	   html += "<span><img class='replyProfile rounded-circle' src='${path }/resources/upload/post/20180030_210021127_730.jpg'></span>";
	   html += "<input type='text' name='g_comment_contents' class='inputReplyTxt form-control' placeholder=' 답글을 입력하세요...'/>";
	   html += "<div style='clear: both'></div></form>";
	   
	   div.html(html);
	   
	   div.appendTo($(this).parent().children('.reply-container'));
	   
	   $(this).off('click');
	   
	});
   
    /* 답글 삽입 스크립트 */
    $('.replyDisplay').each(function() {
       var reply=$(this);
       
       $('.replyDisplay-container').each(function(){
         
          if($(this).attr('id') == reply.attr('title')) {
             $(this).append(reply);
          }
       });
    });


/* 하트... */
$.ajax({
   type: "POST",
   url: "${pageContext.request.contextPath}/group/startLike.do",
   contentType : "application/x-www-form-urlencoded; charset=utf-8",
   dataType : "json",
     
   success: function(data) {
       
       var like = data.myLikeOnList;
       var count = data.startLikeCount;
       /* var postCnt = data.startPostCount;
       var commentCnt = data.startCommentCount; */
       
       $.each(like, function(idx, value) {
             
             if($('.likeBtn[title=' + value.postRef + ']').attr('title') == value.postRef && value.likeCheck == 1) {
                $('.likeBtn[title=' + value.postRef + ']').children().removeClass();
                 $('.likeBtn[title=' + value.postRef + ']').children().addClass('fas fa-heart like');
             }
             
             if($('.likeCommentBtn[title=' + value.commentRef + ']').attr('title') == value.commentRef && value.likeCheck == 2) {
                $('.likeCommentBtn[title=' + value.commentRef + ']').children().removeClass();
                 $('.likeCommentBtn[title=' + value.commentRef + ']').children().addClass('fas fa-heart like');
             }
       });
       
       $.each(count, function(idx, val) {
           if($('.likePostCount-container[title=' + val.POST_REF + ']').attr('title') == val.POST_REF && val.LIKE_CHECK == 1) {
               var html = "<p class='likeCount'>" + val.CNT + "</p>";
                  $('.likePostCount-container[title=' + val.POST_REF + ']').html(html);
             }
           
           if($('.likeCommentCount-container[title=' + val.COMMENT_REF + ']').attr('title') == val.COMMENT_REF && val.LIKE_CHECK == 2) {
               var html = "<p class='likeCount'>" + val.CNT + "</p>";
                  $('.likeCommentCount-container[title=' + val.COMMENT_REF + ']').html(html);
            }
       });

   },
   
   error: function(xhr, status, errormsg) {
      console.log(xhr);
      console.log(status);
      console.log(errormsg);
   }
});

});

function fn_postLike(e) { /* 좋아요 전송 */
	
	var likeFrm = $(e).next($('.likeFrm'));
	var btn = $(e)
	var likeUrl;
	
	console.log("무슨 넘버?? : " + btn.attr('title'));
	console.log("떠라 ~~ " + likeFrm.children('.postRef').val());
	
	   
	   if(btn.children().attr('class').includes('far')){
	      btn.children().removeClass();
	      btn.children().addClass('fas fa-heart like');
	      likeUrl = "${pageContext.request.contextPath}/group/likeInsertAndSelect.do";
	   }
	   
	   else{
	      btn.children().removeClass();
	      btn.children().addClass('far fa-heart like');
	      likeUrl="${pageContext.request.contextPath}/group/likeDeleteAndSelect.do";
	   }
	
	$.ajaxSettings.traditional = true;
	$.ajax({
		type: "POST",
		url: likeUrl,
		data: {
			g_like_member : likeFrm.children('.likeMember').val(),
			g_post_ref : likeFrm.children('.postRef').val(),
			g_comment_ref : likeFrm.children('.commentRef').val(),
			g_like_check : likeFrm.children('.likeCheck').val()
		},
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
	    dataType : "json",
        
		success: function(data) {
			var likeMember;
			var postRef;
			var commentRef;
			var likeCheck;

			$.each(data.likeList, function(i, item) {
				likeMember = item.g_like_member;
				postRef = item.g_post_ref;
				commentRef = item.g_comment_ref;
				likeCheck = item.g_like_check;
			})
			
			console.log("member"+likeMember);
			console.log("post"+postRef);
			console.log("comment"+commentRef);
			console.log("like"+likeCheck);
			
			if(data.count == 0 || likeFrm.children('.postRef').val() == postRef && likeFrm.children('.likeCheck').val() == 1) {
	               var html = "<p class='likeCount'>" + data.count + "</p>";
	               likeFrm.next($('.likePostCount-container')).html(html);
	            }
	            
	            if(data.count == 0 || likeFrm.children('.commentRef').val() == commentRef && likeFrm.children('.likeCheck').val() == 2) {
	               var html = "<p class='likeCount'>" + data.count  + "</p>";
	               likeFrm.next($('.likeCommentCount-container')).html(html);
	            } 
	      },
		
		error: function(xhr, status, errormsg) {
			console.log(xhr);
			console.log(status);
			console.log(errormsg);
		}
	})
	/* $(e).parent().submit(); */
}


function fn_subMenu(e) {
	   var btn = $(e);
	   var subMenu = $(e).next('.subMenu-container');
	   
	   console.log("클릭 버튼의 postNo = " + btn.attr('title'));
	   
}

</script>
<c:if test="${groupMemberCheck.G_MEMBER_STATUS eq 'Y' }">
	<div class="w3-col m6">
	<!-- 게시글 등록 미리보기. 클릭시 #postModal이 연결 돼 실제 입력창 나타난다. -->
	<div id="createPostContainer" data-toggle="modal" data-target="#postModal">
	   <div class="modal-header">
	      <h4 class="modal-title">Welcome to Jarvis</h4>
	      <button type="button" class="close" data-dismiss="modal">&times;</button>
	   </div>
	   
	   <div class="modal-body">
	      <textarea rows="5" id="fakePostContents" class="form-control" name="g_post_contents" placeholder="문구 입력..." disabled></textarea>
	   </div>
	</div>
	
	
	<!-- 게시글 등록 -->
	<div class="modal fade" id="postModal">
	   <div class="modal-dialog modal-lg">
	      <div class="modal-content">
	         
	         <!-- Modal Header -->
	         <div class="modal-header">
	            <h4 class="modal-title">게시물 올리기</h4>
	            <button type="button" class="close" data-dismiss="modal">&times;</button>
	         </div>
	                     
	         <!-- Modal body -->
	         <form id="createPostFrm" method="post" action="${path }/group/insertGroupPost.do?g_no=${groupNo}" enctype="multipart/form-data">
	            <div class="modal-body">
	               <input type="hidden" id="postWriter" name="g_post_writer" value="${memberLoggedIn.getMemberEmail() }"/>
	               <textarea class="form-control" rows="5" id="postContents" name="g_post_contents" placeholder="문구 입력..."></textarea>
	               <hr>
	               
	               <!-- 이미지 업로드 -->
	               <div id="imgDisplayContainer"></div>
	               <hr>
	               <div class="filebox"> <label for="imgInput">업로드</label> <input type="file" id="imgInput" name="upFile" multiple> </div>
	            </div>
	            
	            <!-- Modal footer -->
	            <div class="modal-footer">
	               <button type="submit" class="btn btn-primary text-center">등록하기</button>
	               <input type="reset" class="btn btn-danger text-center" value="취소" data-dismiss="modal"/>
	            </div>
	         </form>
	      </div>
	   </div>
	</div>
	<hr>
	
	<!-- 게시물 출력 -->
	<c:forEach items="${postList}" var="post" varStatus="vs">
	<div class="panel panel-default" >
	    <div class="panel-heading">
	    
	    <c:forEach items="${memberList }" var="member">
          <c:if test="${post.getG_post_writer() eq member.getMemberEmail() }">
          <span><img class='postProfile rounded-circle' src='${path }/resources/profileImg/${member.getMemberPFP() }'></span>
           <span class="userName" style="font-size: 2em">${member.getMemberNickname() }</span>&nbsp;&nbsp;
           </c:if>
           </c:forEach>
	        <span><fmt:formatDate value="${post.getG_post_date() }" pattern="yy-MM-dd HH:mm"/></span>
	        <!-- 게시글 좋아요를 위한 form -->
        	<a href="javascript:void(0);" onclick="fn_postLike(this);" title="${post.getG_post_no() }"><i class="far fa-heart like" style="font-size: 2.3em;"></i></a>
	        <form class="likeFrm" style="display: inline-block;" method="post" action="${path }/group/likeInsertAndSelect.do">
	        	<input type="hidden" class="likeMember" name="g_like_member" value="${memberLoggedIn.getMemberEmail() }"/>
	        	<input type="hidden" class="postRef" name="g_post_ref" value="${post.getG_post_no() }"/>
	        	<input type="hidden" class="commentRef" name="g_comment_ref" value= "0"/>
	        	<input type="hidden" class="likeCheck" name="g_like_check" value="1"/>
	        </form>
	        
	        <!-- 게시물 좋아요 갯수 출력 -->
            <div class="likePostCount-container" title="${post.getG_post_no() }" style="display: inline-block">

            </div>
	        
	        <!-- 게시물 서브 메뉴 -->
           <a href="javascript:void(0);" onclick="fn_subMenu(this);" class="dropdown-toggle" data-toggle="dropdown" title="${post.getG_post_no() }" style="float: right; padding-top: 10px;"><i class="fas fa-angle-double-down subAwe" style="font-size: 2.3em;"></i></a>
	           <c:choose>
	              <c:when test="${post.getG_post_writer() eq memberLoggedIn.getMemberEmail()}">
		              <div class="subMenu-container dropdown-menu">
			              <a href="javascript:void(0);" onclick="subMenuPostUpdate(this)" title="${post.getG_post_no() }" class="dropdown-item" data-toggle="modal" data-target="#groupPostUpdateModal">수정하기</a>
                		  <a href="javascript:void(0);" onclick="subMenuPostDelete(this)" title="${post.getG_post_no() }" class="dropdown-item" data-toggle="modal" data-target="#groupPostDeleteModal">삭제하기</a>
			              <a class="dropdown-item" href="#">신고하기</a>
		              </div>
	              </c:when>
	              
	              <c:when test="${g.g_master eq memberLoggedIn.getMemberEmail() }">
		              <div class="subMenu-container dropdown-menu">
		              	  <a href="javascript:void(0);" onclick="subMenuPostDelete(this)" title="${post.getG_post_no() }" class="dropdown-item" data-toggle="modal" data-target="#groupPostDeleteModal">삭제하기</a>
	              		  <a class="dropdown-item" href="#">신고하기</a>
		              </div>
	              </c:when>
	              
	              <c:when test="${g.g_master ne member.getMemberEmail() and post.getG_post_writer() ne member.getMemberEmail() }">
		              <div class="subMenu-container dropdown-menu">
		              	  <a class="dropdown-item" href="#">신고하기</a>
		              </div>
	              </c:when>
              
	           </c:choose>

       <!-- 게시글 삭제 모달!! -->
          <div class="modal fade" id="groupPostDeleteModal">
             <div class="modal-dialog">
                <div class="modal-content">
                
                   <div class="modal-header">
                        <h3 class="modal-title" style='color: black;'><strong>선택한 게시물</strong>을 삭제하시겠습니까??</h3>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                     </div>
                     
                     <form id="deletePostFrm" method="post" action="${path }/group/deleteGroupPost.do?groupNo=${groupNo }">
                        <div class="modal-body">
                           <input type="hidden" id="postNo" name="postNo" value="${post.getG_post_no() }"/>
                           <p style="color: red;">게시물을 삭제하면 이후 복구할 수 없습니다.</p>
                        </div>
                        
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary text-center">삭제하기</button>
                            <input type="reset" class="btn btn-danger text-center" value="취소" data-dismiss="modal"/>
                        </div>
                     </form>
                     
                </div>
             </div>
          </div>
          
          <!-- 게시글 수정 모달!! -->
         <div class="modal fade" id="groupPostUpdateModal">
            <div class="modal-dialog modal-lg">
               <div class="modal-content">
                  
                  <!-- Modal Header -->
                  <div class="modal-header">
                     <h3 class="modal-title" style='color: black;'><strong>선택한 게시물</strong> 수정하기</h3>
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                              
                  <!-- Modal body -->
                  <form id="updatePostFrm" method="post" action="${path }/group/updateGroupPost.do?g_no=${groupNo}" enctype="multipart/form-data">
                     <div class="modal-body">
                        <input type="hidden" id="postNo" name="g_post_no" value="${post.getG_post_no() }"/>
                        <input type="hidden" id="postWriter" name="g_post_writer" value="${memberLoggedIn.getMemberEmail() }"/>
                        <textarea class="form-control" rows="5" id="postContents" name="g_post_contents" placeholder="문구 입력..."></textarea>
                        <hr>
                        
                        <!-- 이미지 업로드 -->
                        <div id="imgDisplayUpdateContainer"></div>
                        <hr>
                        
                        <div class="filebox"> <label for="imgUpdateInput">업로드</label> <input type="file" id="imgUpdateInput" name="upFile" multiple> </div>
                     </div>
                     
                     <!-- Modal footer -->
                     <div class="modal-footer">
                        <button type="submit" class="btn btn-primary text-center">등록하기</button>
                        <input type="reset" class="btn btn-danger text-center" value="취소" data-dismiss="modal"/>
                     </div>
                  </form>
               </div>
            </div>
         </div>
           
       </div> 
       
       
	    
	    <div class="panel-body">
	       <div id="postContentsContainer">
	          <pre>${post.getG_post_contents() }</pre>
	      </div>
	       <c:forEach items="${attachmentList }" var="attach" varStatus="vs">
	          <c:if test='${post.getG_post_no() == attach.getG_post_no() }'>
	             <div class="postAttachContainer">
	                 <img class="imgSize img-thumbnail" src="${path }/resources/upload/group/${attach.getG_renamed_filename() }">
	              </div>
	           </c:if>
	        </c:forEach>
	        <div style="clear: both"></div>
	    </div>
	    
	    
	   <div class="panel-footer">
	      <!-- 댓글 출력 -->
	      <c:forEach items="${commentList }" var="comment">
	         <c:if test='${post.getG_post_no() eq comment.getG_post_ref() and comment.getG_comment_level() eq 1}'>
	         <div class="commentDisplay-container">
	         
	         <c:forEach items="${memberList }" var="member">
             <c:if test="${comment.getG_comment_writer() eq member.getMemberEmail() }">
             <span><img class='commentProfile rounded-circle' src='${path }/resources/profileImg/${member.getMemberPFP() }'></span>
               <a href="#"><span class="commentWriter" style="color: #EE4035">${member.getMemberNickname() }</span></a>
              </c:if>
                </c:forEach>
	            <span class="commentContents">&nbsp;&nbsp;${comment.getG_comment_contents() }</span>
	            
	            <!-- 댓글 좋아요를 위한 form -->
            	<%-- <a href="javascript:void(0);" onclick="fn_postLike(this);" title="${comment.getCommentNo() }"><i class="fas fa-heart like ok" style="font-size: 1.1em;"></i></a> --%>
            	<a href="javascript:void(0);" onclick="fn_postLike(this);" title="${comment.getG_comment_no() }" class="likeCommentBtn"><i class="far fa-heart like" style="font-size: 1.1em;"></i></a>
	        	<form class="likeFrm" style="display:inline-block" method="post" action="${path }/group/likeInsertAndSelect.do">
	            	<input type="hidden" class="likeMember" name="g_like_member" value="${memberLoggedIn.getMemberEmail() }"/>
		        	<input type="hidden" class="postRef" name="g_post_ref" value="${post.getG_post_no() }"/>
		        	<input type="hidden" class="commentRef" name="g_comment_ref" value="${comment.getG_comment_no() }"/>
		        	<input type="hidden" class="likeCheck" name="g_like_check" value="2"/>
	            </form>
	            
	            <!-- 댓글 좋아요 갯수 출력 -->
                <div class="likeCommentCount-container" title="${comment.getG_comment_contents() }" style="display: inline-block">

                </div>
	            
	            <button style="margin-left: 1%" class="inputReplyIcon btn btn-primary btn-sm" id="reply_commentRef" title="${comment.getG_post_ref() }" value="${comment.getG_comment_no() }" ><i class="fas fa-long-arrow-alt-down" style="font-size: 1.1em;"></i></button>
	            <div style="clear: both"></div>
	            
	            
	            <div class="reply-container"> <!-- 답글은 여기로 -->
	               <div id='${comment.getG_comment_no() }' class="replyDisplay-container"> <!-- 답글 출력 -->
	
	               </div>   
	               <!-- 답글 버튼 클릭 시  답글 입력 DIV 삽입 -->
	               
	            </div>
	            
	         </div>
	         </c:if>
	         
	         <!-- replyDisplay 블록이 위의 replyDisplay-container로 붙는다 -->
	         <c:if test='${post.getG_post_no() eq comment.getG_post_ref() and comment.getG_comment_level() eq 2}'>
	            <div title='${comment.getG_comment_ref() }' class='replyDisplay'>
	               <a href='#'><span class='replyWriterDisplay'>${comment.getG_comment_writer()}</span></a>
	               <span>&nbsp;&nbsp;${comment.getG_comment_contents() }</span>
	               
	               <!-- 답글 좋아요를 위한 form -->
				   <%-- <a href="javascript:void(0);" onclick="fn_postLike(this);" title="${comment.getCommentNo() }"><i class="fas fa-heart like ok" style="font-size: 1.1em;"></i></a> --%>
				   <a href="javascript:void(0);" onclick="fn_postLike(this);" title="${comment.getG_comment_no() }"><i class="far fa-heart like" style="font-size: 1.1em;"></i></a>
	        	   <form class="likeFrm" style="display:inline-block" method="post" action="${path }/group/likeInsertAndSelect.do">
						<input type="hidden" class="likeMember" name="g_like_member" value="${memberLoggedIn.getMemberEmail() }"/>
			        	<input type="hidden" class="postRef" name="g_post_ref" value="${post.getG_post_no() }"/>
			        	<input type="hidden" class="commentRef" name="g_comment_ref" value="${comment.getG_comment_no() }"/>
			        	<input type="hidden" class="likeCheck" name="g_like_check" value="2"/>
	               </form>
	               
	               <!-- 답글 좋아요 갯수 출력 -->
	               <div class="likeCommentCount-container" title="${comment.getG_comment_no() }" style="display: inline-block">
	
	               </div>
	               <div style='clear: both'></div>
	            </div>
	            </c:if>
	      </c:forEach>

	      <!-- 댓글 쓰기 -->
	      <div id="inputComment-container">
	         <form id="createCommentFrm" method="post" action="${path }/group/postCommentInsert.do?groupNo=${g.g_no}">
	            <span><img class="commentProfile rounded-circle" src='${path }/resources/profileImg/${memberLoggedIn.getMemberPFP() }'></span>
	            <input type="text" id="inputCommentTxt" name="g_comment_contents" class="form-control" placeholder=" 댓글을 입력하세요..."/>
	            <input type="hidden" id="reply_postRef" name="g_post_ref" value="${post.getG_post_no() }"/>
	            <input type="hidden" name="g_comment_writer" value="${memberLoggedIn.getMemberEmail() }"/>
	            <input type="hidden" name="g_comment_level" value="1"/>
	            <div style="clear: both"></div>
	         </form>
	      </div> <!-- inputComment-container -->
	      
	      
	   </div> <!-- panel-footer -->
	</div> <!-- panel -->
	
	
	</c:forEach>

</div>
<div class="w3-col m3">
	<div class="w3-card w3-round w3-white" style="height: 250px; overflow-y: scroll;">
		<table class="table">
			<thead>
				<tr>
					<th colspan="2" style="text-align: center;">가입 요청</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${g.g_master eq memberLoggedIn.getMemberEmail() }">
					<c:forEach items="${groupEnrollList }" var="memberEnroll">
						<tr>
							<td>${memberEnroll.MEMBER_EMAIL }</td>
							<td>
								<button class="btn btn-outline-secondary btn-sm ac" title="이 버튼이 맞아요">수락</button>
								<button class="btn btn-outline-secondary btn-sm re" title="이 버튼이 맞아요">거절</button>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>
	<div class="w3-card w3-round w3-white" style="height: 250px; overflow-y: scroll;">
		<table class="table">
			<thead>
				<tr>
					<th style="text-align: center;">회원목록</th>
					<c:if test="${g.g_master eq memberLoggedIn.getMemberEmail() }">
						<th style="text-align: center;">관리</th>
					</c:if>
					<c:if test="${g.g_master ne memberLoggedIn.getMemberEmail() }">
						<th><a class="btn btn-outline-secondary btn-sm" style="float:right;" href="${path }/group/groupMemberDelete.do?mEmail=${memberLoggedIn.getMemberEmail()}" onclick="fn_validateSelf()">탈퇴</a></th>
					</c:if>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${gmList }" var="gm" varStatus="a">
				<tr>
					<c:if test="${g.g_master ne memberLoggedIn.getMemberEmail() }">
						<td colspan="2" align="center" id='master${a.index }'>${gm.MEMBER_NICKNAME } </td>
					</c:if>
					<c:if test="${g.g_master eq memberLoggedIn.getMemberEmail() }">
						<td id='g_member'>${gm.MEMBER_NICKNAME } </td>
					</c:if>
					<c:if test="${g.g_master eq memberLoggedIn.getMemberEmail() }">
						<td style="text-align: center;">
							<c:if test="${g.g_master ne gm.MEMBER_EMAIL }">
								<a class="btn btn-outline-secondary btn-sm" href="${path }/group/groupMemberDelete1.do?mEmail=${gm.MEMBER_EMAIL}&groupNo=${g.g_no}" onclick="fn_validate()">강퇴</a>
							</c:if>
							<c:if test="${g.g_master eq gm.MEMBER_EMAIL }">
								<a class="btn btn-outline-danger btn-sm" href="${path }/group/deleteGroup.do?groupNo=${g.g_no}" onclick="fn_validate()">그룹삭제</a>
							</c:if>
						</td>
					</c:if>
				</tr>
				<script>
				$(document).ready(function () {
					console.log("userIdList : " +userIdList.length );
					console.log("" + $('#master${a.index }').html() );
					for(var i = 0; i< userIdList.length;i++){
						if(userIdList[i] == mas){	
							console.log("들어옴");
							 $('#master${a.index }').append("123");
					    }	
					}
				});
				</script>
			</c:forEach>
			</tbody>
		</table>
		<script>
			$(function(){
				$('.ac').on('click',function(){
					var mEmail=$(this).parent().prev().html();
					var event=$(this).parent();
					console.log(mEmail);
					console.log($(this).parent());
					$.ajax({
						url:"${path}/group/groupMemberAccept.do",
						type:"GET",
						data:{mEmail:mEmail},
						dataType:"Json",
						success : function(data){
							if(data==1){
								event.html('<span>수락 완료</span>');
							}
						},
						error:function(request,status,error)
						{
							alert(request.responseText+" "+error);
						}
					})
				});
				
				$('.re').on('click',function(){
					var mEmail=$(this).parent().prev().html();
					var event=$(this).parent();
					console.log(mEmail);
					console.log($(this).parent());
					$.ajax({
						url:"${path}/group/groupMemberReject.do",
						type:"GET",
						data:{mEmail:mEmail},
						dataType:"Json",
						success : function(data){
							if(data==1){
								event.html('<span>거절 완료</span>');
							}
						},
						error:function(request,status,error)
						{
							alert(request.responseText+" "+error);
						}
					})
				});
			});
			function fn_validate(){
				confirm("정말로 강퇴 하시겠습니까?");
			}
			function fn_validateSelf(){
				confirm("정말로 탈퇴 하시겠습니까?");
			}
		</script>
	</div>
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
							<!-- 받은 메세지 -->
							
							<c:forEach items="${chat_contents }" var="chat">
							<c:if test="${chat.MEMBER_EMAIL!=memberLoggedIn.getMemberEmail() }">
								<div class="incoming_msg m-1">
									<div class="incoming_msg_img">
										<img src="${path}/resources/profileImg/${chat.MEMBER_PFP}" class="w3-circle" title="${chat.MEMBER_NAME }">
									</div>
									<div class="received_msg">
										<div class="received_withd_msg">
											<p>${chat.MESSAGE }</p>
											<span class="time_date"> ${chat.WRITER_DATE}<%-- <fmt:formatDate value="${chat.WRITER_DATE}" pattern="yy-MM-dd"/> | <fmt:formatDate value="${chat.WRITER_DATE}" pattern="HH:mm"/> --%></span>
										</div>
									</div>
								</div>
							</c:if>
							</c:forEach>
								
							<!-- 보낸 메세지 -->
							<c:forEach items="${chat_contents }" var="chat">
							<c:if test="${chat.MEMBER_EMAIL==memberLoggedIn.getMemberEmail() }">
								<div class="outgoing_msg m-1">
									<div class="sent_msg">
										<p>${chat.MESSAGE }</p>
										<span class="time_date"> ${chat.WRITER_DATE}<%-- <fmt:formatDate value="${chat.WRITER_DATE}" pattern="yy-MM-dd"/> | <fmt:formatDate value="${chat.WRITER_DATE}" pattern="HH:mm"/> --%></span>
									</div>
								</div>
							</c:if>
							</c:forEach>
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

				</div>
			</div>
		</div>
	</div>		
</div>
</c:if>

<c:if test="${memberCheck eq 0 }">
<div class="w3-col m6">
	<div class="mb-5" style="text-align: center;"><h2>그룹에 가입하세요~~!</h2></div>
	<div class="row">
		<div class="col-3"></div>
		<div class="col-6">
			<div class="card" style="width:100%">
				<img class="card-img-top" src="${path }/resources/upload/group/${g.g_renamedFilename }" alt="Card image" style="width:100%">
				<div class="card-body">
					<h4 class="card-title">${g.g_name }</h4>
					<p class="card-text">${g.g_intro }</p>
					<a href="${path }/group/groupMemberInsert.do?groupNo=${g.g_no}" class="btn btn-outline-secondary">가입 하기</a>
				</div>
			</div>
		</div>
		<div class="col-2"></div>
	</div>
</div>
</c:if>

<c:if test="${groupMemberCheck.G_MEMBER_STATUS eq 'W' }">
<div class="w3-col m6">
	<div class="mb-5" style="text-align: center;"><h2> 승인 대기중 </h2></div>
	<div class="row">
		<div class="col-3"></div>
		<div class="col-6">
			<div class="card" style="width:100%">
				<img class="card-img-top" src="${path }/resources/upload/group/${g.g_renamedFilename }" alt="Card image" style="width:100%">
				<div class="card-body">
					<h4 class="card-title">${g.g_name }</h4>
					<p class="card-text">${g.g_intro }</p>
					<p>그룹 가입 승인 대기중입니다.~~ 기다려주세요.~~</p>
				</div>
			</div>
		</div>
		<div class="col-2"></div>
	</div>
</div>
</c:if>



<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/> --%>