package com.kosa.starrydonuts.dao;

import java.util.List;

import com.kosa.starrydonuts.domain.NoticeDTO;

public interface NoticeDAO {

	//1. 공지사항 목록
	public List<NoticeDTO> noticeList() throws Exception;
	
	//2. 공지사항 상세보기
	public NoticeDTO noticeGet(int noticeid) throws Exception;
	
	//3. 공지사항 글쓰기
	public boolean noticeInsert(NoticeDTO notice) throws Exception; 
	
	//4. 공지사항 수정하기
	public boolean noticeUpdate(NoticeDTO notice) throws Exception;

	//5. 공지사항 삭제하기
	public boolean noticeDelete(NoticeDTO notice) throws Exception;
	
	//6. 메인에 TOP5 출력하기
	public List<NoticeDTO> noticeTop5() throws Exception;
	
	//7. 조회수 증가
	public int viewCount(int noticeid) throws Exception;
	
	//8. 체크박스된 게시글 삭제
	public boolean noticesDelete(NoticeDTO notice) throws Exception;

	//9. [페이징]검색된 전체 건수 얻는다
	//	 공지사항 총 개수
	public int getTotalCount(NoticeDTO notice) throws Exception;
	// 	 공지사항 목록(파라미터값 notice임!)
	public List<NoticeDTO> noticePagingList(NoticeDTO notice) throws Exception ;
	
	//10. 게시글 삭제 후 다시 10건으로 만들어주는 메서드
	public List<NoticeDTO> noticeListBoforeN(NoticeDTO notice, int length) throws Exception;

	
} // end class
