<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/form-validation.css">

<title>Appo_paymentresult</title>
</head>
<body>

	<%@ include file="../common/header.jsp"%>
	<%@ include file="../common/nav.jsp"%>


	<div class="container">

		<!-- content -->
		<div class="row">
			<div class="container">


				<div class="col-md-12">

					<div class="order2 col-md-6 py-5">
						<h4 class="text-left font-weight-bold">주문완료</h4>
					</div>

					<div class="order3 col-md-6 py-5">
						<div class="order col-md-2">
							<span class="num1 text-muted">01</span> <span
								class="numtitle1 text-muted">&nbsp;장바구니</span>
						</div>

						<div class="order col-md-2">
							<span class="text-muted"><strong> > </strong></span> <span
								class="num3 text-muted">02</span> <span
								class="numtitle2  text-muted">&nbsp;주문/결제</span>
						</div>

						<div class="order col-md-2">
							<span class="font-weight-bold"><strong> > </strong></span> <span
								class="num2"><strong>03</strong></span> <span class="numtitle3"><strong>&nbsp;주문완료</strong></span>
						</div>
					</div>

				</div>

				<p class="text-left text-muted">
					<small>선택하신 상품의 가격과 옵션정보는 구매내역 정보에서 확인하실 수 있습니다.</small>
				</p>

				<br>
				<br>
				<br>
				<div class="col-md-12 text-center">
					<h3>
						<strong>결제가 정상적으로 완료되었습니다.</strong>
					</h3>
				</div>
			</div>

		</div>
		<br>
		<br>
		<br>

		<hr id="hrcss">


		<div class="col-md-12">
			<span class="font-weight-bold ml-3">구매내역 -</span> <span
				class="font-weight-bold">일반상품</span> <span
				class="pull-right text-muted ml-5 mr-4">2019.12.27</span> <span
				class="pull-right text-muted ml-2">239243658</span> <span
				class="pull-right text-muted">주문번호</span>

			<hr id="hrcss">
		</div>

		<div class="row">

			<div class="productimgbox ml-5">
				<img src="../img/5x5.png" id="img5x5">
			</div>

			<div class="col-md-5">
				<span id="producttitle2" name="">&nbsp;&nbsp;iPhone 8 64GB
					Silver</span><br> <span class="productstatus2">상품번호 :</span> <span
					class="detailtxt2">12345678</span><br> <span
					class="productstatus2">상품상태 :</span> <span class="detailtxt2">중고</span><br>
				<span class="productstatus2">색상 :</span> <span class="detailtxt">스페이스그레이</span><br>
			</div>
			<div class="col-md-5 ml-4">
				<span class="pull-right mt-4 pt-2 mr-4">원</span> <span
					class="pull-right mr-1 ml-5 mt-4 pt-2">902,500</span>

			</div>

		</div>


		<hr id="hrcss">


		<div class="d-flex justify-content-center">
			<button class="btn btn-primary btn-lg mr-1" type="submit"
				id="mainbutt">메인으로</button>
			<button class="btn btn-info btn-lg ml-1" type="submit" id="paybutt">구매내역</button>
		</div>


	</div>






	<div>
		<%@ include file="../common/footer.jsp"%>
	</div>

</body>
</html>