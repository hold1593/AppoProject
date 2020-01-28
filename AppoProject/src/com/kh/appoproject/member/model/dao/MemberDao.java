package com.kh.appoproject.member.model.dao;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import static com.kh.appoproject.common.JDBCTemplate.*;

import com.kh.appoproject.member.model.vo.Member;

public class MemberDao {

	private Properties prop = null;

	public MemberDao() throws Exception {

		// member 관련 sql 파일을 관리할 properties 파일 생성

		String fileName = MemberDao.class.getResource("/com/kh/appoproject/sql/member/member-query.properties")
				.getPath();

		prop = new Properties();

		prop.load(new FileReader(fileName));
	}

	/**
	 * 로그인용 Dao
	 * 
	 * @param conn
	 * @param member
	 * @return loginMember
	 * @throws Exception
	 */
	public Member loginMember(Connection conn, Member member) throws Exception {

		PreparedStatement pstmt = null;
		ResultSet rset = null;

		Member loginMember = null;

		String query = prop.getProperty("loginMember");

		try {

			pstmt = conn.prepareStatement(query);

			pstmt.setString(1, member.getMember_Id());
			pstmt.setString(2, member.getMember_Pwd());

			rset = pstmt.executeQuery();

			if (rset.next()) {

				int member_No = rset.getInt("MEMBER_NO");
				String member_Id = rset.getString("MEMBER_ID");
				String member_Pwd = rset.getString("MEMBER_PWD");
				String member_NM = rset.getString("MEMBER_NM");
				String member_Phone = rset.getString("MEMBER_PHONE");
				String member_Email = rset.getString("MEMBER_EMAIL");
				Date member_ErollDate = rset.getDate("MEMBER_ENROLLDATE");
				String member_Account = rset.getString("MEMBER_ACCOUNT");
				String member_Status = rset.getString("MEMBER_STATUS");
				String member_Address = rset.getString("MEMBER_ADDR");

				loginMember = new Member(member_No, member_Id, member_Pwd, member_NM, member_Phone, member_Email,
						member_ErollDate, member_Account, member_Status, member_Address);

			}
		} finally {

			close(rset);
			close(pstmt);
		}

		return loginMember;
	}

	/**
	 * 아이디 중복체크 확인용 Dao
	 * 
	 * @param conn
	 * @param id
	 * @return result
	 * @throws Exception
	 */
	public int idDupCheck(Connection conn, String id) throws Exception {
		// TODO Auto-generated method stub
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;

		String query = prop.getProperty("idDupCheck");

		try {
			pstmt = conn.prepareStatement(query);

			pstmt.setString(1, id);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				result = rset.getInt(1); // 첫번째 값을 갖고 오겠다 count(*) 써도 됨 어차피 1행1열
			}

		} finally {

			close(rset);
			close(pstmt);

		}
		return result;
	}
	
	/** 회원가입용 Dao
	 * @param conn
	 * @param member
	 * @return result
	 * @throws Exception
	 */
	public int signUp(Connection conn, Member member) throws Exception {
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("signUp");
		
		try {
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, member.getMember_Id());
			pstmt.setString(2, member.getMember_Pwd());
			pstmt.setString(3, member.getMember_NM());
			pstmt.setString(4, member.getMember_Phone());
			pstmt.setString(5, member.getMember_Email());
			pstmt.setString(6, member.getMember_Address());
		
			
			result = pstmt.executeUpdate();
			
		} finally {
			
			close(pstmt);
		}
		
		return result;
	}

	/** 회원가입용 Dao
	 * @param conn
	 * @param member
	 * @return result
	 * @throws Exception
	 */
	public int join(Connection conn, Member member) throws Exception{
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("join");
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, member.getMember_Id());
			pstmt.setString(2, member.getMember_Pwd());
			pstmt.setString(3, member.getMember_NM());
			pstmt.setString(4, member.getMember_Phone());
			pstmt.setString(5, member.getMember_Email());
			pstmt.setString(6, member.getMember_Address());
			pstmt.setString(7, member.getMember_Account());
			
			result = pstmt.executeUpdate();
			
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	/** 아이디 중복체크 확인용 DAO
	 * @param conn
	 * @param id
	 * @return result
	 * @throws Exception
	 */
	public int inDupCheck(Connection conn, String id) throws Exception{
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;

		String query = prop.getProperty("idDupCheck");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				result = rset.getInt(1);
			}

		} finally {
			close(rset);
			close(pstmt);
		}

		return result;
	}

}
