package com.kosa.starrydonuts.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kosa.starrydonuts.domain.BoardDTO;
import com.kosa.starrydonuts.domain.MemberDTO;
import com.kosa.starrydonuts.domain.NoticeDTO;
import com.kosa.starrydonuts.service.BoardService;
import com.kosa.starrydonuts.service.NoticeService;

@Controller
public class MainController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private NoticeService noticeService;
	

	@RequestMapping("main.do")
	public String main(MemberDTO member, HttpServletRequest req, HttpServletResponse res) throws Exception {
    	System.out.println("main() invoked. starrynodnuts");
		
		try { 
			
			List<NoticeDTO> noticeTop5 = noticeService.noticeTop5();
        	req.setAttribute("noticeTop5", noticeTop5);
        	
			
			 List<BoardDTO> boardTop5 = boardService.boardTop5();
			 req.setAttribute("boardTop5", boardTop5);
			 
        } catch (Exception e) { 
        	e.printStackTrace();
        }

		return "main";
		
	} // list

} // end class
