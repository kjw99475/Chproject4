<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>
<style>
    .main{
        width: 1100px;
        margin: 0 auto;
    }
    span{
        width: 100px;
        font-size: 18px;
        margin-right: 10px;
        line-height: 50px;
    }
    #btn_submit, #btn_cancel, #btn_delete{
        margin-top: 10px;
        padding: 5px 10px;
        margin-top: 10px;
        margin-right: 15px;

    }
    .title{
        font-size: 28px;
        text-align: center;
        width: 1100px;
    }
    .date{
        margin: 20px 0;
        font-size: 18px;
    }
    .content{
        margin: 20px 0;
        font-size: 18px;
    }
    ul{
        padding: 0px;
        height: 80px;
        border-top: 1px silver solid;
        border-bottom: 1px silver solid;
        margin: 0px;
    }
    .moveArticle{
        width: 1100px;
        height: 50px;
    }
    span{
        width: 100px;
        font-size: 18px;
        margin-right: 10px;
        line-height: 50px;
        text-align:center;
        padding: 10px 0px;
        height: 60px;
        display: table-cell;
    }
    .flag{
        width: 100px;
    }
    #title{
        width: 800px;
    }
    .regdate{
        width: 200px;
        text-align: center;
    }
    a{  
        height: 80px;
        text-decoration: none;
        color: black;
    }
    .comment{
        margin: 10px 0;
    }
    #frm_comment{
        border: 1px solid black;
        padding: 10px;
    }
    textarea{
        width: 1060px;
        height: 100px;
        font-size: 18px;
        resize: none;
    }
    #cmt_btn_submit{
        padding: 5px 10px;
    }
    .btn{
        display: flex;
        flex-direction: row-reverse;
        margin-top: 10px;
        margin-right: 15px;
    }
    #cmtUserId{
        display: inline;
    }
    img{
        vertical-align: middle
    }
    .commentView{
        border-top: 1px silver solid;
        border-bottom: 1px silver solid;
    }
    .btn{
    	margin-bottom: 10px;
    }
    .commentView{
    	display:none;
    	border: 1px solid black;
    	margin-bottom: 10px;
    }
    #filelist{
    	border-collapse: collapse;
    	width: 600px;
    	margin: 10px auto;
    }
    #frm_com_modify, #frm_com_delete{
    	display:inline-block;
    }
    .commentView{
    	padding: 10px;
    }
</style>
</head>
<body>
<div class="wrap">
<div class=header>
<%@ include file="../header/header.jsp" %>
</div>
<div class="main">
    <div class="article">
        <div class="title"><p>${title}</p></div>
        <div class="date">작성일 ${reg_date} 최종 수정일 ${modify_date}</div>
        <div class="content" id="content">${content}</div>
    <table id="filelist" border="1">
	<tr>
		<th> 첨부 파일 이름 </th>
		<th> 파일 다운로드 </th>
		<th> 파일 삭제 </th>
	</tr>
	<c:choose>
	<c:when test="${not empty fileLists }">
		<c:forEach var="list" items="${fileLists }" varStatus="loop">
		<tr>
			<td>${list.getSaveFile()}</td>
			<td><a href="./filedown.do?orgFile=${list.getOrgFile()}&saveFile=${list.getSaveFile()}&bbs_idx=${list.getBbs_idx()}">다운로드</a></td>
			<c:if test="${ user_id eq userId}">
			<td><a id="filedelete" href="./filedelete.do?orgFile=${list.getOrgFile()}&saveFile=${list.getSaveFile()}&bbs_idx=${list.getBbs_idx()}">삭제</a></td>
			</c:if>
			<c:if test="${ user_id != userId}">
			<td>삭제는 작성자만 가능합니다.</td>
			</c:if>
		</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
		<td colspan="3">등록된 게시물이 없습니다.</td>
		</tr>
	</c:otherwise>
	</c:choose>
	</table>
        <ul>
            <a href="bbsdetail.do?idx=${preidx < 1 ? idx : preidx}" class= "moveArticle" id="preArticle" >
            <span class="flag">↑</span>
            <span class="flag">${preidx  < 1 ? " " : "이전글"}</span>
            <span class="title" id="title">${preidx  < 1 ? "첫글 입니다." : title1}</span>
            <span class="regdate">${reg_date1}</span>
            </a>
        </ul>
        <ul>
            <a href="bbsdetail.do?idx=${nextidx > lastidx ? idx : nextidx}" class= "moveArticle" id="nextArticle" >
            <span class="flag">↓</span>
            <span class="flag">${nextidx > lastidx ? " " : "다음글"}</span>
            <span class="title" id="title">${nextidx > lastidx ? "다음글이 없습니다." : title2}</span>
            <span class="regdate">${reg_date2}</span>
            </a>
        </ul>

    </div>
    <div class="comment" id="commentbtn"><button>댓글${cmt_total}<b> ▼</b></button></div>
    <div class="commentView">
    
	<c:choose>
	<c:when test="${not empty cmtList }">
		<c:forEach var="list" items="${cmtList}" varStatus="loop">
		<div class="commentlist">
            <img src="/Project4/img/cmtperson.png">
            <span id="cmtUserId">${list.member_user_id}</span>
        <c:if test="${ list.member_user_id eq userId}">
        <form id="frm_com_delete" name="frm_com_delete" action="cmtdelete.do">
        <input type=hidden id="cmtidx" name="cmtidx" value="${list.comt_idx}">
        <input type=hidden id="idx" name="idx" value="${idx}">
        <input type="submit" name="cmt_btn_delete" id="cmt_btn_delete" value="삭제">
        </form>
        <form id="frm_com_modify" name="frm_com_modify" action="cmtmodify.do" method="post">
         <input type=hidden id="cmtidx" name="cmtidx" value="${list.comt_idx}">
         <input type=hidden id="idx" name="idx" value="${idx}">
        <input type="submit" name="cmt_btn_modify" id="cmt_btn_modify" value="수정">
        <textarea style="resize: none; width: 300px; height: 50px; position: absolute; margin-left: 5px;" 
        name=cmtmodifycontent id=cmtmodifycontent placeholder="수정할 내용을 입력하세요."></textarea>
        </form>
        </c:if>
   
        <p>${list.comt_content}</p>
        <p>${list.comt_reg_date}</p>
        </div>

		</c:forEach>
	</c:when>
	<c:otherwise>
		<span class="QNA" style="width: 1100px;"><img src="/Project4/img/Q.png" alt="Q">등록된 글이 없습니다.</span>
	</c:otherwise>
	</c:choose>  
        
   </div>
    <form name="frm_comment" id="frm_comment" action="cmtregist.do" method="post">
            <div class="f1">
            <div>
            <img src="/Project4/img/cmtperson.png">
            <span id="cmtUserId">${userId}</span>
            </div>
            <input type="hidden" name="user_id" id="user_id" value="${userId}" readonly>
            <input type="hidden" name="idx" id="idx" value="${idx}" readonly>
            </div>
            <textarea name="cmtContent" id="cmtContent"></textarea>
            <div class="btn">
            <c:if test="${userId != null}">
            <input type="submit" name="cmt_btn_submit" id="cmt_btn_submit" value="글등록">
        	</c:if>
        	<c:if test="${userId == null}">
            <input type="button" name="cmt_btn_login" id="cmt_btn_login" value="로그인">
            </c:if>
            </div>  
    </form>

        <div class="btn">
        <input type="button" name="btn_cancel" id="btn_cancel" value="목록">
        <c:if test="${ user_id eq userId}">
        <input type="button" name="btn_delete" id="btn_delete" value="삭제">
        <input type="submit" name="btn_submit" id="btn_submit" value="수정">
        </c:if>
        </div>
</div>


<div class=footer>
<%@ include file="../footer/footer.jsp" %>
</div>

</div>

<script>
	if(document.querySelector("#btn_submit")!=null){
    document.querySelector("#btn_submit").addEventListener("click",()=>{
        
        let c = document.getElementById("content");
        if(c.value == ""){
            alert("내용이 비어있습니다.");
            event.preventDefault();
        }
        window.location.href="./modifyConn.do?idx=${idx}";
    })
	}
	if(document.querySelector("#btn_submit")!=null){
    document.querySelector("#btn_delete").addEventListener("click",()=>{
        if(confirm("삭제하시겠습니까?")){
            window.location.href="./delete.do?idx=${idx}";
        }
    })
	}
    document.querySelector("#btn_cancel").addEventListener("click",()=>{
        if(confirm("이전페이지로 돌아가시겠습니까?")){
            window.location.href="./comu.do";
        }
    })
    if(document.querySelector("#btn_submit")!=null){
    document.querySelector("#filedelete").addEventListener("click",()=>{
        if(confirm("정말 삭제하시겠습니까?")){
        }
        else{
        	event.preventDefault();
        }
    })
    }
    let a = document.querySelector(".commentView");
	document.querySelector("#commentbtn").addEventListener("click",()=>{
	a.style.display=='block'? a.style.display='none': a.style.display='block';
	})
	if(document.querySelector("#cmt_btn_login")!=null){
    document.querySelector("#cmt_btn_login").addEventListener("click",()=>{
        if(confirm("글등록을 하시려면 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")){
            window.location.href="member/login.do";
        }
    })
	}
	if(document.querySelector("#cmt_btn_modify")!=null){
	    document.querySelector("#cmt_btn_modify").addEventListener("click",()=>{
	        if(confirm("수정 하시겠습니까?")){
	            window.location.href="./cmtmodify.do?idx=${idx}";
	        }
	        else{
	        	event.preventDefault();
	        }
	    })
		}
	if(document.querySelector("#cmt_btn_delete")!=null){
	    document.querySelector("#cmt_btn_delete").addEventListener("click",()=>{
	        if(confirm("삭제 하시겠습니까?")){
	            window.location.href="./cmtdelete.do?idx=${idx}";
	        }
	        else{
	        	event.preventDefault();
	        }
	    })
		}
    </script>
</body>
</html>
