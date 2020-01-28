package com.kh.appoproject.member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.appoproject.member.model.service.MemberService;
import com.kh.appoproject.member.model.vo.Member;

@WebServlet("/member/*")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemberServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String uri = request.getRequestURI();

		String contextPath = request.getContextPath();

		String command = uri.substring((contextPath + "/member").length());

		String path = null;
		RequestDispatcher view = null;
		String msg = null;

		MemberService memberService = new MemberService();

		if (command.equals("/loginForm")) {

			path = "/WEB-INF/views/member/memberLogin.jsp";
			view = request.getRequestDispatcher(path);
			view.forward(request, response);

		} else if (command.equals("/login")) {

			request.setCharacterEncoding("UTF-8");

			String memberId = request.getParameter("member_Id");
			String memberPwd = request.getParameter("member_Pwd");

			System.out.println(memberId + memberPwd);

			Member member = new Member(memberId, memberPwd);

			try {
				Member loginMember = new MemberService().loginMember(member);

				System.out.println("loginMember : " + loginMember);

				response.setContentType("text/html); charset=UTF-8");

				HttpSession session = request.getSession();

				if (loginMember != null) {

					session.setMaxInactiveInterval(600);

					session.setAttribute("loginMember", loginMember);

					String save = request.getParameter("save");
					System.out.println("save : " + save);

					Cookie cookie = new Cookie("saveId", memberId);

					if (save != null) {
						cookie.setMaxAge(60 * 60 * 24 * 7);
					} else {
						cookie.setMaxAge(0); // 쿠키 만료
					}

					cookie.setPath("/");

					response.addCookie(cookie);
					session.setAttribute("msg", "로그인 성공!");
					response.sendRedirect(request.getContextPath());

				} else {

					session.setAttribute("msg", "로그인 정보가 유효하지 않습니다.");
					response.sendRedirect(request.getHeader("referer"));
				}

			} catch (Exception e) {

				request.setAttribute("errorMsg", "로그인 과정에서 오류가 발생하였습니다.");
				e.printStackTrace();

				path = "/WEB-INF/views/common/errorPage.jsp";
				view = request.getRequestDispatcher(path);
				view.forward(request, response);
			}
		}

	

		else if (command.equals("/logoutForm")) {
			request.getSession().invalidate();
			response.sendRedirect(request.getHeader("referer"));
		}

		
		
		else if (command.equals("/joinForm")) {

			path = "/WEB-INF/views/member/memberJoin.jsp";
			view = request.getRequestDispatcher(path);
			view.forward(request, response);
		}

		else if (command.equals("/join")) {

			String member_Id = request.getParameter("id");
			String member_Pwd = request.getParameter("pwd1");
			String member_NM = request.getParameter("name");

			String member_Email = request.getParameter("email");

			String member_Phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-"
					+ request.getParameter("phone3");

			String post = request.getParameter("post");
			String member_Address = post + "," + request.getParameter("address1") + ","
					+ request.getParameter("address2");

			String bank = request.getParameter("bank");
			String member_Account = bank + "," + request.getParameter("accNo");

			Member member = new Member(member_Id, member_Pwd, member_NM, member_Phone, member_Email, member_Account,
					member_Address);

			System.out.println("join :" + member);

			try {

				int result = new MemberService().join(member);
				
				//response.sendRedirect(request.getContextPath());
				
				path = "/WEB-INF/views/member/memberJoinSuccess.jsp";
				view = request.getRequestDispatcher(path);
				view.forward(request, response);

			} catch (Exception e) {
				
				request.setAttribute("errorMsg", "회원가입 과정에서 오류가 발생 하였습니다.");
				e.printStackTrace();
				
				path = "/WEB-INF/views/common/errorPage.jsp";
				view = request.getRequestDispatcher(path);
				view.forward(request, response);
				
			}
			
			
			
		}
		else if(command.equals("/idDupCheck")) {
			
			String id = request.getParameter("id");
			try {
	
				int result = new MemberService().idDupCheck(id);
				
				PrintWriter out = response.getWriter();
				
				if(result>0) out.append("no");
				else		out.append("yes");
				
			}catch(Exception e) {
				request.setAttribute("errorMsg", "아이디 중복 확인 과정에서 오류가 발생하였습니다.");
				e.printStackTrace();
				
				path="/WEB-INF/views/common/errorPage.jsp";
				view = request.getRequestDispatcher(path);
				view.forward(request,response);
			}
		}
		
		else if(command.equals("/idDupForm")) {
			path= "/WEB-INF/views/member/idDupCheck.jsp";
			view = request.getRequestDispatcher(path);
			view.forward(request, response);
		}
		
		// 로그인 성공시 넘어가는 화면
		/*else if(command.equals("/loginSuccess")) {

			path = "/WEB-INF/views/member/memberJoinSuccess.jsp";
			view = request.getRequestDispatcher(path);
			view.forward(request, response);
		}*/
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
