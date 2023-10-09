package com.kosa.starrydonuts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.starrydonuts.dao.CommentDAO;
import com.kosa.starrydonuts.domain.CommentDTO;

@Service
public class CommentService {

   @Autowired
   private CommentDAO commentDAO;
   
   //1. 댓글 작성하기
   
   public boolean commentInsert(CommentDTO comment) throws Exception {
      System.out.println("service.commentInsert invoked(). 댓글작성");
      boolean success = commentDAO.commentInsert(comment);
      System.out.println("서비스 댓글 등록여부 : " + success);
      
      return success;
   
   } //commentInsert
   
   
   //2. 댓글 목록(5개씩)
   public List<CommentDTO> commentList(int boardid) throws Exception {
	  System.out.println("service.commentListBoforeN invoked(). 댓글 더보기");
	  List<CommentDTO> list = commentDAO.commentListBoforeN(boardid);
      System.out.println("서비스 댓글 목록 : " + list);
      
      return list;
   
   } //commentList
	  
   
   
   //3. 댓글 수정하기
   public boolean commentUpdate(CommentDTO comment) throws Exception {
      System.out.println("service.commentUpdate invoked(). 댓글작성");
      boolean success = commentDAO.commentUpdate(comment);
      System.out.println("서비스 댓글 수정여부 : " + success);
      
      return success;
      
   } //commentUpdate
   
   
   //4. 댓글 삭제하기
   public boolean commentDelete(CommentDTO comment) throws Exception {
      System.out.println("service.commentDelete invoked(). 댓글작성");
      boolean success = commentDAO.commentDelete(comment);
      System.out.println("서비스 댓글 삭제여부 : " + success);
      
      return success;
      
   } //commentDelete


	
   
   
}