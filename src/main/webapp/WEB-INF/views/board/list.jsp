<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<c:url value='/resources/css/board/boardList.css' />">

<style>
    /* 링크 스타일 */
    a {
      text-decoration: none;
    }

    a:link { text-decoration: black;}
 	a:visited { text-decoration: black;}
</style>

           <h1 id="text">공지사항</h1>
           <div id="container">
           <!-- 게시판 목록 표시 -->
           
           <form action="<c:url value='/board/deletes.do' />" method="post" onsubmit="return checkMultiDelete()">
           
           <table>
           	
	           	<tr id="boardItem" style="display:none">
	           		<c:if test="${loginMember.id=='admin'}">
	               	   <td><input type="checkbox" name="selectall" value="selectall" onclick="selectAll(this)"></th>
	               </c:if>
	                <td id="boardid"></td>
	                <td ><a href="boardGet?boardid=${boardid}" id="title"></a></td>
	                <td id="writer_uid"></td>
	                <td id="reg_date"></td>
	                <td id="view_count"></td>
					<td><button type="button" id="deleteBtn">삭제</button></td>
	            </tr>
	            
	            <tbody id="boardList">
	            	<tr>
		               <c:if test="${loginMember.id=='admin'}">
		               	   <th><input type="checkbox" name="selectall" value="selectall" onclick="selectAll(this)"></th>
		               </c:if>
		                   <th>글번호</th>
		                   <th>제목</th>
		                   <th>작성자</th>
		                   <th>작성날짜</th>
		                   <th>조회수</th>
		                   <c:if test="${loginMember.id=='admin'}">
		                     <th>삭제</th>
		                   </c:if>
	               	</tr>
	     
				   	<c:forEach items="${boardList}" var="board">
	                  <tr>
	                  <c:if test="${loginMember.id=='admin'}">
		                <td><input type="checkbox" name="item" class="item" onclick="checkSelectAll()" value="${board.boardid}" /></td>
		              </c:if>
		                <td>${board.boardid}</td>
						<td style="text-align: left">
							<span style="padding-left:${(board.level-1)*20}px"></span>
							${board.level != 1 ? "[답변] " : ""}
							<a href="#" onclick="board_dialogDetail(${board.boardid})">${board.title}</a>
						</td>
		                <td>${board.writer_uid}</td>
		                <td>${board.reg_date}</td>
		                <td>${board.view_count}</td>
		                <c:if test="${loginMember.id=='admin'}">
		                	<td><button type="button" id="deleteBtn">삭제</button></td>
		                </c:if>
	                  </tr>
	                </c:forEach>
				</tbody>
				                
           	</table>
           
	            
            <div style="text-align:center; margin-top:10px">
<!--            버튼의 name은 서버로 넘어갈 것에 대해서만 씀 넘어갈 게 없으면 안씀 더보기는 넘길게 없음 -->
           		<input type ="button" id="moreBtn" value="더보기" /> 
           	</div>
           	
           	<!-- 로그인한 사람만 작성 -->
           	<c:if test="${loginMember != null}">
	           	<div class="buttons">
		           	<%-- <button class="button"><a href="<c:url value='/board/insertForm.do'/>">글 작성</a></button> --%>
		           	<button class="button" id="insert_form">글 작성</button>
		           	<!-- 로그인한 사람만 작성 -->
		            <c:if test="${loginMember.id=='admin'}">
			       	 	<button class="button" type="submit">글 삭제</button>
			        </c:if>
	            </div>
	        </c:if>
			</form>
            </div>
            
<!---------------------------------------- 대화상자 Dialog ------------------------------------------->

		<!-- 회원게시판 글 상세보기 -->
 		<div id="board_detail" title="글 상세보기" >
			<div class="board_detail2">
			  	<input type="hidden" name="boardid" id="boardid3" value="${board.boardid}"/> 
		      	<h3 id="title3">[  ] </h3>
		      	<hr>
			      <br>
			      <div class="meta-info" id="info3"">
			  		작성자 :  <span id="writer_uid3">${board.writer_uid}</span>  |　 작성날짜 :  <span id="reg_date3">${board.reg_date}</span>　 |　 조회수 :  <span id="view_count3">${board.view_count}</span>
				  </div>
			      <div class="contents" id="contents3">
			    	${board.contentsHTML}
				  </div>
			</div>
		</div> 
       
       
<script src="<c:url value='/resources/js/check.js'/>"></script>

<script type="text/javascript">

/* --------------------------- 버튼 클릭 --------------------------- */

/* 게시판 상세 */
/* 회원게시판 상세 패치 코드 */
$(document).ready(function() {
	$("#board_detail").dialog({
	    autoOpen: false,
	    modal: true,
	    width: 800,
	    height: 500,
	    buttons: {
	        Close: function() {
	            $(this).dialog("close");
	        }
	    }
	});
});

/* 글 상세 패치 코드 */
function board_dialogDetail(boardid) {
	alert("회원게시판 상세보기");
 	const boardid3 = document.querySelector("#boardid3");
	const title3 = document.querySelector("#title3");
	const contents3 = document.querySelector("#contents3");
	const writer_uid3 = document.querySelector("#writer_uid3");
	const reg_date3 = document.querySelector("#reg_date3");
	const view_count3 = document.querySelector("#view_count3");

	
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
	    	   boardid3.innerText = json.detail2.noticeid;  
	    	   title3.innerText = json.detail2.title;  
	    	   contents3.innerText = json.detail2.contents;  
	    	   writer_uid3.innerText = json.detail2.writer_uid;  
	    	   reg_date3.innerText = json.detail2.reg_date;  
	    	   view_count3.innerText = json.detail2.view_count;  
	       	   $("#board_detail").dialog("open");
	      });
	
	return false;
	
}	





document.querySelector("#deleteBtn").addEventListener("click", e => {
	//이벤트 핸들러의 기본 동작을 취소한다
	e.preventDefault();
	
	if (!confirm(" 삭제하시겠습니까?")) return false;
	
	const param = {
		boardid: document.querySelector("#boardid").value,
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
  	  alert(json.message);
        if (json.status) {
      	  location.href = "<c:url value='/board/list.do'/>"; 
        }
    });
	
	return false;
})


document.querySelector("#moreBtn").addEventListener("click", e => {
	//이벤트 핸들러의 기본 동작을 취소한다
	e.preventDefault();
	
	const param = {
	        boardid: document.querySelector("#boardList tr:last-child td:first-child").innerText,
	      };

	      fetch("<c:url value='/board/ajaxList.do'/>", {
	        method: "POST",
	        headers: {
	          "Content-Type": "application/json; charset=UTF-8",
	        },
	        body: JSON.stringify(param),
	      })
	      .then((response) => response.json())
	      .then((json) => {
	    	  console.log(json.list);
	    	  let html = "";
	          if (json.status) {
	        	  const boardList = json.list;
	        	  const boardItem = document.querySelector("#boardItem");
	        	  const boardListHTML = document.querySelector("#boardList");
	        	  
	        	  for (let i=0;i<boardList.length;i++) {
		        	  const board = boardList[i];
		        	  const newBoardItem = boardItem.cloneNode(true);
		        	  
		        	  newBoardItem.querySelector("#boardid").innerText = board.boardid; 
		        	  newBoardItem.querySelector("#title").innerText = board.title; 
		        	  newBoardItem.querySelector("#writer_uid").innerText = board.writer_uid; 
		        	  newBoardItem.querySelector("#reg_date").innerText = board.reg_date; 
		        	  newBoardItem.querySelector("#view_count").innerText = board.view_count; 

		        	  newBoardItem.style.display = "";
		        	  boardListHTML.appendChild(newBoardItem);
	        	  }


	          }
	      });
	
	return false;
	
})



// 다이얼로그



</script>
