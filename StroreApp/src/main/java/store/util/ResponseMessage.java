package store.util;

//jsp가 아닌 서블릿으로 응답 데이터를 만드는게 귀찮음
public class ResponseMessage {
	public static String getMsgURL(String msg, String url) {
		StringBuilder sb=new StringBuilder();
		sb.append("<script>");
		sb.append("alert('"+msg+"');");
		sb.append("location.href='"+url+"';");
		sb.append("</script>");
		
		return sb.toString();
	}
	
	public static String getMsgBack(String msg) {
		StringBuilder sb=new StringBuilder();
		sb.append("<script>");
		sb.append("alert('"+msg+"');");
		sb.append("history.back();");
		sb.append("</script>");
		
		return sb.toString();
	}
}
