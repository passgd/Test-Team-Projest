package com.kosa.starrydonuts.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.starrydonuts.domain.MemberDTO;
import com.kosa.starrydonuts.service.MemberService;

@Controller
public class MemberContoller {

	@Autowired
	private MemberService memberService;
	
//	회원가입 =====================================================================================

	
	// 회원가입
	@ResponseBody
	@RequestMapping(value="/member/join.do", method = RequestMethod.POST)
	public String join(@RequestBody MemberDTO member, HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		System.out.println("controller.insert() invoked.");
		System.out.println(member);
		
		JSONObject jsonResult = memberService.memberInsert(member);

		return jsonResult.toString();
	} // join
	
	
	// 아이디 중복확인
	public String isExistUId(MemberDTO member, HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		System.out.println("isExistUId() invoked.");

		JSONObject jsonResult = new JSONObject();
		if(memberService.isExistUId(member)) {
			jsonResult.put("status", true);
			jsonResult.put("message", "아이디가 사용 불가능 합니다");
		} else {
			jsonResult.put("status", false);
			jsonResult.put("message", "아이디가 사용가능합니다");
		}
		
		return jsonResult.toString();
	} // isExistUId
	
	
//	로그인 & 로그아웃 =====================================================================================
	

	// 로그인
	@ResponseBody
	@RequestMapping(value="/member/login.do", method = RequestMethod.POST)
	public String login(@RequestBody MemberDTO member, HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		HttpSession session = request.getSession();
		System.out.println("controller.member.controller.login() invoked.");
		
		JSONObject member2 = memberService.memberLogin(member, session);
		session.setAttribute("loginMember", member2.get("loginMember"));
		
		System.out.println("controller.session : " + session.getAttribute("loginMember"));
		System.out.println("controller.member2 : " + member2);
		
		
		return member2.toString();
	} // login
	
	
	// 로그아웃
	@RequestMapping(value="/member/logout.do", method = RequestMethod.POST)
	public void logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		System.out.println("logout() invoked.");

		session.invalidate();
		System.out.println("logout2() invoked. 성공");
	} // logout
	

//	아이디 & 비밀번호 찾기 =====================================================================================
	

	// 아이디 찾기
	@ResponseBody
	@RequestMapping(value="/member/idFind.do", method = RequestMethod.POST)
	public Map<String, Object> idFind (@RequestBody MemberDTO member) throws Exception {
		
		Map<String, Object> result = new HashMap<>();
		
		MemberDTO findId = memberService.memberFindId(member);
		
		if(findId != null) {
			String id = findId.getId();			
			result.put("status", true);
			result.put("message", "아이디를 찾았습니다. \n회원님의 아이디는 '" + id + "'입니다.");
		}else {
			result.put("status", false);
			result.put("message", "이름 또는 전화번호가 잘못 입력했습니다.");	
		}
		 
		return result;
	} // idFind
		

	// 비밀번호 찾기
	@ResponseBody
	@RequestMapping(value="/member/pwdFind.do", method = RequestMethod.POST)
	public Map<String, Object> pwdFind (@RequestBody MemberDTO member) throws Exception {
		System.out.println("controller.pwdFind() invoked.");
		
		Map<String, Object> result = new HashMap<>();
		
		MemberDTO findPwd = memberService.memberFindPwd(member);
		
		if (findPwd != null) {
			String pwd = findPwd.getPwd();
			result.put("status", true);
			result.put("message", "비밀번호를 찾았습니다. \n회원님의 비밀번호는 '" + pwd + "'입니다.");
		} else {
			result.put("status", false);
			result.put("message", "비밀번호 찾기 실패");
		}

		return result;
	} // pwdFind
	

//	회원관리 =====================================================================================
	
	
	// 회원 전체목록 창
	public String list (HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("list() invoked.");
		
		try { 
			request.setAttribute("member", memberService.memberList());
        } catch (Exception e) { 
        	e.printStackTrace();
        }
		
		System.out.println(memberService.memberList());
		return "member/memberList.jsp";
	} // list

	
	// 회원 수정
	@ResponseBody
	@RequestMapping(value="/member/update.do", method = RequestMethod.POST)
	public String update (@RequestBody MemberDTO member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("controller.update() invoked.");

		JSONObject jsonResult = memberService.memberUpdate(member);
		HttpSession session = request.getSession();
		System.out.println("controller member : "+ member);
		session.setAttribute("loginMember", member);
		
		return jsonResult.toString();
	} // update
	

	// 회원 탈퇴
	@ResponseBody
	@RequestMapping(value="/member/delete.do", method = RequestMethod.POST)
	public String delete (@RequestBody MemberDTO member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("controller.delete() invoked.");
		System.out.println("controller.member : " + member);
		
		HttpSession session = request.getSession();
		JSONObject jsonResult = memberService.memberDelete(member);
		session.invalidate();
		
		return jsonResult.toString();
	} // delete
	
} // end class
