package com.kosa.starrydonuts.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.starrydonuts.dao.MemberDAO;
import com.kosa.starrydonuts.domain.MemberDTO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	//1. 회원가입
	public JSONObject memberInsert(MemberDTO member) {
		System.out.println("service.memberInsert() 회원가입 서비스 진입");
		
		JSONObject jsonResult = new JSONObject();
		if (memberDAO.memberInsert(member) == true) {
			jsonResult.put("status", true);
		} else {
			jsonResult.put("status", false);

		}
		return jsonResult;
	}
	
	
	//1-2. 아이디 중복 검사
	public boolean isExistUId(MemberDTO member) throws Exception {
		  System.out.println("service.isExistUId() 아이디 중복 확인 서비스 진입");
	    
	      return memberDAO.isExistUid(member);
	}
	
		
	//2. 로그인
	public JSONObject memberLogin(MemberDTO member, HttpSession session) {
		  System.out.println("service.memberLogin() 로그인 서비스 진입");
		  
		  JSONObject jsonResult = new JSONObject();
		  MemberDTO loginMember = memberDAO.memberLogin(member);
		  if (loginMember != null) {
				session.setAttribute("loginMember", loginMember);
				jsonResult.put("loginMember", loginMember);
				jsonResult.put("status", true);
				
				System.out.println("로그인 성공~~! service");
		  } else {
				System.out.println("로그인 실패!");
				jsonResult.put("status", false);

		  }
		  
		
	      return jsonResult;
	}
	

	//3. 회원 전체조회
	public List<MemberDTO> memberList() throws Exception {
		  System.out.println("service.memberList() 회원 전체 조회 서비스 진입");
		  
	      return memberDAO.memberList();
	}
	
	
	//4. 상세조회
	public MemberDTO memberGet(String id) throws Exception {
		  System.out.println("service.memberGet() 회원 상세 조회 서비스 진입");
		  
		  return memberDAO.memberGet(id);
	}
	
	
	//5. 회원수정
	public JSONObject memberUpdate(MemberDTO member) throws Exception {
		  System.out.println("service.memberUpdate() 회원 수정 서비스 진입");
		 
		  JSONObject jsonResult = new JSONObject();
		  
			if (memberDAO.memberUpdate(member) == true) {
				jsonResult.put("status", true);
			} else {
				jsonResult.put("status", false);
			}

	      return jsonResult;
	}
	
	
	//6. 회원탈퇴
	public JSONObject memberDelete(MemberDTO member) throws Exception {
		  System.out.println("service.memberDelete() 회원 탈퇴 서비스 진입");
		 
		  JSONObject jsonResult = new JSONObject();
		  
			if (memberDAO.memberDelete(member) == true) {
				jsonResult.put("status", true);
			} else {
				jsonResult.put("status", false);
			}

	      return jsonResult;
	}
	
	
	//7. 아이디찾기
	public MemberDTO memberFindId(MemberDTO member) throws Exception {
		  System.out.println("service.memberFindId() 아이디 찾기 서비스 진입");

	      return memberDAO.memberFindId(member);
	}
	
	
	//8. 비밀번호찾기
	public MemberDTO memberFindPwd(MemberDTO member) throws Exception {
		  System.out.println("service.memberFindPwd() 비밀번호 찾기 서비스 진입");

	      return memberDAO.memberFindPwd(member);
	}
	
	
} // end class
