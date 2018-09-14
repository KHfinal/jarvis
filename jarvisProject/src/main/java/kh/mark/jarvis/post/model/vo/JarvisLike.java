package kh.mark.jarvis.post.model.vo;

public class JarvisLike {
   private int likeNo;
   private String likeMember;
   private int postRef;
   private int commentRef;
   private int likeCheck;
   
   public JarvisLike() {
      
   }

   public JarvisLike(int likeNo, String likeMember, int postRef, int commentRef, int likeCheck) {
      super();
      this.likeNo = likeNo;
      this.likeMember = likeMember;
      this.postRef = postRef;
      this.commentRef = commentRef;
      this.likeCheck = likeCheck;
   }

   public int getLikeNo() {
      return likeNo;
   }

   public void setLikeNo(int likeNo) {
      this.likeNo = likeNo;
   }

   public String getLikeMember() {
      return likeMember;
   }

   public void setLikeMember(String likeMember) {
      this.likeMember = likeMember;
   }

   public int getPostRef() {
      return postRef;
   }

   public void setPostRef(int postRef) {
      this.postRef = postRef;
   }

   public int getCommentRef() {
      return commentRef;
   }

   public void setCommentRef(int commentRef) {
      this.commentRef = commentRef;
   }

   public int getLikeCheck() {
      return likeCheck;
   }

   public void setLikeCheck(int likeCheck) {
      this.likeCheck = likeCheck;
   }

   @Override
   public String toString() {
      return "JarvisLike [likeNo=" + likeNo + ", likeMember=" + likeMember + ", postRef=" + postRef + ", commentRef="
            + commentRef + ", likeCheck=" + likeCheck + "]";
   }


}

