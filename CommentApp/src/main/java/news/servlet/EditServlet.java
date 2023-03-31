package news.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import news.domain.News;
import news.repository.NewsDAO;
import news.util.ResponseMessage;

public class EditServlet extends HttpServlet{
	NewsDAO newsDAO=new NewsDAO();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out=response.getWriter();
		
		//파라미터 받기
		News news=new News();  //empty dto
		String news_idx=request.getParameter("news_idx");
		String title=request.getParameter("title");
		String writer=request.getParameter("writer");
		String content=request.getParameter("content");
		
		//dto에 넣기
		news.setNews_idx(Integer.parseInt(news_idx));
		news.setTitle(title);
		news.setWriter(writer);
		news.setContent(content);
		
		int result=newsDAO.update(news);
		if(result>0) {
			out.print(ResponseMessage.getMsgURL("수정성공", "/news/content.jsp?news_idx="+news_idx));
		}else {
			out.print(ResponseMessage.getMsgBack("등록실패"));
		}
	}
}
