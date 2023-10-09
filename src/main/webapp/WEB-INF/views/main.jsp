<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


        <div id="slideShow">
            <div id="slides">
                <img src="<c:url value='/resources/images/main1.jpg'/>">
                <img src="<c:url value='/resources/images/main2.jpg'/>">
                <button id="prev">&lang;</button>
                <button id="next">&rang;</button>
            </div>
        </div>
        <div id="contents">
            <div id="tabMenu">
                <input type="radio" id="tab1" name="tabs" checked>
                <label for="tab1">공지사항</label>
                <input type="radio" id="tab2" name="tabs">
                <label for="tab2">게시판</label>

                <div id="notice" class="tabContent">
                    <h2>공지사항</h2>
                    <ul>
			            <c:forEach var="notice" items="${noticeTop5}">
			              <li><a href="#" onclick="notice_dialogDetail(${notice.noticeid})">${notice.title}</a></li>
			            </c:forEach>
                    </ul>
                </div>
                <div id="gallery" class="tabContent">
                    <h2>회원 게시판</h2>
                    <ul>
                        <c:forEach var="board" items="${boardTop5}">
			              <li><a href="#" onclick="board_dialogDetail(${board.boardid})">${board.title}</a></li>
			            </c:forEach>
                    </ul>
                </div>
            </div>
            <div id="links">
                <ul>
                    <li>
                        <a href="#">
                            <span id="quick-icon1"></span>
                            <p>BEST</p>
                            
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span id="quick-icon2"></span>
                            <p>NEW</p>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span id="quick-icon3"></span>
                            <p>GOODS</p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        
        <!-- 공지사항 글 상세보기 -->
		<div id="notice_detail" title="글 상세보기" >
			<div class="notice_detail2">
			  	<input type="hidden" name="noticeid" id="notice_noticeid" value="${notice.noticeid}"/> 
		      	<h3 id="ntitle2">[  ] </h3>
		      	<hr>
			      <br>
			      <div class="meta-info" id="info2"">
			  		작성자 :  <span id="notice_writer_uid2">${notice.writer_uid}</span>  |　 작성날짜 :  <span id="notice_reg_date2">${notice.reg_date}</span>　 |　 조회수 :  <span id="notice_view_count2">${notice.view_count}</span>
				  </div>
			      <div class="contents" id="notice_contents2">
			    	${notice.contentsHTML}
				  </div>
				  
			</div>
		</div> 

	<!-- 회원게시판 글 상세보기 -->
	<div id="detail" title="글 상세보기" >
	<div class="detail">
	  	<input type="hidden" name="boardid" id="boardid2" value="${board.boardid}"/> 
	       <h2 id="title2">[  ] </h2>
	       <br>
	       <hr>
	       <br>
	       <div class="meta-info" id="info2">
	   		작성자 :  <span id="writer_uid2">${board.writer_uid}</span>  |　 작성날짜 :  <span id="reg_date2">${board.reg_date}</span>　 |　 조회수 :  <span id="view_count2">${board.view_count}</span>
		   </div>
	       <div class="contents"  id="contents2">
	     	${board.contentsHTML}
	 	   </div>
		  <br>
		  <div style="margin:100px">
		       <c:forEach var="attacheFile" items="${board.attacheFileList}" >
		       	   <img src="<c:url value='/attacheFile/download.do?fileNo='/>${attacheFile.fileNo}">
		       </c:forEach>
		  </div>
		  <br>
		  <hr>
		  <br>
		  <br>
 	  	<!-- 댓글 폼 -->
  		<li id="commentItem"  style="display: none; list-style-type: none;" >
			<div>
				댓글번호 : <span id="commentid5">${comment.commentid}</span>
			</div>
			<div>
		        작성자 : <span id="writer_uid5">${comment.writer_uid}</span> | 작성날짜 : <span id="reg_date5"><fmt:formatDate value="${comment.reg_date}" pattern="yyyy-MM-dd" /></span>
		    </div>
		    	<input type="text" class="contents5" style="border: none;" value="${comment.contents}">
		</li>
		
 	  	  <div id="commentList">
 	  	  <ul id="commentListUl">
 	  	  	
 	  	  </ul>
		  </div>
		  
		  <div style="text-align:center; margin-top:10px">
<!--            버튼의 name은 서버로 넘어갈 것에 대해서만 씀 넘어갈 게 없으면 안씀 더보기는 넘길게 없음 -->
           		<!-- <input type ="button" class="button" id="moreBtn" value="더보기" />  -->
          </div>
          <br>
          <br>
          <!-- 댓글 작성 -->
		  <div id="commentInsert">
		  	<p>
		  		<input type="hidden" id="writer_uid6" name="writer_uid" value="${loginMember.id}"  readonly>
		  	<p id="commentWidth">
		  		<input type="text"  id="commentContents"><input type="button" class="button" value="댓글작성" onclick="commentInsert()" style="margin-left:2px;">
		  	</p>
		  </div>
		  
	</div>
	</div> 

		
<!-- ---------------------------------------------------------------------------------------------------- -->

<script src="<c:url value='/resources/js/slideshow.js'/>"></script>
<script type="text/javascript">

/* 공지사항 상세 */
$(document).ready(function() {
	$("#notice_detail").dialog({
	    autoOpen: false,
	    modal: true,
	    width: 1040,
	    height: 600,
	    buttons: {
	        Close: function() {
	            $(this).dialog("close");
	        }
	    }
	});
});

/* 공지사항 상세 패치 코드 */
function notice_dialogDetail(noticeid) {
	alert("공지사항 상세보기");
 	const notice_noticeid = document.querySelector("#notice_noticeid");
	const ntitle2 = document.querySelector("#ntitle2");
	const notice_contents2 = document.querySelector("#notice_contents2");
	const notice_writer_uid2 = document.querySelector("#notice_writer_uid2");
	const notice_reg_date2 = document.querySelector("#notice_reg_date2");
	const notice_view_count2 = document.querySelector("#notice_view_count2");
	
	const param = {
	        noticeid: noticeid
	      };

	      fetch("<c:url value='/notice/detail.do'/>", {
	        method: "POST",
	        headers: {
	          "Content-Type": "application/json; charset=UTF-8",
	        },
	        body: JSON.stringify(param),
	      })
	      .then((response) => response.json())
	      .then((json) => {
	    	  notice_noticeid.innerText = json.detail.noticeid;  
	    	   ntitle2.innerText = json.detail.title;  
	    	   notice_contents2.innerText = json.detail.contents;  
	    	   notice_writer_uid2.innerText = json.detail.writer_uid;  
	    	   notice_reg_date2.innerText = json.detail.reg_date;  
	    	   notice_view_count2.innerText = json.detail.view_count;  
	       	   $("#notice_detail").dialog("open");
	      });
	
	return false;
	
}	

/* ========================================================================== */	
	
/* 회원게시판 상세 */
$(document).ready(function() {
	$("#detail").dialog({
	    autoOpen: false,
	    modal: true,
	    width: 1040,
	    height: 600,
	    buttons: {
	        Close: function() {
	            $(this).dialog("close");
	        }
	    },
	    close: function() {
 	    $("#commentList").empty();
/* 	    location.href="<c:url value='/board/list2.do' />"; */
	    }
	});

	
});



/* 회원게시판 상세 패치 코드 */
function board_dialogDetail(boardid) {

 	const boardid2 = document.querySelector("#boardid2");
	const title2 = document.querySelector("#title2");
	const contents2 = document.querySelector("#contents2");
	const writer_uid2 = document.querySelector("#writer_uid2");
	const reg_date2 = document.querySelector("#reg_date2");
	const writer_uid5 = document.querySelector("#writer_uid5");
	const reg_date5 = document.querySelector("#reg_date5");
	const contents5 = document.querySelector(".contents5");

	
	
	const param = {
	        boardid: boardid
	      };

	      fetch("<c:url value='/board/detail.do'/>", {
	        method: "POST",
	        headers: {
	          "Content-Type": "application/json; charset=UTF-8",
	        },
	        body: JSON.stringify(param),
	      })
	      .then((response) => response.json())
	      .then((json) => {
	    	   boardid2.innerText = json.bdetail.boardid;  
	    	   title2.innerText = json.bdetail.title;  
	    	   contents2.innerText = json.bdetail.contents;  
	    	   writer_uid2.innerText = json.bdetail.writer_uid;  
	    	   reg_date2.innerText = json.bdetail.reg_date;  
	    	   
	    	   const commentList = $("#commentList"); // 댓글 목록 요소 (전체 데이터)
	    	   /* commentList.empty(); */
	    	   
	    	   const comments = json.comment;
	    	   
	    	   comments.forEach((comment) => {
	    	   console.log(">>> " + comment.contents);
	    	   
	    	   const commentItem = $("#commentItem").clone(); // html 복사
	    	   commentItem.find(".contents5").val(comment.contents);
	    	   commentItem.find("#reg_date5").text(comment.reg_date);
	    	   commentItem.find("#writer_uid5").text(comment.writer_uid);
	    	   commentItem.find("#commentid5").text(comment.commentid);
	    	   
	    	   if ("${loginMember.id}" == comment.writer_uid) {
		    	   commentItem.append('<a id="commentUpdateBtn" href="#" onclick="commentUpdate(' + comment.commentid + ')">수정</a>');
		    	   commentItem.append(' | <a id="commentdeletBtn" href="#" onclick="commentDelete(' + comment.commentid + ')">삭제</a>');
	    	   }
	    	   
	    	   commentItem.show();
	    	   commentList.append(commentItem)
	    	   
	    	   })
	    	   
  	   
	       	   $("#detail").dialog("open");
	      });
	      
	
	return false;
	
}

/* 댓글 상세 */
$(document).ready(function() {
	$("#detail").dialog({
	    autoOpen: false,
	    modal: true,
	    width: 1040,
	    height: 600,
	    buttons: {
	        "수정": function() {
	        	
	        	const title = $("#title2").val();
	        	const contents = $("#contents2").text();
	        	
	        	$("#title3").val(title);
	        	$("#contents3").val(contents);
	        	console.log(title);
	        	console.log(contents);
	        	
	            $("#update").dialog("open");
	            
	        },
	        "삭제": function() {
		        	
	        		const boardid2 = $("#boardid2").text();
		        	
		        	console.log('boardid2 : ' + boardid2);
		        	console.log('boardid : ' + boardid);
		        	
		        	const param = {
		        	        boardid: boardid2
		        	      };
	
		        	      fetch("<c:url value='/board/delete.do'/>", {
		        	        method: "POST",
		        	        headers: {
		        	          "Content-Type": "application/json; charset=UTF-8",
		        	        },
		        	        body: JSON.stringify(param),
		        	      })
		        	      .then((response) => response.json())
		        	      .then((json) => {
		        	    	if(json.status === true) {
		        		    	alert(json.message);
		        				alert("해당 글이 삭제되었습니다.");
		        				location.href="<c:url value='/board/list2.do' />";
		        	    	} else {
		        				alert("삭제되지 않았습니다.");
		        	    	}
		        	    	
		        	      });
		        	
		        	return false;
	        },
			"답글": function() {
	        	$("#reply").dialog("open"); 
	        },
	        Close: function() {
	            $(this).dialog("close");
	    	
	        }
	    },
	    close: function() {
 	    $("#commentList").empty();
/* 	    location.href="<c:url value='/board/list2.do' />"; */
	    }
	});

	
});

/* 댓글 작성 패치 코드 */
function commentInsert() {
    // 게시물의 boardid 값을 가져오기
    const boardid = $("#boardid2").text();
    const writer_uid = '${loginMember.id}';
    const commentContents = document.querySelector("#commentContents").value;
    
    console.log("boardid " , boardid);
    console.log("writer_uid " , writer_uid);
    console.log("commentContents " , commentContents);

    const param = {
        boardid: boardid,
        writer_uid: writer_uid,
        contents: commentContents,
    };
    
    fetch("<c:url value='/comment/register.do'/>", {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify(param),
    })
    .then((response) => response.json())
    .then((json) => {
        if (json.status) {
            alert(json.message);
            /* location.href = "<c:url value='/board/list2.do'/>"; */
             /* 	writer_uid2.innerText = json.comment.writer_uid;  */
/*             	boardid2.innerText = json.detail.boardid;  
	    	   title2.innerText = json.detail.title;  
	    	   contents2.innerText = json.detail.contents;  
	    	   writer_uid2.innerText = json.detail.writer_uid;  
	    	   reg_date2.innerText = json.detail.reg_date;   */
	    	   
	    	   const commentList = $("#commentList"); // 댓글 목록 요소 (전체 데이터)
	    	   commentList.empty();
	    	   
	    	   const comments = json.comment;
	    	   console.log(comments);
	    	   
	    	   
	    	   comments.forEach((comment) => {
	    	   console.log(">>> " + comment.contents);
	    	   
	    	   const commentItem = $("#commentItem").clone(); // html 복사
	    	   commentItem.find(".contents5").val(comment.contents);
	    	   commentItem.find("#writer_uid6").text(comment.writer_uid);
	    	   commentItem.find("#reg_date5").text(comment.reg_date);
	    	   commentItem.find("#writer_uid5").text(comment.writer_uid);
	    	   commentItem.find("#commentid5").text(comment.commentid);
	    	   
	    	   console.log("comment.commentid " , comment.commentid);
	    	   
	    	   if ("${loginMember.id}" == comment.writer_uid) {
		    	   commentItem.append('<a id="commentUpdateBtn" href="#" onclick="commentUpdate(' + comment.commentid + ')">수정</a>');
		    	   commentItem.append(' | <a id="commentdeletBtn" href="#" onclick="commentDelete(' + comment.commentid + ')">삭제</a>');
	    	   }
	    	   
	    	   commentItem.show();
	    	   commentList.append(commentItem)
	    	   
	    	   } 
	    	   
	    	 
	    	   
	    	   )
	    	   
	    	   
        } else {
            alert(json.message);
        }
    });

    return false;
}

	
</script>	
	
