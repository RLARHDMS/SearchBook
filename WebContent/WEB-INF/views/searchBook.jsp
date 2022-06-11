<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<style type="text/css">
	.newsletter {
		padding: 80px 0;
		background: #19beda;
	}
	
	.newsletter .content {
		max-width: 650px;
		margin: 0 auto;
		text-align: center;
		position: relative;
		z-index: 2;
	}
	
	.newsletter .content h2 {
		color: #243c4f;
		margin-bottom: 40px;
	}
	
	.newsletter .content .form-control {
		height: 50px;
		border-color: #ffffff;
		border-radius: 0;
	}
	
	.newsletter .content.form-control:focus {
		box-shadow: none;
		border: 2px solid #243c4f;
	}
	
	.newsletter .content .btn {
		min-height: 50px;
		border-radius: 0;
		background: #243c4f;
		color: #fff;
		font-weight: 600;
	}
</style>
</head>

<!-- jQuery 2.2.4.min -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

	<!-- CSS only -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
		crossorigin="anonymous">

	<!-- JavaScript Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
		crossorigin="anonymous"></script>
	<script>
	var isEnd = false;
	var pageNum = 1;
		
        $(document).ready(function () {
        	$("#showMore").hide();
        	
            $("#search").click(function () {
            	$("#searchRes").html(""); //목록 초기화
            	pageNum = 1;
            	getBookList(); // 책 목록 조회
            });
            
			$("#showMore").click(function () {
				pageNum = pageNum + 1;
				getBookList();
			                
			});
        });
        
        function getBookList(){
        	$.ajax({
                method: "GET",
                url: "https://dapi.kakao.com/v3/search/book?target=title",
                data: { query: $("#bookName").val() ,page : pageNum },
                headers: { Authorization: "KakaoAK 080def2ff1d974a61f0d965696d7e674" }
            })
                .done(function (msg) {
                	console.log(msg);
                	isEnd = msg.meta.is_end;
                	if(!isEnd){
                		$("#showMore").show();
                	}else{
                		$("#showMore").hide();
                	}
                	var makeHtml = "";
                	for(var i = 0; i < msg.documents.length; i++){
                		makeHtml += '<div style="height: 50px;"></div>';
                		makeHtml += '<div class="card mb-3" style="width: 60%;">';
                		makeHtml += '	<div class="row g-0">';
                		makeHtml += '		<div class="col-md-4" id="bookImg">';
                		makeHtml += '			<img src="' + msg.documents[i].thumbnail + '" style="width: 200px;"/>';
                		makeHtml += '		</div>';
                		makeHtml += '		<div class="col-md-8">';
                		makeHtml += '			<div class="card-body">';
                		makeHtml += '				<h5 class="card-title">' + msg.documents[i].title + '</h5>';
                		makeHtml += '				<p class="card-author">' + msg.documents[i].authors + '</p>';
                		makeHtml += '				<p class="card-publisher">' + msg.documents[i].publisher + '</p>';
                		makeHtml += '				<p class="card-text">' + msg.documents[i].contents + '</p>';
                		makeHtml += '			</div></div></div></div>';
                	}
                	
                	$("#searchRes").append(makeHtml);
                   
                });
        
        }
    </script>
    
<body>

<section class="newsletter">
<div class="container">
<div class="row">
<div class="col-sm-12">
	<div class="content">
		<h2>Kakao 도서검색기</h2>
	<div class="input-group">
         <input type="text" id="bookName" class="form-control" placeholder="도서명을 검색해주세요">
         <span class="input-group-btn">
         <button class="btn" type="submit" id="search">검색</button>
         </span>
          </div>
	</div>
</div>
</div>
</div>
</section>


	<div id="searchRes"></div>
	<button id="showMore">더보기</button>
	

</body>
</html>