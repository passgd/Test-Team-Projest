package com.kosa.starrydonuts.dao;

import java.util.List;

import com.kosa.starrydonuts.domain.CommentDTO;

public interface CommentDAO {

	  //1. 댓글 작성하기
	  public boolean commentInsert(CommentDTO comment) throws Exception;
	  
	  //2. 댓글 목록
	  public List<CommentDTO> commentList(int boardid) throws Exception;
	  
	  //2-1. 댓글 더보기(5개씩)
	  public List<CommentDTO> commentListBoforeN(int boardid) throws Exception;
	  
	  //3. 댓글 수정하기
	  public boolean commentUpdate(CommentDTO comment) throws Exception;
	  
	  //4. 댓글 삭제하기
	  public boolean commentDelete(CommentDTO comment) throws Exception;

	  // 주석테스트	  
}
