package com.kosa.starrydonuts.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {
	
	private String id;			// 아이디
	private String pwd;			// 비밀번호
	private String uname;		// 이름
	private String birth;		// 생일
	private String gender;		// 성별
	private String phone;		// 핸드폰번호
	private String email;		// 이메일
	private int adcheck;		// 관리자여부
	
	
	// 로그인 - 비밀번호 일치여부
	public boolean isEqualsPwd(MemberDTO member) {
		return pwd.equals(member.getPwd());
	}

}