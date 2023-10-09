<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value='/resources/css/board/boardList.css' />">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="<c:url value='/resources/css/board/boardList.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/board/boardGet.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/board/boardUpdate.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/board/boardInsert.css' />">

           
           <h1 id="text">회원 게시판</h1>
           <div id="container">
           <!-- 게시판 목록 표시 -->
           
           <form name="pageForm" id="pageForm" action="<c:url value='/admin/board/list2.do'/>" method="post" >
				<input type="hidden" name="pageNo" id="pageNo" value="${plist.board.pageNo}" />
				<input type="hidden" name="searchTitle" id="searchTitle" value="${plist.board.searchTitle}" >
				<input type="hidden" name="pageLength" id="pageLength" value="${plist.board.pageLength}" >
           </form>

			<form name="mForm" id="mForm" action="<c:url value='/admin/board/list2.do'/>" method="post" >
			
 			<input type="hidden" name="pageNo" id="pageNo2" value="${plist.board.pageNo}" />
 				<div style="margin:0px auto;">
					<div style="display: flex; margin:0px auto; width:70%; justify-align: center">
						<select name="pageLength" id="pageLength2" >
							<option value="10" ${plist.board.pageLength == 10 ? 'selected="selected"' : ''} >10건</option>
							<option value="20" ${plist.board.pageLength == 20 ? 'selected="selected"' : ''} >20건</option>
							<option value="50" ${plist.board.pageLength == 50 ? 'selected="selected"' : ''} >50건</option>
							<option value="100" ${plist.board.pageLength == 100 ? 'selected="selected"' : ''} >100건</option>
						</select>

						<input type="text" name="searchTitle" id="searchTitle2" value="${plist.board.searchTitle}" >
						<input type="submit" id="searchTitleBtn2" value="검색"/>
           			</div>
				</div>


	           <table>
	           
	              <tr id="boardItem" style="display:none;" >
                     <td><input type="checkbox" class="item" /></td>
                     <td id="boardid"></td>
                     <td id="title"></td>
                     <td id="writer_uid"></td>
                     <td id="reg_date"></td>
                     <td id="view_count"></td>
                  </tr>  
                  
	               <tr>
               	   <c:if test="${loginMember.id == 'admin'}">
               	   	   <th><input type="checkbox" name="selectall" value="selectall" onclick="selectAll(this)"></th>
               	   </c:if>
	                   <th>글번호</th>
	                   <th>제목</th>
	                   <th>작성자</th>
	                   <th>작성날짜</th>
	                   <th>조회수</th>
	               </tr>
	               
	               <tbody id="boardList">
				   <c:forEach items="${plist.list}" var="board">
    				  <tr>
	                    <c:if test="${loginMember.id == 'admin'}">
	                     <td><input type="checkbox" name="item" class="item" onclick="checkSelectAll()" value="${board.boardid}"/></td>
	                    </c:if>
	                     <td>${board.boardid}</td>
	                     <td style="text-align: left">
							<span style="padding-left:${(board.level-1)*20}px"></span>
							${board.level != 1 ? "[답변] " : ""}
							<a href="#" onclick="dialogDetail(${board.boardid})">${board.title}</a>
						</td>
	                     <td>${board.writer_uid}</td>
	                     <td>${board.reg_date}</td>
	                     <td>${board.view_count}</td>
	                  </tr>
	                </c:forEach>
	                
 	            	<c:if test="${empty plist}">
	                	<tr>
	                		<td colspan=7>검색결과가 없습니다</td>
	                 	</tr>
	                </c:if> 
	              </tbody>
	           	</table>
	           	
	           	<div style="text-align: center;margin-top:20px;">
		           	<c:if test="${plist.board.navStart != 1}">
		           		<a href="javascript:jsPageNo(${plist.board.navStart-1})" style="padding: 10px;"> &lt; </a> 
		           	</c:if>
		           	<c:forEach var="item" begin="${plist.board.navStart}" end="${plist.board.navEnd}">
		           		<c:choose>
		           			<c:when test="${plist.board.pageNo != item }">
		           				<a href="javascript:jsPageNo(${item})" style="padding: 10px;">${item}</a>  
		           			</c:when>
		           			<c:otherwise>
		           				<strong style="font-size:1.2rem">${item}</strong>   
		           			</c:otherwise>
		           		</c:choose>
		           	</c:forEach>
		           	<c:if test="${plist.board.navEnd != plist.board.totalPageSize}">
		           		<a href="javascript:jsPageNo(${plist.board.navEnd+1})" style="padding: 10px;"> &gt; </a> 
		           	</c:if>
	           	
	           	</div>
	           	
				<c:if test="${loginMember.id =='admin'}">
		            <div class="buttons"> 
				       <button class="button"><a href="#" id ="dialogWrite">등록</a></button>
			           <button class="button" type="submit" id="deleteBtn">삭제</button>
		            </div>
	            </c:if>
		    </form>
            </div>
            



<!---------------------------------------- 대화상자 Dialog ------------------------------------------->
                        
<div id="insert" title="글 작성">
	<div class="write">
	<form id="image-post" name="mForm" method="post" enctype="multipart/form-data">
		<input type="hidden" id="writer_uid1" name="writer_uid" value="${loginMember.id}"  readonly>
		<input type="text" id="title1" name="title" placeholder="제목" class="text_title2"><br>
		<textarea name="contents" id="contents1" placeholder="내용" ></textarea>
		<input type="button"  value="파일추가" onClick="fn_addFile()"/><br>
		<div id="d_file"></div>
	</form>
	</div>
</div>



<%-- 	<h1 id="text">회원 게시판</h1>
	<div id="container">
	    <div id="insert_form" title="게시판 상세보기">
	    	<form name="mForm" method="post" action="<c:url value='/board/replyForm.do'/>">
	    		<input type="hidden" name="boardid" value="${board.boardid}">
			        제목 : ${board.title} <br/>
			        내용 : ${board.contentsHTML} <br/>
		       <button type="submit">답글</button>
		       <div style="margin:100px">
		       <c:forEach var="attacheFile" items="${board.attacheFileList}" >
		       	   <img src="<c:url value='/attacheFile/download.do?fileNo='/>${attacheFile.fileNo}">
		       </c:forEach>
		       </div>
	       </form>
	    </div>
	</div>     --%>
	
	
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


<div id="update" title="글 수정">
	<input type="hidden" name="boardid" id="boardid3" value="${board.boardid}"><br>
	<input type="text" name="title" id="title3" placeholder="제목" class="text_title" value="${board.title}"><br>
    <textarea name="contents" id="contents3" placeholder="내용" class="board_ct">${board.contents}</textarea>
    <!-- ${loginMember.id}-->
    <p><input type="hidden" id="writer_uid3" name="writer_uid" value="${loginMember.id}"  readonly></p>
</div> 


<div id="reply" title="답글 작성">
	<div class="write">
		<input type="hidden" name="boardid" id="boardid4" value="${board.boardid}"><br>
		<input type="hidden" id="writer_uid4" name="writer_uid" value="${loginMember.id}"  readonly>
		<input type="text" id="title4" name="title2" placeholder="제목" class="text_title2"><br>
		<textarea name="contents2" id="contents4" placeholder="내용" ></textarea>
	</div>
</div>


      
<script src="<c:url value='/js/check.js'/>"></script>
<script>

var cnt=1;
function fn_addFile(){
	$("#d_file").append("<br>"+"<input  type='file' name='file"+cnt+"' />");
	cnt++;
}


/* --------------------------- 버튼 클릭 --------------------------- */

$("#dialogWrite").on("click", () => {
	$("#insert").dialog("open");
});


$("#dialogUpdate").on("click", () => {
	$("#update").dialog("open");
});


/* --------------------------- 다이얼로그 창 띄우기 --------------------------- */
/* 회원게시판 등록 */

$(document).ready(function() {
    $("#insert").dialog({
        autoOpen: false,
        modal: true,
	    width: 1040,
	    height: 600,
        buttons: {
        	"등록":function() {
        		dialogInsert();
        	},
        	Close: function() {
                $(this).dialog("close");
            }
        }
    });

});



/* 회원게시판 상세 */
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


/* 회원게시판 수정 */
$(document).ready(function() {
	$("#update").dialog({
	    autoOpen: false,
	    modal: true,
	    width: 1040,
	    height: 600,
	    buttons: {
	        "수정":function() {
	            dialogUpdate();
	        },
	        Close : function() {
	            $(this).dialog("close");
	        }
	    }
	});
    
});


/* 회원게시판 답글 */
$(document).ready(function() {
	$("#reply").dialog({
	    autoOpen: false,
	    modal: true,
	    width: 1040,
	    height: 600,
	    buttons: {
	        "등록":function() {
	        	dialogReply();
	        },
	        Close : function() {
	            $(this).dialog("close");
	        }
	    }
	});
    
});


/* --------------------------- 공지사항 패치 코드 --------------------------- */
/* 글 작성 패치 코드 */
function dialogInsert() {
	
	const formData = new FormData($("#image-post")[0]);
	const title = document.querySelector("#title1");
	const contents = document.querySelector("#contents1");
	
	if (title.value == "") {
		alert("제목은 필수 입력입니다");
		title.focus();
		return false;
	}
	
	if (contents.value == "") {
		alert("내용은 필수 입력입니다");
		contents.focus();
		return false;
	}
	
/* 	const param = {
	        writer_uid: writer_uid1.value,
	        title: title1.value,
	        contents: contents1.value
	      }; */
	
	      fetch("<c:url value='/board/insert.do'/>", {
	        method: "POST",
	        headers: {
	        },
	        body: formData,
	      })
	      .then((response) => response.json())
	      .then((json) => {
	          if (json.status) {
	        	  alert(json.message);
	        	  location.href = "<c:url value='/board/list2.do'/>"; 
	          } else {
	        	  alert(json.message);
	          }
	      });
	
	return false;
	
}



/* 글 답글 패치 코드 */
function dialogReply() {
	
	const pid = $("#boardid2").text();
	const title = document.querySelector("#title4");
	const contents = document.querySelector("#contents4");
	
	if (title.value == "") {
		alert("제목은 필수 입력입니다");
		title.focus();
		return false;
	}
	
	if (contents.value == "") {
		alert("내용은 필수 입력입니다");
		contents.focus();
		return false;
	}
	alert(pid);
	const param = {
			pid: pid,
	        writer_uid: writer_uid4.value,
	        title: title.value,
	        contents: contents.value
	      };
	
	      fetch("<c:url value='/board/reply.do'/>", {
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
	        	  location.href = "<c:url value='/board/list2.do'/>"; 
	          } else {
	        	  alert(json.message);
	          }
	      });
	
	return false;
	
}


/* 글 상세 패치 코드 */
function dialogDetail(boardid) {

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



/* 글 수정 패치 코드 */
function dialogUpdate(boardid) {
	
    const boardid2 = $("#boardid2").text();
    const title3 = $("#title3").val();
    const contents3 = $("#contents3").val();
    const writer_uid2 = $("#writer_uid2").text(); // 수정: # 추가
    
    const param = {
        boardid: boardid2,
        title: title3,
        contents: contents3,
        writer_uid: writer_uid2
    };
    
    
    fetch("<c:url value='/board/update.do'/>", {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify(param)
    })
    .then(response => response.json())
    .then(data => {
        if (data.status) {
            alert(data.message);
            // 수정이 성공한 경우에 업데이트된 내용을 화면에 반영
            $("#title3").text(title3);
            $("#contents3").text(contents3);
            // editDialog 열고 닫는 코드 (확인 필요)
            // editDialog.dialog("close");
            location.href = "<c:url value='/board/list2.do'/>"; 
        }
    });
    
    // editDialog 닫는 코드 (확인 필요)
    // editDialog.dialog("close");
}




function jsPageNo(pageNo) {
	document.querySelector("#pageForm > #pageNo").value = pageNo;
	document.querySelector("#pageForm").submit(); 
}




document.querySelector("#mForm").addEventListener("submit", e => {
	document.querySelector("#mForm > #pageNo").value = "1";
	
	return true;
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
	    	   commentItem.find(".contents5").text(comment.contents);
	    	   commentItem.find("#writer_uid6").text(comment.writer_uid);
	    	   commentItem.find("#reg_date5").text(comment.reg_date);
	    	   commentItem.find("#writer_uid5").text(comment.writer_uid);
	    	   commentItem.find("#commentid5").text(comment.commentid);
	    	   
	    	   console.log("comment.commentid " , comment.commentid);
	    	   
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



function commentDelete() {
    // 현재 클릭한 댓글 아이템을 가져옴
    const commentItem = $(event.target).closest("li");
    
    // 해당 댓글 아이템에서 commentid와 writer_uid5 값을 가져옴
    const commentid5 = commentItem.find("#commentid5").text();
    const writer_uid5 = commentItem.find("#writer_uid5").text();
    
    console.log("commentItem:", commentItem);
    console.log("commentid5:", commentid5);
    console.log("writer_uid5:", writer_uid5);

    const param = {
        commentid: commentid5,
        writer_uid: writer_uid5
    };

    fetch("<c:url value='/comment/remove.do'/>", {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify(param),
    })
    .then((response) => response.json())
    .then((json) => {
        if (json.status === true) {
            alert(json.message);
            alert("해당 댓글이 삭제되었습니다.");

               const commentList = $("#commentList"); // 댓글 목록 요소 (전체 데이터)
	    	   commentList.empty();
	    	   
	    	   const comments = json.comment;
	    	   console.log(comments);
	    	   
	    	   
	    	   comments.forEach((comment) => {
	    	   console.log(">>> " + comment.contents);
	    	   
	    	   const commentItem = $("#commentItem").clone(); // html 복사
	    	   commentItem.find(".contents5").text(comment.contents);
	    	   commentItem.find("#writer_uid6").text(comment.writer_uid);
	    	   commentItem.find("#reg_date5").text(comment.reg_date);
	    	   commentItem.find("#writer_uid5").text(comment.writer_uid);
	    	   commentItem.find("#commentid5").text(comment.commentid);
	    	   
	    	   console.log("comment.commentid " , comment.commentid);
	    	   
	    	   commentItem.show();
	    	   commentList.append(commentItem)
	    	   
	    	   } 

	    	   )
        } else {
            alert("삭제되지 않았습니다.");
        }
    });

    return false;
}



/* 댓글 수정 패치 코드 */
function commentUpdate(commentid) {
    const commentItem = $(event.target).closest("li");
    
    const commentid5 = commentItem.find("#commentid5").text();
    const writer_uid5 = commentItem.find("#writer_uid5").text();
    const contents5 = commentItem.find(".contents5").val();
    
    const param = {
        commentid: commentid5,
        writer_uid: writer_uid5,
        contents: contents5
    };
	
	console.log(commentid);

    
    fetch("<c:url value='/comment/modify.do'/>", {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify(param)
    })
    .then(response => response.json())
    .then(data => {
        if (data.status) {
            alert(data.message);
            // 수정이 성공한 경우에 업데이트된 내용을 화면에 반영
            $(".contents5").val(contents5);

	    	   const commentList = $("#commentList"); // 댓글 목록 요소 (전체 데이터)
	    	   commentList.empty();
	    	   
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
	    	   
        }
    });
    
    // editDialog 닫는 코드 (확인 필요)
    // editDialog.dialog("close");
}



/* document.querySelector("#deleteBtn").addEventListener("click", e => {
	e.preventDefault();
	const boardList = document.querySelector("#boardList");
	let ids = [];
	const items = document.querySelectorAll(".item:checked");

	if (items.length == 0) {
		alert("삭제할 항목을 선택하세요");
		return false;
	}		
	
	if (!confirm("삭제하시겠습니까?")) return false;
	
	items.forEach(item => {
		ids.push(item.value);
	});
	
	console.log(ids);

	const param = {
		ids: ids,
        boardid: document.querySelector("#boardList tr:last-child td:first-child input[type='checkbox']").value,
	};

    fetch("<c:url value='/board/deletes.do'/>", {
      method: "POST",
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: JSON.stringify(param),
    })
    .then((response) => response.json())
    .then((json) => {
        if (json.status) {
      	    //서버에서 공지사항 삭제 됨 
      	    //1. 화면부분에 있는 자료를 삭제
			//삭제 함수 
			for (let i=items.length-1;i>=0;i--) {
				boardList.removeChild(items[i].parentNode.parentNode);
			}
      	    
      	    //2. 서버에서 삭제 건수 만큼 얻는 공지사항 목록을 출력한다
	      	  const boardListJson = json.boardList;
	      	  const boardItem = document.querySelector("#boardItem");
	      	  
	      	  for (let i=0;i<boardListJson.length;i++) {
		        	  const board = boardListJson[i];
		        	  const newboardItem = boardItem.cloneNode(true);
					  const title = newboardItem.querySelector("#title");

					  newboardItem.querySelector("#boardid").innerText = board.boardid; 
		        	  title.innerText = board.title;
		        	  newboardItem.querySelector("#writer_uid").innerText = board.writer_uid; 
		        	  newboardItem.querySelector("#reg_date").innerText = board.reg_date; 
		        	  newboardItem.querySelector("#view_count").innerText = board.view_count; 
		        	  newboardItem.querySelector("#fixed_yn").innerText = board.fixed_yn; 
	
		        	  //이벤트 핸들링 
		        	  newboardItem.querySelector(".item").value = board.boardid;
		        	  newboardItem.querySelector(".item").addEventListener("click", e => checkSelectAll());
		        	  newboardItem.addEventListener("click", e => jsDetailView(board.boardid));
		        	  
		        	  newboardItem.style.display = "";
		        	  boardList.appendChild(newboardItem);
	      	  }
      	    
        } else {
        	alert(json.message);
        }
        
    });
	
	return false;
	
}); */


document.querySelector("#moreBtn").addEventListener("click", e => {

    // 마지막 댓글의 ID 가져오기
    const lastComment = document.querySelector("#commentList li:last-child");
    const lastCommentId = lastComment.getAttribute("data-comment-id");
    
    const param = {
        boardid: lastCommentId, // 이 부분을 수정하여 마지막 댓글의 ID를 서버에 전달합니다.
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
        console.log(json.list);
        if (json.status) {
            const commentList = json.list;
            const commentItem = document.querySelector("#commentItem");
            const commentListHTML = document.querySelector("#commentList");
            
            for (let i = 0; i < commentList.length; i++) {
                const comment = commentList[i];
                const newCommentItem = commentItem.cloneNode(true);
                
                // 수정된 부분: commentItem 대신 newCommentItem을 사용해야 합니다.
                
                newCommentItem.querySelector(".contents5").innerText = comment.contents;
                newCommentItem.querySelector("#reg_date5").innerText = comment.reg_date;
                newCommentItem.querySelector("#writer_uid5").innerText = comment.writer_uid;
                
                newCommentItem.style.display = "";
                commentListHTML.appendChild(newCommentItem);
            }
        }
    });
    
    return false;
});



</script>