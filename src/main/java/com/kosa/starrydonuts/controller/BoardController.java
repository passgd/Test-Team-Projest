package com.kosa.starrydonuts.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kosa.starrydonuts.domain.AttacheFileDTO;
import com.kosa.starrydonuts.domain.BoardDTO;
import com.kosa.starrydonuts.domain.CommentDTO;
import com.kosa.starrydonuts.service.AttacheFileService;
import com.kosa.starrydonuts.service.BoardService;
import com.kosa.starrydonuts.service.CommentService;


@Controller
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private CommentService cservice;
	
	@Autowired
	private AttacheFileService aservice;
	
	private static final String CURR_IMAGE_REPO_PATH = "C:\\file_repo";

	
//	게시판 목록 =====================================================================================
	
	
	// 1. [페이징]게시판 전체 목록 페이지
	@RequestMapping("/board/list2.do")
	public String list2(BoardDTO board, HttpServletRequest req, HttpServletResponse res, String searchTitle) throws Exception {
    	System.out.println("notice.controller.list2() invoked.");
    	
    	Map<String, Object> plist = new HashMap<>();
    	
    	plist = service.noticePageList(board);
		req.setAttribute("plist", plist);
		System.out.println("plist : " +plist);
		
		
		
		return "board/list2";
	}

	
//	게시판 상세 =====================================================================================
	
	// 2. 게시판 상세 페이지
	@ResponseBody
	@RequestMapping(value="/board/detail.do", method = RequestMethod.POST)
	public Map<String, Object> detail(@RequestBody BoardDTO board, Model model) throws Exception {
		System.out.println("board.controller.detail() invoked.");

		
		// 글 상세 조회
		Map<String, Object> map = new HashMap<>();
		BoardDTO detail = service.boardGet(board.getBoardid());
    	
		map.put("bdetail", detail);
    	System.out.println("bdetail : " + detail);
    
		
    	// 댓글 조회
    	// 댓글 목록 출력
    	List<CommentDTO> comment = cservice.commentList(board.getBoardid());
    	map.put("comment", comment);
    	System.out.println("댓글 더보기 출력 성공여부 : " + comment);
    
    	
    	//첨부파일 리스트 출력
    	List<AttacheFileDTO> file = aservice.getList(board);
    	map.put("file", file);

    	
		return map;
		
	} // detail
	
	
	
	// 3. 회원게시판 답글 등록
	@ResponseBody
	@RequestMapping(value="/board/reply.do", method = RequestMethod.POST)
	public String reply(@RequestBody BoardDTO board, HttpServletRequest req, HttpServletResponse res) throws Exception {
    	System.out.println("board.controller.reply() invoked.");
    	
    	JSONObject result = new JSONObject();
    	int status = service.reply(board);

    	System.out.println("회원게시판 답글 성공여부 : " + status);
    	
    	if(status == 1) {
    		result.put("status", true);
    		result.put("message", "회원게시판 답글이 등록되었습니다.");
    	} else {
    		result.put("status", false);
    		result.put("message", "회원게시판 답글이 등록되지 않았습니다.");
    	}

    	System.out.println(result.toString());
		return result.toString();
	}
	
	
	
//	게시판 글쓰기 =====================================================================================

	
	// 3-2. 게시판 글쓰기
	@ResponseBody
	@RequestMapping(value="/board/insert.do", method = RequestMethod.POST)
	public String insert(BoardDTO board, HttpServletRequest req, HttpServletResponse res, MultipartHttpServletRequest multipartRequest) throws Exception {
		System.out.println("board.controller.insert() invoked.");
		JSONObject jsonResult = new JSONObject();
		
		multipartRequest.setCharacterEncoding("utf-8");
		Map map = new HashMap();
		
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			//System.out.println(name+", "+value);
			map.put(name,value);
		}
		
		board.setAttacheFileList(fileProcess(multipartRequest));

		boolean status = service.boardInsert(board);
		
		jsonResult.put("status", status);
		
		return jsonResult.toString();
	
	} // insert

	
//	게시판 글 삭제 =====================================================================================

	// 4-1. 게시판 글 삭제
	@ResponseBody
	@RequestMapping(value="/board/delete.do", method = RequestMethod.POST)
	public String delete(@RequestBody BoardDTO board, HttpServletRequest req, HttpServletResponse res) throws Exception {
		System.out.println("board.controller.delete() invoked.");
		JSONObject jsonResult = new JSONObject();
		boolean status = service.boardDelete(board);
		
    	System.out.println("회원게시판 삭제 성공여부 : " + status);
    	
		jsonResult.put("status", status);
		jsonResult.put("message", status ? "글이 삭제되었습니다" : "오류가 발생하였습니다. 다시 시도해주세요.");
		
		System.out.println();
		return jsonResult.toString();
		
	} // delete
	
	
	// 4-2. 체크박스 글 삭제
	public String deleteBoards(String[] boardids, HttpServletRequest req, HttpServletResponse res) throws Exception {
		System.out.println("board.controller.deleteBoards() invoked.");
		JSONObject jsonResult = new JSONObject();
		boolean status = service.boardsDelete(boardids);
		
		jsonResult.put("status", status);
		jsonResult.put("message", status ? "글이 삭제되었습니다" : "오류가 발생하였습니다. 다시 시도해주세요.");
		
		return jsonResult.toString();
	
	}

	
//	게시판 글 수정 =====================================================================================
	

	
	// 5-1. 게시판 글 수정
	@ResponseBody
	@RequestMapping(value="/board/update.do", method = RequestMethod.POST)
	public String update(@RequestBody BoardDTO board, HttpServletRequest req, HttpServletResponse res) throws Exception {
		System.out.println("board.controller.update() invoked.");
		
		JSONObject jsonResult = new JSONObject();
		boolean status = service.boardUpdate(board);
		
		jsonResult.put("status", status);
		jsonResult.put("message", status ? "글이 수정되었습니다." : "오류가 발생하였습니다. 다시 시도해주세요.");
		
		return jsonResult.toString();
		
	} // update
	
	
	
//	게시판 첨부파일 =====================================================================================
	
	
	private List<AttacheFileDTO> fileProcess(MultipartHttpServletRequest multipartRequest) throws Exception{
		List<AttacheFileDTO> fileList = new ArrayList<>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		Calendar now = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("\\yyyy\\MM\\dd");
		
		while(fileNames.hasNext()){
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String fileNameOrg = mFile.getOriginalFilename();
			String realFolder = sdf.format(now.getTime());
			
			File file = new File(CURR_IMAGE_REPO_PATH + realFolder);
			if (file.exists() == false) {
				file.mkdirs();
			}

			String fileNameReal = UUID.randomUUID().toString() + fileNameOrg.substring(fileNameOrg.lastIndexOf("."));
			
			//파일 저장 
			mFile.transferTo(new File(file, fileNameReal)); //임시로 저장된 multipartFile을 실제 파일로 전송

			fileList.add(
					AttacheFileDTO.builder()
					.fileNameOrg(fileNameOrg)
					.fileNameReal(realFolder + "\\" + fileNameReal)
					.length((int) mFile.getSize())
					.contentType(mFile.getContentType())
					.build()
					);
		}
		
		return fileList;
	
	}	

	
}
