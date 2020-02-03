<%@page import="com.kh.appoproject.destination.model.vo.Destination"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>   
<%@page import="com.kh.appoproject.product.model.vo.Product"%>
<%
	List<Product> pList = (List<Product>)request.getAttribute("pList");
	List<Destination> dList = (List<Destination>)request.getAttribute("dList");

	int productPrice = 0;
	int fee = 3000;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/payment.css"
	href="<%=request.getContextPath()%>/resources/js/form-validation.js" type="text/css">
<title>Appo_payment</title>

<script type="text/javascript"src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

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
			<% Product product0 = pList.get(0); %>
	 		<div class="productimgbox">
			<% if (product0.getImagePath()==null){ %>
				<img src="../img/5x5.png" id="img5x5">
				<% } else{ %>
				<img src="../img/5x5.png" id="img5x5">
				 <% } %>
			</div>
			
			<div>
				<span id="producttitle" name="">&nbsp;&nbsp;<%= product0.getProductTitle() %>&nbsp;
				<%= product0.getDeviceName() %>&nbsp;<%= product0.getItemName() %></span>
						<% if(pList.size() == 1) { %>
						<span id="producttxt"> 상품을 주문합니다.</span><br>
						<% } else { %>					
							<span id="producttxt"> 상품 외 <%=pList.size()-1 %>개의 상품을 주문합니다.</span><br> 
						<% } %>
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
						<% if (dList.size() > 0) { %>
						
							<% for(Destination dest : dList) { %>
							<option><%=dest.getDestinationName() %></option>
							<% }%>
							
						<%} else { %>
						
							<option value="" disabled selected>등록한 배송지가 없습니다. 추가하여 주세요</option>
							
						<% } %>
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
					
						<% for(Destination dest : dList) { %>
							<% String[] address = dest.getDestinationAddr().split(","); %>
							<form method="get">
								<div class="card border-primary mb-3" style="max-width: auto;"
									id="delivery1">
									<div class="card-header font-weight-bold" id="deltitle">
										<%= dest.getDestinationName() %></div>
									<div class="card-body">
										<input type="text" class="form-control" id="name"
											placeholder="이름 입력" required value="<%=dest.getDestinationReceiver()%>"></input><br>
										<div class="row mb-3 form-row">
											<div class="col-md-3">
												<input type="text" name="post"
													class="form-control postcodify_postcode5" id="post-1"
													placeholder="우편번호" required value="<%= address[0] %>">
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
													required value="<%= address[1] %>">
											</div>
										</div>
	
										<div class="row mb-3 form-row">
											<div class="col-md-9">
												<input type="text" class="form-control postcodify_details"
													name="address2" id="address2-1" placeholder="상세주소를 입력하세요"
													required value="<%= address[2] %>">
											</div>
										</div>
	
										<input type="text" class="form-control" id="phone" value="<%=dest.getDestinationContact()%>"
											placeholder="휴대전화번호를 입력하세요" required ></input><br> <input
											type="text" class="form-control" id="delmag"
											placeholder="배송요청 메세지를 입력하세요" value="<%= dest.getDestinationNote()%>"></input><br>
									</div>
									<button type="button" class="btn btn-outline-secondary btn-sm">저장</button>
									<button type="submit" class="btn btn-primary btn-sm"
										data-dismiss="modal">선택</button>
								</div>
							</form>
						<% } %>
						<% for(int i = 0 ; i < 3 - dList.size() ; i++) {%>
						<form method="get">
							<div class="card border-primary mb-3" style="max-width: auto;"
								id="delivery1">
								<div class="card-header font-weight-bold" id="deltitle">
								  <input type="text" name="destName" placeholder="배송지 이름 입력" size=30></div>
								<div class="card-body">
									<input type="text" class="form-control" id="name" name="receiveName"
										placeholder="이름 입력" required></input><br>
									<div class="row mb-3 form-row">
										<div class="col-md-3">
											<input type="text" name="post"
												class="form-control postcodify_postcode5" id="post-2"
												placeholder="우편번호" required>
										</div>
										<div class="col-md-3">
											<button type="button" class="btn btn-primary"
												id="postcodify_search_button<%=i+2%>">검색</button>
										</div>
									</div>

									<div class="row mb-3 form-row">
										<div class="col-md-9">
											<input type="text" class="form-control postcodify_address"
												name="address1" id="address1-<%=i+2%>" placeholder="주소를 입력하세요"
												required>
										</div>
									</div>

									<div class="row mb-3 form-row">
										<div class="col-md-9">
											<input type="text" class="form-control postcodify_details"
												name="address2" id="address2-<%=i+2%>" placeholder="상세주소를 입력하세요"
												required>
										</div>
									</div>

									<input type="text" class="form-control" id="phone" name="phone"
										placeholder="휴대전화번호를 입력하세요" required></input><br> <input
										type="text" class="form-control" id="delmag" name="note"
										placeholder="배송요청 메세지를 입력하세요"></input><br>
								</div>
								<button type="button" class="btn btn-outline-secondary btn-sm btn-success addDest">배송지 추가</button>
								<button type="submit" class="btn btn-primary btn-sm"
									data-dismiss="modal">선택</button>
							</div>
						</form>
						<% } %>
						<script>
							$(".addDest").click(function(e){
								console.log($(this).parent().parent().serialize())
								$.ajax({
									url : "<%=request.getContextPath()%>/destination/addDest",
									data : $(this).parent().parent().serialize(),
									success : function(result){
										console.log("aJax 통신 성공");
										console.log(result + "," + e.target);
									},
									error : alert("배송지 추가 과정 중 오류 발생")
								});
							});
						</script>

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
							<th class="isth desInf">이름</th>
							<td>홍길동</td>
						</tr>
						<tr>
							<th class="isth desInf">연락처</th>
							<td>010-1111-1111</td>
						</tr>
						<tr>
							<th class="isth desInf">주소</th>
							<td>서울 중구 남대문로 1가 18, 2층 A강의장</td>
						</tr>
						<tr>
							<th class="isth desInf">배송 메모</th>
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

			<% 
			int total = 0;
			for(Product product : pList){ %>
			<div class="row">

				<div class="productimgbox ml-5">
					<!-- <img src="../img/5x5.png" id="img5x5"> -->
					<img src="<%=request.getContextPath() + "resources/appoimg/" + product.getImagePath() %>" class="img5x5">
				</div>

				<div class="col-md-5">
					<span id="producttitle2" name="">&nbsp;&nbsp;<%=product.getProductTitle() %></span><br> 
						<span class="productstatus">상품번호 :</span> 
						<span class="detailtxt2"><%=product.getProductNo() %></span><br> 
				</div>
				
				<div class="col-md-5">
					<span class="pull-right mr-3 ml-5 mt-4 pt-2"><%= fee %></span> 
					<span class="pull-right mr-3 ml-5 mt-4 pt-2"><%= product.getBasicPrice() %></span> 
					<span class="pull-right mr-4 ml-5 mt-4 pt-2"><%= product.getMemberId() %></span>
				<%-- 	<span class="pull-right mr-4 ml-5 mt-4 pt-2"><%= product.getProductTitle() %></span> --%>
				</div>

			</div>

			<hr id="hrcss">
				
			<% 	total += product.getBasicPrice() + fee;
				} %>
			
			<div class="col-md-12">
				<span class="pull-right ml-5 mr-2"><%= total - (fee * pList.size()) %></span> <span
					class="pull-right">상품금액</span><br> <span
					class="pull-right ml-5 mr-2"><%= fee * pList.size() %></span> <span
					class="pull-right mr-3">배송비</span>
			</div>
			<br>
			<hr id="hrcss">
			
			<div>
				<span class="totalprice font-weight-bold ml-3">총 주문 금액</span> 
				<span class="totalprice font-weight-bold pull-right mr-3">원</span> 
				<span class="totalprice font-weight-bold pull-right mr-2" id="totalPrice"><%=total%></span>
			</div>
			<hr id="hrcss">
			<br> <br> <br>
			

			<h5 class="font-weight-bold">결제수단</h5>
			<hr id="hrcss">
			<div class="col-md-12">
				<span class="mr-5 ml-3">결제 방법</span>
				
					<input type="radio" id="creditcard" name="paymentType" value="1"> 
					<label for="creditcard">신용카드</label> &nbsp;&nbsp;&nbsp;&nbsp; 
					<input type="radio" id="bankdeposit" name="paymentType" value="2"> 
					<label for="bankdeposit">무통장입금</label>
				
			</div>

			<hr id="hrcss">

			<div class="col-md-12">
				<button class="btn btn-primary btn-lg col-md-5" type="button"
					id="undobutton">취소</button>
				<button class="btn btn-primary btn-lg col-md-5" type="button"
					id="paymentbutton">결제 하기</button>
			</div>
		</form>
		
		<script>
		
			$("#paymentbutton").on("click", function(){
				// 배송지 정보
				var desInf = [];
				$.each($(".desInf"), function(index, item){
					desInf.push($(item).next().text());
				});
				console.log(desInf);
				
				var productNo = [];
				$.each($(".productstatus"), function(index, item){
					productNo.push($(item).next().text());
				});
				console.log(productNo);
				
				var totalPrice = $("#totalPrice").text();
				console.log(totalPrice);
				
				var paymentType = $("input[name=paymentType]:checked").val();
				console.log(paymentType);
				
				
				var $form = $("<form>").prop({"action":"bankDepositResult","method":"POST","id":"doPayment"}).hide();
				var $dInf = $("<input>").prop({"type":"hidden", "name":"desInf"}).val(desInf);
				var $pNo = $("<input>").prop({"type":"hidden", "name":"productNo"}).val(productNo);
				var $total = $("<input>").prop({"type":"hidden", "name":"totalPrice"}).val(totalPrice);
				
				$("#paymentbutton").append($form.append($dInf).append($pNo).append($total));
				
				if(paymentType == 2){
					
					$("#doPayment").submit();
					
					
					
					
					
					
					
					
					
				
				}else if(paymentType == 1){
					
					
					var name = "<%= product0.getProductTitle() %>";
					var size = <%= pList.size()%>;
					if(size > 1) name += " 외 " + (size - 1);
					
					var amount = totalPrice;
					var buyer_name ="<%= loginMember.getMember_NM() %>";
					var buyer_email = " ";
					var buyer_tel = " ";
					var buyer_postcode = " ";
					var buyer_addr =" ";
					
					var merchant_uid;
					
					console.log(name);
					console.log(amount);
					console.log(buyer_name);
					
					$.ajax({
						url : "cardPayment",
						type : "post",
						data : {
							name : name,					// 주문명
							amount: amount,					// 결제할 금액
							buyer_email: buyer_email,		// 주문자 Email
							buyer_name: buyer_name,	 		// 주문자명 
							buyer_tel: buyer_tel,			// 주문자 연락처
							buyer_addr: buyer_addr,			// 주문자 주소 (선택항목)
							buyer_postcode: buyer_postcode	// 주문자 우편번호
						},
						success : function(merchant_uid){
							alert(merchant_uid);
							
							if(merchant_uid != ""){
								payment(name, amount, buyer_email, buyer_name, buyer_tel, buyer_addr, buyer_postcode, merchant_uid);
							}else{
								alert("실패");
							}
						},
						
						error : function(){
							alert("ajax 통신 실패");
						}
						
					});
				}
				
				
			});
			
			function payment(name, amount, buyer_email, buyer_name, buyer_tel, buyer_addr, buyer_postcode, merchant_uid){
				
				// STEP2 가맹점 식별하기
				// IMP 객체의 init 함수의 인자에 가맹점 식별코드를 삽입하고 웹사이트의 결제 페이지에서 호출합니다.
		
				var IMP = window.IMP; // 생략해도 괜찮습니다.
				IMP.init("imp60474063"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.
				
				// STEP3결제창 호출코드 추가하기
				// IMP.request_pay(param, callback)을 호출합니다. 함수의 첫번째 인자인 param에 결제 요청에 필요한 속성과 값을 담습니다
				// IMP.request_pay(param, callback) 호출
				IMP.request_pay({ // param
					// param 객체 속성
					// https://docs.iamport.kr/tech/imp#param
					
					// pg : pg사 선택
					pg: "kakaopay", // (이니시스웹표준)
					
					// 결제 수단
					pay_method: "card", // (신용카드)
					
					// 가맹점에서 생성/관리하는 고유 주문번호 (필수항목)
					// 결제가 된 적이 있는 merchant_uid로는 재결제 불가
					// script 마지막 설명 참고 
					merchant_uid: merchant_uid,
					
					// 주문명
					name: name,  //(주문명 입력값)
					
					// 결제할 금액
					amount: amount,	// 결제할 금액 입력값
					
					// 주문자 Email (선택항목)
					buyer_email: buyer_email,
					
					// 주문자명 (선택항목)
					buyer_name: buyer_name,
					
					// 주문자 연락처 (선택항목)
					buyer_tel: buyer_tel
					
				}, function (rsp) { // callback
					/*
						- callback함수의 rsp객체
						IMP.request_pay()함수의 두번째 인자에는 JavaScript 함수를 지정합니다. 
						이를 callback함수라고 부르며, 결제 프로세스 완료 후 호출되는 함수입니다. 
						해당 함수가 호출될 때 결제 결과의 정보를 담고있는 rsp객체를 인자로써 가집니다. 
						해당 객체를 통해 결제 성공여부, 결제 에러 메시지, 결제 승인 시각 등의 정보를 확인할 수 있습니다.
					*/
					
				  	if (rsp.success) {  // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
					//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid,merchant_uid 전달하기
						$.ajax({
							url: "test/insertImpUid", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
							type: 'POST',
							//dataType: 'json',
							data: {
								imp_uid : rsp.imp_uid,			// 아임포트 거래 고유 번호
								merchant_uid: rsp.merchant_uid//,	// 가맹점에서 생성/관리하는 고유 주문번호
								//name : name,					// 주문명
								//amount: amount,					// 결제할 금액
								//buyer_name: buyer_name,	 		// 주문자명 
								//buyer_email: buyer_email,		// 주문자 Email
								//buyer_tel: buyer_tel,			// 주문자 연락처
								//buyer_postcode: buyer_postcode,	// 주문자 우편번호
								//buyer_addr: buyer_addr			// 주문자 주소 (선택항목)
								//기타 필요한 데이터가 있으면 추가 전달
							}
						}).done(function(data) {
							//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
							if ( everythings_fine ) {
								var msg = '결제가 완료되었습니다.';
								/* msg += '\n고유ID : ' + rsp.imp_uid;
								msg += '\n상점 거래ID : ' + rsp.merchant_uid;
								msg += '\결제 금액 : ' + rsp.paid_amount;
								msg += '카드 승인번호 : ' + rsp.apply_num; */
						
								alert(msg);
							} else {
								//[3] 아직 제대로 결제가 되지 않았습니다.
								//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
							}
						});  
					 } else {
						 alert("결제 실패");
					 }
				});
			}
		</script>
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