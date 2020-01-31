package com.kh.appoproject.product.model.dao;

import static com.kh.appoproject.common.JDBCTemplate.*;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.kh.appoproject.member.model.dao.MemberDao;
import com.kh.appoproject.product.model.vo.Image;
import com.kh.appoproject.product.model.vo.Product;

public class ProductDao {

	private Properties prop = null;
	
	public ProductDao() throws Exception{
		String fileName=ProductDao.class
				.getResource("/com/kh/appoproject/sql/product/product-query.properties")
				.getPath();
		
		prop = new Properties();
		
		prop.load(new FileReader(fileName));
	}
	
	/** 전체 게시글 수 조회용 Dao
	 * @param conn
	 * @return listCount
	 * @throws Exception
	 */
	public int getListCount(Connection conn, String productItem) throws Exception {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		int listCount = 0;
		String query = prop.getProperty("getListCount");
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, productItem);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				listCount = rset.getInt(1);
			}
		}finally {
			close(rset);
			close(pstmt);
		}
		return listCount;
	}

	/** 게시판 목록 조회용 Dao
	 * @param conn
	 * @param currentPage
	 * @param limit
	 * @return pList
	 * @throws Exception
	 */
	public List<Product> selectList(Connection conn, int currentPage, int limit, String productItem) throws Exception {
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Product> pList = null;
		
		String query = prop.getProperty("selectList");
		try {
			int startRow = (currentPage - 1)*limit + 1;
			int endRow = startRow + limit - 1;
			
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, productItem);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			pList = new ArrayList<Product>();
			Product product = null;
			
			while(rset.next()) {
				product = new Product(rset.getInt("PRODUCT_NO"), 
									  rset.getString("PRODUCT_TITLE"), 
									  rset.getString("PRODUCT_FORM"), 
									  rset.getInt("PRODUCT_COUNT"), 
									  rset.getInt("BASIC_PRICE"), 
									  rset.getInt("AUCTION_RESERVE_PRICE"), 
									  rset.getDate("AUCTION_DEADLINE"));
				pList.add(product);
			}
		}finally {
			close(rset);
			close(pstmt);
		}
		return pList;
	}

	/** 다음 상품 번호 반환용 Dao
	 * @param conn
	 * @return productNo
	 * @throws Exception
	 */
	public int selectNextNo(Connection conn) throws Exception {
		Statement stmt = null;
		ResultSet rset = null;
		int productNo = 0;
		
		String query = prop.getProperty("selectNextNo");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
				productNo = rset.getInt(1);
			}
		}finally {
			close(rset);
			close(stmt);
		}
		return productNo;
	}


	/** 아이템번호 조회용 Dao
	 * @param conn
	 * @param itemName
	 * @return itemNo
	 * @throws Exception
	 */
	public int selectItemNo(Connection conn, String itemName) throws Exception{
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int itemNo = 0;
		
		String query = prop.getProperty("selectItemNo");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, itemName);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				itemNo = rset.getInt(1);
			}
		}finally {
			close(rset);
			close(pstmt);
		}
		return itemNo;
	}
	/** 상품 등록용 Dao
	 * @param conn
	 * @param product
	 * @param memberWriter
	 * @return
	 * @throws Exception
	 */
	public int insertProduct(Connection conn, Product product, int memberWriter) throws Exception {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertProduct");
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, product.getProductNo());
			pstmt.setString(2, product.getProductTitle());
			pstmt.setString(3, product.getProductComment());
			pstmt.setString(4, product.getProductUsed());
			pstmt.setString(5, product.getProductForm());
			pstmt.setInt(6, memberWriter);
			pstmt.setInt(7, product.getItemCode());
			
			result = pstmt.executeUpdate();
		}finally {
			close(pstmt);
		}
		return result;
	}
	/** 일반 상품 추가용 Dao
	 * @param conn
	 * @param basicProduct
	 * @param memberWriter
	 * @return result
	 * @throws Exception
	 */
	public int insertBasic(Connection conn, Product basic, int productNo) throws Exception {
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertBasic");
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, productNo);
			pstmt.setInt(2, basic.getBasicPrice());
			
			result = pstmt.executeUpdate();
		}finally {
			close(pstmt);
		}
		return result;
	}

	/** 경매 상품 등록용 Dao
	 * @param conn
	 * @param auctionProduct
	 * @param memberWriter
	 * @return result
	 * @throws Exception
	 */
	public int insertAuction(Connection conn, Product auction,int productNo) throws Exception{
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("insertAuction");
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, productNo);
			pstmt.setInt(2, auction.getAuctionImmediateBid());
			pstmt.setInt(3, auction.getAuctionReservePrice());
			pstmt.setDate(4, auction.getAuctionDeadline());
			
			result = pstmt.executeUpdate();
		}finally {
			close(pstmt);
		}
		return result;
	}

	/** 게시글 파일(이미지) 정보 삽입용 Dao
	 * @param conn
	 * @param file
	 * @return result
	 * @throws Exception
	 */
	public int insertImage(Connection conn, Image file) throws Exception {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = prop.getProperty("insertImage");
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, file.getImagePath());
			pstmt.setInt(2, file.getImageLevel());
			pstmt.setInt(3, file.getProductNo());
			
			result = pstmt.executeUpdate();
		}finally {
			close(pstmt);
		}
		return result;
	}

	/** 썸네일 이미지 목록 조회 Dao
	 * @param conn
	 * @param currentPage
	 * @param limit
	 * @param productItem
	 * @return 
	 * @throws Exception
	 */
	public ArrayList<Image> selectFileList(Connection conn, int currentPage, int limit, String productItem) throws Exception {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Image> fList = null;
		
		String query = prop.getProperty("selectFileList");
		try {
			int startRow = (currentPage - 1)*limit + 1; // 시작
			int endRow = startRow + limit - 1; 
			
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, productItem);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			fList = new ArrayList<Image>();
			Image file = null;
			
			while(rset.next()) {
				file = new Image();
				file.setImageNo(rset.getInt("IMAGE_NO"));
				file.setProductNo(rset.getInt("PRODUCT_NO"));
				file.setImagePath(rset.getString("IMAGE_PATH"));
				
				fList.add(file);
			}
		}finally {
			close(rset);
			close(pstmt);
		}
		return fList;
	}

	/** 상품 상세 조회용 Dao
	 * @param conn
	 * @param productNo
	 * @return
	 * @throws Exception
	 */
	public Product selectProduct(Connection conn, int productNo) throws Exception {
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Product product = null;
		
		String query = prop.getProperty("selectProduct");
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, productNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				product = new Product(productNo, 
									  rset.getString("PRODUCT_TITLE"),
									  rset.getDate("PRODUCT_REG_DATE"),
									  rset.getString("PRODUCT_COMMENT"), 
									  rset.getString("PRODUCT_USED"), 
									  rset.getString("PRODUCT_FORM"), 
									  rset.getInt("PRODUCT_COUNT"), 
									  rset.getInt("MEMBER_REG"), 
									  rset.getInt("BASIC_PRICE"), 
									  rset.getInt("AUCTION_IMMEDIATE_BID"), 
									  rset.getInt("AUCTION_RESERVE_PRICE"), 
									  rset.getDate("AUCTION_DEADLINE"), 
									  rset.getInt("BIDDING_MEMBER"), 
									  rset.getString("ITEM_NAME"), 
									  rset.getString("ITEM_INFO"), 
									  rset.getString("DEVICE_NAME"),
									  rset.getString("MEMBER_ID"));
			}
		}finally {
			close(rset);
			close(pstmt);
		}
		return product;
	}

	/** 게시글 이미지 파일 조회용 Dao
	 * @param conn
	 * @param productNo
	 * @return files
	 * @throws Exception
	 */
	public List<Image> selectFiles(Connection conn, int productNo) throws Exception {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		ArrayList<Image> files = null;
		String query = prop.getProperty("selectFiles");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, productNo);
			rset = pstmt.executeQuery();
			
			files = new ArrayList<Image>();
			Image file = null;
			
			while(rset.next()) {
				file = new Image(rset.getInt("IMAGE_NO"),
								 rset.getString("IMAGE_PATH"),
								 rset.getString("IMAGE_STATE"),
								 rset.getInt("IMAGE_LEVEL"),
								 rset.getInt("PRODUCT_NO"));
				files.add(file);
				
				System.out.println("files dao : " + files);
			}
		}finally {
			close(rset);
			close(pstmt);
		}
		return files;
	}

	public int deleteProduct(Connection conn, int no) throws Exception{
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = prop.getProperty("deleteProduct");
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, no);
			
			result = pstmt.executeUpdate();
		}finally {
			close(pstmt);
		}
		return result;
	}

	
	/** 현재 회원이 게시글 이전 신고 여부 파악 Dao
	 * @param conn
	 * @param productNo
	 * @param memberId
	 * @return result
	 * @throws Exception
	 */
	public int reportProductCount(Connection conn, int productNo, String memberId) throws Exception{
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;
		String query = prop.getProperty("reportProductCount");
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, productNo);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				result = rset.getInt(1);
			}
		}
		finally {
			close(rset);
			close(pstmt);
		}
		return result;
	}

	/** 게시글 신고 중복 방지 Dao
	 * @param conn
	 * @param productNo
	 * @param memberId
	 * @return result
	 * @throws Exception
	 */
	public int reportProduct(Connection conn, int productNo, String memberId) throws Exception{
		PreparedStatement pstmt = null;
		int result = 0;
		String query = prop.getProperty("reportProduct");
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, productNo);
			result = pstmt.executeUpdate();
		} finally {
			close(pstmt);
		}
		return result;
	}

	/** 상품게시글 신고 1 증가
	 * @param conn
	 * @param productNo
	 * @return result
	 * @throws Exception
	 */
	public int updateProductDeclareCount(Connection conn, int productNo) throws Exception{
		PreparedStatement pstmt = null;
		int result = 0;
		String query = prop.getProperty("updateProductDeclareCount");
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, productNo);
			result = pstmt.executeUpdate();
		} 
		finally {
			close(pstmt);
		}
		return result;
	}	
	


}
