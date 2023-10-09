package com.kosa.starrydonuts.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.starrydonuts.domain.NoticeDTO;

@Repository("NoticeDAO")
public class NoticeDAOImpl implements NoticeDAO {

	@Autowired
	private SqlSession sqlSession;

	//1. 공지사항 목록
	@Override
	public List<NoticeDTO> noticeList() throws Exception {
		System.out.println("dao.noticeDAOImpl.noticeList() 공지사항 목록 호출");

		return sqlSession.selectList("mapper.notice.noticeList");
	}

	
	//2. 공지사항 상세보기
	@Override
	public NoticeDTO noticeGet(int noticeid) throws Exception {
		System.out.println("dao.noticeDAOImpl.noticeGet() 공지사항 상세보기 호출");
		
		return sqlSession.selectOne("mapper.notice.noticeGet", noticeid);
	}

	
	//3. 공지사항 글쓰기
	@Override
	public boolean noticeInsert(NoticeDTO notice) throws Exception {
		System.out.println("dao.noticeDAOImpl.noticeInsert() 공지사항 등록 호출");
		
		return  0 != sqlSession.insert("mapper.notice.noticeInsert", notice);
	}

	
	//4. 공지사항 수정하기
	@Override
	public boolean noticeUpdate(NoticeDTO notice) throws Exception {
		System.out.println("dao.noticeDAOImpl.noticeUpdate() 공지사항 수정 호출");
		
		return  0 != sqlSession.update("mapper.notice.noticeUpdate", notice);
	}

	
	//5. 공지사항 삭제하기
	@Override
	public boolean noticeDelete(NoticeDTO notice) throws Exception {
		System.out.println("dao.noticeDAOImpl.noticeDelete() 공지사항 삭제 호출");
		int result = sqlSession.delete("mapper.notice.noticeDelete", notice);
		System.out.println("noticeid -> " + notice.getNoticeid());
		System.out.println("삭제결과 : " + result);
		
		return result != 0 ;
	}

	
	//6. 메인에 TOP5 출력하기
	@Override
	public List<NoticeDTO> noticeTop5() throws Exception {
		System.out.println("dao.noticeDAOImpl.noticeTop5() 공지사항 TOP5 호출");
		
		return sqlSession.selectList("mapper.notice.noticeTop5");
	}

	
	//7. 조회수 증가
	@Override
	public int viewCount(int noticeid) throws Exception {
		System.out.println("dao.noticeDAOImpl.viewCount() 공지사항 조회수 증가 호출");
		
		return sqlSession.update("mapper.notice.viewCount", noticeid);
	}

	
	//8. 체크박스된 게시글 삭제
	@Override
	public boolean noticesDelete(NoticeDTO notice) throws Exception {
		System.out.println("dao.noticeDAOImpl.noticesDelete() 공지사항 체크박스 중복 삭제 호출");
		
		return  0 != sqlSession.update("mapper.notice.noticesDelete", notice);
	}

	
	//9. [페이징]검색된 전체 건수 얻는다
	@Override
	public int getTotalCount(NoticeDTO notice) throws Exception {
		System.out.println("dao.noticeDAOImpl.getTotalCount() 게시글 총 개수 호출");
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchTitle",notice.getSearchTitle());
		
		return sqlSession.selectOne("mapper.notice.getTotalCount", map);
	}


	//10. 페이징 목록
	@Override
	public List<NoticeDTO> noticePagingList(NoticeDTO notice) throws Exception {
		System.out.println("dao.noticeDAOImpl.noticePagingList() 공지사항 목록(페이징) 호출");
		Map<String, Object> map = new HashMap<>();
		map.put("noticeid", notice.getNoticeid());
		map.put("startNo",notice.getStartNo());
		map.put("endNo", notice.getEndNo());
		map.put("searchTitle",notice.getSearchTitle());
		List<NoticeDTO> notice2 = sqlSession.selectList("mapper.notice.noticePagingList", map);
		
		System.out.println("notice2 : " + notice2); 
		return notice2;
	}

	
	//10. 게시글 삭제 후 다시 10건으로 만들어주는 메서드
	@Override
	public List<NoticeDTO> noticeListBoforeN(NoticeDTO notice, int length) throws Exception {
		System.out.println("dao.noticeDAOImpl.noticeListBoforeN() 공지사항 목록(10건 메서드) 호출");
		
		return sqlSession.selectList("mapper.notice.noticeListBoforeN");
	}



} // end class
