package com.kosa.starrydonuts.dao;

import java.util.List;
import java.util.Map;

import com.kosa.starrydonuts.domain.BoardDTO;
import com.kosa.starrydonuts.domain.NoticeDTO;

public interface BoardDAO {
	
	//1. 게시판 목록
	public List<BoardDTO> boardList() throws Exception;
	
	//2. 게시판 상세보기
	public BoardDTO boardGet(int boardId) throws Exception;
	
	//3. 게시판 글쓰기
	public boolean boardInsert(BoardDTO board) throws Exception; 
	
	//4. 게시판 수정하기
	public boolean boardUpdate(BoardDTO board) throws Exception;

	//5. 게시판 삭제하기
	public boolean boardDelete(BoardDTO board) throws Exception;
	
	//6. 메인에 TOP5 출력하기
	public List<BoardDTO> boardTop5() throws Exception;
	
	//7. 조회수 증가
	public int viewCount(int boardid) throws Exception;
	
	//8. 체크박스된 게시글 삭제
	public int boardsDelete(Map<String, Object> params) throws Exception;
		
	//9. 더보기 만들기
//	public List<BoardDTO> boardList2(BoardDTO board) throws Exception;
	
	
	//9. [페이징]검색된 전체 건수 얻는다
	//	 공지사항 총 개수
	public int getTotalCount(BoardDTO board) throws Exception;
	// 	 공지사항 목록(파라미터값 notice임!)
	public List<BoardDTO> boardPagingList(BoardDTO board) throws Exception ;
	
	
	//10. 게시글 10개씩 돌아오게하는 메서드
	public List<BoardDTO> boardListBoforeN(BoardDTO board) throws Exception;

	//11. 답글 추가하기
	public int reply(BoardDTO board);

	
} // end class
