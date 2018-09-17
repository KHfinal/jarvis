<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ page import="kh.mark.jarvis.member.model.vo.Member" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var="path" value="<%=request.getContextPath()%>"/>
<c:set var="loopFlag" value="false"/>


<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="social" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${path }/resources/css/socialHome.css?ver=15">


<script>

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
     var myLikeList = data.myLikeList;
     var myPostNoList = data.myPostNoList;
     
     for(var i=0; i<myPostNoList.length; i++) {
        var myPostNo = myPostNoList[i]; 
        for(var j=0; j<myLikeList.length; j++) {
           var myLike = myLikeList[j];
           
           if($('.likeBtn[title=' + myPostNo + ']').attr('title') == myLike) {
              $('.likeBtn[title=' + myLike + ']').children().removeClass();
              $('.likeBtn[title=' + myLike + ']').children().addClass('fas fa-heart like');
           }
        }
     }
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
	
	console.log("무슨 넘버?? : " + btn.attr('title'));
	console.log("떠라 ~~ " + likeFrm.children('.postRef').val());
	
	$.ajaxSettings.traditional = true;
	$.ajax({
		type: "POST",
		url: "${pageContext.request.contextPath}/group/likeInsertAndSelect.do",
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
	            var html = "<p class='likeCount'>" + data.count + "</p>";
	            likeFrm.next($('.likeCommentCount-container')).html(html);
	            
	            var html = "<p class='likeCount'>" + data.count + "</p>";
	            likeFrm.next($('.likeReplyCount-container')).html(html);
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
<c:if test="${memberCheck eq 1 }">
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
	        
	        <!-- 좋아요 갯수 출력 -->
	        <div class="likeCount-container" style="display: inline-block">
				<p class='likePostCoopen launch configurationunt'></p>
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
            	<a href="javascript:void(0);" onclick="fn_postLike(this);" title="${comment.getG_comment_no() }"><i class="far fa-heart like" style="font-size: 1.1em;"></i></a>
	        	<form class="likeFrm" style="display:inline-block" method="post" action="${path }/group/likeInsertAndSelect.do">
	            	<input type="hidden" class="likeMember" name="g_like_member" value="${memberLoggedIn.getMemberEmail() }"/>
		        	<input type="hidden" class="postRef" name="g_post_ref" value="${post.getG_post_no() }"/>
		        	<input type="hidden" class="commentRef" name="g_comment_ref" value="${comment.getG_comment_no() }"/>
		        	<input type="hidden" class="likeCheck" name="g_like_check" value="2"/>
	            </form>
	            
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
	<div class="w3-card w3-round w3-white">
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
							<td><button class="btn btn-outline-secondary btn-sm" onclick="fn_memberAccept('${memberEnroll.MEMBER_EMAIL}')">수락</button></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>
	<div class="w3-card w3-round w3-white">
		<table class="table">
			<thead>
				<tr>
					<th>회원목록</th>
					<c:if test="${g.g_master eq memberLoggedIn.getMemberEmail() }">
						<th>관리</th>
					</c:if>
					<c:if test="${g.g_master ne memberLoggedIn.getMemberEmail() }">
						<th><a class="btn btn-outline-secondary btn-sm" style="float:right;" href="${path }/group/groupMemberDelete.do?mEmail=${memberLoggedIn.getMemberEmail()}" onclick="fn_validateSelf()">탈퇴</a></th>
					</c:if>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${gMemberList }" var="gm" varStatus="a">
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
			function fn_memberAccept(mEmail) {
				var g_no = '${g.g_no}';
				alert(g_no);
				$.ajax({
					url:"${path}/group/groupMemberAccept.do",
					type:"GET",
					data:{mEmail:mEmail,groupNo:g_no},
					dataType:"Json",
					success : function(data){
						alert(data);
					}
				})
			};
			
			function fn_validate(){
				confirm("정말로 강퇴 하시겠습니까?");
			}
			function fn_validateSelf(){
				confirm("정말로 탈퇴 하시겠습니까?");
			}
		</script>
	</div>		
</div>
</c:if>
<div class="w3-col m6">
<c:if test="${memberCheck eq 0 }">
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
</c:if>
</div>


<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/> --%>