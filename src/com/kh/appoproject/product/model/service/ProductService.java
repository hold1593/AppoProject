package com.kh.appoproject.product.model.service;

import static com.kh.appoproject.common.JDBCTemplate.*;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.kh.appoproject.product.model.dao.ProductDao;
import com.kh.appoproject.product.model.vo.Image;
import com.kh.appoproject.product.model.vo.Product;

public class ProductService {

	/** 전체 게시글 수 조회 Service
	 * @param productItem
	 * @return
	 * @throws Exception
	 */
	public int getListCount(String productItem) throws Exception {
		Connection conn = getConnection();
		
		int listCount = new ProductDao().getListCount(conn, productItem);
		
		close(conn);
		return listCount;
	}

	/** 게시판 목록 조회용 Service
	 * @param currentPage
	 * @param limit
	 * @return bList
	 * @throws Exception
	 */
	public List<Product> selectList(int currentPage, int limit, String productItem) throws Exception{
		Connection conn = getConnection();
		List<Product> pList = new ProductDao().selectList(conn, currentPage, limit, productItem);
		close(conn);
		return pList;
	}

	/** 상품 게시글 등록용 Service
	 * @param auctionProduct
	 * @param basicProduct
	 * @param memberWriter
	 * @param fList
	 * @return result
	 * @throws Exception
	 */
	public static int insertProduct(String itemName, String productForm, Product product, Product auction, Product basic, int memberWriter,
			ArrayList<Image> fList) throws Exception {
		Connection conn = getConnection();
		ProductDao productDao = new ProductDao();
		int result = 0;
		// 1) 품목 코드를 얻어옴
		int itemNo = productDao.selectItemNo(conn, itemName);
		
		System.out.println("itemNo : " + itemNo);
		
		// 2) 등록될 상품의 번호를 얻어옴
		//	  -> SEQ_PNO.NEXTVAL 값을 얻어오기
		int productNo = productDao.selectNextNo(conn);
		System.out.println("productNo : " + productNo);
		
		if(productNo>0) { // 상품 번호를 얻어 온 경우
			
			// 3) 품목코드, 상품번호를 저장하고 DB에 글 등록	
			product.setItemCode(itemNo);
			product.setProductNo(productNo);
			
			result = productDao.insertProduct(conn, product, memberWriter);
			
			System.out.println("result1 : " + result);
			
			// 4) 게시글 성공하면 일반, 경매 추가
			if(result>0) {
				result = 0;
				if(productForm.equals("B")) result = productDao.insertBasic(conn, basic, productNo);
				else 						result = productDao.insertAuction(conn, auction, productNo);
				System.out.println("result2 : " + result);
				
				
				
				if(result > 0 && !fList.isEmpty()) {
					System.out.println(fList);
					result = 0;
					for(Image file : fList) {
						// 현재 게시글 번호 추가
						file.setProductNo(productNo);
						result = productDao.insertImage(conn, file);
						
						// 삽입 실패 시
						if(result == 0) break;
					}
				}
			}
			System.out.println("result3 : " + result);
		}
		
		// 5)트랜잭션 처리
		if(result>0) commit(conn);
		else { // 6) DB삽입 실패시 서버에 저장된 파일을 삭제
			for(Image file : fList) {
				String path = file.getImagePath();
				int saveFile = file.getImageNo();
				File faildFile = new File(path + saveFile);
				faildFile.delete();
			}
			rollback(conn);
		}
		close(conn);
		return result;
	}

	/** 썸네일 이미지 목록 조회 Service
	 * @param currentPage
	 * @param limit
	 * @param productItem
	 * @return fList
	 * @throws Exception
	 */
	public List<Image> selectFileList(int currentPage, int limit, String productItem) throws Exception {
		Connection conn = getConnection();
		
		ArrayList<Image> fList = new ProductDao().selectFileList(conn,currentPage, limit, productItem);
		
		close(conn);
		return fList;
	}

	/** 상품 상세 조회용 Service
	 * @param productNo
	 * @return product
	 * @throws Exception
	 */
	public Product selectProduct(int productNo) throws Exception{
		Connection conn = getConnection();
		ProductDao productDao = new ProductDao();
		// 1) 상품 상세 조회
		Product product = productDao.selectProduct(conn, productNo);
		// 2) 상품 상세 조회 성공 시 조회수 증가
		
		close(conn);
		return product;
	}

	/** 게시글 이미지 파일 조회용 Service
	 * @param productNo
	 * @return files
	 * @throws Exception
	 */
	public List<Image> selectFiles(int productNo) throws Exception {
		Connection conn = getConnection();
		List<Image> files = new ProductDao().selectFiles(conn, productNo);
		
		close(conn);
		return files;
	}

	/** 상품 게시글 수정 화면용 Service
	 * @param no
	 * @return product
	 * @throws Exception
	 */
	public Product updateForm(int no) throws Exception {
		Connection conn = getConnection();
		// 상품글 상세조회
		Product product = new ProductDao().selectProduct(conn, no);
		
		System.out.println("product service : " + product);
		
		if(product.getProductComment() !=null) {
			product.setProductComment(product.getProductComment().replace("<br>", "\r\n"));
		}
		close(conn);
		return product;
	}

	public static int updateProduct(String itemName, Product product, Product basic, int memberWriter,
			ArrayList<Image> fList) throws Exception {
		return 0;
	}

	/** 게시글 삭제 Service
	 * @param no
	 * @return result
	 * @throws Exception
	 */
	public static int deleteProduct(int no) throws Exception {
		Connection conn = getConnection();
		int result = new ProductDao().deleteProduct(conn, no);
		
		if(result>0)	commit(conn);
		else			rollback(conn);
		close(conn);
		return result;
	}
	
	
	public int reportProduct(int productNo, String memberId) throws Exception{
		Connection conn = getConnection();
		int result = new ProductDao().reportProductCount(conn,productNo,memberId); // 게시글 중복 신고 방지
		if(result > 0) { // 게시글 중복 신고인 경우
			result = -1;
		} else {
			result = new ProductDao().reportProduct(conn,productNo,memberId); // declare테이블 등록
			
			if(result > 0) { // 게시글 중복 방지 테이블에 insert 성공시
				commit(conn);
				result = new ProductDao().updateProductDeclareCount(conn,productNo); // 상품테이블 신고 1증가
				
				if(result > 0)	commit(conn);
				else			rollback(conn);
			} else {
				rollback(conn);
			}
		}
		close(conn);
		return result;
	}

}
