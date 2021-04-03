<%@page import="kr.co.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>게시판</title>
	
	
	 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
    <script src="http://malsup.github.com/jquery.form.js"></script>
	<script type="text/javascript">
	
		$(document).ready(function(){
			fn_addFile();
		})
	
		function fn_addFile() {
			var fileIndex = 1;
			$(".fileAdd_btn").on("click", function() {
				$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:bottom;' id='fileDelBtn'>"+"삭제"+"</button></div>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
			});
		}
		
		function writeReplyBoard() {
			var yn = confirm("답글을 등록하시겠습니까?");

			if (yn == true) {
				
				$("#replyWriteForm").ajaxForm({
					
					url : "/board/replyWrite",
					enctype : "multipart/form-data",
					cache : false,
					async : false,
					type : 'POST',
					success : function(str) {
						writeReplyCallBack(str);
					},
					error : function (request, error) {
						alert("code:" + request.status + "message:" + request.responseText);
					}
				}).submit();
				
				
			}
		}
		
		function writeReplyCallBack(str) {
			if (str != null) {
				var result = str;
				
				if (result == "SUCCESS") {
					alert("답글을 등록하였습니다.");
					location.href = "/board/list";
				} else {
					alert("답글 등록에 실패하였습니다.");
					return;
				}
			}
		}
	</script>	
	</head>
	<body>
	<div class="container">
		<header>
			<h1>게시판</h1>
		</header>
		<hr />
		
		<div>
			<%@ include file="nav.jsp" %>
		</div>
		<hr />
		
		<section id="container">
			<form name="replyWriteForm" id="replyWriteForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="origNo" value="${read.origNo}" readonly="readonly"/>
				<input type="hidden" name="depth" value="${read.depth}"/>
				<input type="hidden" name="groupLayer" value="${read.groupLayer}"/>
				
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input type="text" id="title" name="title" class="form-control" value="${read.title}" readonly="readonly" //>	
				</div>
				
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<input type="text" id="content" name="content" class="form-control"/>	
				</div>
				
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<input type="text" id="writer" name="writer" class="form-control"/>	
				</div>
				
				<div class="form-group">
					<label for="upload">첨부파일</label>
					<input type="file" name="file" />
				</div>
				
				<div id="fileIndex">
				</div>
				<div class="form-group">
					<button type="button" class="replyBoard_btn btn btn-success" onclick="javascript:writeReplyBoard();">작성</button>	
					<button type="button" class="fileAdd_btn">파일 추가</button>
				</div>
			</form>	
		</section>
		<hr />
	</div>
</body>
</html>