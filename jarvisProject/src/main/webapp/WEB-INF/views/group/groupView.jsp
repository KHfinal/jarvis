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

<link rel="stylesheet" href="${path }/resources/css/socialHome.css?ver=121">
<style>
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
  /* width: 100%; */
  max-width: 200px;
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
  /* width:100%; */
  max-width: 200px;
}
.outgoing_msg{ overflow:hidden; margin:26px 0 26px;}
.sent_msg {
  float: right;
  /* width: 46%; */
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
  height: 550px;
  overflow-y: auto;
}
</style>

<script>

//SoketJS 채팅구현
var sock=new SockJS("<c:url value='/groupChatting'/>")
	sock.onmessage=onMessage;
	//sock.onclose=onClose;
	
var today=null;

	$(function(){
		//전송버튼을 눌렀을때 이벤트 처리!
		$("#sendBtn").click(function(){
			sendMessage();//우리가 구현할 함수!!
			$('#message').val('');
		});
		$("#exitBtn").click(function(){
			sock.onclose();
		});
	});
	function sendMessage()
	{
		sock.send($('#message').val());
		//handler객체! 거기의 handlerTextMessage메소드가 실행!
	};
	function onMessage(evt)
	{
		var data=evt.data;//TextMessage생성 매게변수(아이디|값|아이피)
		var host=null;
		var strArray=data.split("|");
		var userName=null;
		var message=null;
		
		for(i=0;i<strArray.length;i++)
		{
			console.log("strArray["+i+"] : "+strArray[i]);	
		}
		
		if(strArray.length>1){
			
			//실제 채팅 메세지 구현
			userName=strArray[0]; //접속자 아이디
			message=strArray[1]; //전송내용
			host=strArray[2].substr(1,strArray[2].indexOf(":")-1); //실제 아이피 주소만 남기기
			
			today=new Date();
			printDate=today.getFullYear()+"/"+today.getMonth+"/"+today.getDate()+" "+today.getHours()+":"+today.getMinutes()+":"+today.getSeconds();
			console.log(printDate);
			
			var ck_host='${host}';
			
			console.log(host);
			console.log(ck_host);
			
			if(host==ck_host||(host==0&&ck_host.includes('0:0'))){
				
				//자기 자신 메세지
				var printHTML = "<div class='outgoing_msg m-1'>";
				printHTML += "<div class='sent_msg'>";
				printHTML += "<p title='" + printDate + "'>" + message + "</p>";
				printHTML += "</div></div>";
				$("#chatdata").append(printHTML);
				
				/* var printHTML="<div class='well' style='margin-left:30%;'>";
				printHTML+="<div class='alert alert-info'>";
				printHTML+="<sub>"+printDate+"</sub></br>";
				printHTML+="<strong>["+userName+"] : "+message+"</strong>";
				printHTML+="</div>";
				printHTML+="</div>";
				$('#chatdata').append(printHTML); */
			}
			else{
				
				//타인 메세지
				var printHTML = "<div class='incoming_msg m-1'>"
				printHTML += "<div class='incoming_msg'>";
				printHTML += userName+"</div>";
				printHTML += "<div class='received_withd_msg'>";
				printHTML += "<p title='" + printDate + "'>" + message + "</p>";
				printHTML += "</div></div>";
				$("#chatdata").append(printHTML);
				
				/* var printHTML="<div class='well' style='margin-left:-5%; margin-right:30%;'>";
				printHTML+="<div class='alert alert-warning'>";
				printHTML+="<sub>"+printDate+"</sub></br>";
				printHTML+="<strong>["+userName+"] : "+message+"</strong>";
				printHTML+="</div>";
				printHTML+="</div>";
				$('#chatdata').append(printHTML); */
			}
		}
		else{
			
			//나가기 들어온사람 알리기
			today=new Date();
			printDate=today.getFullYear()+"/"+today.getMonth+"/"+today.getDate()+" "+today.getHours()+":"+today.getMinutes()+":"+today.getSeconds();
			message=strArray[0];
			var printHTML="<div class='well' style='margin-left:-5%; margin-right:30%;'>"; 
			printHTML+="<div class='alert alert-danger'>";
			printHTML+="<sub>"+printDate+"</sub></br>";
			printHTML+="<strong>[서버관리자] : "+message+"</strong>";
			printHTML+="</div>";
			printHTML+="</div>";
		}
		
	};
	function onClose(){
		location.href='${pageContext.request.contextPath}';
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
	
	$('.inputReplyIcon').click(function() {
	 
	   
	   /* var replyPostRef = $('#reply_postRef').val(); */
	   var replyProfile = $('.postProfile').attr('src');
	   var replyPostRef = $(this).attr("title");
	   var replyCommentRef = $(this).val();
	   var replyProImg = '${path }/resources/profileImg/${memberLoggedIn.getMemberPFP()}';
	   
	   var div = $("<div class='replyInput'></div>");
	   
	   console.log(replyPostRef);
	   console.log(replyCommentRef);
	   
	   /* 답글 입력 */
	   var html = "<form class='createCommentFrm' method='post' action='${path }/group/postCommentInsert.do?groupNo=${groupNo}'>";
	   html += "<input type='hidden' name='g_comment_writer' value='${memberLoggedIn.getMemberEmail() }'/>";
	   html += "<input type='hidden' name='g_post_ref' value='" + replyPostRef + "'/>";
	   html += "<input type='hidden' name='g_comment_level' value='2'/>";
	   html += "<input type='hidden' name='g_comment_ref' value='" + replyCommentRef + "'/>";
	   html += "<span><img class='replyProfile rounded-circle' src='" + replyProImg + "'></span>";
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
       
       $.each(like, function(idx, value) {
             console.log("group post Ref = " + value.g_post_ref);
             if($('.likeBtn[title=' + value.g_post_ref + ']').attr('title') == value.g_post_ref && value.g_like_check == 1) {
                $('.likeBtn[title=' + value.g_post_ref + ']').children().removeClass();
                 $('.likeBtn[title=' + value.g_post_ref + ']').children().addClass('fas fa-heart like');
             }
             
             if($('.likeCommentBtn[title=' + value.g_comment_ref + ']').attr('title') == value.g_comment_ref && value.g_like_check == 2) {
                $('.likeCommentBtn[title=' + value.g_comment_ref + ']').children().removeClass();
                 $('.likeCommentBtn[title=' + value.g_comment_ref + ']').children().addClass('fas fa-heart like');
             }
       });
       
       $.each(count, function(idx, val) {
    	   console.log("group post Ref = " + val.g_post_ref + " group post count = " + val.CNT)
           if($('.likePostCount-container[title=' + val.G_POST_REF + ']').attr('title') == val.G_POST_REF && val.G_LIKE_CHECK == 1) {
               var html = "<p class='likePostCount'>" + val.CNT + "</p>";
                  $('.likePostCount-container[title=' + val.G_POST_REF + ']').html(html);
             }
           
           if($('.likeCommentCount-container[title=' + val.G_COMMENT_REF + ']').attr('title') == val.G_COMMENT_REF && val.G_LIKE_CHECK == 2) {
               var html = "<p class='likeCommentCount'>" + val.CNT + "</p>";
                  $('.likeCommentCount-container[title=' + val.G_COMMENT_REF + ']').html(html);
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
	               var html = "<p class='likePostCount'>" + data.count + "</p>";
	               likeFrm.next($('.likePostCount-container')).html(html);
	            }
	            
	            if(data.count == 0 || likeFrm.children('.commentRef').val() == commentRef && likeFrm.children('.likeCheck').val() == 2) {
	               var html = "<p class='likeCommentCount'>" + data.count  + "</p>";
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

function subMenuCommentDelete(e) {
	   var btn = $(e);
	   var btnCommentNo = btn.attr('title');
	   
	   location.href="${pageContext.request.contextPath}/group/deleteComment.do?commentNo=" + btnCommentNo + "&groupNo=" + ${groupNo};
	}

	function goMyPage(e) {
		var btn = $(e);
		var memberEmail;

		memberEmail = btn.attr('title');
		console.log('btn memberEmail = ' + memberEmail);
		location.href="${pageContext.request.contextPath}/post/myPage?memberEmail=" + memberEmail;
		
	}
</script>

<c:if test="${groupMemberCheck.G_MEMBER_STATUS eq 'Y' }">
	<div class="w3-col m7">
	<!-- 게시글 등록 미리보기. 클릭시 #postModal이 연결 돼 실제 입력창 나타난다. -->
	<div id="createPostContainer" data-toggle="modal" data-target="#postModal">
	   <div class="modal-header">
	      <h4 class="modal-title">${g.getG_name() }</h4>
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
           <a href="javascript:void(0)" onclick="goMyPage(this)" title="${member.getMemberEmail() }"><span class="goPostWriter" style="font-size: 2em">${member.getMemberName() }</span></a>
           </c:if>
           </c:forEach>
	        <span><fmt:formatDate value="${post.getG_post_date() }" pattern="yy-MM-dd HH:mm"/></span>
	        <!-- 게시글 좋아요를 위한 form -->
        	<a href="javascript:void(0);" onclick="fn_postLike(this);" title="${post.getG_post_no() }" class="likeBtn"><i class="far fa-heart like" style="font-size: 2.3em;"></i></a>
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
	        <c:if test="${post.getG_post_writer() eq memberLoggedIn.getMemberEmail() or g.g_master eq memberLoggedIn.getMemberEmail() }">
           <a href="javascript:void(0);" onclick="fn_subMenu(this);" class="dropdown-toggle" data-toggle="dropdown" title="${post.getG_post_no() }" style="float: right; padding-top: 10px;"><i class="fas fa-angle-double-down subAwe" style="font-size: 2.3em;"></i></a>
	           <c:choose>
	              <c:when test="${post.getG_post_writer() eq memberLoggedIn.getMemberEmail()}">
		              <div class="subMenu-container dropdown-menu">
			              <a href="javascript:void(0);" onclick="subMenuPostUpdate(this)" title="${post.getG_post_no() }" class="dropdown-item" data-toggle="modal" data-target="#groupPostUpdateModal">수정하기</a>
                		  <a href="javascript:void(0);" onclick="subMenuPostDelete(this)" title="${post.getG_post_no() }" class="dropdown-item" data-toggle="modal" data-target="#groupPostDeleteModal">삭제하기</a>
			              
		              </div>
	              </c:when>
	              
	              <c:when test="${g.g_master eq memberLoggedIn.getMemberEmail() }">
		              <div class="subMenu-container dropdown-menu">
		              	  <a href="javascript:void(0);" onclick="subMenuPostDelete(this)" title="${post.getG_post_no() }" class="dropdown-item" data-toggle="modal" data-target="#groupPostDeleteModal">삭제하기</a>
		              </div>
	              </c:when>
	           </c:choose>
	        </c:if>
	           <!-- 멤버 이메일 -->
              <c:forEach items="${memberList }" var="member">
              <c:if test="${post.getG_post_writer() eq member.getMemberEmail() }">
                <sub style="float: left; top: 55px; left: 80px;">${member.getMemberEmail() }</sub>
              </c:if>
              </c:forEach>

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
               <a href="javascript:void(0)" onclick="goMyPage(this)"><span class="goCommentWriter" style="color: #EE4035">${member.getMemberName() }</span></a>
              
              <!-- 댓글 서브 메뉴 -->
              <c:if test="${comment.getG_comment_writer() eq memberLoggedIn.getMemberEmail() or g.g_master eq memberLoggedIn.getMemberEmail()}">
                 <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" title="${comment.getG_comment_no() }" style="float: right; padding-top: 10px;"><i class="fas fa-angle-double-down subAwe" style="font-size: 1.1em;"></i></a>
                 <div class="subMenu-container dropdown-menu">
                   <a href="javascript:void(0);" onclick="subMenuCommentDelete(this)" title="${comment.getG_comment_no() }" class="dropdown-item" data-toggle="modal" data-target="#commentDeleteModal">삭제하기</a>
                 </div>
              </c:if>

                    <!-- 댓글/답글 삭제 모달!! -->
                  <div class="modal fade" id="commentDeleteModal">
                     <div class="modal-dialog">
                        <div class="modal-content">
                        
                           <div class="modal-header">
                              <h3 class="modal-title" style='color: black;'><strong>선택한 댓글</strong>을 삭제하시겠습니까??</h3>
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                           </div>
                           
                           <div class="modal-body">
                              <p style="color: red;">댓글을 삭제하면 이후 복구할 수 없습니다.</p>
                           </div>
                           
                           <div class="modal-footer">
                               <button type="submit" class="btn btn-primary text-center">삭제하기</button>
                               <input type="reset" class="btn btn-danger text-center" value="취소" data-dismiss="modal"/>
                           </div>
                        
                        </div>
                     </div>
                  </div>  
                  
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
                <div class="likeCommentCount-container" title="${comment.getG_comment_no() }" style="display: inline-block">

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
	               <c:forEach items="${memberList }" var="member">
          			<c:if test="${comment.getG_comment_writer() eq member.getMemberEmail() }">
	               <span><img class='replyProfile rounded-circle' src='${path }/resources/profileImg/${member.getMemberPFP() }'></span>
	               <a href='javascript:void(0)' onclick="goMyPage(this)" title="${member.getMemberEmail() }"><span class='goCommentWriter' style="color: #EE4035">${member.getMemberName() }</span></a>
	               
	               <!-- 답글 서브메뉴 -->
	               		<c:if test="${comment.getG_comment_writer() eq memberLoggedIn.getMemberEmail() or g.g_master eq memberLoggedIn.getMemberEmail()}">
	                  		<a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" title="${comment.getG_comment_no() }" style="float: right; padding-top: 10px;"><i class="fas fa-angle-double-down subAwe" style="font-size: 1.1em;"></i></a>
	                       <div class="subMenu-container dropdown-menu">
	                         <a href="javascript:void(0);" onclick="subMenuCommentDelete(this)" title="${comment.getG_comment_no() }" class="dropdown-item" data-toggle="modal" data-target="#commentDeleteModal">삭제하기</a>
	                       </div>
	                    </c:if>
                    </c:if>
                    </c:forEach>
                    <span>&nbsp;&nbsp;${comment.getG_comment_contents() }</span>
                    
	               <!-- 답글 좋아요를 위한 form -->
				   <%-- <a href="javascript:void(0);" onclick="fn_postLike(this);" title="${comment.getCommentNo() }"><i class="fas fa-heart like ok" style="font-size: 1.1em;"></i></a> --%>
				   <a href="javascript:void(0);" onclick="fn_postLike(this);" title="${comment.getG_comment_no() }" class="likeCommentBtn"><i class="far fa-heart like" style="font-size: 1.1em;"></i></a>
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
<style>
.table td{
	word-break:break-all;
	padding: 0.10rem;
}
</style>
<div class="w3-col m2">
	<c:if test="${g.g_master eq memberLoggedIn.getMemberEmail() }">
		<div class="w3-card w3-round w3-white" style="overflow-y: auto; height: 200px;">
			<table class="table">
				<thead>
					<tr>
						<th colspan="2" style="text-align: center;">가입 요청</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${groupEnrollList }" var="memberEnroll">
						<tr>
							<td>${memberEnroll.MEMBER_NAME }</br><sub>${memberEnroll.MEMBER_EMAIL }</sub></td>
							<td style="width: 30%">
								<button class="btn btn-outline-secondary btn-sm ac" title="이 버튼이 맞아요">수락</button>
								<button class="btn btn-outline-secondary btn-sm re" title="이 버튼이 맞아요">거절</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</c:if>
	<div class="w3-card w3-round w3-white mt-3" style="overflow-y: auto; height: 200px;">
		<table class="table">
			<thead>
				<tr>
					<th colspan="2" style="text-align: center;">회원목록</th>
					<c:if test="${g.g_master ne memberLoggedIn.getMemberEmail() }">
						<th><a class="btn btn-outline-secondary btn-sm" style="float:right;" href="${path }/group/groupMemberDelete.do?mEmail=${memberLoggedIn.getMemberEmail()}" onclick="fn_validateSelf()">탈퇴</a></th>
					</c:if>
				</tr>
			</thead>
			<tbody class="pre-scrollable">
			<c:forEach items="${gmList }" var="gm" varStatus="a">
				<tr>
					<c:if test="${g.g_master ne memberLoggedIn.getMemberEmail() }">
						<td colspan="3" align="center" id='master${a.index }'><a href="javascript:void(0)" onclick="goMyPage(this)">${gm.MEMBER_NAME }</br><sub>${gm.MEMBER_EMAIL }</sub></a></td>
					</c:if>
					<c:if test="${g.g_master eq memberLoggedIn.getMemberEmail() }">
						<td id='g_member'><a href="javascript:void(0)" onclick="goMyPage(this)">${gm.MEMBER_NAME }</br><sub>${gm.MEMBER_EMAIL }</sub></a></td>
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
			</c:forEach>
			</tbody>
		</table>
		<script>
			$(function(){
				$('.ac').on('click',function(){
					var mEmail=$(this).parent().prev().find("sub").html();
					var event=$(this).parent();
					var groupNo = ${groupNo};
					console.log(mEmail);
					console.log($(this).parent());
					$.ajax({
						url:"${path}/group/groupMemberAccept.do",
						type:"GET",
						data:{mEmail:mEmail, groupNo:groupNo},
						dataType:"Json",
						success : function(data){
							alert(data);
							if(data==1){
								
								event.html('<span>수락</span>');
							}
						},
						error:function(request,status,error)
						{
							alert(request.responseText+" "+error);
						}
					})
				});
				
				$('.re').on('click',function(){
					var mEmail=$(this).parent().prev().find("sub").html();
					var event=$(this).parent();
					var groupNo = ${groupNo};
					console.log(mEmail);
					console.log($(this).parent());
					$.ajax({
						url:"${path}/group/groupMemberReject.do",
						type:"GET",
						data:{mEmail:mEmail, groupNo:groupNo},
						dataType:"Json",
						success : function(data){
							alert(data);
							if(data==1){
								event.html('<span>거절</span>');
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
				confirm("그룹에서 강퇴 하시겠습니까?");
			}
			function fn_validateSelf(){
				confirm("그룹을 탈퇴 하시겠습니까?");
			}
			function fn_validate(){
				confirm("그룹을 삭제 하시겠습니까?")
			}
		</script>
	</div>
	<div class="w3-card w3-round w3-white mt-3">
	<!-- <script>
		/* $(".scrollDiv").scrollTop($(".scrollDiv")[0].scrollHeight); */
		/* $('.scrollDiv').scrollTop($('.scrollDiv').prop('scrollHeight')); */
		var divdiv = document.getElementsByClassName('scrollDiv');
		divdiv.scrollTop = divdiv.scrollHeight;
	</script> -->
		<div class="pt-1" style="text-align: center;"><h5>그룹 채팅</h5></div>
			<div class="form-group mb-0">
				<div class="panel panel-default" id="scrollDiv" style="width:100%; margin: 0px;">
					<div id="chatdata" class="panel-body scrollDiv" style=" height:300px; overflow-y: auto;"></div>
				</div>
			</div>
			<div class="type_msg">
				<div class="input_msg_write">
					<input type="text" name="message" id="message" placeholder="메세지를 입력하세요..."/>
					<button class="msg_send_btn" type="button" id="sendBtn">
						<i class="fa fa-paper-plane-o" aria-hidden="true"></i>
					</button>
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
					<p>가입 승인 대기중입니다.~~ 기다려주세요.~~</p>
				</div>
			</div>
		</div>
		<div class="col-2"></div>
	</div>
</div>
</c:if>



<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/> --%>