<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/payment.css"
	href="<%=request.getContextPath()%>/resources/js/form-validation.js" type="text/css">
<title>Appo_payment</title>
<style>
/* number 태그 화살표 제거 */
input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<%@ include file="../common/nav.jsp"%>



	<div class="container">
		<div class="row">


			<div class="col-md-12">

				<div class="order2 col-md-6 py-5">
					<h4 class="text-left font-weight-bold">주문/결제</h4>
				</div>

				<div class="order3 col-md-6 py-5">
					<div class="order col-md-2">
						<span class="num1 text-muted">01</span> <span
							class="numtitle1 text-muted">&nbsp;장바구니</span>
					</div>

					<div class="order col-md-2">
						<span class="font-weight-bold"><strong> > </strong></span> <span
							class="num2"><strong>02</strong></span> <span class="numtitle2"><strong>&nbsp;주문/결제</strong></span>
					</div>

					<div class="order col-md-2">
						<span class="text-muted">></span> <span class="num3 text-muted">03</span>
						<span class="numtitle3 text-muted">&nbsp;주문완료</span>
					</div>
				</div>

			</div>

			<p class="text-left text-muted">
				<small>선택하신 상품의 가격과 옵션정보는 하단 주문상품 정보에서 확인하실 수 있습니다.</small>
			</p>

		</div>
	</div>

	<div class="container">


		<hr id="hrcss">
		<br>

		<div class="row col-md-12 m-0">

			<div class="productimgbox">
				<img src="../img/5x5.png" id="img5x5">
			</div>

			<div>
				<span id="producttitle" name="">&nbsp;&nbsp;iPhone 8 64GB
					Silver</span> <span id="producttxt"> 상품을 주문합니다.</span><br> <span
					class="productstatus">상품번호 :</span> <span class="detailtxt">12345678</span><br>
				<span class="productstatus">상품상태 :</span> <span class="detailtxt">중고</span><br>
				<span class="productstatus">색상 :</span> <span class="detailtxt">스페이스그레이</span><br>
			</div>


		</div>
		<br>
		<hr id="hrcss">
	</div>

	<div class="container">
		<br> <br> <br>
		<h5 class="font-weight-bold">배송지 정보</h5>
		<hr id="hrcss">

		<form>
			<fieldset>
				<div class="form-group mb-0 ml-5">
					<label for="deliverySelect">배송지 선택</label>&nbsp; <select
						class="form-control-sm" id="deliverySelect">
						<option>KH 정보교육원 종로지원</option>
						<option>회사</option>
						<option>할머니댁</option>
					</select> &nbsp;
					<button type="button" class="btn btn-outline-secondary btn-sm"
						data-toggle="modal" data-target="#deliveryplace">배송지 관리</button>
				</div>
			</fieldset>
		</form>
		<hr id="hrcss">

		<!--배송지 관리 모달창 -->
		<div class="modal" id="deliveryplace">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">배송지 관리</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>

					<div class="modal-body">


						<form>
							<div class="card border-primary mb-3" style="max-width: auto;"
								id="delivery1">
								<div class="card-header font-weight-bold" id="deltitle">KH
									정보교육원 종로지원</div>
								<div class="card-body">
									<input type="text" class="form-control" id="name"
										placeholder="이름 입력" required></input><br>
									<div class="row mb-3 form-row">
										<div class="col-md-3">
											<input type="text" name="post"
												class="form-control postcodify_postcode5" id="post-1"
												placeholder="우편번호" required>
										</div>
										<div class="col-md-3">
											<button type="button" class="btn btn-primary"
												id="postcodify_search_button1">검색</button>
										</div>
									</div>

									<div class="row mb-3 form-row">
										<div class="col-md-9">
											<input type="text" class="form-control postcodify_address"
												name="address1" id="address1-1" placeholder="주소를 입력하세요"
												required>
										</div>
									</div>

									<div class="row mb-3 form-row">
										<div class="col-md-9">
											<input type="text" class="form-control postcodify_details"
												name="address2" id="address2-1" placeholder="상세주소를 입력하세요"
												required>
										</div>
									</div>

									<input type="number" class="form-control" id="phone"
										placeholder="휴대전화번호를 입력하세요" required></input><br> <input
										type="text" class="form-control" id="delmag"
										placeholder="배송요청 메세지를 입력하세요"></input><br>
								</div>
								<button type="button" class="btn btn-outline-secondary btn-sm">저장</button>
								<button type="submit" class="btn btn-primary btn-sm"
									data-dismiss="modal">선택</button>
							</div>
						</form>



						<form>
							<div class="card border-primary mb-3" style="max-width: auto;"
								id="delivery1">
								<div class="card-header font-weight-bold" id="deltitle">KH
									정보교육원 종로지원</div>
								<div class="card-body">
									<input type="text" class="form-control" id="name"
										placeholder="이름 입력" required></input><br>
									<div class="row mb-3 form-row">
										<div class="col-md-3">
											<input type="text" name="post"
												class="form-control postcodify_postcode5" id="post-2"
												placeholder="우편번호" required>
										</div>
										<div class="col-md-3">
											<button type="button" class="btn btn-primary"
												id="postcodify_search_button2">검색</button>
										</div>
									</div>

									<div class="row mb-3 form-row">
										<div class="col-md-9">
											<input type="text" class="form-control postcodify_address"
												name="address1" id="address1-2" placeholder="주소를 입력하세요"
												required>
										</div>
									</div>

									<div class="row mb-3 form-row">
										<div class="col-md-9">
											<input type="text" class="form-control postcodify_details"
												name="address2" id="address2-2" placeholder="상세주소를 입력하세요"
												required>
										</div>
									</div>

									<input type="number" class="form-control" id="phone"
										placeholder="휴대전화번호를 입력하세요" required></input><br> <input
										type="text" class="form-control" id="delmag"
										placeholder="배송요청 메세지를 입력하세요"></input><br>
								</div>
								<button type="button" class="btn btn-outline-secondary btn-sm">저장</button>
								<button type="submit" class="btn btn-primary btn-sm"
									data-dismiss="modal">선택</button>
							</div>
						</form>

						<form>
							<div class="card border-primary mb-3" style="max-width: auto;"
								id="delivery1">
								<div class="card-header font-weight-bold" id="deltitle">KH
									정보교육원 종로지원</div>
								<div class="card-body">
									<input type="text" class="form-control" id="name"
										placeholder="이름 입력" required></input><br>
									<div class="row mb-3 form-row">
										<div class="col-md-3">
											<input type="text" name="post"
												class="form-control postcodify_postcode5" id="post-3"
												placeholder="우편번호" required>
										</div>
										<div class="col-md-3">
											<button type="button" class="btn btn-primary"
												id="postcodify_search_button3">검색</button>
										</div>
									</div>

									<div class="row mb-3 form-row">
										<div class="col-md-9">
											<input type="text" class="form-control postcodify_address"
												name="address1" id="address1-3" placeholder="주소를 입력하세요"
												required>
										</div>
									</div>

									<div class="row mb-3 form-row">
										<div class="col-md-9">
											<input type="text" class="form-control postcodify_details"
												name="address2" id="address2-3" placeholder="상세주소를 입력하세요"
												required>
										</div>
									</div>


									<input type="number" class="form-control" id="phone"
										placeholder="휴대전화번호를 입력하세요" required></input><br> <input
										type="text" class="form-control" id="delmag"
										placeholder="배송요청 메세지를 입력하세요"></input><br>
								</div>
								<button type="button" class="btn btn-outline-secondary btn-sm">저장</button>
								<button type="submit" class="btn btn-primary btn-sm"
									data-dismiss="modal">선택</button>
							</div>
						</form>

						<!-- jQuery와 postcodify 를 로딩한다. -->
						<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
						<script>
							$(function() {
								$("#postcodify_search_button1")
										.postcodifyPopUp({
											insertPostcode5 : "#post-1",
											insertAddress : "#address1-1",
											insertDetails : "#address2-1",
											hideOldAddresses : false
										});
							});
							$(function() {
								$("#postcodify_search_button2")
										.postcodifyPopUp({
											insertPostcode5 : "#post-2",
											insertAddress : "#address1-2",
											insertDetails : "#address2-2",
											hideOldAddresses : false
										});
							});
							$(function() {
								$("#postcodify_search_button3")
										.postcodifyPopUp({
											insertPostcode5 : "#post-3",
											insertAddress : "#address1-3",
											insertDetails : "#address2-3",
											hideOldAddresses : false
										});
							});
						</script>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-secondary"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>



		<form class="needs-validation" novalidate>
			<div class="row">
				<div class="col-md-12 mb-3 ml-5">
					<table>
						<tr>
							<th class="isth">이름</th>
							<td>홍길동</td>
						</tr>
						<tr>
							<th class="isth">연락처</th>
							<td>010-1111-1111</td>
						</tr>
						<tr>
							<th class="isth">주소</th>
							<td>서울 중구 남대문로 1가 18, 2층 A강의장</td>
						</tr>
						<tr>
							<th class="isth">배송 메모</th>
							<td>문앞에 두고 가주세요</td>
						</tr>
					</table>
				</div>
			</div>
			<hr id="hrcss">
			<br> <br> <br>
			<h5 class="font-weight-bold">주문상품 정보</h5>
			<hr id="hrcss">


			<div class="col-md-12">
				<span class="mr-5 ml-3">상품정보</span> <span
					class="font-weight-bold ml-5">일반상품</span> <span
					class="pull-right text-muted ml-5 mr-3">배송비</span> <span
					class="pull-right text-muted ml-5">상품금액</span> <span
					class="pull-right text-muted">판매자명</span>
			</div>
			<hr id="hrcss">


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
				<div class="col-md-5">
					<span class="pull-right mr-3 ml-5 mt-4 pt-2">2,500</span> <span
						class="pull-right mr-3 ml-5 mt-4 pt-2">900,000</span> <span
						class="pull-right mr-4 ml-5 mt-4 pt-2">IDIDID</span>
				</div>

			</div>

			<hr id="hrcss">

			<div class="col-md-12">
				<span class="pull-right ml-5 mr-2">900,000</span> <span
					class="pull-right">상품금액</span><br> <span
					class="pull-right ml-5 mr-2">2,500</span> <span
					class="pull-right mr-3">배송비</span>
			</div>
			<br>
			<hr id="hrcss">

			<div>
				<span class="totalprice font-weight-bold ml-3">총 주문 금액</span> <span
					class="totalprice font-weight-bold pull-right mr-3">원</span> <span
					class="totalprice font-weight-bold pull-right mr-2">902,500</span>
			</div>

			<hr id="hrcss">
			<br> <br> <br>


			<h5 class="font-weight-bold">결제수단</h5>
			<hr id="hrcss">
			<div class="col-md-12">
				<span class="mr-5 ml-3">결제 방법</span>
				<form>
					<input type="radio" id="creditcard"> <label
						for="creditcard">신용카드</label> &nbsp;&nbsp;&nbsp;&nbsp; <input
						type="radio" id="bankdeposit"> <label for="bankdeposit">무통장입금</label>
				</form>
			</div>

			<hr id="hrcss">

			<div class="col-md-12">
				<button class="btn btn-primary btn-lg col-md-5" type="submit"
					id="undobutton">취소</button>
				<button class="btn btn-primary btn-lg col-md-5" type="submit"
					id="paymentbutton">결제 하기</button>
			</div>
		</form>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div>
		<h2 class="font-weight-bold ml-5">꼭 ! 확인해주세요</h2>
		<h6 class="font-weight-bold" id="warningtxt">중고 물품 거래 특성 상 구매자의
			단순 변심으로 인한 취소, 반품, 교환이 불가 하오니 다시한번 꼭 확인하시고 결제하시길 바랍니다.</h6>

	</div>
	<br><br><br>


	<div>
		<%@ include file="../common/footer.jsp"%>
	</div>
</body>
</html>