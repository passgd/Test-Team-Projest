<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value='/resources/css/board/boardList.css' />">

           
           <h1 id="text">공지사항</h1>
           <div id="container">
           <!-- 게시판 목록 표시 -->
           
           <form name="pageForm" id="pageForm" action="<c:url value='/notice/list.do'/>" method="post" >
				<input type="hidden" name="pageNo" id="pageNo" value="${notice.pageNo}" />
				<input type="hidden" name="searchTitle" id="searchTitle" value="${notice.searchTitle}" >
				<input type="hidden" name="pageLength" id="pageLength" value="${result.notice.pageLength}" >
           </form>

			
 			<input type="hidden" name="pageNo" id="pageNo" value="${notice.pageNo}" />
 				<div style="margin:0px auto;">
					<div style="display: flex; margin:0px auto; width:70%; justify-align: center">
						<select name="pageLength" id="pageLength" >
							<option value="10" ${notice.pageLength == 10 ? 'selected="selected"' : ''} >10건</option>
							<option value="20" ${notice.pageLength == 20 ? 'selected="selected"' : ''} >20건</option>
							<option value="50" ${notice.pageLength == 50 ? 'selected="selected"' : ''} >50건</option>
							<option value="100" ${notice.pageLength == 100 ? 'selected="selected"' : ''} >100건</option>
						</select>

						<input type="text" name="searchTitle" id="searchTitle" value="${notice.searchTitle}" >
						<input type="submit" id="searchTitleBtn" value="검색"/>
           			</div>
				</div>
				
					
	           <table>
	           
	              <tr id="noticeItem" style="display:none;" >
                     <td><input type="checkbox" class="item" /></td>
                     <td id="noticeid"></td>
                     <td id="title"></td>
                     <td id="writer_uid"></td>
                     <td id="reg_date"></td>
                     <td id="view_count"></td>
                     <td id="fixed_yn"></td>
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
	                   <c:if test="${loginMember.id == 'admin'}">
		                   <th>고정여부</th>
	                   </c:if>
	               </tr>
	               
	               <tbody id="noticeList">
				   <c:forEach items="${list}" var="notice">
    				  <tr class="${notice.fixed_yn == 'Y' ? 'fixed-row' : ''}">
	                    <c:if test="${loginMember.id == 'admin'}">
	                     <td><input type="checkbox" name="item" class="item" onclick="checkSelectAll()" value="${notice.noticeid}"/></td>
	                    </c:if>
	                     <td>${notice.noticeid}</td>
	                     <%-- <td><a href="<c:url value='/notice/detail.do?noticeid=${notice.noticeid }'/>">${notice.title}</a></td> --%>
	                     <td><a href="#" onclick="dialogDetail(${notice.noticeid})">${notice.title}</a></td>
	                     <td>${notice.writer_uid}</td>
	                     <td>${notice.reg_date}</td>
	                     <td>${notice.view_count}</td>
	                     <c:if test="${loginMember.id=='admin'}">
	                     	<td>${notice.fixed_yn}</td>
	                     </c:if>
	                  </tr>
	                </c:forEach>
	                
 	            	<c:if test="${empty list}">
	                	<tr>
	                		<td colspan=7>검색결과가 없습니다</td>
	                 	</tr>
	                </c:if> 
	              </tbody>
	           	</table>
	           	
	           	<%-- <div style="text-align: center;margin-top:20px;">
		           	<c:if test="${result.notice.navStart != 1}">
		           		<a href="javascript:jsPageNo(${result.notice.navStart-1})" style="padding: 10px;"> &lt; </a> 
		           	</c:if>
		           	<c:forEach var="item" begin="${result.notice.navStart}" end="${result.notice.navEnd}">
		           		<c:choose>
		           			<c:when test="${result.notice.pageNo != item }">
		           				<a href="javascript:jsPageNo(${item})" style="padding: 10px;">${item}</a>  
		           			</c:when>
		           			<c:otherwise>
		           				<strong style="font-size:1.2rem">${item}</strong>   
		           			</c:otherwise>
		           		</c:choose>
		           	</c:forEach>
		           	<c:if test="${result.notice.navEnd != result.notice.totalPageSize}">
		           		<a href="javascript:jsPageNo(${result.notice.navEnd+1})" style="padding: 10px;"> &gt; </a> 
		           	</c:if>
	           	
	           	</div>    	 --%>
	           	
				<c:if test="${loginMember.id =='admin'}">
		            <div class="buttons"> 
				       <button class="button"><a href="#" id ="dialogWrite">글 작성</a></button>
			           <button class="button" type="submit" id="deleteBtn">글 삭제</button>
		            </div>
	            </c:if>

            </div>
            



<!---------------------------------------- 대화상자 Dialog ------------------------------------------->
                        
<div id="insert" title="글 작성">
	<div class="write">
		<input type="hidden" id="writer_uid1" name="writer_uid" value="${loginMember.id}"  readonly>
		<input type="text" id="title1" name="title2" placeholder="제목" class="text_title2"><br>
		<textarea name="contents2" id="contents1" placeholder="내용" ></textarea>
		<label><input type="radio" class="fixed_yn" id="fixed_yn1" name="fixed_yn" value="Y" >Y</label>
        <label><input type="radio" class="fixed_yn" id="fixed_yn1" name="fixed_yn" value="N" checked>N</label>
	</div>
</div>


<div id="detail" title="글 상세보기" >
	<div class="detail">
	  	<input type="hidden" name="noticeid" id="noticeid2" value="${notice.noticeid}"/> 
      	<h3 id="title2">[  ] </h3>
      	<hr>
	      <br>
	      <div class="meta-info" id="info2"">
	  		작성자 :  <span id="writer_uid2">${notice.writer_uid}</span>  |　 작성날짜 :  <span id="reg_date2">${notice.reg_date}</span>　 |　 조회수 :  <span id="view_count2">${notice.view_count}</span>
		  </div>
	      <div class="contents" id="contents2">
	    	${notice.contentsHTML}
		  </div>
	</div>
</div> 


<div id="update" title="글 수정">
	<input type="hidden" name="noticeid" id="noticeid3" value="${notice.noticeid}"><br>
	<input type="text" name="title" id="title3" placeholder="제목" class="text_title" value="${notice.title}"><br>
    <textarea name="contents" id="contents3" placeholder="내용" class="notice_ct">${notice.contents}</textarea>
    <!-- ${loginMember.id}-->
    <p><input type="hidden" id="writer_uid3" name="writer_uid" value="${loginMember.id}"  readonly></p>
    <span class="radio-group">
    	상단고정 여부　      
        <label><input type="radio" name="fixed_yn3" class="fixed_yn" id="fixed_yn3" value="Y" checked>Y</label>
        <label><input type="radio" name="fixed_yn3" class="fixed_yn" id="fixed_yn3" value="N">N</label>
    </span>
</div> 


      
<%-- <script src="<c:url value='/js/check.js'/>"></script> --%>
<script>

/* --------------------------- 버튼 클릭 --------------------------- */

$("#dialogWrite").on("click", () => {
	$("#insert").dialog("open");
});


$("#dialogUpdate").on("click", () => {
	$("#update").dialog("open");
});


/* --------------------------- 다이얼로그 창 띄우기 --------------------------- */
/* 공지사항 등록 */

$(document).ready(function() {
    $("#insert").dialog({
        autoOpen: false,
        modal: true,
        width: 800,
        height: 500,
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



/* 공지사항 상세 */
$(document).ready(function() {
	$("#detail").dialog({
	    autoOpen: false,
	    modal: true,
	    width: 800,
	    height: 500,
	    buttons: {
	        "수정": function() {
	        	
	        	const title = $("#title2").text();
	        	const contents = $("#contents2").text();
	        	
	        	$("#title3").val(title);
	        	$("#contents3").val(contents);
	        	console.log(title);
	        	console.log(contents);
	        	
	            $("#update").dialog("open");
	            
	        },
	        "삭제": function() {
		        	
	        		const noticeid2 = $("#noticeid2").text();
		        	
		        	console.log('noticeid2 : ' + noticeid2);
		        	console.log('noticeid : ' + noticeid);
		        	
		        	const param = {
		        	        noticeid: noticeid2
		        	      };
	
		        	      fetch("<c:url value='/notice/delete.do'/>", {
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
		        				location.href="<c:url value='/notice/list.do' />";
		        	    	} else {
		        				alert("삭제되지 않았습니다.");
		        	    	}
		        	    	
		        	      });
		        	
		        	return false;
	        },
	        Close: function() {
	            $(this).dialog("close");
	        }
	    }
	});

	
});


/* 공지사항 수정 */
$(document).ready(function() {
	$("#update").dialog({
	    autoOpen: false,
	    modal: true,
	    width: 800,
	    height: 500,
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


/* --------------------------- 공지사항 패치 코드 --------------------------- */
/* 글 작성 패치 코드 */
function dialogInsert() {
	
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
	
	const param = {
	        writer_uid: writer_uid1.value,
	        title: title1.value,
	        contents: contents1.value,
	        fixed_yn : document.querySelector("#fixed_yn1:checked").value
	      };
	
	      fetch("<c:url value='/notice/insert.do'/>", {
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
	        	  location.href = "<c:url value='/notice/list.do'/>"; 
	          } else {
	        	  alert(json.message);
	          }
	      });
	
	return false;
	
}



/* 글 상세 패치 코드 */
function dialogDetail(noticeid) {
	
 	const noticeid2 = document.querySelector("#noticeid2");
	const title2 = document.querySelector("#title2");
	const contents2 = document.querySelector("#contents2");
	const writer_uid2 = document.querySelector("#writer_uid2");
	const reg_date2 = document.querySelector("#reg_date2");
	const view_count2 = document.querySelector("#view_count2");

	
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
	    	   noticeid2.innerText = json.noticeid;  
	    	   title2.innerText = json.title;  
	    	   contents2.innerText = json.contents;  
	    	   writer_uid2.innerText = json.writer_uid;  
	    	   reg_date2.innerText = json.reg_date;  
	    	   view_count2.innerText = json.view_count;  
	       	   $("#detail").dialog("open");
	      });
	
	return false;
	
}



/* 글 수정 패치 코드 */
function dialogUpdate(noticeid) {
	
    const noticeid2 = $("#noticeid2").text();
    const title3 = $("#title3").val();
    const contents3 = $("#contents3").val();
    const writer_uid2 = $("#writer_uid2").text(); // 수정: # 추가
    const fixed_yn3 = $("input[name='fixed_yn3']:checked").val(); // 수정: # 추가
    
    const param = {
        noticeid: noticeid2,
        title: title3,
        contents: contents3,
        writer_uid: writer_uid2,
        fixed_yn: fixed_yn3
    };
    
    
    fetch("<c:url value='/notice/update.do'/>", {
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
            $("#fixed_yn3").prop(fixed_yn3);
            // editDialog 열고 닫는 코드 (확인 필요)
            // editDialog.dialog("close");
            location.href = "<c:url value='/notice/list.do'/>"; 
        }
    });
    
    // editDialog 닫는 코드 (확인 필요)
    // editDialog.dialog("close");
}




/* function jsPageNo(pageNo) {
	document.querySelector("#pageForm > #pageNo").value = pageNo;
	document.querySelector("#pageForm").submit(); 
}




document.querySelector("#mForm").addEventListener("submit", e => {
	document.querySelector("#mForm > #pageNo").value = "1";
	
	return true;
}); */


/* function dialogDelete() {
	
	const noticeid2 = $("#noticeid2").text();
	
	console.log('noticeid2 : ' + noticeid2);
	console.log('noticeid : ' + noticeid);
	
	const param = {
	        noticeid: noticeid2
	      };

	      fetch("<c:url value='/notice/delete.do'/>", {
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
				location.href="<c:url value='/notice/list.do' />";
	    	} else {
				alert("삭제되지 않았습니다.");
	    	}
	    	
	      });
	
	return false;
} */


/* document.querySelector("#deleteBtn").addEventListener("click", e => {
	e.preventDefault();
	const noticeList = document.querySelector("#noticeList");
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
        noticeid: document.querySelector("#noticeList tr:last-child td:first-child input[type='checkbox']").value,
	};

    fetch("<c:url value='/notice/deletes.do'/>", {
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
				noticeList.removeChild(items[i].parentNode.parentNode);
			}
      	    
      	    //2. 서버에서 삭제 건수 만큼 얻는 공지사항 목록을 출력한다
	      	  const noticeListJson = json.noticeList;
	      	  const noticeItem = document.querySelector("#noticeItem");
	      	  
	      	  for (let i=0;i<noticeListJson.length;i++) {
		        	  const notice = noticeListJson[i];
		        	  const newNoticeItem = noticeItem.cloneNode(true);
					  const title = newNoticeItem.querySelector("#title");

					  newNoticeItem.querySelector("#noticeid").innerText = notice.noticeid; 
		        	  title.innerText = notice.title;
		        	  newNoticeItem.querySelector("#writer_uid").innerText = notice.writer_uid; 
		        	  newNoticeItem.querySelector("#reg_date").innerText = notice.reg_date; 
		        	  newNoticeItem.querySelector("#view_count").innerText = notice.view_count; 
		        	  newNoticeItem.querySelector("#fixed_yn").innerText = notice.fixed_yn; 
	
		        	  //이벤트 핸들링 
		        	  newNoticeItem.querySelector(".item").value = notice.noticeid;
		        	  newNoticeItem.querySelector(".item").addEventListener("click", e => checkSelectAll());
		        	  newNoticeItem.addEventListener("click", e => jsDetailView(notice.noticeid));
		        	  
		        	  newNoticeItem.style.display = "";
		        	  noticeList.appendChild(newNoticeItem);
	      	  }
      	    
        } else {
        	alert(json.message);
        }
        
    });
	
	return false;
	
}); */


</script>
