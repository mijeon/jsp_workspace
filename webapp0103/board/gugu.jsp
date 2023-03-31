<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        function send(){
            //서버에 있는 gugu.jsp에게 입력한 단수를 파라미터로 전송하자
            //post, get
            let dan=document.getElementById("dan");
            location.href="/board/gugu2.jsp?dan="+dan.value;
        }
    </script>
</head>
<body>
    <%
    String param=request.getParameter("dan");
    out.print("넘어온 dan 변수값은"+param);
    
    //만약 최초에 페이지에 접속한 경우 param이 전송되지 않았으므로, null 상태이므로 
    //아래의 정수화 시키는 코드는 null이 아닐때만 수행하자
    int dan=0;
    if(param!=null){    
        dan=Integer.parseInt(param);
    }
    %>
    <input type="text" id="dan">
    <button onClick="send()">서버에 있는 jsp에게 단요청</button>
    <table width="500px" border="1px">
        <tr>
            <td>구구단 <%=dan%>단</td>
        </tr>
        <%for(int i=1; i<=9; i++){%>
        <tr>
            <td><%=dan+"*"+i+"="+(dan*i)%> </td>
        </tr>
        <%}%>
    </table>
</body>
</html>