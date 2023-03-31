package gallery.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gallery.repository.GalleryDAO;

public class DeleteServlet extends HttpServlet {
	GalleryDAO galleryDAO; // 한번만 생성
	ServletContext context; // 어플리케이션의 전반적인 컨텍스트 (행위 달성을 위한 부가정보)

	public DeleteServlet() {
		galleryDAO = new GalleryDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 요청 파라미터 받기
		response.setContentType("text/html;charset=utf-8"); // body에 들어가는 한글
		PrintWriter out = response.getWriter();

		int gallery_idx = Integer.parseInt(request.getParameter("gallery_idx"));
		String filename = request.getParameter("filename");
		System.out.println("gallery_idx is " + gallery_idx);
		// delete gallery where gallery_idx=?

		// 로컬하드의 파일을 제어하기 위해서는 자바의 File 클래스 이용
		context = request.getServletContext(); // 루트를 기준으로 폴더의 풀경로를 조사해줌
		String app_path = context.getRealPath("/data");
		//System.out.println("현재 어플리케이션의 data 디렉토리의 실제 위치는 " + app_path);
		File file = new File(app_path + "/" + filename); // 파일명 복원
		System.out.println(app_path + "/" + filename);

		if (file.delete()) {  //파일이 삭제되었다면
			// DB 삭제 + 파일
			int result = galleryDAO.delete(gallery_idx);
			out.print("<script>");
			if (result > 0) {
				out.print("alert('삭제성공');");
				out.print("location.href='/gallery/list.jsp';");
			} else {
				out.print("alert('삭제실패')");
				out.print("history.back()");
			}
			out.print("</script>");

		}
	}
}
