<%@ page contentType="text/html;charset=UTF-8"%>
<%
    //색상 배열 선언
    String[] bgArray={"red", "orange", "yellow", "green", "blue", "navy", "purple"};

    //클라이언트의 파라미터 넘겨받기
    //웹상으로 전송된 모든 파라미터는 문자열임, 심지어 숫자형으로 넘겨도 문자열로 취급함
    String bg=request.getParameter("bg");
    out.print("넘어온 bg 값은"+bg);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        //서버에 bg.jsp 라는 jsp에 파라미터 전송
        //Get 방식으로 보내도 됨 보안상 중요하지 않고 양이 많지 않기 때문, 마치 편지봉투에 간단한 메세지를 적는 것과 같음
        //header 타고 전송한다고 표현함
        function setBg(){
            // '/'는 도메인을 의미 localhost:8888
            //선택한 select box의 값 접근
            let sel=document.querySelector("select");
            location.href="/bg.jsp?bg="+sel.value;
        }
    </script>
</head>
<body bgcolor="<%=bg%>">  <!--넘겨받은 파라미터 값-->
    <select name="" id="">
        <%for(int i=0;i<bgArray.length;i++){%>
        <option value="<%=bgArray[i]%>"><%=bgArray[i]%></option>
       <%}%>
    </select>
    <button onClick="setBg()">배경색변경</button>
</body>
</html>