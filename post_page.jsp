<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import = "java.util.ArrayList" %>

<%  
    request.setCharacterEncoding("utf-8"); 
    session = request.getSession();
    String idx = (String)session.getAttribute("idx");

    String postIdxValue = request.getParameter("idx");

    Class.forName("com.mysql.jdbc.Driver"); 
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); //db 주소 포트번호, 계정

    String firstSql = "SELECT post_category.name, post.title, post.date, account.nickname , post.content, account.idx FROM post,account,post_category WHERE post.idx = ? AND post.account_idx = account.idx AND post.post_category_idx = post_category.idx"; 
    PreparedStatement firstQuery = conn.prepareStatement(firstSql); 
    firstQuery.setString(1, postIdxValue);
    
    ResultSet firstResult = firstQuery.executeQuery(); 

    ArrayList<String> postData = new ArrayList<String>();
    
    while(firstResult.next()){
        String category = firstResult.getString(1);
        String title = firstResult.getString(2);
        String date = firstResult.getString(3);
        String writer = firstResult.getString(4);
        String content = firstResult.getString(5);
        content = content.replace("\r\n", "<br>");
        String writerIdx = firstResult.getString(6);
        postData.add("\"" + category + "\"");
        postData.add("\"" + title + "\"");
        postData.add("\"" + date + "\"");
        postData.add("\"" + writer + "\"");
        postData.add("\"" + content + "\"");
        postData.add("\"" + writerIdx + "\"");
    }

    String secondSql = "SELECT comment.content, comment.date, account.nickname, comment.account_idx, comment.idx FROM comment,account WHERE comment.post_idx = ? AND comment.account_idx = account.idx ORDER BY comment.idx"; 
    PreparedStatement secondQuery = conn.prepareStatement(secondSql); 
    secondQuery.setString(1, postIdxValue);
    
    ResultSet secondResult = secondQuery.executeQuery(); 

    ArrayList<ArrayList<String>> commentData = new ArrayList<ArrayList<String>>();
    ArrayList<String> commentIdxArray = new ArrayList<String>();
    
    while(secondResult.next()){
        String content = secondResult.getString(1);
        content = content.replace("\r\n","<br>");
        String date = secondResult.getString(2);
        String writer = secondResult.getString(3);
        String writerIdx = secondResult.getString(4);
        String commentIdx = secondResult.getString(5);

        commentIdxArray.add(commentIdx);

        ArrayList<String> elem = new ArrayList<String>();
        elem.add("\"" + content + "\"");
        elem.add("\"" + date + "\"");
        elem.add("\"" + writer + "\"");
        elem.add("\"" + writerIdx + "\"");
        elem.add("\"" + commentIdx + "\"");
        commentData.add(elem);
    }
    
    
    ArrayList<ArrayList<String>> replyData = new ArrayList<ArrayList<String>>();

    
    for(int index = 0; index < commentIdxArray.size(); index++){        

        String thirdSql = "SELECT reply_comment.content, reply_comment.date, account.nickname, reply_comment.account_idx, reply_comment.idx  FROM account, reply_comment WHERE reply_comment.comment_idx = ? AND reply_comment.account_idx = account.idx ORDER BY reply_comment.idx";
        PreparedStatement thirdQuery = conn.prepareStatement(thirdSql); 
        thirdQuery.setString(1, commentIdxArray.get(index));

        ResultSet thirdResult = thirdQuery.executeQuery();

        while(thirdResult.next()){
            String content = thirdResult.getString(1);
            String date = thirdResult.getString(2);
            String writer = thirdResult.getString(3);
            String writerIdx = thirdResult.getString(4);
            String replyIdx = thirdResult.getString(5);

            ArrayList<String> elem = new ArrayList<String>();
            elem.add("\"" + index + "\"");
            elem.add("\"" + content + "\"");
            elem.add("\"" + date + "\"");
            elem.add("\"" + writer + "\"");
            elem.add("\"" + writerIdx + "\"");
            elem.add("\"" + replyIdx + "\"");
            replyData.add(elem);
        }

    }

%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" type="text/css" href="index.css">
    <link rel = "stylesheet" type="text/css" href="post_page.css">
    <title>Document</title>
</head>
<body>
    <header>
        <section>
            <a id = "login" href = "login_page.jsp">로그인</a>
            <a id = "signup" href = "signup_page.jsp">회원가입</a>
            <a id = "myinfo" href = "myinfo_page.jsp">내 정보</a>
            <a id = "logout" href = "logout_action.jsp">로그아웃</a>
        </section>
        <h1>
            <a href = "index.jsp">게시판 이름</a>
        </h1>
        <nav id = "menu">
            <a href = "index.jsp?category_idx=1">잡담</a>
            <a href = "index.jsp?category_idx=2">운동</a>
            <a href = "index.jsp?category_idx=3">게임</a>
            <a href = "index.jsp?category_idx=4">취미</a>
            <a href = "index.jsp?category_idx=5">웃음</a>
        </nav>
    </header>
    <main>
        <div id = "header_box">
            <div id = "category_box" name = "category_box"></div> 
            <div id = "title_box" name = "title_box"></div>
        </div>
        <div class = "post_etc_box">
            <div id = "detail_box"></div>
            <div>
                <a href = "" id = "update_a" onclick = "return updatePostEvent()">게시물 수정</a>
                <a href = "" id = "delete_a" onclick = "return deletePostEvent()">게시물 삭제</a>
            </div>
        </div>
        <div id = "content_box" name = "content_value"></div>   
              
        <div id = "comment_box"></div>
        <form action = "comment_write_action.jsp" class = "new_comment_box" onsubmit = "return checkCommentEvent()">
            <textarea class = "new_comment_area" name = "comment_content_value" placeholder = "댓글을 작성하세요(500자이내)"></textarea>
            <input type = "submit" value ="등록">
            <input class = "only_data" value = <%=postIdxValue%> name = "post_value">
        </form>
    </main>
    <script>
        function accountLogin(account){
            if(account){
                document.getElementById("login").style.display = "none";
                document.getElementById("signup").style.display = "none";
                document.getElementById("myinfo").style.display = "block";
                document.getElementById("logout").style.display = "block";
            }
            else{
                document.getElementById("login").style.display = "block";
                document.getElementById("signup").style.display = "block";
                document.getElementById("myinfo").style.display = "none";
                document.getElementById("logout").style.display = "none";
            }
        }


        function insertInfo(){
            var data = <%=postData%>
            document.getElementById("category_box").innerHTML = data[0]
            document.getElementById("title_box").innerHTML = data[1]
            document.getElementById("detail_box").innerHTML = "작성자 : " + data[3] + " 작성일자 : " + data[2]
            document.getElementById("content_box").innerHTML = data[4]
        }


        function checkPost(){
            var accountIdx = <%=idx%> 
            var data = <%=postData%>
            var writerIdx = data[5]
            if(accountIdx == writerIdx){
                document.getElementById("update_a").style.display = "inline"
                document.getElementById("delete_a").style.display = "inline"
            }
            else{
                document.getElementById("update_a").style.display = "none"
                document.getElementById("delete_a").style.display = "none"
            }
        }


        function updatePostEvent(){
            document.getElementById("update_a").href = "post_revice_page.jsp?"+"idx="+ <%=postIdxValue%>
        }


        function deletePostEvent(){
            var deleteflag = confirm("정말로 삭제하시겠습니까?")
            if(deleteflag){
                document.getElementById("delete_a").href = "post_delete_action.jsp?"+"idx="+ <%=postIdxValue%>
            }
            else{
                return false
            }
        }

        function createComment(){
            var commentData = <%=commentData%>
            var account = <%=idx%>
            var parent = document.getElementById("comment_box")
            for(var index =0; index < commentData.length; index++){
                var list = commentData[index]
                var newDiv = document.createElement("div")
                var newInfoDiv = document.createElement("div")
                var newEtcDiv = document.createElement("div")
                var newNicknameDiv = document.createElement("div")
                var newDateDiv = document.createElement("div")
                var newOptionDiv = document.createElement("div")
                var replyButton = document.createElement("button")
                var updateButton = document.createElement("button")
                var deleteButton = document.createElement("button")
                var newContent = document.createElement("div")
                newInfoDiv.className = "comment_info_box"
                newEtcDiv.className = "comment_etc_box"
                newNicknameDiv.className = "nickname_box"
                newNicknameDiv.innerHTML = list[2]
                newDateDiv.className = "date_box"
                newDateDiv.innerHTML = list[1]
                newOptionDiv.className = "comment_option"
                replyButton.innerHTML = "대댓글 달기"
                replyButton.id = "replyButton" + index
                updateButton.innerHTML = "댓글 수정"
                updateButton.id = "updateButton" + index
                deleteButton.innerHTML = "댓글 삭제"
                deleteButton.id = "deleteButton" + index
                newContent.innerHTML = list[0]
                newContent.value = list[0]
                newContent.id = "newContent" + index
                parent.appendChild(newDiv)
                parent.appendChild(newContent)
                newDiv.appendChild(newInfoDiv)
                newInfoDiv.appendChild(newEtcDiv)
                newInfoDiv.appendChild(newOptionDiv)
                newEtcDiv.appendChild(newNicknameDiv)
                newEtcDiv.appendChild(newDateDiv)
                newOptionDiv.appendChild(replyButton)
                newOptionDiv.appendChild(updateButton)
                newOptionDiv.appendChild(deleteButton)

                var newForm = document.createElement("form")
                var commentIdxInput = document.createElement("input")
                var postIdxInput = document.createElement("input")
                commentIdxInput.value = list[4]
                commentIdxInput.id = "commnetIdxInput" + index
                commentIdxInput.name = "comment_idx"
                commentIdxInput.style.display = "none"
                postIdxInput.value = <%=postIdxValue%>
                postIdxInput.name = "post_idx"
                postIdxInput.style.display = "none"
                newForm.appendChild(commentIdxInput)
                newForm.appendChild(postIdxInput)
                newForm.className = "new_comment_box"
                newForm.id = "newForm" + index
                var newTextArea = document.createElement("textarea")
                newTextArea.id = "newTextArea" + index
                newTextArea.name = "update_comment_value"
                newTextArea.className = "new_comment_area"
                var newSubmitButton = document.createElement("input")
                newSubmitButton.type = "submit"
                newSubmitButton.value = "등록"
                newContent.appendChild(newForm)
                newForm.appendChild(newTextArea)
                newForm.appendChild(newSubmitButton)
                newForm.style.display = "none"

                createEventButton(index)

                if(account == list[3]){
                    updateButton.style.display = "block"
                    deleteButton.style.display = "block"
                }
                else{
                    updateButton.style.display = "none"
                    deleteButton.style.display = "none"
                }
            }
            
        }

        function createEventButton(index){
            document.getElementById("deleteButton" + index).addEventListener('click', (e) => {
                    var flag = confirm("삭제하시겠습니까?")
                    var number = e.target.id.replace(/\D/g,"")
                    console.log(number)
                    if(flag){
                        location.href = "comment_delete_action.jsp?" + "comment_idx="+ document.getElementById("commnetIdxInput" + number).value +"&post_idx=" + <%=postIdxValue%>
                    }
                    else{
                        return false
                    }
                })
                document.getElementById("updateButton" + index).addEventListener('click', (e) =>{
                    var number =  e.target.id.replace(/\D/g,"")
                    var updateButton = document.getElementById("updateButton"+ number)
                    if(document.getElementById("replyButton" + number).innerHTML == "닫기"){
                        alert("대댓글 작성후 댓글을 수정해주세요")
                        e.preventDefault()
                    }
                    else{
                         if(updateButton.innerHTML == "댓글 수정"){
                            updateButton.innerHTML = "닫기"
                            document.getElementById("newForm" + number).style.display = "flex"
                            document.getElementById("newForm" + number).action = "comment_revice_action.jsp"
                            document.getElementById("newTextArea" + number).value = document.getElementById("newContent" + number).value.replaceAll("<br>","\r\n")
                        }
                        else {
                            updateButton.innerHTML = "댓글 수정"
                            document.getElementById("newForm" + number).style.display = "none"
                        }

                    }
                    
                })
                
                document.getElementById("newForm" + index).addEventListener('submit', (e) => {
                    var number =  e.target.id.replace(/\D/g,"")
                    var account = <%=idx%>
                    var comment = document.getElementById("newTextArea" + number).value
                    if(!checkComment(comment)){
                        e.preventDefault()
                    }
                })
                document.getElementById("replyButton" + index).addEventListener('click', (e) => {
                    var number = e.target.id.replace(/\D/g,"")
                    var replyButton = document.getElementById("replyButton" + number)
                    if(document.getElementById("updateButton" + number).innerHTML == "닫기"){
                        alert("댓글 수정 후 대댓글을 작성해주세요")
                        e.preventDefault()
                    }
                    else{
                        if(replyButton.innerHTML == "대댓글 달기"){
                            replyButton.innerHTML = "닫기"
                            document.getElementById("newForm" + number).style.display = "flex"
                            document.getElementById("newForm" + number).action = "reply_comment_write_action.jsp"
                            document.getElementById("newTextArea" + number).value = ""
                        }
                        else{
                            replyButton.innerHTML = "대댓글 달기"
                            document.getElementById("newForm" + number).style.display = "none"
                        }
                    }
                    
                })
        }
        
        function checkCommentEvent(){
            var account = <%=idx%>
            console.log("왜 안돼")
            var comment = document.getElementsByName("comment_content_value")[0].value
            if(!comment){
                alert("댓글 내용을 입력하세요")
                return false
            }
            else if(comment.length > 500){
                alert("500자 이내로 작성하세요")
                return false
            }
            if(!account){
                alert("로그인 후 이용 가능합니다.")
                return false
            }
            return true
        }
        function checkComment(comment){
            var account = <%=idx%>
            console.log("왜 돼")
            if(!comment){
                alert("댓글 내용을 입력하세요")
                return false
            }
            else if(comment.length > 500){
                alert("500자 이내로 작성하세요")
                return false
            }
            if(!account){
                alert("로그인 후 이용 가능합니다.")
                return false
            }
            return true
        }

        function createReplyComment(){
            var replyData = <%=replyData%>
            var account = <%=idx%>
            for(var index =0; index < replyData.length; index++){
                var list = replyData[index]
                var parent = document.getElementById("newContent" + list[0])
                var newDiv = document.createElement("div")
                var newInfoDiv = document.createElement("div")
                var newEtcDiv = document.createElement("div")
                var newNicknameDiv = document.createElement("div")
                var newDateDiv = document.createElement("div")
                var newOptionDiv = document.createElement("div")
                var updateButton = document.createElement("button")
                var deleteButton = document.createElement("button")
                var newContent = document.createElement("div")
                newInfoDiv.className = "comment_info_box"
                newEtcDiv.className = "comment_etc_box"
                newNicknameDiv.className = "nickname_box"
                newNicknameDiv.innerHTML = list[3]
                newDateDiv.className = "date_box"
                newDateDiv.innerHTML = list[2]
                newOptionDiv.className = "comment_option"
                updateButton.innerHTML = "댓글 수정"
                updateButton.id = "replyUpdateButton" + index
                deleteButton.innerHTML = "댓글 삭제"
                deleteButton.id = "replyDeleteButton" + index
                newContent.innerHTML = "ㄴ " + list[1]
                newContent.value = list[1]
                newContent.id = "replyNewContent" + index
                parent.appendChild(newDiv)
                parent.appendChild(newContent)
                newDiv.appendChild(newInfoDiv)
                newInfoDiv.appendChild(newEtcDiv)
                newInfoDiv.appendChild(newOptionDiv)
                newEtcDiv.appendChild(newNicknameDiv)
                newEtcDiv.appendChild(newDateDiv)
                newOptionDiv.appendChild(updateButton)
                newOptionDiv.appendChild(deleteButton)

                var newForm = document.createElement("form")
                var replyCommentIdx = document.createElement("input")
                var postIdxInput = document.createElement("input")
                replyCommentIdx.value = list[5]
                replyCommentIdx.id = "replyCommentIdx" + index
                replyCommentIdx.name = "reply_comment_idx"
                replyCommentIdx.style.display = "none"
                postIdxInput.value = <%=postIdxValue%>
                postIdxInput.name = "post_idx"
                postIdxInput.style.display = "none"
                newForm.appendChild(replyCommentIdx)
                newForm.appendChild(postIdxInput)
                newForm.className = "new_comment_box"
                newForm.id = "replyNewForm" + index
                var newTextArea = document.createElement("textarea")
                newTextArea.id = "replyNewTextArea" + index
                newTextArea.name = "update_comment_value"
                newTextArea.className = "new_comment_area"
                var newSubmitButton = document.createElement("input")
                newSubmitButton.type = "submit"
                newSubmitButton.value = "등록"
                newContent.appendChild(newForm)
                newForm.appendChild(newTextArea)
                newForm.appendChild(newSubmitButton)
                newForm.style.display = "none"

                 document.getElementById("replyDeleteButton" + index).addEventListener('click', (e) => {
                    var flag = confirm("삭제하시겠습니까?")
                    var number = e.target.id.replace(/\D/g,"")
                    console.log(number)
                    if(flag){
                        location.href = "reply_comment_delete_action.jsp?" + "reply_comment_idx="+ document.getElementById("replyCommentIdx" + number).value +"&post_idx=" + <%=postIdxValue%>
                    }
                    else{
                        return false
                    }
                })
                document.getElementById("replyUpdateButton" + index).addEventListener('click', (e) =>{
                    var number =  e.target.id.replace(/\D/g,"")
                    var updateButton = document.getElementById("replyUpdateButton"+ number)                  
                    if(updateButton.innerHTML == "댓글 수정"){
                        updateButton.innerHTML = "닫기"
                        document.getElementById("replyNewForm" + number).style.display = "flex"
                        document.getElementById("replyNewForm" + number).action = "reply_comment_revice_action.jsp"
                        document.getElementById("replyNewTextArea" + number).value = document.getElementById("replyNewContent" + number).value.replaceAll("<br>","\r\n")
                    }
                    else {
                        updateButton.innerHTML = "댓글 수정"
                        document.getElementById("replyNewForm" + number).style.display = "none"
                    }                   
                    
                })
                
                document.getElementById("replyNewForm" + index).addEventListener('submit', (e) => {
                    var number =  e.target.id.replace(/\D/g,"")
                    var account = <%=idx%>
                    var comment = document.getElementById("replyNewTextArea" + number).value
                    if(!checkComment(comment)){
                        e.preventDefault()
                    }
                })
                if(account == list[4]){
                    updateButton.style.display = "block"
                    deleteButton.style.display = "block"
                }
                else{
                    updateButton.style.display = "none"
                    deleteButton.style.display = "none"
                }
            }
            
        }
        
        
       
        checkPost()
        createComment()
        createReplyComment()
        accountLogin(<%=idx%>)
        insertInfo()
    </script>
    
</body>