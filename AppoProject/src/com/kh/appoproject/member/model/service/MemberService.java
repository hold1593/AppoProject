package com.kh.appoproject.member.model.service;

import java.sql.Connection;
import static com.kh.appoproject.common.JDBCTemplate.*;

import com.kh.appoproject.member.model.dao.MemberDao;
import com.kh.appoproject.member.model.vo.Member;

public class MemberService {

	/**
	 * 로그인용 DAO
	 * @param member
	 * @return loginMember
	 * @throws Exception
	 */
	public Member loginMember(Member member) throws Exception {

		Connection conn = getConnection();

		Member loginMember = new MemberDao().loginMember(conn, member);

		return loginMember;
	}

	/** 회원가입용 Service
	 * @param member
	 * @return result
	 * @throws Exception
	 */
	public int join(Member member) throws Exception{
		
		Connection conn = getConnection();
		int result = new MemberDao().join(conn, member);
		
		if(result > 0) commit(conn);
		else rollback(conn);
	
		return result;
	}

	/** 아이디 중복 확인용 Service
	 * @param id
	 * @return result
	 * @throws Exception
	 */
	public int idDupCheck(String id) throws Exception{
		Connection conn = getConnection();
		return new MemberDao().inDupCheck(conn, id);
	}

}
