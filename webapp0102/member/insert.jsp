<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
/*이  jsp는 java 기술로 작성된 페이지이자, 오직 서버에서만 실행되는 스크립트임
클라이언트의 html 문서로부터 전송되어온, 파라미터들을 넘겨받아 오라클에 넣어보자
특히, 오라클에 넣을 때 기존 javaSE 시절의 연동코드를 그대로 사용하면 됨*/

//클라이언트에서 전송된 파라미터 받기, 내장 객체중 요청정보를 가진 request 객체 사용

String id=request.getParameter("id");  //id를 넘겨받자, html상의 변수명 넣음
String pass=request.getParameter("pass");  //pass
String name=request.getParameter("name");  //name

out.print("넘어온 id는 "+id);
out.print("넘어온 pass는 " + pass);
out.print("넘어온 name은 "+name);

//넘겨받은 파라미터 (전송되어 온 변수)들을 오라클에 넣기

//코드를 분리시키지 않고, 그냥 진행
Class.forName("oracle.jdbc.driver.OracleDriver");
out.print("<br>");
out.print("드라이버 로드 성공 ");

String url="jdbc:oracle:thin:@localhost:1521:XE";
String user="javase";
String pwd="1234";

Connection con=DriverManager.getConnection(url, user, pwd);
if(con!=null){
    out.print("접속 성공 ");
}else{
    out.print("접속 실패 ");
}

String sql="insert into member2(member2_idx, id, pass, name)";
sql+=" values(seq_member2.nextval, ?, ?, ?)";

PreparedStatement pstmt=null;
pstmt=con.prepareStatement(sql);
pstmt.setString(1, id);  //넘겨받은 id
pstmt.setString(2, pass);  //넘겨받은 pass
pstmt.setString(3, name);  //넘겨받은 name

int result=pstmt.executeUpdate();
if(result>0){
    out.print("가입성공 ");
}
pstmt.close();
con.close();
%>