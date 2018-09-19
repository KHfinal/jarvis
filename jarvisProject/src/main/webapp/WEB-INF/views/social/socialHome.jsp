<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ page import="kh.mark.jarvis.member.model.vo.Member" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>

<c:set var="path" value="<%=request.getContextPath()%>"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="social" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${path }/resources/css/socialHome.css?ver=121">

<script>
// 게시글 등록
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

// 게시글 수정
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
      var replyProfile = $('#commentPro').attr('src');
      var replyPostRef = $(this).attr("title");
      var replyCommentRef = $(this).val();
      
      var div = $("<div class='replyInput'></div>");
      
      /* 답글 입력 */
      var html = "<form class='createCommentFrm' method='post' action='${path }/post/postCommentInsert.do'>";
      html += "<input type='hidden' name='commentWriter' value='${memberLoggedIn.getMemberEmail() }'/>";
      html += "<input type='hidden' name='postRef' value='" + replyPostRef + "'/>";
      html += "<input type='hidden' name='commentLevel' value='2'/>";
      html += "<input type='hidden' name='commentRef' value='" + replyCommentRef + "'/>";
      html += "<span><img class='replyProfile rounded-circle' src='" + replyProfile + "'></span>";
      html += "<input type='text' name='commentContents' class='inputReplyTxt form-control' placeholder=' 답글을 입력하세요...'/>";
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
       url: "${pageContext.request.contextPath}/post/startLike.do",
       contentType : "application/x-www-form-urlencoded; charset=utf-8",
       dataType : "json",
        
       success: function(data) {
          
          var like = data.myLikeOnList;
          var count = data.startLikeCount;
          
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
                     var html = "<p class='likePostCount'>" + val.CNT + "</p>";
                     $('.likePostCount-container[title=' + val.POST_REF + ']').html(html);
              }
              
              if($('.likeCommentCount-container[title=' + val.COMMENT_REF + ']').attr('title') == val.COMMENT_REF && val.LIKE_CHECK == 2) {
                     var html = "<p class='likeCommentCount'>" + val.CNT + "</p>";
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

/* 좋아요 전송 */
function fn_postLike(e) { /* 좋아요 전송 */
   
   var btn = $(e)
   var likeFrm = btn.next($('.likeFrm'));
   var likeUrl;
   
   if(btn.children().attr('class').includes('far')){
      btn.children().removeClass();
      btn.children().addClass('fas fa-heart like');
      likeUrl = "${pageContext.request.contextPath}/post/likeInsertAndSelect.do";
   }
   
   else{
      btn.children().removeClass();
      btn.children().addClass('far fa-heart like');
      likeUrl = "${pageContext.request.contextPath}/post/likeDeleteAndSelect.do";
   }
   
   $.ajaxSettings.traditional = true;
   $.ajax({
      type: "POST",
      url: likeUrl,
      data: {
         likeMember : likeFrm.children('.likeMember').val(),
         postRef : likeFrm.children('.postRef').val(),
         commentRef : likeFrm.children('.commentRef').val(),
         likeCheck : likeFrm.children('.likeCheck').val(),
      },
      contentType : "application/x-www-form-urlencoded; charset=utf-8",
       dataType : "json",
        
      success: function(data) {
         var likeMember;
         var postRef;
         var commentRef;
         var likeCheck;

         $.each(data.likeList, function(i, item) {
            likeMember = item.likeMember;
            postRef = item.postRef;
            commentRef = item.commentRef;
            likeCheck = item.likeCheck;
         });
         
         if(data.count == 0 || likeFrm.children('.postRef').val() == postRef && likeFrm.children('.likeCheck').val() == 1) {
            var html = "<p class='likePostCount'>" + data.count + "</p>";
            likeFrm.next($('.likePostCount-container')).html(html);
         }
         
         if(data.count == 0 || likeFrm.children('.commentRef').val() == commentRef && likeFrm.children('.likeCheck').val() == 2) {
            var html = "<p class='likeCommentCount'>" + data.count + "</p>";
            likeFrm.next($('.likeCommentCount-container')).html(html);
         } 
      },
      
      error: function(xhr, status, errormsg) {
         console.log(xhr);
         console.log(status);
         console.log(errormsg);
      }
   });
}


function subMenuPostDelete(e) {
   var btn = $(e);
   var btnPostNo = btn.attr('title');
   
   location.href="${pageContext.request.contextPath}/post/deletePost.do?postNo=" + btnPostNo;   
   
}

function subMenuPostUpdate(e) {
   var btn = $(e);
   var btnPostNo = btn.attr('title');
   var frm = $('#updatePostFrm');
   
   frm.find('#postNo').val(btnPostNo);
}

function subMenuPostNotify(e) {
	var btn = $(e);
	var btnPostNo = btn.attr('title');
	var btnPostWriter = btn.attr('id');
	var frm = $('#notifyPostFrm');
	
	console.log("btnPostNo = " + btnPostNo);
	console.log("btnPostWriter = " + btnPostWriter);
	
	frm.find('#postNo').val(btnPostNo);
	frm.find('#postWriter').val(btnPostWriter);
}

function subMenuCommentUpdate(e) {
   var btn = $(e);
   var btnCommentNo = btn.attr('title');
   var frm = $('#updateCommentFrm')
   
   frm.find('#commentNo').val(btnCommentNo);
   console.log(btnCommentNo);
}


function subMenuCommentDelete(e) {
   var btn = $(e);
   var btnCommentNo = btn.attr('title');
   
   location.href="${pageContext.request.contextPath}/post/deleteComment.do?commentNo=" + btnCommentNo;
}

function goMyPage(e) {
	var btn = $(e);
	var memberEmail;

	memberEmail = btn.attr('title');
	console.log('btn memberEmail = ' + memberEmail);
	location.href="${pageContext.request.contextPath}/post/myPage?memberEmail=" + memberEmail;
	
}

</script>

<style>
   .subMenu-container {
      background-color: red;
      color: white;
      z-index: 100;
   }
</style>
       
<div class="w3-col m6">
   <!-- 게시글 등록 미리보기. 클릭시 #postModal이 연결 돼 실제 입력창 나타난다. -->
   <div id="createPostContainer" data-toggle="modal" data-target="#postModal">
      <div class="modal-header">
         <h4 class="modal-title">Welcome to Jarvis</h4>
         <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <div class="modal-body">
         <textarea rows="5" id="fakePostContents" class="form-control" name="postContents" placeholder="문구 입력..." disabled></textarea>
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
            <form id="createPostFrm" method="post" action="${path }/post/insertPost.do" enctype="multipart/form-data">
               <div class="modal-body">
                  <input type="hidden" id="postWriter" name="postWriter" value="${memberLoggedIn.getMemberEmail() }"/>
                  <textarea class="form-control" rows="5" id="postContents" name="postContents" placeholder="문구 입력..."></textarea>
                  <hr>
                  
                  <!-- 이미지 업로드 -->
                  <div id="imgDisplayContainer"></div>
                  <hr>
                  
                  <div class="privacyBoundContainer">
                      <label for="privacyBound" style="display: inline;">공개 범위</label>
                      <select class="form-control" id="privacyBound" name="privacyBound">
                         <option value="public">전체 보기</option>
                         <option value="friend">친구만</option>
                         <option value="private">나만 보기</option>
                      </select>
                  </div>
                  
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
           <c:if test="${post.getPostWriter() eq member.getMemberEmail() }">
              <span><img class='postProfile rounded-circle' src='${path }/resources/profileImg/${member.getMemberPFP() }'></span>
              <a href="javascript:void(0)" onclick="goMyPage(this)" title="${member.getMemberEmail() }"><span class="goPostWriter" style="font-size: 2em">${member.getMemberName() }</span></a>
           </c:if>
           </c:forEach>
           <span><fmt:formatDate value="${post.getPostDate()}" pattern="yy-MM-dd HH:mm"/></span>
           
           <a href="javascript:void(0);" onclick="fn_postLike(this);" title="${post.getPostNo() }" class="likeBtn"><i class="far fa-heart like" style="font-size: 2.3em;"></i></a>
           <!-- 좋아요 전송 form -->
           <form class="likeFrm" style="display: inline-block;" method="post" action="${path }/post/likeInsertAndSelect.do">
              <input type="hidden" class="likeMember" name="likeMember" value="${memberLoggedIn.getMemberEmail() }"/>
              <input type="hidden" class="postRef" name="postRef" value="${post.getPostNo() }"/>
              <input type="hidden" class="commentRef" name="commentRef" value= "0"/>
              <input type="hidden" class="likeCheck" name="likeCheck" value="1"/>
           </form>
           
           <!-- 게시물 좋아요 갯수 출력 -->
           <div class="likePostCount-container" title="${post.getPostNo() }" style="display: inline-block">

           </div>
           
           <!-- 게시물 서브 메뉴 -->
           <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" title="${post.getPostNo() }" style="float: right; padding-top: 10px;"><i class="fas fa-angle-double-down subAwe" style="font-size: 2.3em;"></i></a>
           <c:choose>
              <c:when test="${post.getPostWriter() eq memberLoggedIn.getMemberEmail() }">
              <div class="subMenu-container dropdown-menu">
                <a href="javascript:void(0);" onclick="subMenuPostUpdate(this)" title="${post.getPostNo() }" class="dropdown-item" data-toggle="modal" data-target="#postUpdateModal">수정하기</a>
                <a href="javascript:void(0);" onclick="subMenuPostDelete(this)" title="${post.getPostNo() }" class="dropdown-item" data-toggle="modal" data-target="#postDeleteModal">삭제하기</a>
              </div>
              </c:when>
              
              <c:otherwise>
              <div class="subMenu-container dropdown-menu">
                <a href="javascript:void(0);" onclick="subMenuPostNotify(this)" title="${post.getPostNo() }" id="${post.getPostWriter() }" class="dropdown-item" data-toggle="modal" data-target="#postNotifyModal">신고하기</a>
              </div>
              </c:otherwise>
              </c:choose>
             
              <!-- 멤버 이메일 -->
              <c:forEach items="${memberList }" var="member">
              <c:if test="${post.getPostWriter() eq member.getMemberEmail() }">
                <sub style="float: left; top: 55px; left: 80px;">${member.getMemberEmail() }</sub>
              </c:if>
              </c:forEach>
          
          <!-- 게시글 수정 모달!! -->
          <div class="modal fade" id="postUpdateModal">
            <div class="modal-dialog modal-lg">
               <div class="modal-content">
                  
                  <div class="modal-header">
                     <h3 class="modal-title" style='color: black;'><strong>선택한 게시물</strong> 수정하기</h3>
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                        
                  <form id="updatePostFrm" method="post" action="${path }/post/postUpdate.do" enctype="multipart/form-data">
                     <div class="modal-body">
                        <input type="hidden" id="postNo" name="postNo" value="${post.getPostNo() }"/>
                        <textarea class="form-control" rows="5" id="postContents" name="postContents" placeholder="문구 입력..."></textarea>
                        <hr>
                        
                        <div id="imgDisplayUpdateContainer"></div>
                        <hr>
                        <div class="privacyBoundContainer">
                            <label for="privacyBound" style="display: inline; color: black;">공개 범위</label>
                            <select class="form-control" id="privacyBound" name="privacyBound">
                               <option value="public">전체 보기</option>
                               <option value="friend">친구만</option>
                               <option value="private">나만 보기</option>
                            </select>
                        </div> 
                        
                        <div class="filebox"> <label for="imgUpdateInput">업로드</label> <input type="file" id="imgUpdateInput" name="upFile1" multiple> </div>
                     </div>
                     
                     <div class="modal-footer">
                        <button type="submit" class="btn btn-primary text-center">수정하기</button>
                        <input type="reset" class="btn btn-danger text-center" value="취소" data-dismiss="modal"/>
                     </div>
                  </form>
               </div>
            </div>
          </div>
          
          <!-- 게시글 삭제 모달!! -->
          <div class="modal fade" id="postDeleteModal">
             <div class="modal-dialog">
                <div class="modal-content">
                
                   <div class="modal-header">
                      <h3 class="modal-title" style='color: black;'><strong>선택한 게시물</strong>을 삭제하시겠습니까??</h3>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                   </div>
                   
                   <div class="modal-body">
                      <p style="color: red;">게시물을 삭제하면 이후 복구할 수 없습니다.</p>
                   </div>
                   
                   <div class="modal-footer">
                       <button type="submit" class="btn btn-primary text-center">삭제하기</button>
                       <input type="reset" class="btn btn-danger text-center" value="취소" data-dismiss="modal"/>
                   </div>
                
                </div>
              </div>
           </div>
           
           <!-- 게시글 신고 모달!! -->
          <div class="modal fade" id="postNotifyModal">
             <div class="modal-dialog">
                <div class="modal-content">
                
                   <div class="modal-header">
                      <h3 class="modal-title" style='color: black;'><strong>선택한 게시물</strong>을 신고하시겠습니까??</h3>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                   </div>
                   
                   <form id="notifyPostFrm" method="post" action="${path }/admin/postNotify.do">
	                   <div class="modal-body">
	                   	  <p style="color: black;">소중한 의견을 보내주셔서 감사합니다.</p>
	                      <input type="hidden" id="postNo" name="postNo" value="${post.getPostNo() }"/>
	                      <input type="hidden" id="postWriter" name="postWriter" value="${post.getPostWriter() }"/>
	                      <input type="hidden" id="notifyWriter" name="notifyWriter" value="${memberLoggedIn.getMemberEmail() }"/>
	                      <select class="form-control" id="notifyReason" name="notifyReason">
							<option value="폭력적인 내용이 포함되어 있습니다.">폭력적인 내용이 포함되어 있습니다.</option>
							<option value="과도한 노출 이미지가 포함되어 있습니다.">과도한 노출 이미지가 포함되어 있습니다.</option>
							<option value="자살 또는 자해 게시글입니다.">자살 또는 자해 게시글입니다.</option>
							<option value="지나친 광고성 게시글 입니다.">지나친 광고성 게시글 입니다.</option>
				          </select> 
	                   </div>
	                   
	                   <div class="modal-footer">
	                       <button type="submit" class="btn btn-primary text-center">신고하기</button>
	                       <input type="reset" class="btn btn-danger text-center" value="취소" data-dismiss="modal"/>
	                   </div>
                   </form>
                
                </div>
              </div>
           </div>
          
       </div>
       
       <!-- POST 이미지, 게시글 출력 -->
       <div class="panel-body">
          <div id="postContentsContainer">
             <pre>${post.getPostContents() }</pre>
         </div>
          <c:forEach items="${attachmentList }" var="attach" varStatus="vs">
             <c:if test='${post.getPostNo() == attach.getPostNo() }'>
                <div class="postAttachContainer">
                    <img class="imgSize img-thumbnail" src="${path }/resources/upload/post/${attach.getRenamedFileName() }">
                 </div>
              </c:if>
           </c:forEach>
           <div style="clear: both"></div>
       </div>
       
      <!-- 댓글 출력 --> 
      <div class="panel-footer">
         <c:forEach items="${commentList }" var="comment">
            <c:if test='${post.getPostNo() eq comment.getPostRef() and comment.getCommentLevel() eq 1}'>
            <div class="commentDisplay-container">
               
               <c:forEach items="${memberList }" var="member">
                <c:if test="${comment.getCommentWriter() eq member.getMemberEmail() }">
                <span><img class='commentProfile rounded-circle' src='${path }/resources/profileImg/${member.getMemberPFP() }'></span>
                <a href="javascript:void(0)" onclick="goMyPage(this)" title="${member.getMemberEmail() }"><span class="goCommentWriter" style="color: #EE4035">${member.getMemberName() }</span></a>
                 
                 <!-- 댓글 서브 메뉴 -->
                 <c:if test="${comment.getCommentWriter() eq memberLoggedIn.getMemberEmail() }">
                 <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" title="${comment.getCommentNo() }" style="float: right; padding-top: 10px;"><i class="fas fa-angle-double-down subAwe" style="font-size: 1.1em;"></i></a>
                 </c:if>
                 <div class="subMenu-container dropdown-menu">
                   <a href="javascript:void(0);" onclick="subMenuCommentUpdate(this)" title="${comment.getCommentNo() }" class="dropdown-item" data-toggle="modal" data-target="#commentUpdateModal">수정하기</a>
                   <a href="javascript:void(0);" onclick="subMenuCommentDelete(this)" title="${comment.getCommentNo() }" class="dropdown-item" data-toggle="modal" data-target="#commentDeleteModal">삭제하기</a>
                 </div>

                   <!-- 댓글 수정 모달!! -->
                   <div class="modal fade" id="commentUpdateModal">
                     <div class="modal-dialog">
                        <div class="modal-content">
                           
                           <div class="modal-header">
                              <h3 class="modal-title" style='color: black;'><strong>선택한 댓글</strong> 수정하기</h3>
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                           </div>
                                 
                           <form id="updateCommentFrm" method="post" action="${path }/post/commentUpdate.do">
                              <div class="modal-body">
                                 <p>내용을 입력하세요</p>
                                 <input type="hidden" id="commentNo" name="commentNo"/>
                                 <input type="text" id="commentContents" name="commentContents" class="form-control"/>
                                 <hr>
                              </div>
                              
                              <div class="modal-footer">
                                 <button type="submit" class="btn btn-primary text-center">수정하기</button>
                                 <input type="reset" class="btn btn-danger text-center" value="취소" data-dismiss="modal"/>
                              </div>
                           </form>
                        </div>
                     </div>
                   </div>
                   
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
               <span class="commentContents">&nbsp;&nbsp;${comment.getCommentContents() }</span>
               
              <!-- 댓글 좋아요를 위한 form -->
              <a href="javascript:void(0);" onclick="fn_postLike(this);" title="${comment.getCommentNo() }" class="likeCommentBtn"><i class="far fa-heart like" style="font-size: 1.1em;"></i></a>
              <form class="likeFrm" style="display:inline-block" method="post" action="${path }/post/likeInsertAndSelect.do">
                 <input type="hidden" class="likeMember" name="likeMember" value="${memberLoggedIn.getMemberEmail() }"/>
                 <input type="hidden" class="postRef" name="postRef" value="${post.getPostNo() }"/>
                 <input type="hidden" class="commentRef" name="commentRef" value="${comment.getCommentNo() }"/>
                 <input type="hidden" class="likeCheck" name="likeCheck" value="2"/>
              </form>
               
              <!-- 댓글 좋아요 갯수 출력 -->
              <div class="likeCommentCount-container" title="${comment.getCommentNo() }" style="display: inline-block">

              </div>
               
               <button style="margin-left: 1%" class="inputReplyIcon btn btn-primary btn-sm" id="reply_commentRef" title="${comment.getPostRef() }" value="${comment.getCommentNo() }"><i class="fas fa-long-arrow-alt-down" style="font-size: 1.1em;"></i></button>
               <div style="clear: both"></div>
               
               
               
               <div class="reply-container"> <!-- 답글은 여기로 -->
                  <div id='${comment.getCommentNo() }' class="replyDisplay-container"> <!-- 답글 출력 -->
   
                  </div>   
                  <!-- 답글 버튼 클릭 시  답글 입력 DIV 삽입 -->
                  
               </div>
            </div>
            </c:if>
            
            <!-- 답글 출력 -->
            <!-- replyDisplay 블록이 위의 replyDisplay-container로 붙는다 -->
            <c:if test='${post.getPostNo() eq comment.getPostRef() and comment.getCommentLevel() eq 2}'>
               <div title='${comment.getCommentRef() }' class='replyDisplay'>
               <c:forEach items="${memberList }" var="member">
                  <c:if test="${comment.getCommentWriter() eq member.getMemberEmail() }">
                  <span><img class='replyProfile rounded-circle' src='${path }/resources/profileImg/${member.getMemberPFP() }'></span>
                  <a href="javascript:void(0)" onclick="goMyPage(this)" title="${member.getMemberEmail() }"><span class="goCommentWriter" style="color: #EE4035">${member.getMemberName() }</span></a>
                     <!-- 댓글 서브 메뉴 -->
	                 <c:if test="${comment.getCommentWriter() eq memberLoggedIn.getMemberEmail() }">
	                 <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" title="${comment.getCommentNo() }" style="float: right; padding-top: 10px;"><i class="fas fa-angle-double-down subAwe" style="font-size: 1.1em;"></i></a>
	                 </c:if>
	                 <div class="subMenu-container dropdown-menu">
	                   <a href="javascript:void(0);" onclick="subMenuCommentUpdate(this)" title="${comment.getCommentNo() }" class="dropdown-item" data-toggle="modal" data-target="#commentUpdateModal">수정하기</a>
	                   <a href="javascript:void(0);" onclick="subMenuCommentDelete(this)" title="${comment.getCommentNo() }" class="dropdown-item" data-toggle="modal" data-target="#commentDeleteModal">삭제하기</a>
	                 </div>
                  </c:if>
               </c:forEach>
               <span>&nbsp;&nbsp;${comment.getCommentContents() }</span>
                  
                 <!-- 답글 좋아요를 위한 form -->
                 <a href="javascript:void(0);" onclick="fn_postLike(this);" title="${comment.getCommentNo() }" class="likeCommentBtn"><i class="far fa-heart like" style="font-size: 1.1em;"></i></a>
                 <form class="likeFrm" style="display:inline-block" method="post" action="${path }/post/likeInsertAndSelect.do">
                     <input type="hidden" class="likeMember" name="likeMember" value="${memberLoggedIn.getMemberEmail() }"/>
                     <input type="hidden" class="postRef" name="postRef" value="${post.getPostNo() }"/>
                     <input type="hidden" class="commentRef" name="commentRef" value="${comment.getCommentNo() }"/>
                     <input type="hidden" class="likeCheck" name="likeCheck" value="2"/>
                 </form>
                  
                  <!-- 답글 좋아요 갯수 출력 -->
               <div class="likeCommentCount-container" title="${comment.getCommentNo() }" style="display: inline-block">

               </div>
                  
                  <div style='clear: both'></div>
               </div>
            </c:if>
         </c:forEach>
         
   
         <!-- 댓글 쓰기 -->
         <div id="inputComment-container">
            <form id="createCommentFrm" method="post" action="${path }/post/postCommentInsert.do">
               <span><img class='commentProfile rounded-circle' src='${path }/resources/profileImg/${memberLoggedIn.getMemberPFP() }' id='commentPro'></span>
               <input type="text" id="inputCommentTxt" name="commentContents" class="form-control" placeholder=" 댓글을 입력하세요..."/>
               <input type="hidden" id="reply_postRef" name="postRef" value="${post.getPostNo() }"/>
               <input type="hidden" name="commentWriter" value="${memberLoggedIn.getMemberEmail() }"/>
               <input type="hidden" name="commentLevel" value="1"/>
               <div style="clear: both"></div>
            </form>
         </div> <!-- inputComment-container -->
         
         
      </div> <!-- panel-footer -->
   </div> <!-- panel -->
   </c:forEach>

</div>
<style>
.a{ size: }
</style>
<script>

function searchsearch(){
	
ajax();
var myEmail = '${memberLoggedIn.memberEmail}';
var searchKeyword = $('#searchKeyword').val();
var searchType = $('#searchType').val();
if(searchKeyword  == null){
	return ;
} 
var friendKeywordTag;
var tr="";

	$('.tablefriendKeyword').empty();
	$.ajax({
		url:"${path }/friend/friendSearch.do",
		type:"post",
		data:{searchKeyword : searchKeyword,searchType:searchType },
		dataType:"json",
		success : function(data){
			$('.tablefriendKeyword').append("<tr><th colspan='2' style='text-align:center '>친구 목록</th></tr>");
			
			console.log("friendList : " + friendList);
			
			$.each(data,function(i,item){
				var searchPFP = item.memberPFP;
				var searchEmail = item.memberEmail; 
				console.log("가져온 이메일 : " +searchEmail);
				console.log("친구목록 : " + friendList);
				if(friendList.length < 1){

					friendKeywordTag = "<tr ><td style='padding-right:0%;padding-left:2%;font-size: 15px;'><img src='${path}/resources/profileImg/"+searchPFP+"' class='w3-circle' style='height:50px;width:50px' >&nbsp;&nbsp;&nbsp;"+searchEmail+'<img style=" float:right; margin-top:4%;" src="${path }/resources/img/friendAdd.png"  id="friend_add"  onclick="fn_friendAdd(this,'+"'"+searchEmail+"'"+');"/></td></tr>';
					if(searchEmail !=myEmail){
						$('.tablefriendKeyword').append(friendKeywordTag);
					}
					 
				}
				if(friendList.length >=1){
				for(var i =0; i<friendList.length;i++){
					friendKeywordTag ="";
					if(friendList[i]==searchEmail ){
						friendConcernTag ;
						break;
					}if(friendList[i]==searchEmail){
						break;
					}
					if(i==friendList.length-1){
						friendKeywordTag = "<tr ><td style='padding-right:0%;padding-left:2%;font-size: 15px;'><img src='${path}/resources/profileImg/"+searchPFP+"' class='w3-circle' style='height:50px;width:50px' >&nbsp;&nbsp;&nbsp;"+searchEmail+'<img style=" float:right; margin-top:4%;" src="${path }/resources/img/friendAdd.png"  id="friend_add"  onclick="fn_friendAdd(this,'+"'"+searchEmail+"'"+');"/></td></tr>';
						if(searchEmail!=myEmail){
							$('.tablefriendKeyword').append(friendKeywordTag);
						}
					 break;
					}	
				}
				}
			});
		}
	});
}
function concernSearch() {
	ajax();
		$('.tablefriendConcern').empty();
		var myEmail = '${memberLoggedIn.memberEmail}';
		$.ajax({
			url:"${path}/friend/concernRecommendList.do",
			type:"GET",
			data:{email:myEmail},
			dataType:"json",
			success : function(data){
				var friendConcernTag ="";
				$('.tablefriendConcern').empty();
				$('.tablefriendConcern').append("<tr><th colspan='2' style='text- '>관심사가 비슷한 친구</th></tr>");
				$.each(data,function(i,item){
					var a = item;
					friendConcernTag = "<tr ><td style='padding-right:0%;padding-left:2%;font-size: 15px;'><img src='${path}/resources/profileImg/"+a.memberPFP+"' class='w3-circle' style='height:50px;width:50px' >&nbsp;&nbsp;&nbsp;"+a.memberEmail+'<img style=" float:right; margin-top:4%;" src="${path }/resources/img/friendAdd.png"  id="friend_add"  onclick="fn_friendAdd(this,'+"'"+a.memberEmail+"'"+');"/></td></tr>';
					if(a==""){
						friendConcernTag ="<tr ><td style='padding-right:0%;padding-left:2%;font-size: 15px;'>관심사가 같은 친구를 찾을 수 없습니다</td></tr>"
					}
					$('.tablefriendConcern').append(friendConcernTag);
				}); 
			}
		});
};
function recognizableSearch() {
	ajax();
	$('.tablefriendRecognize').empty();
	var myEmail = '${memberLoggedIn.memberEmail}';
	$.ajax({
		url:"${path}/friend/recognizableRecommendList.do",
		type:"GET",
		data:{email:myEmail},
		dataType:"json",
		success : function(data){
			var friendReco ="";
			$('.tablefriendRecognize').empty();
			$('.tablefriendRecognize').append("<tr><th colspan='2' style='text-align:center; '>알 수도 있는 친구</th></tr>");
			$.each(data,function(i,item){
				var recoList = item;
				friendReco = "<tr ><td style='padding-right:0%;padding-left:2%;font-size: 15px;'><img src='${path}/resources/profileImg/"+recoList.memberPFP+"' class='w3-circle' style='height:50px;width:50px' >&nbsp;&nbsp;"+recoList.memberEmail+'<img style=" float:right; margin-top:4%;"  src="${path }/resources/img/friendAdd.png"  id="friend_add"  onclick="fn_friendAdd(this,'+"'"+recoList.memberEmail+"'"+');"/></td></tr>';
				if(recoList==""){
					friendReco ="<tr ><td style='padding-right:0%;padding-left:2%;font-size: 15px; >알 수 있는 친구가 없습니다 ㅠㅠ</td></tr>"
				}
				$('.tablefriendRecognize').append(friendReco);
			}); 
		}
	});
}
function fn_friendAdd(e,mail){
	$.ajax({
		url:"${path}/friend/friendRequestSocial.do",
		type:"GET",
		data:{mail:mail},
		dataType:"json",
		success : function(data){
			
				$(e).attr("onclick","fn_two(this,'"+mail+"')");
				$(e).attr("src","${path }/resources/img/request.png");
				var msg = decodeURIComponent(data.msg);
			alert(msg);
		
		}
	});
};
function fn_two(e,mail) {
	$.ajax({
		url:"${path}/friend/friendRefuseSocial.do",
		type:"GET",
		data:{mail:mail},
		dataType:"json",
		success : function(data){
			
				$(e).attr("onclick","fn_two(this,'"+mail+"')");
				$(e).attr("src","${path }/resources/img/friendAdd.png");
				var msg = decodeURIComponent(data.msg);
			alert(msg);
		
		}
	});
}

function searchValidata(){

	if($('#searchKeyword').val()==""){
		alert("검색어를 입력하세요~");
		return false;
	}
	return true;
}


</script>

<div class='w3-col m3' id='friendRecommendClass'>
	<div class="pull-center well">
            <label style="width: 100%; margin: 0%; text-align: center;" >친구찾기</label>
            
           <div class="input-group custom-search-form" >
	           <select class="form-control" name="searchType" id='searchType' style="width: 20%;">
				<option value="member_email" ${'member_email' eq param.searchType?"selected":"" }>이메일</option>
				<option value="member_name" ${'member_name'==param.searchType?"selected":"" }>이름</option>
				<option value="ADDR2" ${'ADDR2' eq param.searchType?"selected":"" }>지역</option>
	           </select> 
            
            <input type="search" id="searchKeyword" placeholder="Search..." onkeypress=" if( event.keyCode == 13 && searchValidata()){searchsearch();}" style="width: 60%; " />
            </div>	           
    </div><hr>
    <div class="input-group custom-search-form" >
    <input class ='input1' onclick="concernSearch();" style="width: 30%; margin: 0%; " value="관심사">
    <input class ='input1' onclick="recognizableSearch();" style="width: 60%;margin: 0%;" value="알 수도 있는 친구">
    </div>
	<table  class='tablefriendKeyword' style="height:30%; width: 100%; margin: 0%;  overflow-y: scroll;">
    </table>
    <table class='tablefriendConcern' style="height:30%; width: 100%; margin: 0%;  overflow-y: scroll;">
    </table>
    <table class='tablefriendRecognize' style="height:30%; width: 100%; margin: 0%;  overflow-y: scroll; ">
    </table>
   
   
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>