package com.kosa.starrydonuts.dao;

import java.util.List;

import com.kosa.starrydonuts.domain.MemberDTO;

public interface MemberDAO {
	
	//1. 회원가입
	public boolean memberInsert(MemberDTO member);
	
	//1-2. 아이디 중복 검사
	public boolean isExistUid(MemberDTO member);
		
	//2. 로그인
	public MemberDTO memberLogin(MemberDTO member);
	
	//3. 회원 전체조회 
	public List<MemberDTO> memberList();
	
	//4. 상세조회
	public MemberDTO memberGet(String id);
	
	//5. 회원수정
	public boolean memberUpdate(MemberDTO member);
	
	//6. 회원탈퇴
	public boolean memberDelete(MemberDTO member);
	
	//7. 아이디찾기
	public MemberDTO memberFindId(MemberDTO member);
	
	//8. 비밀번호찾기
	public MemberDTO memberFindPwd(MemberDTO member);



	
} // end class
