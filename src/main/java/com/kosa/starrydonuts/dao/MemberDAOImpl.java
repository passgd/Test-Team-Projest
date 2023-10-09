package com.kosa.starrydonuts.dao;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.starrydonuts.domain.MemberDTO;

@Repository("MemberDAO")
public class MemberDAOImpl implements MemberDAO{
	
	@Autowired
	private SqlSession sqlSession;

	
	//1. 회원가입
	@Override
	public boolean memberInsert(MemberDTO member) {
		int member1 = sqlSession.insert("mapper.member.memberInsert", member);
		
		System.out.println("dao.memberDAOImpl.memberInsert() invoked. starrydonuts");
		System.out.println("dao.memberDAOImpl.memberInsert.member1 : " + member1);
		
		return member1 == 1;
	}

	//1-2. 아이디 중복 검사
	@Override
	public boolean isExistUid(MemberDTO member) {
		return sqlSession.selectOne("mapper.member.isExistUid", member);
	}	
	
	//2. 로그인
	@Override
	public MemberDTO memberLogin(MemberDTO member) {
		MemberDTO member1 = sqlSession.selectOne("mapper.member.memberLogin", member);
		
		System.out.println("dao.memberDAOImpl.memberLogin() invoked. starrydonuts");
		System.out.println(member1);

		return member1;
		
//		System.out.println(member);
	}

	//3. 회원 전체조회 
	@Override
	public List<MemberDTO> memberList() {
		return sqlSession.selectList("mapper.member.memberLogin");
	}

	//4. 상세조회
	@Override
	public MemberDTO memberGet(String id) {
		return sqlSession.selectOne("mapper.member.memberLogin", id);
	}

	//5. 회원수정
	@Override
	public boolean memberUpdate(MemberDTO member) {
		
		int member1 = sqlSession.insert("mapper.member.memberUpdate", member);
		
		System.out.println("dao.memberDAOImpl.memberUpdate() invoked. starrydonuts");
		System.out.println("dao.memberDAOImpl.memberUpdate.member1 : " + member1);
		
		return member1 == 1;
	}

	//6. 회원탈퇴
	@Override
	public boolean memberDelete(MemberDTO member) {
		int member1 = sqlSession.delete("mapper.member.memberDelete", member);
		
		System.out.println("dao.memberDAOImpl.memberDelete() invoked. starrydonuts");
		System.out.println("dao.memberDAOImpl.memberDelete.member1 : " + member1);
		
		return member1 == 1;
	}

	
	//7. 아이디찾기
	@Override
	public MemberDTO memberFindId(MemberDTO member) {
		MemberDTO idFind = sqlSession.selectOne("mapper.member.memberFindId", member);
		System.out.println(idFind);
		
		return idFind;
	}

	//8. 비밀번호찾기
	@Override
	public MemberDTO memberFindPwd(MemberDTO member) {
		MemberDTO pwdFind = sqlSession.selectOne("mapper.member.memberFindPwd", member);
		System.out.println(pwdFind);
		
		return pwdFind;
	}

	
} // end class
