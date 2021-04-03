<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		
	<style type="text/css">
		#reply{ margin:10px; padding: 10px;}
	</style>
	
	<title>게시판</title>
	</head>
	<% 
		String bno = request.getParameter("bno"); 
		String rno = request.getParameter("rno");
	%>
	<c:set var="bno" value="<%=bno%>"></c:set>
	<c:set var="rno" value="<%=rno%>"></c:set>
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
    <script src="http://malsup.github.com/jquery.form.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='readForm']");

			// 답글
			$(".reply_btn").on("click", function(){
				formObj.attr("action", "/board/replyWriteView");
				formObj.attr("method", "get");
				formObj.submit();			
			})
			
			// 수정
			$(".update_btn").on("click", function(){
				formObj.attr("action", "/board/updateView");
				formObj.attr("method", "get");
				formObj.submit();				
			})
			
			// 취소
			$(".list_btn").on("click", function(){
				location.href = "/board/list";
			})

			// 댓글 수정
			$(".replyUpdate_btn").on("click", function() {
				location.href = "/board/replyUpdateView?bno=${read.bno}" + "&rno=" + $(this).attr("data-rno");
			})
			
			$(".replyDelete_btn").on("click", function() {
				var yn = confirm("댓글을 삭제하시겠습니까?");
				
				if (yn == true) {
					$.ajax({
						url : "/board/replyDelete?bno=${read.bno}" + "&rno=" + $(this).attr("data-rno"),
						success : function(str) {
							if (str == "SUCCESS") {
								alert("댓글을 삭제하였습니다.");
								location.href = "/board/readView?bno=${read.bno}";
							}
						}		
					});
				}
			})
		})
		
		// 게시글 삭제
		function deleteBoard() {
			var yn = confirm("게시글을 삭제하시겠습니까?");

			var bno = $("#bno").val();
			
			if (yn == true) {
				
				$.ajax({
					
					url : "/board/delete",
					data    : $("#readForm").serialize(),
					cache : false,
					async : true,
					type : 'POST',
					success : function(str) {
						deleteCallBack(str);
					},
					error : function (request, error) {
						alert("code:" + request.status + "message:" + request.responseText);
					}
				});	
			}
		}
		
		function deleteCallBack(str) {
			if (str != null) {
				var result = str;
				
				if (result == "SUCCESS") {
					alert("게시글을 삭제하였습니다.");
					location.href = "/board/list";
				} else {
					alert("게시글 삭제에 실패하였습니다.");
					return;
				}
			}
		}
		
		// 댓글작성
		function replyWrite() {
			var yn = confirm("댓글을 등록하시겠습니까?")
			
			if (yn == true) {
				$.ajax({
					
					url : "/board/writeReply",
					data : $("#replyForm").serialize(),
					cache : false,
					async : true,
					type : 'POST',
					success : function(str) {
						replyCallBack(str);
					},
					error : function(request, error) {
						alert("code:" + request.status + "message:" + request.responseText);
					}
				});
			}
		}
		
		function replyCallBack(str) {
			if (str != null) {
				var result = str;
				
				if (result == "SUCCESS") {
					alert("댓글을 등록하였습니다.");
					location.href = "/board/readView?bno=${read.bno}";
				} else {
					alert("댓글 등록에 실패하였습니다.");
					return;
				}
			}
		}
		
		function fn_fileDown(fileNo) {
			var formObj = $("form[name='readForm']");
			$("#FILE_NO").attr("value", fileNo);
			formObj.attr("action", "/board/fileDown");
			formObj.submit();
		}
		
// 		function replyUpdateBtn() {
// 			var htmls = '';
			
// 			htmls += '<c:forEach items="${replyList}" var="replyList">';
// 			htmls += '<input type="text" name="bno" value="${read.bno}" readonly="readonly"/>';
// 			htmls += '<input type="hidden" id="rno" name="rno" value="${replyList.rno}" />';

// 			htmls += '<div class="form-group">';
// 			htmls += '<label for="content" class="col-sm-2 control-label">수정 내용</label>';
// 			htmls += '<input type="text" id="content" name="content" class="form-control" value="${replyList.content}"/>';
// 			htmls += '</div>';
			
// 			htmls += '<div>';
// 			htmls += '<button type="button" class="update_btn btn btn-success" onclick="javascript:replyUpdate();">저장</button>';
// 			htmls += '<button type="button" class="cancel_btn btn btn-danger">취소</button>';
// 			htmls += '</div>';
// 			htmls += '</c:forEach>';
// 			$("#replyUpdateContent").html(htmls);
// 		}
	

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
				<form name="readForm" id="readForm" role="form" method="post">
					<input type="hidden" id="bno" name="bno" value="${read.bno}" >
					<input type="hidden" id="origNo" name="origNo" value="${read.origNo}" >
					<input type="hidden" id="depth" name="depth" value="${read.depth}" />
					<input type="hidden" id="groupLayer" name="groupLayer" value="${read.groupLayer}" />
					<input type="hidden" id="FILE_NO" name="FILE_NO" value="">
				</form>
				
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input type="text" id="title" name="title" class="form-control" value="${read.title}" readonly="readonly" />
				</div>
				
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<textarea id="content" name="content" class="form-control" readonly="readonly"><c:out value="${read.content}" /></textarea>
				</div>
				
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<input type="text" id="writer" name="writer" class="form-control" value="${read.writer}"  readonly="readonly"/>
				</div>
				
				<div class="form-group">
					<label for="regdate" class="col-sm-2 control-label">작성 날짜</label>
					<fmt:formatDate value="${read.regdate}" pattern="yyyy-MM-dd" />		
				</div>
				<hr>
				<span>파일 목록</span>
				<div class="form-group" style="border: 1px solid #dbdbdb;">
					<c:forEach var="file" items="${file}">
						<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
					</c:forEach>
				</div>
				<hr>
				<div>
					<button type="button" class="reply_btn btn btn-warning">답글</button>
					<button type="submit" class="update_btn btn btn-danger">수정</button>
					<button type="button" class="delete_btn btn btn-primary" onclick="javascript:deleteBoard();">삭제</button>
				</div>
				
				<!-- 댓글 -->
				<div id="reply">
					<ol class ="replyList">
						<c:forEach items="${replyList}" var="replyList">
							<li>
								<p>
									작성자 : ${replyList.writer} <br /> 
									작성날짜 : <fmt:formatDate value="${replyList.regdate}" pattern="yyyy-MM-dd"/>
								</p>
								<p>${replyList.content}</p>
								<div>
									<button type="button" class="replyUpdate_btn btn btn-warning" data-rno="${replyList.rno}">수정</button>
									<button type="button" class="replyDelete_btn btn btn-danger" data-rno="${replyList.rno}">삭제</button>
								</div>
								<hr />
							</li>	
							
						</c:forEach>
					</ol>
				</div>
				<form name="replyForm" id="replyForm" method="post" class="form-horizontal" action="/board/writeReply">
					<input type="hidden" id="bno" name="bno" value="${read.bno}" />
					<div class="form-group">
						<label for="writer" class="col-sm-2 control-label">댓글 작성자</label>
						<div class="col-sm-10">
							<input type="text" id="writer" name="writer" class="form-control" />
						</div>
					</div>
					
					<div class="form-group">
						<label for="content" class="col-sm-2 control-label">댓글 내용</label>
						
						<div class="col-sm-10">
							<input type="text" id="content" name="content" class="form-control" />
						</div>
					</div>
						
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="button" class="writeReply_btn btn btn-success" onclick="javascript:replyWrite();">작성</button>
						</div>
					</div>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>