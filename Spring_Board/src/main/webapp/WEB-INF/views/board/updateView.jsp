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
			
			$(".update_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				updateBoard();
			});
			
			$(document).on("click","#fileDel", function(){
				$(this).parent().remove();
			})
			
			fn_addFile();
			
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/board/readView?bno=${update.bno}";
			})
		})
		
		function updateBoard() {
			var yn = confirm("게시글을 수정하시겠습니까?");

			if (yn == true) {
				
				$("#updateForm").ajaxForm({
					
					url : "/board/update",
					enctype : "multipart/form-data",
					cache : false,
					async : false,
					type : 'POST',
					success : function(str) {
						updateCallBack(str);
					},
					error : function (request, error) {
						alert("code:" + request.status + "message:" + request.responseText);
					}
				}).submit();
				
				
			}
		}
		
		function updateCallBack(str) {
			if (str != null) {
				var result = str;
				
				if (result == "SUCCESS") {
					alert("게시글을 수정하였습니다.");
					location.href = "/board/readView?bno=${update.bno}";
				} else {
					alert("게시글 수정에 실패하였습니다.");
					return;
				}
			}
		}
		
		function fn_addFile(){
			var fileIndex = 1;
			//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
			$(".fileAdd_btn").on("click", function(){
				$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:bottom;' id='fileDelBtn'>"+"삭제"+"</button></div>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
		}
 		var fileNoArry = new Array();
 		var fileNameArry = new Array();
 		function fn_del(value, name) {
 			
 			fileNoArry.push(value);
 			fileNameArry.push(name);
 			$("#fileNoDel").attr("value", fileNoArry);
 			$("#fileNameDel").attr("value", fileNameArry);
 		}
 		
 		function fn_valiChk(){
			var regForm = $("form[name='updateForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
 		
 		$(function() {
		      $('#title').keyup(function (e){
		          var content = $(this).val();
		          $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
		          $('#counter').html(content.length + '/50');
		          
		          if (content.length > 50){
				        alert("최대 50자까지 입력 가능합니다.");
				        $(this).val(content.substring(0, 50));
				        $('#counter').html("(50 / 최대 50자)");
				    }
		      });
		      $('#title').keyup();
		});
		$(function() {
		      $('#content').keyup(function (e){
		          var content = $(this).val();
		          $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
		          $('#counter2').html(content.length + '/200');
		          
		          if (content.length > 200){
				        alert("최대 200자까지 입력 가능합니다.");
				        $(this).val(content.substring(0, 200));
				        $('#counter2').html("(200 / 최대 200자)");
				    }
		      });
		      $('#content').keyup();
		});
 		
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
				<form name="updateForm" id ="updateForm" role="form" method="post" action="/board/update" enctype="multipart/form-data">
					<input type="hidden" name="bno" value="${update.bno}" readonly="readonly"/>
					<input type="hidden" id="fileNoDel" name="fileNoDel[]" value="">
					<input type="hidden" id="fileNameDel" name="fileNameDel[]" value="">
					<div class="form-group">
						<label for="title" class="col-sm-2 control-label">제목</label>
						<input type="text" id="title" name="title" value="${update.title}" class="form-control chk DOC_TEXT" placeholder="50자 이내" title="제목을 입력하세요" />
						<span style="color:#aaa" id="counter">(0 / 최대 50자)</span>
					</div>
					
					<div class="form-group">
						<label for="content" class="col-sm-2 control-label">내용</label>
						<input type="text" id="content" name="content" value="${update.content}" class="form-control chk DOC_TEXT" placeholder="200자 이내" title="내용을 입력하세요" />
						<span style="color:#aaa" id="counter2">(0 / 최대 50자)</span>
					</div>
					
					<div class="form-group">
						<label for="writer" class="col-sm-2 control-label">작성자</label>
						<input type="text" id="writer" name="writer" value="${update.writer}" class="form-control" readonly="readonly"/>
					</div>
					
					<div class="form-group">
						<label for="regdate" class="col-sm-2 control-label">작성날짜</label>
						<fmt:formatDate value="${update.regdate}" pattern="yyyy-MM-dd"/>		
					</div>
					<div id="fileIndex">
						<c:forEach var="file" items="${file}" varStatus="var">
							<div>
								<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${file.FILE_NO }">
								<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
								<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
								<button id="fileDel" onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index}');" type="button">삭제</button><br>
							</div>
						</c:forEach>
					</div>
					<div>
						<button type="button" class="update_btn btn btn-success">저장</button>
						<button type="button" class="cancel_btn btn btn-danger">취소</button>
						<button type="button" class="fileAdd_btn btn btn-warning">파일추가</button>
					</div>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>