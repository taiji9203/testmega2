<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<!--<div id="bodyContent"> -->
<script type="text/javascript">
var tabIdx = 1;

/* var tabTitle = [
	'박스오피스 < 영화 | MEET PLAY SHARE, 메가박스',
	'상영예정작 < 영화 | MEET PLAY SHARE, 메가박스',
	'필름소사이어티 < 영화 | MEET PLAY SHARE, 메가박스',
	'클래식소사이어티 < 영화 | MEET PLAY SHARE, 메가박스',
	'장르모아보기 < 영화 | MEET PLAY SHARE, 메가박스'
]; */

$(function() {
	// 검색 버튼
	$('#btnSearch').on('click', function() {
		/* if($('#ibxMovieNmSearch').val() == '')
			return gfn_alertMsgBox('영화명을 입력해주세요.');
		*/
		// 메타 테그 URL 설정
		$('#fbUrl').attr('content', fn_getMetaShareURL(tabIdx));
		$('#currentPage').val("1");
		fn_movieSerach();
	});

	// 검색 input enter key 이벤트
	$('#ibxMovieNmSearch').on('keydown', function(e) {
		if(e.keyCode == 13) {
			/* if($('#ibxMovieNmSearch').val() == '') gfn_alertMsgBox('영화명을 입력해주세요.');
			else fn_movieSerach(); */
			$('#currentPage').val("1");
			fn_movieSerach();
		}
	});

	// 더보기 버튼
	$('#btnAddMovie').on('click', function() {
		fn_movieSerach(true);
	});

	// 상단 탭 버튼
	/* $('#topMenu a').on('click', function(e) {

		/e.preventDefault();

		tabIdx = $(this).parent().index() + 1;

		// 메타 테그 URL 설정
		$('#fbUrl').attr('content', fn_getMetaShareURL(tabIdx));
		$('#ibxMovieNmSearch').val('');

		document.title = tabTitle[tabIdx - 1]; // 브라우저 타이틀 변경

		fn_init(); // 페이지 초기화
	}); */

	$('#ibxMovieNmSearch').val('');

	fn_init(); // 페이지 초기화
});

// 페이지 초기화
function fn_init() {
	$('.topSort').hide();

	/* if(tabIdx == 2) fn_playDueInit(); // 상영예정작
	else if(tabIdx == 3) fn_filmInit(); // 필름소사이어티
	else if(tabIdx == 4) fn_classicInit(); // 클래식소사이어티
	else if(tabIdx == 5) fn_myGenreInit(); // 장르모아보기
	else fn_boxOfficeInit(); // 박스오피스  */

	switch( tabIdx ){
	    case 2 : fn_playDueInit(); break;		// 상영예정작
	    case 3 : fn_special(); break;		// 특별상영
	    case 4 : fn_filmInit(); break;			// 필름소사이어티
	    case 5 : fn_classicInit(); break;		// 클래식소사이어티
	    case 6 : fn_myGenreInit(); break; 		// 장르모아보기
	    default   : fn_boxOfficeInit();	break;	// 박스오피스
    }


	$('#topMenu li.on').removeClass('on');
	$('#topMenu li').eq(tabIdx - 1).addClass('on'); // 상단 탭 활성화
};

// 메타테그 공유 URL 생성
function fn_getMetaShareURL(tabIdx) {
	var metaMenuIDAr = ['ON00000006', 'ON00000013', 'ON00000014', 'ON00000015', 'ON00000016'];
	var url = location.href + '?metaMenuId=' + metaMenuIDAr[tabIdx - 1];
	var serachText = $('#ibxMovieNmSearch').val();

	// 초기화가 아니고 검색어 존재시 설정
	if(serachText) url += '&searchText=' + serachText;

	return url;
};

// 정렬 대상 태그 활성화 및 가져오기
function fn_getSortTargetByShow() {
	var sortTarget = $('.topSort').eq(tabIdx - 1);
	sortTarget.show();

	return sortTarget;
};

// 개봉작만보기 버튼 이벤트
function fn_bindOnAirEvent() {
	var sortTarget = fn_getSortTargetByShow();

	// 개봉작만보기
	sortTarget.find('.btnOnAir').off().on('click', function() {
		var onairYn = $(this).attr('class').indexOf(' on') == -1 ? 'Y' : 'N';
		$('#onairYn').val(onairYn);
		$('#currentPage').val("1");
		fn_movieSerach(); // 영화목록 조회
	});
};

// 정렬버튼 이벤트
function fn_bindSortTabEvent() {
	var sortTarget = fn_getSortTargetByShow();

	// 정렬 버튼
	sortTarget.find('.sortTab button').off().on('click', function() {
		sortTarget.find('.sortTab button.on').removeClass('on');
		$(this).addClass('on');
		$('#pageType').val($(this).attr('sort-type'));
		$('#currentPage').val("1");
		fn_movieSerach(); // 영화목록 조회
	});
};

// 박스오피스 초기화
function fn_boxOfficeInit() {
	$('#onairYn').val('N');
	$('#specialType').val('');
	$('#pageType').val('ticketing');

	fn_movieSerach(); // 영화목록 조회
	fn_bindOnAirEvent(); // 개봉작만보기 버튼 이벤트
	fn_bindSortTabEvent(); // 정렬버튼 이벤트
};

// 상영예정작 초기화
function fn_playDueInit() {
	$('#specialType').val('');
	$('#onairYn').val('MSC02');
	$('#pageType').val('rfilmDe');

	fn_movieSerach(); // 영화목록 조회
	fn_bindSortTabEvent(); // 정렬버튼 이벤트
};

// 특별상영 초기화
function fn_special() {
	$('#onairYn').val('N');
	$('#specialType').val('');
	$('#pageType').val('ticketing');

	fn_movieSerach(); // 영화목록 조회
	fn_bindOnAirEvent(); // 개봉작만보기 버튼 이벤트
	fn_bindSortTabEvent(); // 정렬버튼 이벤트
};

// 필름소사이어티 초기화
function fn_filmInit() {
	$('#onairYn').val('N');
	$('#specialType').val('film');
	$('#pageType').val('ticketing');

	fn_movieSerach(); // 영화목록 조회
	fn_bindOnAirEvent(); // 개봉작만보기 버튼 이벤트
	fn_bindSortTabEvent(); // 정렬버튼 이벤트
};

// 클래식소사이어티 초기화
function fn_classicInit() {
	$('#onairYn').val('N');
	$('#specialType').val('classic');
	$('#pageType').val('ticketing');

	fn_movieSerach(); // 영화목록 조회
	fn_bindOnAirEvent(); // 개봉작만보기 버튼 이벤트
	fn_bindSortTabEvent(); // 정렬버튼 이벤트
};

// 장르모아보기 초기화
function fn_myGenreInit() {
	$('#onairYn').val('N');
	$('#pageType').val('ticketing');
	$('#specialType').val('myGenre');

	fn_movieSerach(); // 영화목록 조회
	fn_bindOnAirEvent(); // 개봉작만보기 버튼 이벤트
	fn_bindSortTabEvent(); // 정렬버튼 이벤트
};

// 영화목록 조회
function fn_movieSerach(paging) {
	var currentPage = paging ? parseInt($('#currentPage').val()) + 1 : $('#currentPage').val();

	gfn_logdingModal(); // 로딩바 호출

	// 특별상영 검색을 위해
	var specialYn = "N";

	if(tabIdx == "3"){
		specialYn = "Y";
	}

	$.ajaxMegaBox({
        url: '/on/oh/oha/Movie/selectMovieList.do',
		data: JSON.stringify({
			currentPage: currentPage + '',
			recordCountPerPage: $('#recordCountPerPage').val() + '',
			pageType: $('#pageType').val(),
			ibxMovieNmSearch: $('#ibxMovieNmSearch').val(),
			onairYn: $('#onairYn').val(),
			specialType: $('#specialType').val(),
			specialYn : specialYn

		}),
        success: function (d) {
        	var currentHeight = document.documentElement.scrollTop;

        	MegaboxUtil.Movie.setImgSvrUrl(d.imgSvrUrl); // 이미지 서버 URL 설정
			MegaboxUtil.Movie.createHtml(d.movieList, $('#movieList'), paging); // 영화 목록 생성

        	if(d.movieList.length > 0) {
				var totalCnt = d.movieList[0].totCnt;
        		var currentPage = d.movieList[0].currentPage;
				var recordCountPerPage = d.movieList[0].recordCountPerPage;
        		var pageNo = Math.ceil(totalCnt / recordCountPerPage);

				$('#noDataDiv').hide();
        		$('#noMyGenre').hide();
				$('#movieList').show();

				//현재페이지 설정되도록 수정
				$('#currentPage').val(currentPage);

				if(currentPage < pageNo) $('#addMovieDiv').show();
				else $('#addMovieDiv').hide();

				// 홈페이지 영화>전체영화 페이지 하단 ‘더보기’ 버튼 클릭 시 크롬에서만 확장된 목록의 가장 아래 화면이 보이는 부분 수정(익스는 정상)
				if (currentPage > 1) {
					$('html, body').animate({
						scrollTop: currentHeight
					}, 0);
				}
        	} else {
        		if (tabIdx == "6" && d.myGenreYn == "N") {
            		$('#noMyGenre').show();
        		} else {
            		$('#noDataDiv').show();
        		}

				$('#movieList').hide();
				$('#addMovieDiv').hide();
        	}

        	$('#totCnt').html(totalCnt || 0);

        	gfn_logdingModal(); // 로딩바 호출
        },
        error: function() {
        	gfn_logdingModal(); // 로딩바 호출
        }
    });
};
</script>

<input type="hidden" id="currentPage" name="currentPage" value="1">
<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="20">
<input type="hidden" id="pageType" name="pageType" value="ticketing">
<input type="hidden" id="onairYn" name="onairYn" value="N">
<input type="hidden" id="specialType" name="specialType" value="">

<!-- container -->
<div class="container">
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
                <a href="/movie/movie" title="영화 페이지로 이동">영화</a>
                <a href="/movie/movie" title="전체영화 페이지로 이동">전체영화</a>
			</div>

			
		</div>
	</div>

	<!-- contents -->
	<div id="contents">
		<!-- inner-wrap -->
		<div class="inner-wrap">
			<h2 class="tit">전체영화</h2>

			<div class="tab-list fixed">
				<ul id="topMenu">
					<li class="on"><a href="/movie/movie" title="박스오피스 탭으로 이동">박스오피스</a></li>
					<li><a href="#" title="상영예정작 탭으로 이동">상영예정작</a></li>
					<li><a href="#" title="특별상영 탭으로 이동">특별상영</a></li>
					<li><a href="#" title="필름소사이어티 탭으로 이동">필름소사이어티</a></li>
					<li><a href="#" title="클래식소사이어티 탭으로 이동">클래식소사이어티</a></li>
					
				</ul>
			</div>

			<!-- movie-list-util -->
			<div class="movie-list-util mt40">
				<!-- 박스오피스 -->
				<div class="topSort" style="display: block;">
					<div class="movie-sorting sortTab">
<!-- 						<span><button type="button" class="btn on" sort-type="ticketing">예매율순</button></span> -->
<!-- 						<span><button type="button" class="btn" sort-type="accmAdnc">누적관객순</button></span> -->
<!-- 						<span><button type="button" class="btn" sort-type="megaScore">메가스코어순</button></span> -->
					</div>

					<div class="onair-condition">
						<button type="button" title="개봉작만 보기" class="btn-onair btnOnAir">개봉작만</button>
					</div>
				</div>
				<!--// 박스오피스 -->

				<!-- 상영예정작 -->
				<div class="topSort" style="display: none;">
					<div class="movie-sorting sortTab">
						<span><button type="button" class="btn on" sort-type="rfilmDe">개봉일순</button></span>
						<span><button type="button" class="btn" sort-type="title">가나다순</button></span>
					</div>
				</div>
				<!--// 상영예정작 -->

				<!-- 특별상영 -->
				<div class="topSort" style="display: none;">
					<div class="onair-condition">
						<button type="button" title="개봉작만 보기" class="btn-onair btnOnAir">개봉작만</button>
					</div>
				</div>
				<!--// 특별상영 -->

				<!-- 필름소사이어티 -->
				<div class="topSort" style="display: none;">
					<div class="movie-sorting sortTab">
						<span><button type="button" class="btn on" sort-type="ticketing" tab-cd="">전체</button></span>
						
					</div>

					<div class="onair-condition">
						<button type="button" title="개봉작만 보기" class="btn-onair btnOnAir">개봉작만</button>
					</div>
				</div>
				<!--// 필름소사이어티 -->

				<!-- 클래식소사이어티 -->
				<div class="topSort" style="display: none;">
					<div class="movie-sorting sortTab">
						<span><button type="button" class="btn on" sort-type="ticketing" tab-cd="">전체</button></span>
						
					</div>

					<div class="onair-condition">
						<button type="button" title="개봉작만 보기" class="btn-onair btnOnAir">개봉작만</button>
					</div>
				</div>
				<!--// 클래식소사이어티 -->

				<!-- 장르모아보기 -->
				<div class="topSort" style="display: none;">
					<div class="movie-sorting sortTab">
						<span><button type="button" class="btn on" sort-type="ticketing">예매율순</button></span>
						<span><button type="button" class="btn" sort-type="accmAdnc">누적관객순</button></span>
						<span><button type="button" class="btn" sort-type="megaScore">메가스코어순</button></span>
					</div>

					<div class="onair-condition">
						<button type="button" title="개봉작만 보기" class="btn-onair btnOnAir">개봉작만</button>
					</div>
				</div>
				<!--// 장르모아보기 -->

				<!-- 검색결과 없을 때 -->
				<p class="no-result-count"><strong id="totCnt">95</strong>개의 영화가 검색되었습니다.</p>
				<!--// 검색결과 없을 때 -->

				<div class="movie-search">
					<input type="text" title="영화명을 입력하세요" id="ibxMovieNmSearch" name="ibxMovieNmSearch" placeholder="영화명 검색" class="input-text">
					<button type="button" class="btn-search-input" id="btnSearch">검색</button>
				</div>
			</div>
			<!--// movie-list-util -->

			<div class="bg-loading" style="display: none;">
				<div class="spinner-border" role="status">
					<span class="sr-only">Loading...</span>
				</div>
			</div>

			<!-- movie-list -->
			<div class="movie-list">
				<ol class="list" id="movieList"><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">1<span class="ir">위</span></p>    <img src="/resources/movie/ym0dktzCLlIcYSlKLVW6y39GYa1Vg04l_420.jpg" alt="타이타닉" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style=""><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style=""><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23004000" title="타이타닉 상세보기">            <div class="summary">"내 인생의 가장 큰 행운은 당신을 만난 거야"

우연한 기회로 티켓을 구해 타이타닉호에 올라탄 자유로운 영혼을 가진 화가 ‘잭’(레오나르도 디카프리오)은
막강한 재력의 약혼자와 함께 1등실에 승선한 ‘로즈’(케이트 윈슬렛)에게 한눈에 반한다.
진실한 사랑을 꿈꾸던 ‘로즈’ 또한 생애 처음 황홀한 감정에 휩싸이고, 둘은 운명 같은 사랑에 빠지는데…

가장 차가운 곳에서 피어난 뜨거운 사랑!
영원히 가라앉지 않는 세기의 사랑이 펼쳐진다!</div>            <div class="my-score equa" style="display: none;">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">0<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-15">,</p>    <p title="타이타닉" class="tit">타이타닉</p></div><div class="rate-date">    <span class="rate">예매율 35.6%</span>    <span class="date">개봉일 2023.02.08</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23004000"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>1.5k</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="">        <a href="#" class="button purple bokdBtn" data-no="23004000" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23004000"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23004000" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">2<span class="ir">위</span></p>    <img src="/resources/movie/whzCk46ejtIoWU1eavvF9lJ8rC2Wbvf7_420.jpg" alt="더 퍼스트 슬램덩크" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style=""><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style=""><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="22103500" title="더 퍼스트 슬램덩크 상세보기">            <div class="summary">전국 제패를 꿈꾸는 북산고 농구부 5인방의 꿈과 열정, 멈추지 않는 도전을 그린 영화</div>            <div class="my-score big">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">9.4<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-12">,</p>    <p title="더 퍼스트 슬램덩크" class="tit">더 퍼스트 슬램덩크</p></div><div class="rate-date">    <span class="rate">예매율 21.8%</span>    <span class="date">개봉일 2023.01.04</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="22103500"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>2.5k</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">1월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="">        <a href="#" class="button purple bokdBtn" data-no="22103500" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="22103500"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="22103500" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">3<span class="ir">위</span></p>    <img src="/resources/movie/9vUySe7DNMro6tdYRPEbjzF2ebr48MwE_420.jpg" alt="아바타: 물의 길" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style=""><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style=""><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="22029100" title="아바타: 물의 길 상세보기">            <div class="summary">&lt;아바타: 물의 길&gt;은 판도라 행성에서
'제이크 설리'와 '네이티리'가 이룬 가족이 겪게 되는 무자비한 위협과
살아남기 위해 떠나야 하는 긴 여정과 전투,
그리고 견뎌내야 할 상처에 대한 이야기를 그렸다.

월드와이드 역대 흥행 순위 1위를 기록한 전편 &lt;아바타&gt;에 이어
제임스 카메론 감독이 13년만에 선보이는 영화로,
샘 워싱턴, 조 샐다나, 시고니 위버, 스티븐 랭, 케이트 윈슬렛이 출연하고
존 랜도가 프로듀싱을 맡았다.</div>            <div class="my-score big">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">9.4<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-12">,</p>    <p title="아바타: 물의 길" class="tit">아바타: 물의 길</p></div><div class="rate-date">    <span class="rate">예매율 6.4%</span>    <span class="date">개봉일 2022.12.14</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="22029100"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>6.7k</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">12월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="">        <a href="#" class="button purple bokdBtn" data-no="22029100" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="22029100"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="22029100" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">4<span class="ir">위</span></p>    <img src="/resources/movie/WYpvrot3KxuIj3hVvnsRf7SGZDfDZgg4_420.jpg" alt="다음 소희" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style=""><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23000400" title="다음 소희 상세보기">            <div class="summary">“나 이제 사무직 여직원이다?”
춤을 좋아하는 씩씩한 열여덟 고등학생 소희.
졸업을 앞두고 현장실습을 나가게 되면서 점차 변하기 시작한다.

“막을 수 있었잖아. 근데 왜 보고만 있었냐고”
오랜만에 복직한 형사 유진.
사건을 조사하던 중, 새로운 사실을 발견하고 그 자취를 쫓는다.

같은 공간 다른 시간, 언젠가 마주쳤던 두 사람의 이야기.
우리는 모두 그 애를 만난 적이 있다.</div>            <div class="my-score big" style="display: none;">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">9.5<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-15">,</p>    <p title="다음 소희" class="tit">다음 소희</p></div><div class="rate-date">    <span class="rate">예매율 4.8%</span>    <span class="date">개봉일 2023.02.08</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23000400"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>232</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23000400" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23000400"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="23000400" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">5<span class="ir">위</span></p>    <img src="/resources/movie/l5Xk0admyRtAuzrBRuac8sv2usMPBnfX_420.jpg" alt="[10th REPLAY] 헤어질 결심" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23002500" title="[10th REPLAY] 헤어질 결심 상세보기">            <div class="summary">[제 10회 시네마 리플레이]

이동진 평론가와 필름 소사이어티가 선정한
2020-2022 좋은 영화 12편

★ 코엑스 지점에서는 영화 상영 후 이동진 평론가의 영화 토크가 이어집니다.
★ 동시상영 지점에서는 이동진 평론가의 토크가 없는 일반 영화 상영이 진행됩니다.
</div>            <div class="my-score equa" style="display: none;">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">0<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-15">,</p>    <p title="[10th REPLAY] 헤어질 결심" class="tit">[10th REPLAY] 헤어질 결심</p></div><div class="rate-date">    <span class="rate">예매율 2.6%</span>    <span class="date">개봉일 2023.02.19</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23002500"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>104</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23002500" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23002500"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="23002500" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">6<span class="ir">위</span></p>    <img src="/resources/movie/QU7FdcxjBTaHusZSFDeJO7Ti4SLaakYA_420.jpg" alt="바빌론" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style=""><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style=""><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23000500" title="바빌론 상세보기">            <div class="summary">"모든 순간이 영화가 되는 곳ㅡ'바빌론'"

황홀하면서도 위태로운 고대 도시, '바빌론'에 비유되던 할리우드.
'꿈' 하나만을 위해 모인 사람들이 이를 쟁취하기 위해 벌이는 강렬하면서도 매혹적인 이야기</div>            <div class="my-score big">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">8.3<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-19">,</p>    <p title="바빌론" class="tit">바빌론</p></div><div class="rate-date">    <span class="rate">예매율 2.2%</span>    <span class="date">개봉일 2023.02.01</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23000500"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>553</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="">        <a href="#" class="button purple bokdBtn" data-no="23000500" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23000500"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23000500" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">7<span class="ir">위</span></p>    <img src="/resources/movie/Sem462xlBQ5TL5JJOcK1UQMFjQcgtvgI_420.jpg" alt="[10th REPLAY] 에브리씽 에브리웨어 올 앳 원스" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23002200" title="[10th REPLAY] 에브리씽 에브리웨어 올 앳 원스 상세보기">            <div class="summary">[제 10회 시네마 리플레이]

이동진 평론가와 필름 소사이어티가 선정한
2020-2022 좋은 영화 12편

★ 코엑스 지점에서는 영화 상영 후 이동진 평론가의 영화 토크가 이어집니다.
★ 동시상영 지점에서는 이동진 평론가의 토크가 없는 일반 영화 상영이 진행됩니다.</div>            <div class="my-score equa" style="display: none;">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">0<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-15">,</p>    <p title="[10th REPLAY] 에브리씽 에브리웨어 올 앳 원스" class="tit">[10th REPLAY] 에브리씽 에브리웨어 올 앳 원스</p></div><div class="rate-date">    <span class="rate">예매율 1.9%</span>    <span class="date">개봉일 2023.02.12</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23002200"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>120</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23002200" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23002200"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="23002200" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">8<span class="ir">위</span></p>    <img src="/resources/movie/0YK4k2ufWV8fyX35OVrDmYXvwk06yHpR_420.jpg" alt="원 웨이" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23007900" title="원 웨이 상세보기">            <div class="summary">죽여라! 도망쳐라! 살고 싶다면!
돌아갈 수 없는 편도행 버스 안에서 벌어지는 숨막히는 긴장감!

마약 조직의 보스 '빅'의 돈과 마약을 훔쳐 달아난 '프레디'는 야간 버스에 탑승해 도망친다.
'빅'의 눈을 피해 도망갈 곳을 찾는 '프레디'는 친구인 '제이제이'와 아버지에게 전화를 걸며 도망칠 방법을 찾는다.
한편, 버스 안에는 집을 가출한 '레이첼'이 함께 탑승해 '프레디'에게 관심을 가지는데...
버스에서 내릴 수 없다면 목숨을 걸고 도망가야 한다.
과연, '프레디'는 무사히 버스에서 내려 가족을 만날 수 있을까?</div>            <div class="my-score equa" style="display: none;">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">0<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-15">,</p>    <p title="원 웨이" class="tit">원 웨이</p></div><div class="rate-date">    <span class="rate">예매율 1.9%</span>    <span class="date">개봉일 2023.02.09</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23007900"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>29</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23007900" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23007900"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="23007900" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">9<span class="ir">위</span></p>    <img src="/resources/movie/nQjdH9Lm0jufkqpnWS8XUrtEloSlhQ1P_420.jpg" alt="울프 하운드" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23007800" title="울프 하운드 상세보기">            <div class="summary">코드네임 ‘울프 하운드’
런던 폭격을 막기 위한 비밀 전투 실화

연합군의 전투비행단이 독일 전투기에 급습을 당한다.
홀로 적진에 추락한 파일럿은 독일군의 추격을 받고
런던 폭격의 일급 작전인 코드네임 ‘울프 하운드’를 알게 된다.
독일군 기지에 잠입해 포로로 잡힌 동료를 탈출시키고
폭격을 막기 위해 함께 지상전과 공중전을 벌이는데…

120분간의 논스톱 전쟁 액션을 만난다!</div>            <div class="my-score equa" style="display: none;">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">0<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-15">,</p>    <p title="울프 하운드" class="tit">울프 하운드</p></div><div class="rate-date">    <span class="rate">예매율 1.8%</span>    <span class="date">개봉일 2023.02.09</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23007800"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>46</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23007800" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23007800"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="23007800" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">10<span class="ir">위</span></p>    <img src="/resources/movie/intGSqw2gFJInt9iyFrRAxkWNBtCnYfk_420.jpg" alt="상견니" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23000200" title="상견니 상세보기">            <div class="summary">드라마의 스토리를 영화 버전으로 확장시킨
멀티버스 판타지 로맨스
완전히 새로운 세계관, 완전히 새로운 스토리의 &lt;상견니&gt;

2009년,
리쯔웨이와 황위쉬안은 밀크티 가게에서 우연히 재회한다.
처음 만났지만 마치 오래전부터 알고 있었던 것 같은 기시감과
묘한 설렘을 느끼는 두 사람.

이들은 사계절을 함께 보내며 가까워지고,
2010년의 마지막 날, 함께 새해를 맞이하며 연인이 된다.

2017년,
황위쉬안의 인생에 예상치 못한 변화가 생긴다. 해외 발령을 받게 된 것.
황위쉬안은 이 제안을 받아들이고 새로운 여정을 시작하지만
이 선택은 그녀의 미래를 바꿀 뿐만 아니라,
리쯔웨이와 모쥔제, 그리고 그녀가 아직 모르는 천윈루의 운명까지 뒤바꿔 놓는데…

이제, 이들은 수없이 뒤엉킨 타임라인 속에서 서로를 구하기 위해
낡은 테이프 속 들려오는 노래 ‘라스트 댄스’를 따라 달려가기 시작한다.</div>            <div class="my-score big">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">8.1<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-15">,</p>    <p title="상견니" class="tit">상견니</p></div><div class="rate-date">    <span class="rate">예매율 1.7%</span>    <span class="date">개봉일 2023.01.25</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23000200"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>2.1k</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">1월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23000200" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23000200"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="23000200" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">11<span class="ir">위</span></p>    <img src="/resources/movie/H5raSfICeSpI1ZSeYmFVBRvgPrkSBZwi_420.jpg" alt="영웅" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="22085800" title="영웅 상세보기">            <div class="summary">
어머니 ‘조마리아’(나문희)와 가족들을 남겨둔 채
고향을 떠나온 대한제국 의병대장 ‘안중근’(정성화).

동지들과 함께 네 번째 손가락을 자르는 단지동맹으로
조국 독립의 결의를 다진 안중근은
조선 침략의 원흉인 ‘이토 히로부미’를
3년 내에 처단하지 못하면 자결하기로 피로 맹세한다.

그 약속을 지키기 위해 블라디보스토크를 찾은 안중근.
오랜 동지 ‘우덕순’(조재윤), 명사수 ‘조도선’(배정남), 독립군 막내 ‘유동하’(이현우),
독립군을 보살피는 동지 ‘마진주’(박진주)와 함께 거사를 준비한다.

한편 자신의 정체를 감춘 채 이토 히로부미에게 접근해
적진 한복판에서 목숨을 걸고 정보를 수집하던 독립군의 정보원 ‘설희’(김고은)는
이토 히로부미가 곧 러시아와의 회담을 위해
하얼빈을 찾는다는 일급 기밀을 다급히 전한다.

드디어 1909년 10월 26일,
이날만을 기다리던 안중근은
하얼빈역에 도착한 이토 히로부미를 향해
주저 없이 방아쇠를 당긴다.
현장에서 체포된 그는 전쟁 포로가 아닌 살인의 죄목으로,
조선이 아닌 일본 법정에 서게 되는데…

누가 죄인인가, 누가 영웅인가!</div>            <div class="my-score big">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">9.2<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-12">,</p>    <p title="영웅" class="tit">영웅</p></div><div class="rate-date">    <span class="rate">예매율 1.3%</span>    <span class="date">개봉일 2022.12.21</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="22085800"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>2k</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">12월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="22085800" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="22085800"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="22085800" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">12<span class="ir">위</span></p>    <img src="/resources/movie/UmgxlJgwWqM6ueiP32rhQhr2Cpq2GA5P_420.jpg" alt="서치 2" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23003800" title="서치 2 상세보기">            <div class="summary">여행을 끝내고 월요일 귀국을 알린 엄마의 영상통화
그리고 마중 나간 딸
그러나 엄마가 사라졌다

경찰에 도움을 요청하지만, 결정적인 단서들이 나오지 않는 가운데
딸 ‘준’은 엄마의 흔적을 찾기 위해
엄마가 방문한 호텔의 CCTV, 같이 간 지인의 SNS, 
거리뷰 지도까지 온라인에 남아있는 모든 흔적을 검색하는데…

이번에는 딸이 사라진 엄마의 흔적을 검색하다!</div>            <div class="my-score equa" style="display: none;">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">0<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-12">,</p>    <p title="서치 2" class="tit">서치 2</p></div><div class="rate-date">    <span class="rate">예매율 1.3%</span>    <span class="date">개봉일 2023.02.22</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23003800"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>330</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23003800" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23003800"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="23003800" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">13<span class="ir">위</span></p>    <img src="/resources/movie/jaP2f1q8F51aGyRb804y51pU7pHe8mhV_420.jpg" alt="교섭" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="22102600" title="교섭 상세보기">            <div class="summary">“어떤 경우라도 희생자를 안 만드는 게 이 협상의 기조 아닙니까?”

분쟁지역 아프가니스탄에서 한국인들이 탈레반에게 납치되는 최악의 피랍사건이 발생한다.
교섭 전문이지만 아프가니스탄은 처음인 외교관 재호(황정민)가 현지로 향하고,
국정원 요원 대식(현빈)을 만난다.
원칙이 뚜렷한 외교관과 현지 사정에 능통한 국정원 요원.
입장도 방법도 다르지만, 두 사람은 인질을 살려야 한다는 목표를 향해 함께 나아간다.
살해 시한은 다가오고, 협상 상대, 조건 등이 시시각각 변하는 상황에서
교섭의 성공 가능성은 점점 희박해져 가는데...
</div>            <div class="my-score big">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">7.9<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-12">,</p>    <p title="교섭" class="tit">교섭</p></div><div class="rate-date">    <span class="rate">예매율 1.1%</span>    <span class="date">개봉일 2023.01.18</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="22102600"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>889</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">1월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="22102600" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="22102600"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="22102600" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">14<span class="ir">위</span></p>    <img src="/resources/movie/nrQUhgkUlGUzPCu81twxvZbDuXNi1AGQ_420.jpg" alt="극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="22100300" title="극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연 상세보기">            <div class="summary">[템페스트]의 서쪽에 위치한 [라자 소아국].
한때는 금 채굴로 번영했지만 지금은 번영의 그림자는 찾아볼 수조차 없고, 호수는 광산의 독에 오염되어 나라는 위기 상황에 처했다.
여왕 '토와'는 왕가에 대대로 전해 오는 왕관의 마력을 사용해 독을 제거하며 백성을 지키고 있었지만,
그 대가로 왕관에 걸려 있던 저주가 온몸에 퍼져 수명이 단축되고 있었다.
그러던 중, 템페스트에 갑자기 나타난 오거의 생존자 '히이로'.
베니마루 일행의 형님뻘이었다는 히이로는, 토와의 도움으로 살아남았던 것이었다.
자신을 구해 준 토와와 [라자 소아국]을 지키기 위해,
템페스트의 리무루에게 도움을 청하기 위해 온 히이로는 베니마루와 운명의 재회를 한다.
라자를 위기에서 구하기 위해, 그리고 토와에게 걸린 저주의 수수께끼를 풀기 위해,
리무루는 라자로 향하는데...... 그곳에는 놀라운 음모가 기다리고 있었다!</div>            <div class="my-score big">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">8.9<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-15">,</p>    <p title="극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연" class="tit">극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연</p></div><div class="rate-date">    <span class="rate">예매율 1.1%</span>    <span class="date">개봉일 2023.02.02</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="22100300"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>1k</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="22100300" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="22100300"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="22100300" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">15<span class="ir">위</span></p>    <img src="/resources/movie/vRDxzQ7BT5UZJSCxjBXTtxdbKA7eYktj_420.jpg" alt="오늘 밤, 세계에서 이 사랑이 사라진다 해도" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="22091200" title="오늘 밤, 세계에서 이 사랑이 사라진다 해도 상세보기">            <div class="summary">“카미야 토루에 대해 잊지 말 것”

자고 일어나면 전날의 기억을 잃는
‘선행성 기억상실증’에 걸린 소녀 ‘마오리’

“내일의 마오리도 내가 즐겁게 해줄 거야”

누구에게도 기억되지 않는
무색무취의 평범한 소년 ‘토루’

매일 밤 사랑이 사라지는 세계,
그럼에도 불구하고,
다음 날 서로를 향한 애틋한 고백을 반복하는
두 소년, 소녀의 가장 슬픈 청춘담</div>            <div class="my-score big">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">8.9<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-12">,</p>    <p title="오늘 밤, 세계에서 이 사랑이 사라진다 해도" class="tit">오늘 밤, 세계에서 이 사랑이 사라진다 해도</p></div><div class="rate-date">    <span class="rate">예매율 1%</span>    <span class="date">개봉일 2022.11.30</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="22091200"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>3.5k</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">11월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="22091200" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="22091200"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="22091200" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">16<span class="ir">위</span></p>    <img src="/resources/movie/R9Ampe0ZSlp43ijQqlmZzcUySIu9TTbJ_420.jpg" alt="어메이징 모리스" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="22101000" title="어메이징 모리스 상세보기">            <div class="summary">사기력 만렙 말하는 고양이 ‘모리스’와 친구들의 어메이징한 모험이 펼쳐진다!

신기한 능력으로 성공적인 사기 행각을 이어가던 모리스와 친구들!
4차원 소녀 ‘멜리시아’에게 정체가 탄로나 어쩔 수 없이 그녀를 도와 마을에 숨겨진 비밀을 찾아 나선 그들은
세상을 지배하려는 절대악 ‘쥐마왕’의 음모를 알아채지만 뜻하지 않은 위험에 처한다.
가까스로 잡혀있던 ‘복숭아’를 구해낸 모리스와 친구들은 마을에서 탈출을 시도하고,
멜리시아는 허당 피리꾼 ‘키이스’와 함께 쥐마왕에게 맞서기 위해 진짜 마술피리를 찾아나서는데..

쥐마왕의 정체는 과연 무엇?
그리고 모리스와 친구들은 무사히 마을에서 벗어날 수 있을 것인가?!</div>            <div class="my-score big" style="display: none;">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">9.3<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-all">,</p>    <p title="어메이징 모리스" class="tit">어메이징 모리스</p></div><div class="rate-date">    <span class="rate">예매율 1%</span>    <span class="date">개봉일 2023.02.15</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="22101000"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>162</span></button>    <p class="txt movieStat1" style="">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="22101000" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="22101000"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="22101000" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">17<span class="ir">위</span></p>    <img src="/resources/movie/MbxcpuwuUGAutqH9LNFvpsecv8iSZdB4_420.jpg" alt="유령" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="22103600" title="유령 상세보기">            <div class="summary">“유령에게 고함. 작전을 시작한다”

1933년, 일제강점기 경성. 항일조직 ‘흑색단’의 스파이인 ‘유령’이 비밀리에 활약하고 있다.
새로 부임한 경호대장 카이토는 ‘흑색단’의 총독 암살 시도를 막기 위해
조선총독부 내의 ‘유령’을 잡으려는 덫을 친다.
영문도 모른 채, ‘유령’으로 의심받고 벼랑 끝 외딴 호텔에 갇힌 용의자들.
총독부 통신과 감독관 쥰지, 암호문 기록 담당 차경, 정무총감 비서 유리코,
암호 해독 담당 천계장, 통신과 직원 백호. 이들에게 주어진 시간은 단 하루 뿐.
기필코 살아나가 동지들을 구하고 총독 암살 작전을 성공시켜야 하는 ‘유령’과
무사히 집으로 돌아가고 싶은 이들 사이, 의심과 경계는 점점 짙어지는데…

과연 ‘유령’은 작전에 성공할 수 있을 것인가?
“성공할 때까지 멈춰서는 안 된다”</div>            <div class="my-score big">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">8.1<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-15">,</p>    <p title="유령" class="tit">유령</p></div><div class="rate-date">    <span class="rate">예매율 0.9%</span>    <span class="date">개봉일 2023.01.18</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="22103600"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>756</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">1월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="22103600" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="22103600"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="22103600" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">18<span class="ir">위</span></p>    <img src="/resources/movie/t2ZSsHcOUt7xJZFDUvPVmqeu006Fe6uK_420.jpg" alt="궁지에 몰린 쥐는 치즈 꿈을 꾼다" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23000900" title="궁지에 몰린 쥐는 치즈 꿈을 꾼다 상세보기">            <div class="summary">예외가 되는 순간, 사랑은 시작된다

상대를 사랑하지 않아도 누구든 곁에 두고 싶은 ‘쿄이치’
자신을 사랑하지 않아도 그의 곁에 머무르고 싶은 ‘이마가세’

좋아해서 행복했고, 좋아해서 괴로웠던,
누군가를 아플 만큼 사랑해 본 사람들을 위한
가장 강렬한 사랑 이야기가 펼쳐진다.</div>            <div class="my-score equa" style="display: none;">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">0<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-19">,</p>    <p title="궁지에 몰린 쥐는 치즈 꿈을 꾼다" class="tit">궁지에 몰린 쥐는 치즈 꿈을 꾼다</p></div><div class="rate-date">    <span class="rate">예매율 0.9%</span>    <span class="date">개봉일 2023.02.08</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23000900"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>347</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23000900" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23000900"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="23000900" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">19<span class="ir">위</span></p>    <img src="/resources/movie/r5MlUQeDqOjzU8l0Oeg2JI8FXFaLHrtV_420.jpg" alt="[10th REPLAY] 매스" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23002100" title="[10th REPLAY] 매스 상세보기">            <div class="summary">[제 10회 시네마 리플레이]

이동진 평론가와 필름 소사이어티가 선정한
2020-2022 좋은 영화 12편

영화 상영 후 이동진 평론가의 영화 토크가 이어집니다.

영화명: &lt;매스&gt;
진행극장: 메가박스 코엑스
일정: 2/11(토) 15:00</div>            <div class="my-score equa" style="display: none;">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">0<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-12">,</p>    <p title="[10th REPLAY] 매스" class="tit">[10th REPLAY] 매스</p></div><div class="rate-date">    <span class="rate">예매율 0.8%</span>    <span class="date">개봉일 2023.02.11</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23002100"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>45</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23002100" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23002100"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="23002100" title="영화 예매하기">예매</a>    </div></div></li><li tabindex="0" class="no-img"><div class="movie-list-info">    <p class="rank" style="">20<span class="ir">위</span></p>    <img src="/resources/movie/DgDsqbEUW43hiGRphiVfF2Z03IZsjBGY_420.jpg" alt="[10th REPLAY] 레 미제라블" class="poster lozad" onerror="noImg(this)">    <div class="curation">        <p class="film" style="display: none">필름 소사이어티</p>        <p class="classic" style="display: none">클래식 소사이어티</p>    </div>    <div class="screen-type2">        <p name="dbcScrean" style="display: none"><img src="/resources/movie/mov_top_tag_db.png" alt="dolby"></p>        <p name="mxScreen" style="display: none"><img src="/resources/movie/mov_top_tag_mx.png" alt="mx"></p>    </div>    <div class="movie-score">        <a href="#" class="wrap movieBtn" data-no="23002300" title="[10th REPLAY] 레 미제라블 상세보기">            <div class="summary">[제 10회 시네마 리플레이]

이동진 평론가와 필름 소사이어티가 선정한
2020-2022 좋은 영화 12편

영화 상영 후 이동진 평론가의 영화 토크가 이어집니다.

영화명: &lt;레 미제라블&gt;
진행극장: 메가박스 코엑스
일정: 2/17(금) 19:30</div>            <div class="my-score equa" style="display: none;">                <div class="preview">                    <p class="tit">관람평</p>                    <p class="number">0<span class="ir">점</span></p>                </div>            </div>        </a>    </div></div><div class="tit-area">    <p class="movie-grade age-15">,</p>    <p title="[10th REPLAY] 레 미제라블" class="tit">[10th REPLAY] 레 미제라블</p></div><div class="rate-date">    <span class="rate">예매율 0.8%</span>    <span class="date">개봉일 2023.02.17</span></div><div class="btn-util">    <button type="button" class="button btn-like" data-no="23002300"><i title="보고싶어 안함" class="iconset ico-heart-toggle-gray intrstType"></i> <span>82</span></button>    <p class="txt movieStat1" style="display: none">상영예정</p>    <p class="txt movieStat2" style="display: none">2월 개봉예정</p>    <p class="txt movieStat5" style="display: none">개봉예정</p>    <p class="txt movieStat6" style="display: none">상영종료</p>    <div class="case col-2 movieStat3" style="display: none">        <a href="#" class="button purple bokdBtn" data-no="23002300" title="영화 예매하기">예매</a>        <a href="#" class="button purple img splBtn" data-no="23002300"><img src="/resources/movie/mov_list_db_btn.png" alt="dolby 버튼"></a>    </div>    <div class="case movieStat4" style="">        <a href="#" class="button purple bokdBtn" data-no="23002300" title="영화 예매하기">예매</a>    </div></div></li></ol>
			</div>
			<!--// movie-list -->

			<div class="btn-more v1" id="addMovieDiv" style="">
				<button type="button" class="btn" id="btnAddMovie">더보기 <i class="iconset ico-btn-more-arr"></i></button>
			</div>

			<!-- 검색결과 없을 때 -->
			<div class="movie-list-no-result" id="noDataDiv" style="display: none;">
				<p>현재 상영중인 영화가 없습니다.</p>
			</div>


			<!-- 검색결과 없을 때 -->
			<div class="movie-list-no-favor" id="noMyGenre" style="display: none;">
				<p>선호장르가 등록되지 않았습니다. 선호하시는 장르를 등록해보세요.</p>
				<div class="btn-group center">
						<a href="/mypage/additionalinfo" class="button large purple" title="선호장르설정하기 페이지로 이동">선호장르설정하기</a>
				</div>
			</div>


		</div>
	</div>
</div>
<!--// container -->
<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="/movie" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="/movie" class="btn-go-top" title="top">top</a>
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