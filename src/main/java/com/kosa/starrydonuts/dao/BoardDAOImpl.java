package com.kosa.starrydonuts.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.starrydonuts.domain.BoardDTO;
import com.kosa.starrydonuts.domain.NoticeDTO;


@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private  SqlSession sqlSession;

	//1. 게시판 목록
	@Override
	public List<BoardDTO> boardList() throws Exception {
		System.out.println("dao.boardDAOImpl.boardList() 게시판 목록 호출");
		
		return sqlSession.selectList("mapper.board.boardList");
	}

	
	//2. 게시판 상세보기
	@Override
	public BoardDTO boardGet(int boardid) throws Exception {
		System.out.println("dao.boardDAOImpl.boardGet() 게시판 목록 호출");
		
		return sqlSession.selectOne("mapper.board.boardGet", boardid);
	}

	
	//3. 게시판 글쓰기
	@Override
	public boolean boardInsert(BoardDTO board) throws Exception {
		System.out.println("dao.boardDAOImpl.boardInsert() 게시판 등록 호출");
		
		return 0 != sqlSession.insert("mapper.board.boardInsert", board);
	}

	
	//4. 게시판 수정하기
	@Override
	public boolean boardUpdate(BoardDTO board) throws Exception {
		System.out.println("dao.boardDAOImpl.boardUpdate() 게시판 수정 호출");
		
		return 0 != sqlSession.update("mapper.board.boardUpdate", board);
	}

	
	//5. 게시판 삭제하기
	@Override
	public boolean boardDelete(BoardDTO board) throws Exception {
		System.out.println("dao.boardDAOImpl.boardDelete() 게시판 삭제 호출");
		
		return 0 != sqlSession.delete("mapper.board.boardDelete", board);
	}

	
	//6. 메인에 TOP5 출력하기
	@Override
	public List<BoardDTO> boardTop5() throws Exception {
		System.out.println("dao.boardDAOImpl.boardTop5() 게시판 TOP5 호출");
		System.out.println(sqlSession.selectList("mapper.board.boardTop5"));
		return sqlSession.selectList("mapper.board.boardTop5");
	}

	
	//7. 조회수 증가
	@Override
	public int viewCount(int boardid) throws Exception {
		System.out.println("dao.boardDAOImpl.viewCount() 게시판 조회수 증가 호출");
		
		return sqlSession.update("mapper.board.viewCount", boardid);
	}

	
	//8. 체크박스된 게시글 삭제
	/*
	 * 삭제시 할  게시물아이디는 배열로 구성하여 list라는 이름으로 전달 한다 
	 */
	@Override
	public int boardsDelete(Map<String, Object> params) throws Exception {
		System.out.println("dao.boardDAOImpl.boardsDelete() 게시판 체크박스 호출");
		
		return sqlSession.delete("mapper.board.deleteBoards", params);
	}

	
//	//9. 더보기 만들기
//	@Override
//	public List<BoardDTO> boardList2(BoardDTO board) throws Exception {
//		System.out.println("dao.boardDAOImpl.boardList2() 게시판 더보기 목록 호출");
//		
//		return sqlSession.selectList("mapper.board.boardList2", board);
//	}

	
	//10. 게시글 삭제해도 다시 글 10개씩 보이게 하는 메서드
	@Override
	public List<BoardDTO> boardListBoforeN(BoardDTO board) throws Exception {
		System.out.println("dao.boardDAOImpl.boardListBoforeN() 게시판 목록(10건 메서드) 호출");
		
		return sqlSession.selectList("mapper.board.boardListBoforeN", board);
	}

	
	//11. 답글 만들기
	@Override
	public int reply(BoardDTO board) {
		System.out.println("dao.boardDAOImpl.reply() 게시판 목록 호출");
		
		return sqlSession.insert("mapper.board.insertBoardReply", board);
	}


	@Override
	public int getTotalCount(BoardDTO board) throws Exception {
		System.out.println("dao.noticeDAOImpl.getTotalCount() 게시글 총 개수 호출");
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchTitle",board.getSearchTitle());
		
		return sqlSession.selectOne("mapper.board.getTotalCount", map);
	}


	@Override
	public List<BoardDTO> boardPagingList(BoardDTO board) throws Exception {
		System.out.println("dao.noticeDAOImpl.boardPagingList() 게시판 목록(페이징) 호출");
		Map<String, Object> map = new HashMap<>();
		map.put("boardid", board.getBoardid());
		map.put("startNo",board.getStartNo());
		map.put("endNo", board.getEndNo());
		map.put("searchTitle",board.getSearchTitle());
		List<BoardDTO> board2 = sqlSession.selectList("mapper.board.boardPagingList", map);
		
		System.out.println("board2 : " + board2); 
		return board2;
	}


} // end class