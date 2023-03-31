<%@page import="com.jspshop.domain.Admin"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
String[] sizeList = {"XS", "S", "M", "L", "XL", "XXL"};
String[] colorList = {"베이지", "네이비", "블랙", "화이트"};
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | 상품등록</title>
<%@ include file="/admin/inc/header_link.jsp"%>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">

		<!-- Preloader -->
		<%@ include file="/admin/inc/preloader.jsp"%>
		<!-- Navbar -->
		<%@include file="/admin/inc/navbar.jsp"%>
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<%@include file="/admin/inc/sidebar_left.jsp"%>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">상품등록</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">Dashboard v1</li>
							</ol>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="col">
						<form id="form1">
							<div class="form-group">
								<select id="category" class="form-control" placeholder="카테고리">
								</select>
							</div>
							<div class="form-group">
								<input type="email" class="form-control" id="product_name" placeholder="상품명">
							</div>
							<div class="form-group">
								<input type="email" class="form-control" id="brand" placeholder="브랜드">
							</div>
							<div class="form-group">
								<input type="number" class="form-control" id="price" placeholder="가격">
							</div>
							<div class="form-group">
								<input type="number" class="form-control" id="discount" placeholder="할인가">
							</div>
							<div class="form-group">
								<%for (int i=0;i<sizeList.length;i++) {%>
								<div class="icheck-primary d-inline">
									<input type="checkbox" id="size<%=i %>" name="size" value="<%=sizeList[i]%>">
									<label for="size<%=i%>"><%=sizeList[i]%></label>
								</div>
								<%}%>
							</div>
							<div class="form-group">
								<%for (int i=0;i<colorList.length;i++) {%>
								<div class="icheck-primary d-inline">
									<input type="checkbox" id="color<%=i %>" name="color" value="<%=colorList[i]%>">
									<label for="color<%=i%>"><%=colorList[i]%></label>
								</div>
								<%}%>
							</div>
						</form>
					</div>
					<div class="form-group">
						<textarea id="detail" type="email" class="form-control" placeholder="상세"></textarea>
					</div>
					<div class="form-group">
						<div class="custom-file">
							<input type="file" class="custom-file-input" multiple="multiple" id="file">
						</div>
						<span class="btn btn-success col-12 fileinput-button" onClick="triggerFile()">
                                 <i class="fas fa-plus"> 파일을 추가하세요</i>
                             </span>
						</span>
					</div>
					
					<div class="row form-group" id="preview">
						미리보기 영역
					</div>
					<div class="form-group">
						<button type="button" class="btn btn-warning" id="bt_regist">등록</button>
						<button type="button" class="btn btn-warning" id="bt_list">목록</button>
					</div>
				</div>
		</div>
		<!-- /.container-fluid -->
		</section>
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->
	<%@include file="/admin/inc/footer.jsp"%>
	<!-- Control Sidebar -->
	<%@include file="/admin/inc/sidebar_rigth.jsp"%>
	<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->
	<%@ include file="/admin/inc/footer_link.jsp"%>
	<script type="text/babel">
		function ImgBox(props){
			return (
				<div className={"col-sm-2 border"}>
					<div>
						<a href="#" onClick={(e)=>removeImg(e, props.index)}>x</a>					
					</div>
					<img src={props.src} width="100px"/>
				</div>
			);
		}
	</script>
	<script type="text/javascript">
		function triggerFile(){
			//파일 컴포넌트를 대상으로 클릭 효과를 냄 (간접적 효과)
			$("#file").trigger("click");
		}
	
		function regist(){
			//이미지 미리보기 기능은 단순히 우리만의 배열처리였을뿐 input type="file" 컴포넌트는 여전히 유저가 선택한 이미지 정보를 유지함
			//따라서 기존의 폼을 그대로 전송하면 안되고, 개발자가 폼에 들어갈 파일을 직접 제어해야 함 이 방법을 jquery가 지원해줌
			let formData=new FormData();
			
			console.log("전송하기 위해 넣은 파일의 수는 ", fileList.length);
			
			//파일뿐만 아니라 파라미터 등을 심을 수 있음
			//formData 사용 이유 : 개발자가 주도해서 넣고 뺴기 위해
			formData.append("category_idx", $("#category").val());
			formData.append("product_name", $("#product_name").val());
			formData.append("brand", $("#brand").val());
			formData.append("price", $("#price").val());
			formData.append("discount", $("#discount").val());
			
			//체크된 것만 데이터를 모으자
			let sizeCheckedArr=[];  //체크된 데이터만 모을 빈 배열
			for(let i=0;i<$("input[name='size']").length;i++){
				if($($("input[name='size']")[i]).is(":checked")){
					//배열에 값 넣기
					sizeCheckedArr.push($($("input[name='size']")[i]).val());
				}
			};
			formData.append("size[]", sizeCheckedArr);  //배열 전송
			
			//배열을 보내되, 더 줄여쓰는 코드를 작성(jquery)
			let colorCheckedArr=[];
			$.each($("input[name='color']:checked"), function(){
				colorCheckedArr.push($(this).val());
			});
			formData.append("color[]", colorCheckedArr);		

			formData.append("detail", $("#detail").val());		
			
			for(let i=0;i<fileList.length;i++){
				let file=fileList[i];
				//파일뿐만 아니라 파라미터 등도 심을 수 있음
				formData.append("file", file);  //(파라미터명, 어떤 파일)
			}
			
			//비동기방식으로 formData 를 전송
            //processData:false, --> 쿼리스트링화 방지 : 이미지는 쿼리스트링으로 전송할 수 없기 때문
            //application/x-www... --> contentType:false
			$.ajax({
				url:"/admin/product/regist2.jsp",
				type:"post",
				processData:false,  //쿼리리스트링 방지
				contentType:false,  //application//x-www 방지
				data:formData,
				success:function(result, status, xhr){
					alert("상품 등록 완료");
				}
			});
		}
	</script>
	<script type="text/babel">
		let tag=[];  //<ImgBox/> UI 컴포넌트를 누적할 배열  
		let previewRoot;  //react에 의해 랜더링될 컨테이너 요소 (onLoad할 때 메모리에 한번만 올림)
		let fileList=[];  //파일정보를 가진 배열 (일반배열)		 
		let oriFiles;  //원래 유저가 선택한 파일배열 원본 (readOlny)

		//4)
		function removeImg(e, index){  
			//시각적인 삭제 처리
			$(e.target).parent().parent().remove();
			
			//X버튼 누를 경우 원본 배열에서 주소값(고유값)을 이용해 해당 파일을 추출 
			//왜? fileList.splice(index, 1) 인덱스에서 삭제할 경우 삭제마다 배열의 순서가 바뀌므로
			let file=oriFiles[index];

			//추출한 파일이 삭제 대상의 배열에서 몇번째에 살고있는지 index 조사
			let sel_index=fileList.indexOf(file);  

			//배열에서 삭제
			fileList.splice(sel_index, 1);   //console에서 fileList 확인
		}
		
		//UI 목록 반영
		function createCategoryTable(result) {
			let op = "<option value='0'>상품분류 선택</option>";
			for (let i = 0; i < result.length; i++) {
				let category = result[i];
				op += "<option value='"+category.category_idx+"'>"
						+ category.category_name + "</option>";
			}
			$("#category").html(op);
		}
		//카테고리 목록 가져오기	
		function getCategoryList() {
			$.ajax({
				url : "/admin/category/category_list.jsp",
				type : "GET",
				success : function(result, status, xhr) {
					console.log(result);
					//let categoryList=JSON.parse(result);

					createCategoryTable(result); //목록 UI에 반영  //console 창에서 fileList 확인
				}
			});
		}
		
		//3) 파일 미리보기 - 사용자가 선택한 파일들을 매개변수로 받음
		function previewImg(){
			tag=[];

			for(let i=0;i<fileList.length;i++){
				let reader=new FileReader();
				
				reader.onload=function(e){  //파일이 읽혀지면
					//e : 읽은 파일에 대한 정보가 들어있음
					//$("#preview").html("<img src='"+e.target.result+"' width='100px'>");  //react가 대신함
					tag.push(<ImgBox key={i} src={e.target.result} index={i} />);
					
					if(i>=fileList.length-1){  //마지막 이미지에 도달하면
						previewRoot.render(tag);
					}
				};
				reader.readAsDataURL(fileList[i]);  //(읽을 대상 파일)
			}
		}
		
		$(function() {
			previewRoot = ReactDOM.createRoot(document.getElementById("preview"));
			$(document).ready(function() {
				getCategoryList(); //카테고리 목록 가져오기
				
				$('#detail').summernote({
					height : 200
				});
				
				//5)등록 버튼에 이벤트 연결
				$("#bt_regist").click(function(){
					regist();
				});

				//목록 버튼에 이벤트 연결
				$("#bt_list").click(function(){
					$(location).attr("href", "/admin/product/list.jsp");
				});

				//1) 파일에 이벤트 연결
				$("#file").change(function(){
					this.files;  //파일컴포넌트에서 선택한 파일을 보유한 배열이며 이 배열은 readOnly
					console.log("당신이 선택한 파일 수는 ", this.files.length);
					
					//fileList=this.files;

					//유저가 선택한 파일에 대한 정보를 배열로 얻기
					oriFiles=this.files;

					//this.files는 이미 자바스크립트의 파일배열로써, 읽기만 가능함 따라서 수정가능한 배열이 되려면 this.files 안에 있는
					//File들을 꺼내서 일반배열로 옮겨버리면 됨
					for(let i=0;i<this.files.length;i++){
						fileList.push(this.files[i]);
					}
					previewImg();  //2) 파일 미리보기, this.files : 전역변수로 빼두었기 때문에 매개변수로 받을 필요가 없음
				});
			});
		});
	</script>
</body>
</html>
