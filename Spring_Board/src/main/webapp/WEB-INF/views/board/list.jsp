<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
	<title>게시판</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<style type="text/css">
		li {list-style: none; float: left; padding: 6px;}
		td {margin: 0px; height: 0px;}
	</style>
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
				<form role="form" method="post" action="/board/write">
					<table class="table table-hover">
						<tr><th>번호</th><th>제목</th><th>작성자</th><th>등록일</th></tr>
					
					<c:forEach items="${list}" var = "list">
						<tr>
							<td><c:out value="${list.bno}" /></td>
							<td align="left">
								<a href="/board/readView?bno=${list.bno}" style="text-decoration: none;">
								<c:if test="${list.groupLayer > 0}">
									<c:forEach begin="1" end="${list.groupLayer}">
										<span style="padding-left: 20px;"></span>
									</c:forEach>
								</c:if>
									<c:out value="${list.title}" /></a>
							</td>
							<td><c:out value="${list.writer}" /></td>
							<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
						
					</table>
					<div class="col-md-offset-3">
						<ul class="pagination">
							<c:if test="${pageMaker.prev}">
	    						<li><a href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
	    					</c:if> 
	
	   						 <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
	    						<li <c:out value="${pageMaker.cri.page == idx ? 'class=active' : ''}"/>>
	    							<a href="list${pageMaker.makeQuery(idx)}">${idx}</a>
	    						</li>
	    					</c:forEach>
	
						    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						    	<li><a href="list${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
						    </c:if> 
						</ul>
					</div>
				</form>
			</section>
			<hr />
		</div>
	</body>
</html>