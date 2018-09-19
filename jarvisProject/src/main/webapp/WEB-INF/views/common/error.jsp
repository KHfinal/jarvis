<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="<%=request.getContextPath()%>"/>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<style>
#error {
    height: 100vh;
}
</style>


<div class="jumbotron">
		<div class="d-flex justify-content-center align-items-center error" id="error">
		    <h1 class="mr-3 pr-3 align-top border-right inline-block align-content-center">error!</h1>
		    <div class="inline-block align-middle">
		    	<h2 class="font-weight-normal lead" id="desc">죄송합니다. 요청하신 서비스가 정상처리되지 않았습니다.</h2>
		    	뒤로가기: <a href="javascript:history.go(-1)">back</a>
		    </div>
		</div>
</div>