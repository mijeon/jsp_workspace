package gallery.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import gallery.domain.Gallery;
import gallery.repository.GalleryDAO;
import gallery.util.FileManager;

//이미지 파일을 포함한 글수정
public class EditServlet extends HttpServlet {
	GalleryDAO galleryDAO = new GalleryDAO();;
	ServletContext context; // jsp에선 application 내장객체임
	int maxSize = 1024 * 1024 * 5; // 파일 사이즈
	String savePath; // 저장될 경로

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		context = request.getServletContext();
		savePath = context.getRealPath("/data/");
		// String savePath = "C:/jsp_workspace/GallreyProject/src/main/webapp/data/";

		// 생성자 호출에 의해 이미 업로드 완료
		MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "utf-8"); // (request, 저장경로, 사이즈, 인코딩)

		// dto 생성
		String gallery_idx = multi.getParameter("gallery_idx");
		String filename = multi.getParameter("filename");
		String title = multi.getParameter("title");
		String writer = multi.getParameter("writer");
		String content = multi.getParameter("content");

		// 1)파일 삭제
		File file = new File(savePath + filename);
		if (file.delete()) {
			// 2) 이미 업로드된 이미지명을 rename 처리
			File currentFile = multi.getFile("file"); // html에서의 파일 이름
			long time = System.currentTimeMillis();
			String ext = FileManager.getExt(currentFile.getName()); // (업로드된 파일명)

			boolean flag = currentFile.renameTo(new File(savePath + time + "." + ext));
			if (flag) {
				// DB 수정
				// dto 채우기
				Gallery gallery = new Gallery(); // empty dto
				gallery.setGallery_idx(Integer.parseInt(gallery_idx));
				gallery.setTitle(title);
				gallery.setWriter(writer);
				gallery.setContent(content);
				gallery.setFilename(time+"."+ext); // 바뀐 이름 적용하기

				int result = galleryDAO.update(gallery);  //업데이트 수행

				// 이미 업로드된 파일의 이름 변경
				out.print("<script>");
				if (result>0) {
					out.print("alert('수정성공');");
					out.print("location.href='/gallery/content.jsp?gallery_idx="+ gallery_idx + "';");
				} else {
					out.print("alert('수정실패');");
					out.print("history.back();");
				}
				out.print("</script>");
			}
		}
	}
}