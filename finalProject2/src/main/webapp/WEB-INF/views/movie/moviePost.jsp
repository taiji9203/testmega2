<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<!--<div id="bodyContent"> -->

<!-- <script src="/static/pc/js/front.js"></script> -->
<script type="text/javascript">
var msnry;
var scrollTop = '';
var currentPage = '';
var recordCountPerPage = '';

$(function(){
	/*최신순, 공감순 sort 탭*/
	$("#sortTab").on("click","button", function(){
		var sortType = "";
		$(".btn").removeClass("on");
		$(this).addClass("on");
		$("#pageType").val($(this).attr("sort-type"));

		recordCountPerPage = 12;

		fn_moviePostSerach();
	});

	// 상단 탭 클릭
	$('.tab-sorting button').on('click', function() {
		$('.tab-sorting button.on').removeClass('on');
		$(this).addClass('on');
		$('#tabType').val($(this).data('type'));

		recordCountPerPage = 12;

		$("#moviePostId").val('');

		fn_moviePostSerach();
	});

	/*검색 버튼*/
	$("#btnSearch").click(function(){
		fn_moviePostSerach();
	});

	/*더보기 버튼*/
	$("#btnAddMovie").click(function(){
		fn_moviePostSerach(true);
	});

	/*개봉작만보기*/
	$("#btnOnAir").click(function(){
		var onairYn = $("#onairYn").val();

		if(onairYn == "N"){
			$("#onairYn").val("Y");
		}else{
			$("#onairYn").val("N");
		}
		$("#moviePostId").val('');
		fn_moviePostSerach();
	});

	$(document).on('click','.good .btn', function(){
		fn_addHeart(this);
	});

	/* 검색 input enter key 이벤트 */
	$("#ibxMovieNmSearch").on("keydown", function(e){
		var keycode = (e.keyCode ? e.keyCode : e.which);
		if(keycode == 13){
			$("#moviePostId").val('');
			fn_moviePostSerach();
		}
	});

	// TOP5 무비포스트 이동
	$('.top5Btn').on('click', function(e) {
		e.preventDefault();

		$("#ibxMovieNmSearch").val($(this).data('no'));
		$("#moviePostId").val('');
		fn_moviePostSerach();
		//fn_moviePostDetail($(this).data('no'));
	});

	// 나의 무비포스트 모아보기
	$('.myPostBtn').on('click', function(e) {
		//e.preventDefault();
		//fn_myMoviePostDetail($(this).data('no'));
		$("#moviePostId").val('');
		fn_mypageMoviePost();
	});

	// 무비포스트 작성 클릭
	$('.add-post a').on('click', function(e) {
		e.preventDefault();

		if( !sessionAllow( {sessionAt:true} ) ) return

		var isLogin = '' ? true : false;

		/* if(!isLogin)
			return gfn_alertMsgBox("로그인 후 이용가능한 서비스입니다."); */

		location.href = '/moviepost/write';
	});

	/*무비포스트 목록 가져오기*/
	fn_moviePostSerach(false, '');

});

// 페이지 이동
function fn_mvPage() {
	fn_viewLoginPopup('MbLoginMainV','pc');
}

/*무비포스트 가져오기*/
function fn_moviePostSerach(paging, moviePostNo){
	if(paging) {
		currentPage = parseInt(currentPage) + 1;
		recordCountPerPage = 12;
	} else {
		currentPage = 1;
		if(recordCountPerPage) {
			recordCountPerPage = currentPage > 1 ? recordCountPerPage * currentPage : recordCountPerPage;
		} else {
			recordCountPerPage = 12;
		}
	}

	$("#currentPage").val(currentPage + "");

	var paramData = {
		currentPage: currentPage + '',
		recordCountPerPage: recordCountPerPage + '',
		pageType: $("#pageType").val(),
		ibxMovieNmSearch: $("#ibxMovieNmSearch").val(),
		onairYn: $("#onairYn").val(),
		tabType: $("#tabType").val(),
		moviePostId : $("#moviePostId").val(),
		position: 'moviePostPaging',
		json: true
	};

	gfn_logdingModal();

	$.ajaxMegaBox({
        url: "/on/oh/oha/Movie/selectMoviePostList.do",
		data: JSON.stringify(paramData),
        success: function (d) {
        	var list = d.moviePostList;
        	var target = $('.movie-post-list');
        	var totalCnt = 0;
        	var option = {
       			data: list,
       			imgSvrUrl: d.imgSvrUrl,
       			loginId: '',
       			moviePostNo: moviePostNo,
       			moreTarget: 'addMovieDiv'
        	};

        	if(list.length > 0) {
        		totalCnt = list.length > 0 ? list[0].totCnt : 0;
    	        target.show();

        		// 무비포스트 리스트 생성
            	MegaboxUtil.MoviePost.createMoviePostList(target, option, paging, '');

        		var pageNo = Math.ceil(totalCnt / recordCountPerPage);
				if(currentPage < pageNo) $('.btn-more').show();
				else $('.btn-more').hide();


            	$('.no-moviepost').hide();
        	} else {
        		if (totalCnt < 1) {
        	        target.hide();
                	$('.btn-more').hide();
        		}
        		$('.no-moviepost').show();
        	}

        	$('.result-count-cnt').html(Number(totalCnt).format());

        	if(scrollTop > 0) {
        		$(document).scrollTop(scrollTop);
        	}

        	setTab(  );

        	//파라미터 존재시 상세 노출
        	$('.target img').click();

        	gfn_logdingModal();
        }
    });
}

/**
* 탭메뉴 설정
*/
function setTab( moviePostNo ){

	var attr = "";
	if( moviePostNo != null && moviePostNo != ''){
		attr = '?moviePostNo=' + moviePostNo;
	}

	switch( $("#tabType").val() ) {
		default :
			url 	= '' + attr;
			metaFormat = {
				'scnTitle'			: '모든영화 < 무비포스트 | MEET PLAY SHARE, 메가박스'
				, 'metaTagTitle'	: '무비포스트'
				, 'metaTagDtls'		: '메가박스의 다양한 무비포스트를 확인해보세요.'
				, 'metaTagUrl'		: url
				};
			break;
		case "live"  :
			url 	= '/moviepost/showing' + attr;
			metaFormat = {
				'scnTitle'			: '현재상영작 < 무비포스트 | MEET PLAY SHARE, 메가박스'
					, 'metaTagTitle'	: '무비포스트'
					, 'metaTagDtls'		: '메가박스의 다양한 무비포스트를 확인해보세요.'
					, 'metaTagUrl'		: url
					};
			break;
		case "seen"  :
			url 	= '/moviepost/seen' + attr;
			metaFormat = {
				'scnTitle'			: '내가 본 영화 < 무비포스트 | MEET PLAY SHARE, 메가박스'
					, 'metaTagTitle'	: '무비포스트'
					, 'metaTagDtls'		: '메가박스의 다양한 무비포스트를 확인해보세요.'
					, 'metaTagUrl'		: url
					};
			break;
		case "subscribe"  :
			url 	= '/moviepost/subscribe' + attr;
			metaFormat = {
				'scnTitle'			: '구독중인포스트 < 무비포스트 | MEET PLAY SHARE, 메가박스'
					, 'metaTagTitle'	: '무비포스트'
					, 'metaTagDtls'		: '메가박스의 다양한 무비포스트를 확인해보세요.'
					, 'metaTagUrl'		: url
					};
			break;
	}

	//URL 변경
	history.replaceState( null, null, location.origin + url );

	//메타태그 설정
	settingMeta(metaFormat);
}

/*좋아요 저장*/
function fn_addHeart(obj){
	var artiNo = $(obj).attr("arti-no");
	var allData = { artiNo:artiNo, artiDivCd: 'MOPO' };
	var idx = $(".good .btn").index(obj);

	if( !sessionAllow( {sessionAt:true} ) ) return

	$.ajaxMegaBox({
        url: "/on/oh/oha/Movie/mergeMoviePostHeart.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(allData),
		sessionAt: true,
        success: function (data, textStatus, jqXHR) {
			var resultMap = data.resultMap;

			if(resultMap.msg == "sessionFail"){
				gfn_alertMsgBox("로그인 후 이용가능한 서비스입니다.");
				return;
			}
			if(resultMap.rowStatCd == "D"){
				$(obj).find("i").attr('title', '좋아요 설정 안함');
				$(obj).find("i").removeClass("on");

			}else{
				$(obj).find("i").attr('title', '좋아요 설정 함');
				$(obj).find("i").addClass("on");
			}
        },
        error: function(xhr,status,error){
        	 var err = JSON.parse(xhr.responseText);
        	 alert(xhr.status);
        	 alert(err.message);
        }
    });
}

//마이페이지 이동 - 무비포스트
function fn_mypageMoviePost(){
	var contentUrl = "/mypage/moviestory";
	$("#moviePostForm").append("<input type='hidden' name='cd' value='mp' />");
	$("#moviePostForm").attr("method","post");
	$("#moviePostForm").attr("action",contentUrl);
	$("#moviePostForm").submit();
}


//무비포스트 상세페이지 이동
function fn_moviePostDetail(moviePostNo){
	var contentUrl = "/moviepost/detail";
	$("#moviePostForm").append("<input type='hidden' name='moviePostNo' value='" + moviePostNo + "' />");
	$("#moviePostForm").attr("method","get");
	$("#moviePostForm").attr("action",contentUrl);
	$("#moviePostForm").submit();
}

//무비포스트 나의 모아보기 페이지 이동
function fn_myMoviePostDetail(mbNo){
	var contentUrl = "/on/oh/oha/Movie/selectCollectMoviePostDetail.do";
	$("#moviePostForm").append("<input type='hidden' name='mbNo' value='" + mbNo + "' />");
	$("#moviePostForm").attr("method","get");
	$("#moviePostForm").attr("action",contentUrl);
	$("#moviePostForm").submit();
}

// 무비포스트 등록 페이지 이동
function fn_moviePostWrite(){
	$.ajax({
        url: "/on/oh/oha/Movie/loginChk.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
// 		data: JSON.stringify(allData),
		sessionAt:true,
        success: function (data, textStatus, jqXHR) {
			var resultMap = data.resultMap;

			if(resultMap.msg == "sessionFail"){
				gfn_alertMsgBox({ msg: '로그인 후 이용가능한 서비스입니다.', callback: fn_moveLoginPage });

				return;
			}

			var contentUrl = "/moviepost/write";
			$("#moviePostForm").attr("method","post");
			$("#moviePostForm").attr("action",contentUrl);
			$("#moviePostForm").submit();
        },
        error: function(xhr,status,error){
        	 var err = JSON.parse(xhr.responseText);
        	 alert(xhr.status);
        	 alert(err.message);
        }
    });
}

// 로그인 페이지 이동
function fn_moveLoginPage() {
	$('[name=menuId]').val('MoviePistV');
	$('[name=mappingId]').val(location.pathname);

	var form = $('#moviePostForm');
	form.attr('action', '/on/oh/ohg/MbLogin/viewMbLoginMainPage.rest');
	form.submit();
}

</script>


<form id="moviePostForm" method="post">
	<input type="hidden" name="menuId">
	<input type="hidden" name="mappingId">
</form>
<input type="hidden" id="currentPage" name="currentPage" value="1">
<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="10">
<input type="hidden" id="pageType" name="pageType" value="">  <!-- date -->
<input type="hidden" id="tabType" name="tabType" value="all"> <!-- all -->
<input type="hidden" id="onairYn" name="onairYn" value=""> <!-- N -->

<div class="container">
	<!-- page-tit-area -->
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
				<a href="/movie/movie" title="영화 페이지로 이동">영화</a>
				<a href="/movie/moviePost" title="무비포스트 페이지로 이동">무비포스트</a>
			</div>

			
		</div>
	</div>
	<!--// page-tit-area -->

	<!-- contents -->
	<div id="contents" class="pt00">
		<!-- post lank  -->
		<div class="post-lank-box">
			<div class="inner-wrap">
				<h2 class="tit">무비포스트</h2>
				<!-- post-lank -->
				<ol class="post-lank">
					
						
							<li>
								<a href="#" class="top5Btn" data-no="너의 이름은." title="너의 이름은. 무비포스트 보기">
									<p class="lank">1</p>

									<div class="post-count">
										<p class="tit">POST</p>
										<p class="count">2,073</p>
									</div>

									<p class="img"><img src="/resources/movie/KbLPdrF5WBGN5OemdEEAl9TJ3ncdvOIQ_150.jpg" onerror="noImg(this)" alt="너의 이름은."></p>
								</a>
							</li>
						
					
						
							<li>
								<a href="#" class="top5Btn" data-no="아바타: 물의 길" title="아바타: 물의 길 무비포스트 보기">
									<p class="lank">2</p>

									<div class="post-count">
										<p class="tit">POST</p>
										<p class="count">767</p>
									</div>

									<p class="img"><img src="/resources/movie/9vUySe7DNMro6tdYRPEbjzF2ebr48MwE_150.jpg" onerror="noImg(this)" alt="아바타: 물의 길"></p>
								</a>
							</li>
						
					
						
							<li>
								<a href="#" class="top5Btn" data-no="올빼미" title="올빼미 무비포스트 보기">
									<p class="lank">3</p>

									<div class="post-count">
										<p class="tit">POST</p>
										<p class="count">433</p>
									</div>

									<p class="img"><img src="/resources/movie/xFO8r2xbXzxoMD9iXbuKC1n5Bo79InhQ_150.jpg" onerror="noImg(this)" alt="올빼미"></p>
								</a>
							</li>
						
					
						
							<li>
								<a href="#" class="top5Btn" data-no="서치" title="서치 무비포스트 보기">
									<p class="lank">4</p>

									<div class="post-count">
										<p class="tit">POST</p>
										<p class="count">402</p>
									</div>

									<p class="img"><img src="/resources/movie/FF7B4F-6783-46B5-AE43-A84671CC2215.medium.jpg" onerror="noImg(this)" alt="서치"></p>
								</a>
							</li>
						
					
						
							<li>
								<a href="#" class="top5Btn" data-no="더 퍼스트 슬램덩크" title="더 퍼스트 슬램덩크 무비포스트 보기">
									<p class="lank">5</p>

									<div class="post-count">
										<p class="tit">POST</p>
										<p class="count">386</p>
									</div>

									<p class="img"><img src="/resources/movie/whzCk46ejtIoWU1eavvF9lJ8rC2Wbvf7_150.jpg" onerror="noImg(this)" alt="더 퍼스트 슬램덩크"></p>
								</a>
							</li>
						
					
				</ol>
				<!--// post-lank -->

				
				
					
				
					
				
					
				
					
				
					
				

				<!-- mypost-box -->
				<div class="mypost-box">
					
						
						
						<!-- 로그인 전 -->
							<div class="before">
								<div class="post-count">
									<p class="tit">MY POST</p>
									<a href="javaScript:fn_viewLoginPopup(&#39;default&#39;,&#39;pc&#39;);" class="txt-login" title="로그인하기">로그인하기</a>
								</div>
							</div>
						
					
				</div>
				<!--// mypost-box -->

				<!-- add-post -->
				<div class="add-post">
					<a href="#" class="button purple" title="무비포스트 작성">무비포스트 작성</a>
				</div>
				<!--// add-post -->
			</div>
		</div>
		<!--// post lank -->

		<!--content:Start -->
		<div class="inner-wrap mt30">
			<div class="tab-sorting mb40">
				<button type="button" class="on" data-type="all">모든영화</button>
				<button type="button" data-type="live">현재상영작</button>

				
			</div>

			<div class="board-list-util">
				<p class="result-count"><strong>전체 <b class="result-count-cnt">201,966</b>건</strong></p>

				<div class="sorting" id="sortTab">
					<span><button type="button" class="btn on" sort-type="date">최신순</button></span>
					<span><button type="button" class="btn" sort-type="like">공감순</button></span>
				</div>

				<div class="board-search">
					<input type="text" id="ibxMovieNmSearch" name="ibxMovieNmSearch" title="검색어를 입력해 주세요." placeholder="제목, 장르, 감독, 배우, 아이디" class="input-text" value="">
					<input type="hidden" id="moviePostId" name="moviePostId" value="">
					<button type="button" class="btn-search-input" id="btnSearch">검색</button>
				</div>
			</div>

			<!-- 2019-04-19 : 무비 포스트 완전 바뀜. 재작업 -->
			<!-- movie-post-list -->
			<div class="movie-post-list" id="moviePostList" style="position: relative; height: 1317.51px;"><div class="grid-item" style="position: absolute; left: 0px; top: 0px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220590" data-row="1" data-tot="201966" data-url=""><img src="/resources/movie/2pQKI2v7RRsxuLslwEK0CZjRsq6ykDB5_230.jpg" alt="아바타: 물의 길" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="srmariemunmo**님의 무비포스트 보기" class="moviePostId" data-id="5051AF4F-4D9C-498E-A07D-ED095CA31F57">srmariemunmo**</a>            </div>            <a href="/movie-detail?rpstMovieNo=22029100" title="아바타: 물의 길 상세보기">                <p class="tit">아바타: 물의 길</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220590" data-row="1" data-tot="201966">                <p class="txt">완전 감동~~~<br>또 보고싶습니다 <br></p>                <p class="time">1 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220590"><i class="iconset ico-like">좋아요 수</i> <span class="none">0</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220590" data-row="1" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 0</a>            </div>        </div>    </div></div><div class="grid-item" style="position: absolute; left: 290px; top: 0px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220589" data-row="2" data-tot="201966" data-url=""><img src="/resources/movie/5CugcpSUcjhGGARmcOlSXmQUJHC2uOyv_230.jpg" alt="오늘 밤, 세계에서 이 사랑이 사라진다 해도" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="juehe**님의 무비포스트 보기" class="moviePostId" data-id="8A699FF8-0F2B-45D0-A68A-C171E7B66AFF">juehe**</a>            </div>            <a href="/movie-detail?rpstMovieNo=22091200" title="오늘 밤, 세계에서 이 사랑이 사라진다 해도 상세보기">                <p class="tit">오늘 밤, 세계에서 이 사랑이 사라진다 해도</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220589" data-row="2" data-tot="201966">                <p class="txt">애들이라면 충분히 좋아할 만한 영화였습니다</p>                <p class="time">1 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220589"><i class="iconset ico-like">좋아요 수</i> <span class="none">0</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220589" data-row="2" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 0</a>            </div>        </div>    </div></div><div class="grid-item" style="position: absolute; left: 580px; top: 0px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220588" data-row="3" data-tot="201966" data-url=""><img src="/resources/movie/ABzBYSduhjio3sFWznDv8XoBsolYJPpN_230.jpg" alt="바빌론" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="pol11ch**님의 무비포스트 보기" class="moviePostId" data-id="A21F536D-E75A-4298-844C-498CA38C8105">pol11ch**</a>            </div>            <a href="/movie-detail?rpstMovieNo=23000500" title="바빌론 상세보기">                <p class="tit">바빌론</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220588" data-row="3" data-tot="201966">                <p class="txt">영화의 역사를 다채롭게  표현한 영화!! 광적인 여주의 연기압권</p>                <p class="time">2 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220588"><i class="iconset ico-like">좋아요 수</i> <span class="none">0</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220588" data-row="3" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 0</a>            </div>        </div>    </div></div><div class="grid-item" style="position: absolute; left: 870px; top: 0px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220587" data-row="4" data-tot="201966" data-url=""><img src="/resources/movie/SRR8e0b67CljiVfAQHy7OoTFyytQ7rOK_230.jpg" alt="더 퍼스트 슬램덩크" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="07jeep54**님의 무비포스트 보기" class="moviePostId" data-id="30226715-9DBE-4F26-B85C-1311AA82146C">07jeep54**</a>            </div>            <a href="/movie-detail?rpstMovieNo=22103500" title="더 퍼스트 슬램덩크 상세보기">                <p class="tit">더 퍼스트 슬램덩크</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220587" data-row="4" data-tot="201966">                <p class="txt">내일 재관람 합니다^-^</p>                <p class="time">2 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220587"><i class="iconset ico-like">좋아요 수</i> <span class="none">0</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220587" data-row="4" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 0</a>            </div>        </div>    </div></div><div class="grid-item" style="position: absolute; left: 870px; top: 407.984px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220586" data-row="5" data-tot="201966" data-url=""><img src="/resources/movie/A7DMQ23jl8Ft4VQfni8GsJOUYCtg13SJ_230.jpg" alt="유령" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="zosw03**님의 무비포스트 보기" class="moviePostId" data-id="E25BC94B-2312-4288-9628-B214B377137F">zosw03**</a>            </div>            <a href="/movie-detail?rpstMovieNo=22103600" title="유령 상세보기">                <p class="tit">유령</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220586" data-row="5" data-tot="201966">                <p class="txt">백합영화 너무 좋아요.. 특히 저는 쥰지 연설 장면이 좋았던 것 같습니다 감독님 최고입니다</p>                <p class="time">2 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220586"><i class="iconset ico-like">좋아요 수</i> <span class="none">0</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220586" data-row="5" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 0</a>            </div>        </div>    </div></div><div class="grid-item" style="position: absolute; left: 0px; top: 426.172px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220585" data-row="6" data-tot="201966" data-url=""><img src="/resources/movie/nrQUhgkUlGUzPCu81twxvZbDuXNi1AGQ_230.jpg" alt="극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="jaeyun39**님의 무비포스트 보기" class="moviePostId" data-id="0A6DEE57-AC71-47B4-80C6-FA6CA587B6A6">jaeyun39**</a>            </div>            <a href="/movie-detail?rpstMovieNo=22100300" title="극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연 상세보기">                <p class="tit">극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220585" data-row="6" data-tot="201966">                <p class="txt">전생슬 너무너무 좋아하고 ㅠㅠ 리무루 너무 귀엽고 ㅠㅠ 모든 캐릭터가 매력 뿜뿌밍</p>                <p class="time">4 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220585"><i class="iconset ico-like">좋아요 수</i> <span class="none">0</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220585" data-row="6" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 0</a>            </div>        </div>    </div></div><div class="grid-item" style="position: absolute; left: 580px; top: 426.172px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220584" data-row="7" data-tot="201966" data-url=""><img src="/resources/movie/Seho8p2zAwVN2DzDu6Xehv5b7VnOuR2V_230.jpg" alt="오늘 밤, 세계에서 이 사랑이 사라진다 해도" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="liargame**님의 무비포스트 보기" class="moviePostId" data-id="D7DDFEDA-E85D-4B67-A633-6067F0BBAAC2">liargame**</a>            </div>            <a href="/movie-detail?rpstMovieNo=22091200" title="오늘 밤, 세계에서 이 사랑이 사라진다 해도 상세보기">                <p class="tit">오늘 밤, 세계에서 이 사랑이 사라진다 해도</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220584" data-row="7" data-tot="201966">                <p class="txt">일본 멜로 영화의 특색이 묻어있어요<br>스토리 연출 마지막 여운까지..<br></p>                <p class="time">4 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220584"><i class="iconset ico-like">좋아요 수</i> <span class="none">1</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220584" data-row="7" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 0</a>            </div>        </div>    </div></div><div class="grid-item" style="position: absolute; left: 290px; top: 445.672px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220583" data-row="8" data-tot="201966" data-url=""><img src="/resources/movie/9vUySe7DNMro6tdYRPEbjzF2ebr48MwE_230.jpg" alt="아바타: 물의 길" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="taeyangs**님의 무비포스트 보기" class="moviePostId" data-id="D1D25DBB-AD24-40CD-BDCE-1AB2F3C82324">taeyangs**</a>            </div>            <a href="/movie-detail?rpstMovieNo=22029100" title="아바타: 물의 길 상세보기">                <p class="tit">아바타: 물의 길</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220583" data-row="8" data-tot="201966">                <p class="txt">3d 돌비로 꼭 봐야함!!</p>                <p class="time">5 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220583"><i class="iconset ico-like">좋아요 수</i> <span class="none">1</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220583" data-row="8" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 0</a>            </div>        </div>    </div></div><div class="grid-item" style="position: absolute; left: 870px; top: 852.343px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220582" data-row="9" data-tot="201966" data-url=""><img src="/resources/movie/fbgoDoOjsFHf9WMm1j6NYy9kh7fm7yYy_230.jpg" alt="더 퍼스트 슬램덩크" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="primec**님의 무비포스트 보기" class="moviePostId" data-id="C473E99C-4754-4D20-B1AA-E503FC6242AD">primec**</a>            </div>            <a href="/movie-detail?rpstMovieNo=22103500" title="더 퍼스트 슬램덩크 상세보기">                <p class="tit">더 퍼스트 슬램덩크</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220582" data-row="9" data-tot="201966">                <p class="txt">스토리가 인상적이었던 감동의 시간..</p>                <p class="time">6 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220582"><i class="iconset ico-like">좋아요 수</i> <span class="none">1</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220582" data-row="9" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 0</a>            </div>        </div>    </div></div><div class="grid-item" style="position: absolute; left: 290px; top: 853.656px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220581" data-row="10" data-tot="201966" data-url=""><img src="/resources/movie/THSeKCTyXQ3QgOM2cwSmj68IxXkAYn1F_230.jpg" alt="아바타: 물의 길" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="lhg**님의 무비포스트 보기" class="moviePostId" data-id="F6243B76-183E-47BD-A5F2-C76D09C9BDD6">lhg**</a>            </div>            <a href="/movie-detail?rpstMovieNo=22029100" title="아바타: 물의 길 상세보기">                <p class="tit">아바타: 물의 길</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220581" data-row="10" data-tot="201966">                <p class="txt">미국 선진국</p>                <p class="time">8 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220581"><i class="iconset ico-like">좋아요 수</i> <span class="none">0</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220581" data-row="10" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 0</a>            </div>        </div>    </div></div><div class="grid-item" style="position: absolute; left: 0px; top: 890.031px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220580" data-row="11" data-tot="201966" data-url=""><img src="/resources/movie/vRDxzQ7BT5UZJSCxjBXTtxdbKA7eYktj_230.jpg" alt="오늘 밤, 세계에서 이 사랑이 사라진다 해도" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="molang**님의 무비포스트 보기" class="moviePostId" data-id="AF85DC1D-E4BD-4425-A8F8-6C5C71C298C7">molang**</a>            </div>            <a href="/movie-detail?rpstMovieNo=22091200" title="오늘 밤, 세계에서 이 사랑이 사라진다 해도 상세보기">                <p class="tit">오늘 밤, 세계에서 이 사랑이 사라진다 해도</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220580" data-row="11" data-tot="201966">                <p class="txt">남주 죽었다.</p>                <p class="time">12 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220580"><i class="iconset ico-like">좋아요 수</i> <span class="none">0</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220580" data-row="11" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 2</a>            </div>        </div>    </div></div><div class="grid-item" style="position: absolute; left: 580px; top: 890.031px;">    <div class="wrap">        <div class="img">            <a href="#layer_post_detail" title="무비포스트 상세보기" class="post-detailPopup btn-modal-open2" w-data="850" h-data="auto" data-no="220579" data-row="12" data-tot="201966" data-url=""><img src="/resources/movie/EZIn5rUGAuvOI8JR1IHz7zia6VmUMpAj_230.jpg" alt="메간" onerror="noImg(this);"> /&gt;</a>        </div>        <div class="cont">            <div class="writer">                <a href="#" title="ksoomi**님의 무비포스트 보기" class="moviePostId" data-id="CCDBFC5D-FE02-40D2-8645-D9EFAD0F9D20">ksoomi**</a>            </div>            <a href="/movie-detail?rpstMovieNo=23000300" title="메간 상세보기">                <p class="tit">메간</p>            </a>            <a href="#layer_post_detail" title="무비포스트 상세보기" class="link btn-modal-open2 post-detailPopup" w-data="850" h-data="auto" data-no="220579" data-row="12" data-tot="201966">                <p class="txt">인형의 무서움. 나중에 저런 일이 정말로 벌어진다면...</p>                <p class="time">14 시간전</p>            </a>            <div class="condition">                <button type="button" class="btn-like postLikeBtn listBtn jsMake" data-no="220579"><i class="iconset ico-like">좋아요 수</i> <span class="none">0</span></button>                <a href="#layer_post_detail" title="댓글 작성하기" class="link btn-modal-open2 post-detailRlyPopup" w-data="850" h-data="auto" data-no="220579" data-row="12" data-tot="201966"><i class="iconset ico-reply">댓글 수</i> 0</a>            </div>        </div>    </div></div></div>

			<div class="no-moviepost" style="display: none;">등록된 무비포스트가 없습니다.</div>

			<div class="btn-more" style="">
				<button type="button" class="btn" id="btnAddMovie">더보기 <i class="iconset ico-btn-more-arr"></i></button>
			</div>

		</div>
		<!--content:End -->
	</div>
	<!--// contents -->

	<!-- 무비포스트 상세 레이어팝업 -->
	









<script type="text/javascript">

var detailPopup = {
	mbNo : "",
	moviePostNo : "",
	backScreen  : "",
	movieNo : ""
};

var moviePostRlyNo;

$(function() {

	// 구독하기 버튼
	$('#subscribe').on('click', function() {


		$.ajaxMegaBox({
	        url: '/on/oh/oha/Movie/mergeMoviePostSubscribe.do',
            data: JSON.stringify({
				mbNo : detailPopup.mbNo
            }),
            sessionAt:true,
	        success: function (data) {
				var resultMap = data.resultMap;

				if(resultMap.msg == 'sessionFail') return gfn_alertMsgBox('로그인 후 이용가능한 서비스입니다.');

				if(resultMap.moviePostSbscAt == 'Y' || resultMap.moviePostSbscAt == 'C') {
					gfn_alertMsgBox('구독 신청이 완료 되었습니다.', function(){

						// 영화 > 무비포스트 > 구독중인포스트 : 재조회
						if($('[data-type=subscribe].on').length == 1){
							$('[data-type=subscribe].on').click();
						}
						// 나의 무비스토리  > 구독중인포스트 : 재조회
						else if($('[data-type=mySubscribe].on').length == 1){
							$('[data-type=mySubscribe].on').click();
						}
					});
					$('#subscribe').text('구독중');
				} else if(resultMap.moviePostSbscAt == 'N') {
					gfn_alertMsgBox('구독이 해제 되었습니다.', function(){
						// 나의 무비스토리  > 구독중인포스트 : 재조회
						if ($('[data-type=mySubscribe].on').length == 1) {
							$('[data-type=mySubscribe].on').click();

						}

						// 영화 > 무비포스트 > 구독중인포스트 : 재조회
						else if($('[data-type=subscribe].on').length == 1){
							$('[data-type=subscribe].on').click();

						}
					});
					$('#subscribe').text('구독하기');
				} else {
					$('#subscribe').text('구독하기');
				}

	        }
	    });
	});

	// 좋아요 버튼
	$(".layer-con").on('click', '.count .btn', function() {
		fn_addHeart(this);
	});

	// 댓글 등록
	$(".layer-con").on('click', '#btnPostRly', function() {
		var postRlyCn = $('#postRlyCn').val();

		if(gfn_isEmpty(postRlyCn)) return gfn_alertMsgBox('내용을 입력하세요');

		fn_insertPostRlyPre();
	});

	// 더보기 버튼
	$('#btnAddMovie').on('click', function() {
		fn_moviePostRlySearch('add');
	});



	// 댓글 사이즈
	$('#postRlyCn').on('keyup', function(e) {
		var postRlyCn = $('#postRlyCn').val();

		if(postRlyCn.length < 101) $('.text-count').text(postRlyCn.length);
	});

	// 공유하기
	$('.btn-post-share button').off().on('click', function(e) {
		e.preventDefault();

		var classStr = $(this).attr('class');

		if(classStr.indexOf('kakao') > -1) { // 카카오톡
			if(!MegaboxUtil.Common.isMobile() && !MegaboxUtil.Common.isApp())
				MegaboxUtil.Common.alert('앱에서만 사용 가능합니다.');
			else
				MegaboxUtil.Common.alert('준비중입니다.');
		} else if(classStr.indexOf('face') > -1) { // 페이스북
			MegaboxUtil.Share.facebook();
		} else if(classStr.indexOf('band') > -1) { // 밴드
			MegaboxUtil.Share.band();
		} else if(classStr.indexOf('twitter') > -1) { // 트위터
			MegaboxUtil.Share.twitter();
		} else { // 링크 공유
			MegaboxUtil.Share.copyUrl();
		}

		$('.tooltip-layer, .tipPin').css({ 'opacity': 0, 'z-index': 0 });
	});

	// 예매 클릭
    $('#bokdLinkBtn').off().on('click', function(e) {
      e.preventDefault();

      var form = MegaboxUtil.Form.createForm();
      form.append($('<input>').attr({ 'type': 'hidden', 'name': 'rpstMovieNo', 'value': $(this).data('no') }));
      form.attr('action', '/booking');
      form.submit();
    });


});





/*댓글목록 가져오기*/
function fn_moviePostRlySearch(searchtype, moviePostNo, viewDiv){

	var moviePostNo = moviePostNo;
	//var currentPage = $("#currentPage").val();
	//var recordCountPerPage = $("#recordCountPerPage").val();

	if(searchtype == "search"){
		//currentPage = "1";
	}else if(searchtype == "add"){
		//currentPage = parseInt(currentPage) + 1;
	}
	//$("#currentPage").val(currentPage+"");
	//var paramData = { moviePostNo: moviePostNo, currentPage:currentPage + "", recordCountPerPage:recordCountPerPage};
	var paramData = { moviePostNo: moviePostNo};

	$.ajax({
        url: "/on/oh/oha/Movie/selectMoviePostRlyList.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
		data: JSON.stringify(paramData),
        success: function (data) {
        	if(searchtype == "search"){
        		$("#commentList").empty();
        	}

        	$("#commentList").append(data);


        	if(viewDiv == "rly"){ //댓글아이콘 눌러서 상세 볼 경우
        		console.log(viewDiv);

        		$('#postRlyCn').focus();
        		$('.comment-box')[0].scrollIntoView(false); //댓글로 포커스


        	}else if($('#layer_post_detail .bg-modal-dim').length > 0) {
        		// 그림, 텍스트 눌러서 포스트 상세 볼 경우
        		console.log(viewDiv);
        		$('#layer_post_detail .bg-modal-dim')[0].scrollIntoView(true); // 레이어팝업 헤더에 포커스

        	}

        	//$(".link.btn-modal-open2.post-detailRlyPopup").each(function(idx){
        	$(".btn-modal-open2.post-detailRlyPopup").each(function(idx){
       			var hdnMoviePostNo = $('#hdnMoviePostNo').val();
       			if($.trim($(this).data('no')) == hdnMoviePostNo){
       				var totCnt = $('#rlyCntTop').val();
       				$(this).html("<i class='iconset ico-reply'>댓글 수</i> "+totCnt);
       			}
       		});
        }
    });

}

/*좋아요 저장*/
function fn_addHeart(obj){

	var artiNo = $(obj).attr("arti-no");

	if (artiNo == null) return ;

	var allData = { artiNo:artiNo, artiDivCd: 'MOPO' };

	$.ajaxMegaBox({
        url: "/on/oh/oha/Movie/mergeMoviePostHeart.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(allData),
		sessionAt:true,
        success: function (data, textStatus, jqXHR) {
			var resultMap = data.resultMap;

			if(resultMap.msg == "sessionFail"){
				gfn_alertMsgBox("로그인 후 이용가능한 서비스입니다.");
				return;
			}
			var text = "";
			$(obj).html('');
			if(resultMap.rowStatCd == "D"){
				text = "<i title=\"좋아요 설정 함\" class=\"iconset ico-like\"></i>"+resultMap.likeCnt;
				var artiNo = $(obj).attr("arti-no");

				$(".btn-like.listBtn").each(function(idx){
					if($.trim($(this).data('no')) == artiNo){
						var oriVal = $(this).find('span').html();	//좋아요 수
						var toVal = Number(oriVal)-1;				//좋아요 -1
						$(this).find('span').html(toVal);			//태그 적용
						$(this).find('i').removeClass('on');		//온클래스 제거
					}
				});
			}else{
				text = "<i title=\"좋아요 설정 안함\" class=\"iconset ico-like on\"></i>"+resultMap.likeCnt;
				var artiNo = $(obj).attr("arti-no");

				$(".btn-like.listBtn").each(function(idx){
					if($.trim($(this).data('no')) == artiNo){
						var oriVal = $(this).find('span').html();	//좋아요 수
						var toVal = Number(oriVal)+1;				//좋아요 +1
						$(this).find('span').html(toVal);			//태그 적용
						$(this).find('i').addClass('on');			//온클래스 추가
					}
				});
			}
			$(obj).append(text);
        }
    });
}


/*댓글저장 전처리*/
function fn_insertPostRlyPre(){
	var postRlyCn = $("#postRlyCn").val();

 	var fn_complete = function(list){
	      if ( list.length > 0 ) {
	          //alert(list.join(","));
	          gfn_alertMsgBox('허용되지 않는 단어가 포함되어 있습니다.'); //허용되지 않는 단어가 포함되어 있습니다.
	      } else {
	    	  fn_insertPostRly();
	      }
	 }

 	gfn_chkPrhword(postRlyCn,fn_complete);
}

/*댓글저장*/
function fn_insertPostRly(){

	var moviePostNo = detailPopup.moviePostNo;
	var postRlyCn = $("#postRlyCn").val();
	var allData = { moviePostNo:moviePostNo, postRlyCn:postRlyCn};

/* 	if(!confirm("등록 하시겠습니까?")){
		return;
	}
 */
//20190905 한줄평, 댓글 작성시 메세지 불필요  gfn_confirmMsgBox("등록 하시겠습니까?", function(){
 		$.ajaxMegaBox({
	        url: "/on/oh/oha/Movie/insertPostRly.do",
	        type: "POST",
	        contentType: "application/json;charset=UTF-8",
	        dataType: "json",
			data: JSON.stringify(allData),
			sessionAt:true,
            clickLmtChk: true, //중복클릭 방지 실행
	        success: function (data, textStatus, jqXHR) {
				var resultMap = data.resultMap;

				if(resultMap.msg == "sessionFail"){
					gfn_alertMsgBox("로그인 후 이용가능한 서비스입니다.");
					return;
				}

				if(resultMap.msg == 'already') return gfn_alertMsgBox('이미 작성된 댓글이 있습니다.');

				//20190905 한줄평, 댓글 작성시 메세지 불필요  gfn_alertMsgBox("댓글이 등록 되었습니다.");
				$(".text-count").text("0");
				$("#postRlyCn").val("");
				fn_moviePostRlySearch("search", moviePostNo, "rly");
            },complete: function(xhr){
            	clearLmt(); //중복제한 초기화

            }
	    });
	/////});
}



/*댓글 수정화면 취소버튼*/
function fn_writeCancel(moviePostRlyNo){
	$("#rlyWri"+moviePostRlyNo).hide();
	$("#rlyTxt"+moviePostRlyNo).show();
}

/*댓글 사이즈(수정화면)*/
function fn_postRlyCnValChk(moviePostRlyNo){
	var postRlyCn = $("#postRlyCn"+moviePostRlyNo).val();
	if(postRlyCn.length < 101){
		$("#textCount"+moviePostRlyNo).text(postRlyCn.length);
	}
}


/*******************************************************************
 * 무비포스트 상세 레이어팝업 관련 	*
 *******************************************************************/
 function fn_moviePostList(){
	//콜백함수
	 fn_moviePostRlySearch('search', detailPopup.moviePostNo);

}


 function fn_postDetail(moviePostNo, viewDiv, backScreen){
	console.log("MoviePostViewLayerPM.jsp");
	//console.log(moviePostNo);
	detailPopup.moviePostNo = moviePostNo;
	detailPopup.backScreen = backScreen;

	//댓글창 초기화
	$('.comment-function .reset .text-count').text(0);
	$('#postRlyCn').val('');
	$('#subscribe').css("display", "block");
	$('.balloon-space').removeClass('on');


	$.ajaxMegaBox({
		url: '/moviepost/layerDetail',
		type: "POST",
		contentType: "application/json;charset=UTF-8",
		dataType: "json",
		data: JSON.stringify({
			moviePostNo: moviePostNo
		}),
		success: function (data) {

			var detailInfo = data.postList[0];
			$('.post-detail .tit').html(detailInfo.moviePostMovieTitle); //무비포스트 제목
			$('.user-id').html(detailInfo.loginId);
			$('.user-write-time').html(detailInfo.fstRegDe);
			$('.user-post-box .user-info .photo').html('<img src="'+data.imgSvrUrl+detailInfo.profileImgPath+'" alt="'+detailInfo.loginId+'님의 무비포스트" onerror="noImg(this)"/>');
			$('.user-write-time').html(detailInfo.fstRegDe);
			detailPopup.mbNo = detailInfo.mbNo;
			detailPopup.movieNo = detailInfo.movieNo;

			if ((detailInfo.movieStatCd == 'MSC01' || detailInfo.movieStatCd == 'MSC02') && detailInfo.bokdAbleYn == 'Y') {
				$('#bokdLinkBtn').show();
				$('#bokdLinkBtn').data('no', detailInfo.movieNo);
				$('#bokdLinkBtn').attr('title', detailInfo.movieNm +' 예매하기');
			} else {
				$('#bokdLinkBtn').hide();
			}

			if('' != detailInfo.mbNo){ //무비포스트 쓴 회원과 홈페이지 접속한 회원이 같지 않은 경우

				$('.count .btn').attr('arti-no', moviePostNo); //좋아요 버튼에 무비포스트번호 셋팅

				//포스트 옵션 말풍선
				$('.balloon-space').removeClass('writer').addClass('user');
				var html ="";
				html += '<div class="user">';
			    html += '<p class="reset a-c">광고성 내용 및 욕설/비방하는<br />내용이 있습니까?</p>';
			    html += '<button type="button" data-no3="' + moviePostNo + '">포스트 신고 <i class="iconset ico-arr-right-green"></i></button>';
			    html += '</div>';
				html += '<div class="btn-close"><a href="#" title="닫기"><img src="../../../static/pc/images/common/btn/btn-balloon-close.png" alt="닫기" /></a></div>';
			    $('.balloon-space.mpost .balloon-cont').html(html);

				if(detailInfo.moviePostSbscAt == 'Y'){ //무비포스트구독여부가 Y면
					$('#subscribe').text('구독중');
				}else{
					$('#subscribe').text('구독하기');
				}
			}else {
				$('.count .btn').attr('arti-no', moviePostNo); //좋아요 버튼에 무비포스트번호 셋팅

				//포스트 옵션 말풍선
				$('.balloon-space').removeClass('user').addClass('writer');
				var html="";
				html += '<div class="writer layer-pop-detail">';
			    html += '<button type="button" data-no1="'+ moviePostNo +'" data-no2="'+ detailInfo.movieNo +'">수정</button>';
			    html += '<button type="button" data-no1="'+ moviePostNo +'">삭제</button>';
			    html += '</div>';
			    html += '<div class="btn-close"><a href="#" title="닫기"><img src="../../../static/pc/images/common/btn/btn-balloon-close.png" alt="닫기" /></a></div>';

			    $('.balloon-space.mpost .balloon-cont').html(html);

				$('#subscribe').css("display", "none");
			}

			//포스트 내용
		 	if(data.postList.length > 0){

		 		var metaTagImg = "";	//메타태그 이미지
		 		var htmlTxt = "";
		 		var img_Path = "";
		 		for(var i=0; i<data.postList.length; i++){
		 			if( i == 0 ){
		 				metaTagImg = data.imgSvrUrl + data.postList[i].imgPath
		 			}
					if(data.postList[i].moviePostImgDivCd == 'MIK01'){ //스틸컷(포스터)
						img_Path = nvl(data.postList[i].imgPath).posterFormat('_600');
						htmlTxt += '<div class="section">' ;
						htmlTxt += '<img src="'+ data.imgSvrUrl + img_Path + '"';
						htmlTxt += 'alt="" />';
						htmlTxt +='<p class="p-caption">';
						htmlTxt += data.postList[i].moviePostImgDesc.replaceAll('\n', '<br>');
						htmlTxt +='</p></div>';
					}
					else if(data.postList[i].moviePostImgDivCd == 'MIK02'){ //스틸컷
						img_Path = nvl(data.postList[i].imgPath).posterFormat('_648');
						htmlTxt += '<div class="section">';
						htmlTxt += '<img src="'+ data.imgSvrUrl+ img_Path + '"';
						htmlTxt += 'alt="" />';
						htmlTxt += '<p class="p-caption">';
						htmlTxt += data.postList[i].moviePostImgDesc.replaceAll('\n', '<br>');
						htmlTxt += '</p></div>';
					}
					else if(data.postList[i].moviePostImgDivCd == 'MIK03'){ //예고편동영상
						img_Path = nvl(data.postList[i].imgPath).posterFormat('_648');
						htmlTxt += '<div class="section">';
						htmlTxt += '<video controls poster="'+ data.imgSvrUrl + img_Path + '"';
						htmlTxt += '<source src="'+data.postList[i].moviePostVodUrl +'" type="video/mp4" /></video>';
						htmlTxt +=  '<p class="p-caption">';
						htmlTxt += data.postList[i].moviePostImgDesc.replaceAll('\n', '<br>');
						htmlTxt += '</p></div>';

					}
					else if(data.postList[i].moviePostImgDivCd == 'MOVIEPOST'){ //내사진
						htmlTxt += '<div class="section">';
						htmlTxt += '<img src="'+ data.imgSvrUrl + data.postList[i].imgPath+ '"';
						htmlTxt += 'alt="" />';
						htmlTxt +=  '<p class="p-caption">';
						htmlTxt += data.postList[i].moviePostImgDesc.replaceAll('\n', '<br>');
						htmlTxt += '</p></div>';

					}
					else{
						htmlTxt += '<div class="section">';
						htmlTxt += '<img src="'+ data.imgSvrUrl + data.postList[i].imgPath+ '"';
						htmlTxt += 'alt="" />';
						htmlTxt +=  '<p class="p-caption">';
						htmlTxt += data.postList[i].moviePostImgDesc.replaceAll('\n', '<br>');
						htmlTxt += '</p></div>';

					}
				}

		 		$('.post-cont-area .section-area').html(htmlTxt);

			}

			//좋아요 아이콘
			if(detailInfo.likeYn == "Y"){ //좋아요 Y

				var txt="";

				txt += '<i title="좋아요 설정 함" class="iconset ico-like on"></i>';
				txt += ' ' + detailInfo.likeCnt;

				$('.count .btn').html(txt);

			}else{ //좋아요 N

				var txt ="";

				txt += '<i title="좋아요 설정 안함" class="iconset ico-like"></i>';
				txt += ' '+ detailInfo.likeCnt;

				$('.count .btn').html(txt);

			}

			//댓글
			fn_moviePostRlySearch('search', moviePostNo, viewDiv);

			//무비포스트 상세 메타태그 설정
			fn_setMetaTag( detailInfo, moviePostNo, metaTagImg );

		}
	});
}

function fn_setMetaTag( detailInfo, moviePostNo, metaTagImg ){

	var attr	= "";
	if( moviePostNo != null && moviePostNo != '' )				attr = '?moviePostNo=' + moviePostNo;

	var url		= location.pathname + attr;
	if( detailPopup != null && detailPopup.backScreen != '' )	url  = '' + attr;

 	metaFormat = {
			'scnTitle'			: '(' + gfn_charToHtml(detailInfo.moviePostMovieTitle) + ') 무비포스트 상세 | MEET PLAY SHARE, 메가박스'
			, 'metaTagTitle'	: '(' + gfn_charToHtml(detailInfo.moviePostMovieTitle) + ') 무비포스트 상세'
			, 'metaTagDtls'		: '메가박스의 다양한 무비포스트를 확인해보세요.'
			, 'metaTagImg'		: metaTagImg
			, 'metaTagUrl'		: url
 	};

 	//URL 변경
 	history.replaceState( null, null, location.origin + url );

 	//메타태그 설정
 	settingMeta(metaFormat);
}
</script>

<!--################# 무비포스트 상세 레이어팝업으로 변경 ###########################  -->
	<section id="layer_post_detail" class="modal-layer2"><a href="" class="focus">레이어로 포커스 이동 됨</a>
				<div class="wrap">
					<header class="layer-header">
						<h3 class="tit">무비포스트 상세</h3>
					</header>

					<div class="layer-con">

						<div class="post-detail">
							<div class="tit-area mb30">
								<p class="tit">
								</p>

								<div class="direct-link">
									<a id="bokdLinkBtn" data-no="" href="" style="display: none;" title="">예매하기</a>
								</div>
							</div>

							
							<div class="user-post-box mb40">
								<div class="user-post-case">
									<!-- post-top-area -->
									<div class="post-top-area">
										
										<div class="user-info">
											<p class="photo">
												<img src="/resources/movie/img-P-MO-PO0101-user-img01.png" alt="userid80**님의 무비포스트">
											</p>

											<p class="user-id">
												<a href="" title="ID"></a>
											</p>

											<p class="user-write-time"></p>
										</div>
										

										<div class="btn-util">
											<!-- 구독하기 전 -->
											<button type="button" class="button x-small gray-line" id="subscribe"></button>
										</div>

										<!-- post-funtion -->
										<div class="post-funtion">
											<div class="wrapper">
												<button type="button" class="btn-alert mp">옵션보기</button>
												<!--
												유저 일때
												<div class="balloon-space user">

												작성자 일때
												<div class="balloon-space writer">
												-->
												<div class="balloon-space mpost">
													<div class="balloon-cont">

													</div>
												</div>
												<!--// 말풍선 -->
											</div>
										</div>
										<!--// post-funtion -->
									</div>
									<!--// post-top-area -->

									<div class="post-cont-area">
										<!-- post 내용  -->
										<div class="section-area">
										</div>
										<!--// post 내용 -->
									</div>

									<!-- comment count -->
									<div class="count">
										<button type="button" class="btn" arti-no="">
											<i title="좋아요 설정 안함" class="iconset ico-like"></i>
										</button>

									<!-- 코멘트 등록 영역으로 이동 -->

									</div>
									<!--// comment count -->



								</div>
							</div>
							

							<!-- share -->
							<div class="btn-post-share">
<!-- 								<button type="button" title="카카오톡 공유하기" class="btn kakao">카카오톡</button> -->
								<button type="button" title="페이스북 공유하기" class="btn face">페이스북</button>
								<button type="button" title="밴드 공유하기" class="btn band">밴드</button>
								<button type="button" title="트위터 공유하기" class="btn twitter">트위터</button>
								<button type="button" title="링크 공유하기" class="btn link">링크공유</button>
							</div>
							<!--// share -->

						<!-- comment input -->
				<div class="comment-write mb40" id="rly">
					<div class="comment-util mb20">
						<p><span id="rlyCnt">댓글 </span></p>
						<input type="hidden" id="rlyCntTop" value="">
						<input type="hidden" id="hdnMoviePostNo" value="">
					</div>

					<div class="comment" id="input-comment">
						<textarea class="input-textarea" cols="5" rows="5" id="postRlyCn" title="댓글 입력" name="postRlyCn" maxlength="100"></textarea>

						<div class="comment-function">
							<p class="reset"><span class="text-count">0</span> / 100</p>
							<div class="btn">
								<button type="button" id="btnPostRly">등록</button>
							</div>
						</div>
					</div>
				</div>
				<!--// comment input-->

				<!-- comment list -->
				<div class="comment-list" id="commentList">

				</div>
				<!--// comment list -->

				<div class="mb50"></div>

						</div>
					</div>
					<button type="button" class="btn-modal-close2">레이어 닫기</button>
				</div>
			</section>
			<!-- // ################# 무비포스트 상세 레이어팝업으로 변경 ###########################  -->
	<!-- //무비포스트 상세 레이어팝업 -->
</div>
<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="" class="focus">레이어로 포커스 이동 됨</a>
	<input type="hidden" id="isLogin">
	<div class="wrap">
		<header class="layer-header">
			<h3 class="tit">본 영화 등록</h3>
		</header>

		<div class="layer-con">
			<p class="reset">발권하신 티켓 하단의 거래번호 또는 예매번호를 입력해주세요.</p>

			<div class="pop-gray mt10 mb30">
				<label for="movie_regi" class="mr10">거래번호 또는 예매번호</label>
				<input type="text" id="movie_regi" class="input-text w280px numType" maxlength="20" placeholder="숫자만 입력해 주세요" title="티켓 거래번호 입력">
				<button class="button gray ml05" id="regBtn">등록</button>
			</div>

			<div class="box-border v1 mt30">
				<p class="tit-box">이용안내</p>

				<ul class="dot-list">
                        <li>극장에서 예매하신 내역을 본 영화(관람이력)로 등록하실 수 있습니다.</li>
                        <li>예매처를 통해 예매하신 고객님은 극장에서 발권하신 티켓 하단의 온라인 예매번호 <br>12자리를 입력해주세요.(Yes24, 네이버, 인터파크, SKT, KT, 다음)</li>
                        <li>본 영화 등록은 관람인원수 만큼 등록가능하며, 동일 계정에 중복등록은 불가합니다.</li>
                        <li>상영시간 종료 이후 등록 가능합니다.</li>
                        <li>본 영화로 수동 등록한 내역은 이벤트 참여 및 포인트 추후 적립이 불가합니다.</li>
				</ul>
			</div>
		</div>

		<div class="btn-group-fixed">
			<button type="button" class="button purple close-layer">닫기</button>
		</div>

		<button type="button" class="btn-modal-close">레이어 닫기</button>
	</div>
</section>

<div class="quick-area">
	<a href="" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>