package com.kh.appoproject.payment.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.appoproject.cart.model.vo.Cart;
import com.kh.appoproject.common.ExceptionForward;
import com.kh.appoproject.destination.model.vo.Destination;
import com.kh.appoproject.member.model.vo.Member;
import com.kh.appoproject.payment.model.service.PaymentService;
import com.kh.appoproject.payment.model.vo.Payment;
import com.kh.appoproject.product.model.service.ProductService;
import com.kh.appoproject.product.model.vo.Product;

@WebServlet("/payment/*")
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PaymentServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = uri.substring((contextPath + "/payment").length());

		String msg = null;
		String path = null;
		RequestDispatcher view = null;

		HttpSession session = request.getSession();

		List<Cart> cList = (List<Cart>) session.getAttribute("cList");
		Member loginMember = (Member) session.getAttribute("loginMember");
		ProductService productService = new ProductService();

		

		PaymentService paymentService = new PaymentService();

		if (command.equals("/BillingInfo")) {
			String[] products = request.getParameterValues("chk");
			Member member = (Member)request.getSession().getAttribute("loginMember");
			
			try {
				List<Product> pList = paymentService.billingInfo(products);
				List<Destination> dList = paymentService.selectDestination(member.getMember_No());
				
				request.setAttribute("pList", pList);
				request.setAttribute("dList", dList);
				path = "/WEB-INF/views/payment/payment.jsp";
				view = request.getRequestDispatcher(path);
				view.forward(request, response);
				
			} catch (Exception e) {
				ExceptionForward.errorPage(request, response, "결제 페이지 이동", e);
			}
		}else if(command.equals("/bankDepositResult")) {
			
			String desInf = request.getParameter("desInf");
			String productNo = request.getParameter("productNo");
			String totalPrice = request.getParameter("totalPrice");
			
			System.out.println(desInf); //배송지
			System.out.println(productNo); // 상품번호
			System.out.println(totalPrice); //토탈가격
			
			int basicNo = Integer.parseInt(productNo);
			String destinationAddr = desInf;
			int basicPrice = Integer.parseInt(totalPrice);
			
			Payment payment = new Payment(basicNo, destinationAddr, basicPrice);
			
			try {
				
				payment = paymentService.bankDeposit(payment);
				
				
				path = "/WEB-INF/views/member/paymentResult.jsp";
				view = request.getRequestDispatcher(path);
				view.forward(request, response);
				
				
			}catch(Exception e) {
				
			}
			
			
			
			
			
		}else if(command.equals("/cardPayment")) {
			String name = request.getParameter("name");
			String amount = request.getParameter("amount");
			String buyer_name = request.getParameter("buyer_name");
			
			System.out.println(name);
			System.out.println(amount);
			System.out.println(buyer_name);

			response.setHeader("Set-Cookie", "HttpOnly;Secure;SameSite=Strict");
			
			//response.getWriter().print("2020020200003");
			
			try {
				String merchantUid = paymentService.cardPayment(name, amount, buyer_name);
				response.getWriter().print(merchantUid);
			}catch (Exception e) {
				System.out.println("error 발생");
				e.printStackTrace();
			}
			
		}
		

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
