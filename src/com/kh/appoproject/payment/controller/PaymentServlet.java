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
import com.kh.appoproject.member.model.vo.Member;
import com.kh.appoproject.payment.model.service.PaymentService;
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

		Member loginMember = (Member) session.getAttribute("loginMember");
		PaymentService paymentService = new PaymentService();

		if (command.equals("/BillingInfo")) {
			
			List<Cart> cList = null;
			request.setAttribute("cList", cList);
			path = "/WEB-INF/views/payment/payment.jsp";
			view = request.getRequestDispatcher(path);
			view.forward(request, response);

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
