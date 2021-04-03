<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>게시판</title>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
    <script src="http://malsup.github.com/jquery.form.js"></script>
	<script type="text/javascript">
	
		$(document).ready(function(){
			var formObj = $("form[name='writeForm']");
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				writeBoard();
				fn_addFile();
			});
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
		
		function writeBoard() {
			var yn = confirm("게시글을 등록하시겠습니까?");

			if (yn == true) {
				
				$("#writeForm").ajaxForm({
					
					url : "/board/write",
					enctype : "multipart/form-data",
					cache : false,
					async : false,
					type : 'POST',
					success : function(str) {
						writeCallBack(str);
					},
					error : function (request, error) {
						alert("code:" + request.status + "message:" + request.responseText);
					}
				}).submit();
				
				
			}
		}
		
		function writeCallBack(str) {
			if (str != null) {
				var result = str;
				
				if (result == "SUCCESS") {
					alert("게시글을 등록하였습니다.");
					location.href = "/board/list";
				} else {
					alert("게시글 등록에 실패하였습니다.");
					return;
				}
			}
		}
		
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
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
		$(function() {
		      $('#writer').keyup(function (e){
		          var content = $(this).val();
		          $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
		          $('#counter3').html(content.length + '/10');
		          
		          if (content.length > 10){
				        alert("최대 10자까지 입력 가능합니다.");
				        $(this).val(content.substring(0, 10));
				        $('#counter3').html("(10 / 최대 10자)");
				    }
		      });
		      $('#writer').keyup();
		});
		
	</script>	
	</head>
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
				<form name="writeForm" id ="writeForm" method="post" action="/board/write" enctype="multipart/form-data" onsubmit="return false;">
					<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<textarea id="title" name="title" class="form-control chk DOC_TEXT" placeholder="50자 이내" title="제목을 입력하세요."></textarea>	
					<span style="color:#aaa" id="counter">(0 / 최대 50자)</span>
				</div>
				
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<textarea id="content" name="content" class="form-control chk DOC_TEXT" placeholder="200자 이내" title="내용을 입력하세요."></textarea>		
					<span style="color:#aaa" id="counter2">(0 / 최대 200자)</span>
					</div>
		
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<input type="text" id="writer" name="writer" class="form-control chk DOC_TEXT" placeholder="10자 이내" title="작성자를 입력하세요." />	
					<span style="color:#aaa" id="counter3">(0 / 최대 10자)</span>
				</div>		
				
				<div class="form-group">
					<label for="upload">첨부파일</label>
					<input type="file" name="file">
				</div>
				<div id="fileIndex">
				</div>
				<div class="form-group">
					<button type="button" class="write_btn btn btn-success">작성</button>	
					<button type="button" class="fileAdd_btn">파일 추가</button>
				</div>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>