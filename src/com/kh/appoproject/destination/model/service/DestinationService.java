package com.kh.appoproject.destination.model.service;

import static com.kh.appoproject.common.JDBCTemplate.*;
import java.sql.Connection;

import com.kh.appoproject.destination.model.dao.DestinationDao;
import com.kh.appoproject.destination.model.vo.Destination;

public class DestinationService {

	public int addDest(Destination dest) throws Exception{
		Connection conn = getConnection();
		int result = new DestinationDao().addDest(conn, dest);
		
		if(result > 0)	commit(conn);
		else			rollback(conn);
		
		close(conn);
		
		return result;
	}

}
