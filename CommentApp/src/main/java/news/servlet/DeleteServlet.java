package news.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import news.repository.CommentsDAO;
import news.repository.NewsDAO;
import news.util.ResponseMessage;

public class DeleteServlet extends HttpServlet{
	NewsDAO newsDAO=new NewsDAO();
	CommentsDAO commentsDAO=new CommentsDAO();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		
		//파라미터 받기
		String news_idx=request.getParameter("news_idx");
		int commentsSize=Integer.parseInt(request.getParameter("commentsSize"));
		
		if(commentsSize>0) {  //댓글이 존재할 경우
			int result=commentsDAO.delete(Integer.parseInt(news_idx));
			if(result==0) {//댓글 삭제 실패
				out.print(ResponseMessage.getMsgBack("삭제실패"));
				return;
			}
		}
		int result=newsDAO.delete(Integer.parseInt(news_idx));
		if(result>0) {
			out.print(ResponseMessage.getMsgURL("삭제성공", "/news/list.jsp"));
		}else {
			out.print(ResponseMessage.getMsgBack("삭제실패"));
		}
	}
}
