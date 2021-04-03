<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>게시판</title>
	</head>
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
    <script src="http://malsup.github.com/jquery.form.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			$(".cancel_btn").on("click", function(){
				location.href = "/board/readView?bno=${replyUpdate.bno}";
			})
			
		})
		
		function replyUpdate() {
			var yn = confirm("댓글을 수정 하시겠습니까?");

			if (yn == true) {

				$.ajax({
					
					url : "/board/replyUpdate",
					data    : $("#updateForm").serialize(),
					cache : false,
					async : true,
					type : 'POST',
					success : function(str) {
						replyUpdateCallBack(str);
					},
					error : function (request, error) {
						alert("code:" + request.status + "message:" + request.responseText);
					}
				});	
			}
		}
		
		function replyUpdateCallBack(str) {
			if (str != null) {
				var result = str;
				
				if (result == "SUCCESS") {
					alert("댓글을 수정하였습니다.");
					location.href = "/board/readView?bno=${replyUpdate.bno}";
				} else {
					alert("댓글 수정에 실패하였습니다.");
					return;
				}
			}
		}
		
	</script>
	<body>
		<div class="container">
			<header>
				<h1> 게시판</h1>
			</header>
			<hr />
			 
			<div>
				<%@include file="nav.jsp" %>
			</div>
			<hr />
			
			<section id="container">
				<form name="updateForm" id="updateForm" role="form" method="post" action="/board/replyUpdate">
					<input type="hidden" name="bno" value="${replyUpdate.bno}" readonly="readonly"/>
					<input type="hidden" id="rno" name="rno" value="${replyUpdate.rno}" />

					<div class="form-group">
						<label for="content" class="col-sm-2 control-label">댓글 내용</label>
						<input type="text" id="content" name="content" class="form-control" value="${replyUpdate.content}"/>
					</div>
					
					<div>
						<button type="button" class="update_btn btn btn-success" onclick="javascript:replyUpdate();">저장</button>
						<button type="button" class="cancel_btn btn btn-danger">취소</button>
					</div>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>