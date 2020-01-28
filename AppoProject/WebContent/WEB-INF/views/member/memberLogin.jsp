<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.kh.appoproject.member.model.vo.Member"%>
<%
	Member member = (Member) request.getAttribute("member");

	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/signin2.css" type="text/css">
<title>Appo_login</title>
</head>
<body>



	<div>
		<%@ include file="../common/header.jsp"%>
		<%@ include file="../common/nav.jsp"%>

		<div class="row">
			<div class="col-md-12 mt-5">
				<form class="form-signin" method="POST" action="login" onsubmit="return loginValidate();">
					<img src="<%=request.getContextPath()%>/resources/appoimg/appologo_White.png"
						class="mb-4 rounded mx-auto d-block" width="72" height="auto">

					<h1 class="h2 mb-3 font-weight-bold text-center">로그인</h1>

					<label for="inputId" class="sr-only">아이디</label> <input name="member_Id"
						type="text" id="inputId" class="form-control"
						placeholder="아이디" required autofocus> <label
						for="inputPassword" class="sr-only">비밀번호</label> <input name="member_Pwd"
						type="password" id="inputPassword" class="form-control"
						placeholder="비밀번호" required>

					<div class="checkbox mb-3">
						<label> 
							<input type="checkbox" id="save" name="save" <%= save ? "checked" :"" %>><small>&nbsp;&nbsp;아이디 저장</small>
						</label>
					</div>
					
	
					

					<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>

					<div class="text-center">
						<br> 
						<a href="#">아이디 / 비밀번호 찾기</a>
						<br> 
						<a href="<%=request.getContextPath()%>/member/joinForm">회원가입</a>
					</div>

					<p class="mt-5 mb-3 text-muted small text-center">&copy; Appo
						Corp. All Rights Reserved.</p>
					<br> <br>

				</form>

				<p class="text-center">
					문의사항이 있을경우 : <a href="#">고객지원</a>
				</p>
				<br>
				<hr>

			</div>
		</div>
		<%@ include file="../common/footer.jsp"%>
	</div>

	<script>
		function loginValidate() {
			if ($("#member_Id").val().trim().length == 0) {
				alert("아이디를 입력하세요");
				$("#member_Id").focus();

				return false;
			}

			if ($("#member_Pwd").val().trim().length == 0) {
				alert("비밀번호를 입력하세요.");
				$("#member_Pwd").focus();

				return false;
			}
			return true;

		}
	</script>
</body>
</html>