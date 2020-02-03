package com.kh.appoproject.destination.model.dao;

import static com.kh.appoproject.common.JDBCTemplate.*;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Properties;

import com.kh.appoproject.destination.model.vo.Destination;


public class DestinationDao {
	Properties prop = null;
	
	public DestinationDao() throws Exception{
		String fileName=DestinationDao.class
				.getResource("/com/kh/appoproject/sql/destination/destination-query.properties")
				.getPath();
		
		prop = new Properties();
		prop.load(new FileReader(fileName));
	}

	public int addDest(Connection conn, Destination dest) throws Exception{
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("addDest");
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dest.getDestinationAddr());
			pstmt.setInt(2, dest.getMemberCode());
			pstmt.setString(3, dest.getDestinationContact());
			pstmt.setString(4, dest.getDestinationNote());
			pstmt.setString(5, dest.getDestinationName());
			pstmt.setString(6, dest.getDestinationReceiver());
			
			result = pstmt.executeUpdate();
			
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	
}
