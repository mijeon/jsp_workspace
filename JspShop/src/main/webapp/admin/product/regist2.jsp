<%@page import="com.jspshop.exception.PimgException"%>
<%@page import="com.jspshop.exception.ColorException"%>
<%@page import="com.jspshop.exception.PsizeException"%>
<%@page import="com.jspshop.repository.PimgDAO"%>
<%@page import="com.jspshop.repository.PsizeDAO"%>
<%@page import="com.jspshop.repository.ColorDAO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.jspshop.util.MessageObj"%>
<%@page import="com.jspshop.exception.ProductException"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.jspshop.mybatis.MybatisConfig"%>
<%@page import="com.jspshop.repository.ProductDAO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.jspshop.util.FileManager"%>
<%@page import="com.jspshop.domain.Color"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jspshop.domain.Pimg"%>
<%@page import="com.jspshop.domain.Psize"%>
<%@page import="com.jspshop.domain.Category"%>
<%@page import="com.jspshop.domain.Product"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page contentType="application/json;charset=UTF-8"%>
<%!
	ProductDAO productDAO=new ProductDAO();
	PsizeDAO psizeDAO=new PsizeDAO();
	ColorDAO colorDAO=new ColorDAO();
	PimgDAO pimgDAO=new PimgDAO();
	
	MybatisConfig mybatisConfig=MybatisConfig.getInstance();
%>
<%
	//파일업로드 요청이 있으므로, 업로드 라이브러리를 활용해야 함
	int maxSize=5*(1024*1024);  //5MB
	String path="/data/";  //내장객체(application..)는 요청처리 영역에서 사용할 수 있으므로 맴버변수 영역에서 사용되지 못함
	
	//업로드와 관련된 설정정보를 가진 객체, 요청마다 대응
	DiskFileItemFactory factory=new DiskFileItemFactory(); 
	path=application.getRealPath(path);  //실제경로로 대체
	
	System.out.println(path);  //비동기 요청이 들어올 예정이므로 서버의 콘솔에 찍음
	factory.setSizeThreshold(maxSize);  //용량제한
	factory.setRepository(new File(path));  //임시디렉토리 및 파일저장위치
	
	//실제 업로드 처리담당
	ServletFileUpload upload=new ServletFileUpload(factory);
	
	//클라이언트의 요청 분석 후 결과반환
	List<FileItem> itemList=upload.parseRequest(request);
	
	//클라이언트의 파라미터의 종류와 이름에 따라 적절한 DTO에 담자
	Product product=new Product();  //empty dto
	List<Psize> psizeList=new ArrayList<Psize>();
	List<Color> colorList=new ArrayList<Color>();
	List<Pimg> pimgList=new ArrayList<Pimg>();
	
	//Product 안에 리스트 넣어두기
	product.setPsizeList(psizeList);
	product.setColorList(colorList);
	product.setPimgList(pimgList);
			
	for(FileItem item : itemList){  //파라미터 수만큼 반복처리
		if(item.isFormField()){  //일반 텍스트 파라미터일 경우
			if(item.getFieldName().equals("category_idx")){  //html의 파라미터명이 카테고리인지
				//Product가 category_idx라는 int형으로 보유하지 않고 아래 부모를 DTO 형태로 보유하고 있기 때문에	
				Category category=new Category();
				//item.getString();  //"5"
				category.setCategory_idx(Integer.parseInt(item.getString()));
				product.setCategory(category);  //Product에 대입
				
			}else if(item.getFieldName().equals("product_name")){  //html의 파라미터명이 상품명인지
				product.setProduct_name(item.getString("utf-8"));
				
			}else if(item.getFieldName().equals("brand")){  //html의 파라미터명이 브랜드인지
				product.setBrand(item.getString("utf-8"));
			
			}else if(item.getFieldName().equals("price")){  //html의 파라미터명이 가격인지
				product.setPrice(Integer.parseInt(item.getString()));
			
			}else if(item.getFieldName().equals("discount")){  //html의 파라미터명이 할인가인지
				product.setDiscount(Integer.parseInt(item.getString()));
				
			}else if(item.getFieldName().equals("size[]")){  //html의 파라미터명이 사이즈인지
				System.out.println(item.getString("utf-8"));
				//넘어온 데이터가 배열인 경우 쉼표로 구분되어 날아옴, 따라서 쉼표를 구분으로 다시 분리시켜 배열로 만듬
				String[] psize=item.getString("utf-8").split(",");
				
				for(int i=0;i<psize.length;i++){
					Psize psizeObj=new Psize();  //empty DTO
					psizeObj.setProduct(product);  //어떤 상품에 소속된 사이즈인지
					psizeObj.setPsize_name(psize[i]);  //XL, L, M...
					
					psizeList.add(psizeObj);  //DTO를 저 위의 리스트에 추가
				}
				
			}else if(item.getFieldName().equals("color[]")){  //html의 파라미터명이 색상인지
				String[] color=item.getString("utf-8").split(",");
				for(int i=0;i<color.length;i++){  //배열만큼 DTO 생성
					Color colorObj=new Color();  //empty DTO
					colorObj.setProduct(product);  //어떤 상품에 소속된 색상인지
					colorObj.setColor_name(color[i]);  //화이트, 블랙...
					
					colorList.add(colorObj);  //DTO를 저 위의 리스트에 추가
				}
				
			}else if(item.getFieldName().equals("detail")){  //html의 파라미터명이 상세인지
				product.setDetail(item.getString("utf-8"));
			}
		}else{  //파일 업로드일 경우
			long time=System.currentTimeMillis();  //파일이름 예정
			String ext=FileManager.getExt(item.getName());  //확장자
			
			String filename=time+"."+ext;  //조합된 파일명, 재사용성을 위해 변수로 선언
			item.write(new File(path+filename));  //디스크에 내려쓰기
			//파일에 대한 정보를 DTO로 담아서 pimgList에 담기
			
			Pimg pimg=new Pimg();  //empty DTO
			pimg.setProduct(product);  //어떤 상품에 소속된 이미지인지
			pimg.setFilename(filename);
			
			pimgList.add(pimg);  //DTO를 저 위의 리스트에 추가
		}
	}
	//최종적으로 채워진 Product를 확인해보자
	//System.out.println(product);
	
	SqlSession sqlSession=mybatisConfig.getSqlSession();
	
	
	MessageObj messageObj=new MessageObj();
	
	//상품등록 트랜잭션은 총 4개의 DML로 이루어져있음 
	try{
		//얻어진 SqlSession을 해당 DAO에게 전달
		//세부업무 1) : Product 테이블에 넣기
		productDAO.setSqlSession(sqlSession);  //주입
		productDAO.insert(product);
		
		//세부업부 2) : Psize 테이블에 넣기
		psizeDAO.setSqlSession(sqlSession);  //주입
		for(Psize psize:product.getPsizeList()){  //유저가 선택한 사이즈 수만큼 반복문 수행
			psizeDAO.insert(psize);
		}
		
		//세부업무 3) : Color 테이블에 넣기
		colorDAO.setSqlSession(sqlSession);  //주입
		for(Color color:product.getColorList()){  //유저가 선택한 컬러 수만큼 반복문 수행
			colorDAO.insert(color);
		}
		
		//세부업무 4) : Pimg 테이블 넣기
		pimgDAO.setSqlSession(sqlSession);  //주입
		for(Pimg pimg:product.getPimgList()){  //유저가 선택한 이미지 수만큼 반복문 수행
			pimgDAO.insert(pimg);
		}
		
		sqlSession.commit();
		messageObj.setCode(1);
		messageObj.setMsg("상품등록 완료");
		
	}catch(ProductException e){
		sqlSession.rollback();
		messageObj.setCode(0);
		messageObj.setMsg(e.getMessage());
	}catch(PsizeException e){
		sqlSession.rollback();
		messageObj.setCode(0);
		messageObj.setMsg(e.getMessage());
	}catch(ColorException e){
		sqlSession.rollback();
		messageObj.setCode(0);
		messageObj.setMsg(e.getMessage());
	}catch(PimgException e){
		sqlSession.rollback();
		messageObj.setCode(0);
		messageObj.setMsg(e.getMessage());
	}finally{
		mybatisConfig.release(sqlSession);
	}
	
	//응답정보 보내기 (응답정보를 json으로 변환)
	Gson gson=new Gson();
	String json=gson.toJson(messageObj);
	out.print(json);
%>