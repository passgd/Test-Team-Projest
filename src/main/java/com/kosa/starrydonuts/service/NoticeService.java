package com.kosa.starrydonuts.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.starrydonuts.dao.NoticeDAO;
import com.kosa.starrydonuts.domain.NoticeDTO;

@Service
public class NoticeService {

	@Autowired
	private NoticeDAO noticeDAO;


	
	//1. 공지사항 목록
	public List<NoticeDTO> noticeList(NoticeDTO notice) throws Exception {
		System.out.println("service.noticeList() invoked.");
		
		//게시글 총 개수
		
		
		noticeDAO.getTotalCount(notice);
		
		return noticeDAO.noticeList();
	}
	
	
	//2. 공지사항 상세보기
	public NoticeDTO noticeGet(int noticeid) throws Exception {
		System.out.println("service.noticeGet() invoked.");
		
		//조회수 증가
		noticeDAO.viewCount(noticeid);

		return noticeDAO.noticeGet(noticeid);
	}
	
	
	//3. 공지사항 글쓰기
	public boolean noticeInsert(NoticeDTO notice) throws Exception {
		System.out.println("service.noticeInsert() invoked.");
		
		return noticeDAO.noticeInsert(notice);
	} 
	
	
	//4. 공지사항 수정하기
	public boolean noticeUpdate(NoticeDTO notice) throws Exception {
		System.out.println("service.noticeUpdate() invoked.");
		
		return noticeDAO.noticeUpdate(notice);
	}

	
	//5. 공지사항 삭제하기
	public JSONObject noticeDelete(NoticeDTO notice) throws Exception {
		System.out.println("service.noticeDelete() invoked.");
		
		JSONObject jsonResult = new JSONObject();
		
		if (noticeDAO.noticeDelete(notice) == true) {
			jsonResult.put("status", true);
			jsonResult.put("message", "삭제댐");
			
		} else {
			jsonResult.put("status", false);
			jsonResult.put("message", "삭제안댐");
		}
		
		return jsonResult;
	}
	
	
	//6. 메인에 TOP5 출력하기
	public List<NoticeDTO> noticeTop5() throws Exception {
		System.out.println("service.noticeTop5() invoked.");
		
		return noticeDAO.noticeTop5();
	}
	
	
	//7. 조회수 증가
	public int viewCount(int noticeid) throws Exception {
		System.out.println("service.viewCount() invoked.");
		
		return noticeDAO.viewCount(noticeid);
	}
	
	
	//8. 체크박스된 게시글 삭제
	public boolean noticesDelete(NoticeDTO notice) throws Exception {
		System.out.println("service.noticesDelete() invoked.");
		
		return noticeDAO.noticesDelete(notice);
	}

	
	//9. [페이징]검색된 전체 건수 얻는다
	//	 공지사항 총 개수
	/*
	 * public int getTotalCount(NoticeDTO notice) throws Exception {
	 * System.out.println("service.noticesDelete() invoked.");
	 * 
	 * return noticeDAO.getTotalCount(notice); }
	 */
	
	// 	 공지사항 목록(파라미터값 notice임!)
	public Map<String, Object> noticePageList(NoticeDTO notice) throws Exception {
		System.out.println("notice.service.getNoticeList() 페이징 목록 함수 호출됨");

		//1. 전체 건수를 얻는다
		notice.setTotalCount(noticeDAO.getTotalCount(notice));
		
		Map<String, Object> result = new HashMap<>();
		result.put("notice", notice);
		result.put("list", noticeDAO.noticePagingList(notice));
		
		return result;
		
	} // getNoticeList
	
	
	//10. 게시글 삭제 후 다시 10건으로 만들어주는 메서드
	public List<NoticeDTO> noticeListBoforeN(NoticeDTO notice, int length) throws Exception {
		System.out.println("service.noticeListBoforeN() invoked.");
		
		return noticeDAO.noticeListBoforeN(notice, length);
	}
	



}
