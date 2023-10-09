package com.kosa.starrydonuts.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CommentDTO {

      private int commentid;   // 코멘트 아이디
      private int boardid;      	// 참고할 공지사항 아이디
      private String writer_uid;      // 작성자
      private String contents;      // 댓글 내용
      private Date reg_date;      // 작성날짜
      private Date update_date;   // 수정날짜
  	  private String N;

      public int getCommentid() {
          return commentid;
      }
      
} // end class
