<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header --

<!--<div id="bodyContent"> -->

<script type="text/javascript">
var localeCode = "kr";			   //한영 구분 코드
$(function(){
});

function fn_setMeta(scnDiv) {
	var paramData = null;

	if( scnDiv == undefined ){

		switch(tmpData.tabIndx){

		case 0: //영화별
			url = location.protocol + '//' + document.domain + '/booking/timetable';
			paramData = {
					'scnTitle'         : '영화별 상영시간표 < 상영시간표 | MEET PLAY SHARE, 메가박스'
					, 'metaTagTitle'   : '영화별상영시간표 < 상영시간표 | MEET PLAY SHARE, 메가박스'
					, 'metaTagDtls'    : '메가박스의 영화별 상영시간표를 알려드립니다.'
					, 'metaTagKeyword' : ''
					, 'metaTagUrl'     : url
				};
				break;

		case 1: //극장별
			url = location.protocol + '//' + document.domain + '/booking/timetable';
			paramData = {
					'scnTitle'         : '극장별 상영시간표 < 상영시간표 | MEET PLAY SHARE, 메가박스'
					, 'metaTagTitle'   : '극장별상영시간표 < 상영시간표 | MEET PLAY SHARE, 메가박스'
					, 'metaTagDtls'    : '메가박스의 극장별 상영시간표를 알려드립니다.'
					, 'metaTagKeyword' : ''
					, 'metaTagUrl'     : url
				};
				break;

		case 2: //특별관
			url = location.protocol + '//' + document.domain + '/booking/timetable';
			paramData = {
					'scnTitle'         : '특별관 상영시간표 < 상영시간표 | MEET PLAY SHARE, 메가박스'
					, 'metaTagTitle'   : '특별관상영시간표 < 상영시간표 | MEET PLAY SHARE, 메가박스'
					, 'metaTagDtls'    : '메가박스의 특별관 상영시간표를 알려드립니다.'
					, 'metaTagKeyword' : ''
					, 'metaTagUrl'     : url
				};
				break;
		}

	}else{
		url = location.protocol + '//' + document.domain + '/booking';
		paramData = {
				'scnTitle'         : '빠른예매 < 예매 | MEET PLAY SHARE, 메가박스'
				, 'metaTagTitle'   : '빠른예매 < 예매 | MEET PLAY SHARE, 메가박스'
				, 'metaTagDtls'    : '메가박스에서 영화를 간편하고 빠르게 예약해보세요.'
				, 'metaTagKeyword' : ''
				, 'metaTagUrl'     : url
			};
	}

	//이전버튼을 위한 현재 메타태그 정보 저장
	saveCurrentMeta();

	//URL 변경
	history.replaceState( null, null, url );

	//메타태그 설정
	settingMeta(paramData);
}



//좌석도로 파라메타 전달
function fn_setSmapParam(param) {

	NetfunnelChk.script("BOOK_STEP2",function(){

		//param : 좌석도 화면 구동에 필요한 상영스케줄번호
		//scnDiv : 네비게이션 표시를 위한 진입화면 구분 playTime : 예매 > 상영시간표, brch : 극장, spclBrch : 특별관
		var frameBokdMSeatBodyObj    = $('#frameBokdMSeat').get(0).contentWindow.document.body;	//좌석도 프레임 바디 오브젝트
		var framePayBookingBodyObj   = $('#framePayBooking').get(0).contentWindow.document.body;	//결제화면 프레임 바디 오브젝트
		var frameBokdMSeatContentObj = $('#frameBokdMSeat').get(0).contentWindow;
		var innerHtml = "<span>Home</span>";
		var smapPlaySchdlNo = param[0];
		var scnDiv = param[1];
		var brchNo = param[2];

		fn_setMeta(scnDiv);

		if("default" == scnDiv){
			innerHtml += "<a href=\"/booking\" title=\"/예매 페이지로 이동\">예매</a>";
			innerHtml += "<a href=\"/booking\" title=\"/빠른예매 페이지로 이동\">빠른예매</a>";
		}
		else if("playTime" == scnDiv){
			innerHtml += "<a href=\"/booking\" title=\"/예매 페이지로 이동\">예매</a>";
			innerHtml += "<a href=\"/booking/timetable\" title=\"/상영시간표 페이지로 이동\">상영시간표</a>";
		}
		else if("brch" == scnDiv){
			innerHtml += "<a href=\"/theater/list\" title=\"/극장 페이지로 이동\">극장</a>";
			innerHtml += "<a href=\"/theater/list\" title=\"/예매 페이지로 이동\">전체극장</a>";
			innerHtml += "<a href=\"\" title=\"/극장정보\">극장정보</a>";
		}
		else if("TBQ" == scnDiv){
			innerHtml += "<a href=\"/theater/list\" title=\"/극장 페이지로 이동\">극장</a>";
			innerHtml += "<a href=\"/on/oh/ohc/BrchSpecial/mainPage.do\" title=\"/특별관 페이지로 이동\">특별관</a>";
			innerHtml += "<a href=\"/on/oh/ohc/BrchSpecial/boutqInfoPage.do\" title=\"/부티크 페이지로 이동\">부티크</a>";
		}
		else if("MX" == scnDiv){
			innerHtml += "<a href=\"/theater/list\" title=\"/극장 페이지로 이동\">극장</a>";
			innerHtml += "<a href=\"/on/oh/ohc/BrchSpecial/mainPage.do\" title=\"/특별관 페이지로 이동\">특별관</a>";
			innerHtml += "<a href=\"/on/oh/ohc/BrchSpecial/mxInfoPage.do\" title=\"/MX 페이지로 이동\">MX</a>";
		}
		else if("CFT" == scnDiv){
			innerHtml += "<a href=\"/theater/list\" title=\"/극장 페이지로 이동\">극장</a>";
			innerHtml += "<a href=\"/on/oh/ohc/BrchSpecial/mainPage.do\" title=\"/특별관 페이지로 이동\">특별관</a>";
			innerHtml += "<a href=\"/on/oh/ohc/BrchSpecial/comfortInfoPage.do\" title=\"/COMFORT 페이지로 이동\">COMFORT</a>";
		}
		else if("MKB" == scnDiv){
			innerHtml += "<a href=\"/theater/list\" title=\"/극장 페이지로 이동\">극장</a>";
			innerHtml += "<a href=\"/on/oh/ohc/BrchSpecial/mainPage.do\" title=\"/특별관 페이지로 이동\">특별관</a>";
			innerHtml += "<a href=\"/on/oh/ohc/BrchSpecial/kidsInfoPage.do\" title=\"/MEGABOX KIDS 페이지로 이동\">MEGABOX KIDS</a>";
		}
		else if("TFC" == scnDiv){
			innerHtml +="<a href=\"/theater/list\" title=\"/극장 페이지로 이동\">극장</a>";
			innerHtml +="<a href=\"/on/oh/ohc/BrchSpecial/mainPage.do\" title=\"/특별관 페이지로 이동\">특별관</a>";
			innerHtml +="<a href=\"/on/oh/ohc/BrchSpecial/firstClubInfoPage.do\" title=\"/THE FIRST CLUB 페이지로 이동\">THE FIRST CLUB</a>";
		}
		else if("BCY" == scnDiv){
			innerHtml +="<a href=\"/theater/list\" title=\"/극장 페이지로 이동\">극장</a>";
			innerHtml +="<a href=\"/on/oh/ohc/BrchSpecial/mainPage.do\" title=\"/특별관 페이지로 이동\">특별관</a>";
			innerHtml +="<a href=\"/on/oh/ohc/BrchSpecial/balconyInfoPage.do\" title=\"/BALCONY 페이지로 이동\">BALCONY</a>";
		}

		$('#bokdContainer .inner-wrap .location').html(innerHtml);	//네비게이션 표시
		$(frameBokdMSeatBodyObj).find(".quick-reserve h2").html('');	//좌석도 타이틀 숨김
		$(framePayBookingBodyObj).find(".quick-reserve h2").html('');	//결제   타이틀 숨김

		$('#bokdContainer').show();		//좌석도, 결제 컨테이너 보임
		$('#schdlContainer').hide();	//상영시간표 컨테이너 숨김
		$('#bokdMSeat').show();			//좌석도 보임
		$(frameBokdMSeatBodyObj).find('#playSchdlNo').val(smapPlaySchdlNo);
		$(frameBokdMSeatBodyObj).find('#brchNo').val(brchNo);
		frameBokdMSeatContentObj.fn_search();	//좌석도 좌석조회

	// 	$('#frameBokdMSeat').attr('src','/on/oh/ohz/PcntSeatChoi/selectPcntSeatChoi.do?playSchdlNo='+obj.attr("play-schdl-no"));
	// 	$('#frameBokdMSeat').attr('src','/main');
	});
}

//좌석도에서 이전 버튼 클릭
function fn_goPrePagePcntSeatChoi() {
	var frameBokdMSeatContentObj = $('#frameBokdMSeat').get(0).contentWindow;
	$('#bokdContainer').hide();		//좌석도, 결제 컨테이너 보임
	$('#schdlContainer').show();	//상영시간표 컨테이너 숨김

	//결제에서 예매이동 처리 추가
	$('#bokdMSeat').hide();			//좌석도 숨김
	$('#bokdMPayBooking').hide();
	$('#frameBokdMSeat').attr("src", "/on/oh/ohz/PcntSeatChoi/selectPcntSeatChoi.do"); //좌석도 화면초기화
	$('#framePayBooking').attr("src", "/on/oh/ohz/PayBooking/completeSeat.do"); //결제화면 초기화

	//이전 메타태그 정보로 설정 (preMetaFormat:전역변수)
	settingMeta(preMetaFormat);
	//URL 변경
	history.replaceState( null, null, preMetaFormat.metaTagUrl );
}

//좌석도에서 다음 버튼 클릭
function fn_goNextPagePcntSeatChoi(param) {
	//로그인 여부 체크
	fn_validLoginAt(param);
	//데이터 보정 체크
	//fn_validLoginAt();
	//오입력 체크
	//블랙리스트 체크
	//결제로이동
}


//결제화면으로로 파라메타 전달 및 화면 이동
function fn_setBookingParamMove(options) {

	NetfunnelChk.script("BOOK_STEP3",function(){

		var framePayBookingBodyObj    = $('#framePayBooking').get(0).contentWindow.document.body;	//결제화면 프레임 바디 오브젝트
		var framePayBookingContentObj = $('#framePayBooking').get(0).contentWindow;

		//좌석도에서 세팅한 param 값
		var playSchdlNo   = options.playSchdlNo;	//상영스케쥴
		var seatOccupText = options.seatOccupText;	//좌석/티켓 상세정보
		var totalAmt      = options.totalAmt;		//총금액

		$(framePayBookingBodyObj).find('#playSchdlNo').val(playSchdlNo);
		$(framePayBookingBodyObj).find('#seatOccupText').val(seatOccupText);
		$(framePayBookingBodyObj).find('#totalAmt').val(totalAmt);

		framePayBookingContentObj.completeSeat();
		$('#bokdMPayBooking').show();
		//프레임 높이 자동 조정
		calcFrameHeight($('#bokdMPayBooking'), $('#framePayBooking'));

		$('#bokdMSeat').hide();  //좌석도 숨김

	});
}

//결제화면에서 이전 버튼 클릭
function fn_goPrePagePayBooking() {
	var framePayBookingContentObj = $('#framePayBooking').get(0).contentWindow;
	var frameBokdMSeatContentObj = $('#frameBokdMSeat').get(0).contentWindow;
	$('#bokdMPayBooking').hide();
	$('#framePayBooking').attr("src", "/on/oh/ohz/PayBooking/completeSeat.do"); //결제화면 초기화
	$('#bokdMSeat').show();	//좌석도 표시
	$("html,body").scrollTop(0);

	frameBokdMSeatContentObj.fn_display_init();
}

//결제화면에서 이전 버튼 클릭 및 블랙리스트 팝업
function fn_altBlackgoPrePagePayBooking(blackListParam) {
	var framePayBookingContentObj = $('#framePayBooking').get(0).contentWindow;
	var frameBokdMSeatContentObj = $('#frameBokdMSeat').get(0).contentWindow;
	$('#bokdMPayBooking').hide();
	$('#framePayBooking').attr("src", "/on/oh/ohz/PayBooking/completeSeat.do"); //결제화면 초기화
	$('#bokdMSeat').show();	//좌석도 표시
	$("html,body").scrollTop(0);

	frameBokdMSeatContentObj.fn_display_init();

	frameBokdMSeatContentObj.shwoBlackListPopup(blackListParam);
}

//결제화면에서 오류 발생시 좌석도로 이동(기선점 존재, 시간 초과 등)
function fn_goPrePageInitSeat(msg) {
	var framePayBookingContentObj = $('#framePayBooking').get(0).contentWindow;
	$('#bokdMPayBooking').hide();
	$('#framePayBooking').attr("src", "/on/oh/ohz/PayBooking/completeSeat.do"); //결제화면 초기화

	//좌석도 초기화
	var frameBokdMSeatContentObj = $('#frameBokdMSeat').get(0).contentWindow;
	frameBokdMSeatContentObj.fn_search('N');  //새로 조회 및 최초진입 팝업 띄우지 않음
	$('#bokdMSeat').show();	//좌석도 표시
	$("html,body").scrollTop(0);

	if (msg != null && msg != "") {
		gfn_alertMsgBox("결제가능 시간이 초과되어<br/> 좌석선택부터 다시 진행바랍니다.");
	}

	frameBokdMSeatContentObj.fn_display_init();
}

//프레임 height 자동조정 : 결제만 적용가능
function calcFrameHeight(divObj, frameObj) { //div obj, frame obj
	var frameBodyObj = $(frameObj).get(0).contentWindow.document.body;	//프레임 바디 오브젝트
	var height = $(frameObj).contents().find('.inner-wrap').outerHeight();
	$(divObj).height(height + 130);
	$(frameObj).height(height + 130);
}

//로그인여부 체크
function fn_validLoginAt(param){
	$.ajaxMegaBox({
        url    : "/on/oh/ohg/MbLogin/selectLoginSession.do",
        //data   : JSON.stringify(paramData),
        success: function(result){
        	var loginAt = result.resultMap.result;	//로그인 여부

        	//비로그인 상태
			if(loginAt  == "N"){
				//로그인 팝업 표시
				fn_viewLoginPopup('SimpleBokdM','pc','Y',JSON.stringify(param));
			}
        	//로그인 상태
			else {
				//데이터 보정 체크
				fn_validDataRevisn(param);
			}
        }
    });
}

//데이터 보정 체크
function fn_validDataRevisn(param){

	fn_vlaidBlackList(param);

// 	$.ajaxMegaBox({
//         url    : "/on/oh/ohg/MbLogin/selectDataRevisn.do",
//         //data   : JSON.stringify(paramData),
//         success: function(result){
//         	var dataRevisnAt = result.resultMap.result;	//로그인 여부
//         	//자료보정대상
// 			if(dataRevisnAt  == "Y"){
// 				//자료 보정 안내 메세지 표시
// 				var arguments=result.resultMap.birthDe+' / '+result.resultMap.mblpTelno;
// 				var frameBokdMSeatContentObj = $('#frameBokdMSeat').get(0).contentWindow;	//좌석도 프레임 컨텐츠 오브젝트
// 				frameBokdMSeatContentObj.shwoDataRevisnPopup(arguments,param);
//  			}
//  			//자료보정대상아님
//  			else {
//  				//블랙리스트 체크
// 				fn_vlaidBlackList(param);
//  			}
//         }
//     });
}

//블랙리스트 체크
function fn_vlaidBlackList(param){


	var paramData = { BokdCnt : param.bokdCnt
					, BokdBrch : param.brchNo
					};

// 	//좌석수 param
	$.ajaxMegaBox({
        url    : "/on/oh/ohg/MbLogin/selectBlackList.do",
        data   : JSON.stringify(paramData),
        success: function(result){
        	var dataBlackListAt = result.resultMap.result;
        	//블랙리스트 대상
			if(dataBlackListAt  == "Y"){
				//블랙리스트 안내 메세지 표시
				var frameBokdMSeatContentObj = $('#frameBokdMSeat').get(0).contentWindow;
				var blackListParam = { bokdAbleBrch: result.resultMap.bokdAbleBrch
									, bokdAbleCnt: result.resultMap.bokdAbleCnt
									, bokdAbleQty: result.resultMap.bokdAbleQty
									 }
				frameBokdMSeatContentObj.shwoBlackListPopup(blackListParam);
			}
			//블랙리스트 비 대상
			else {
				//결제로 이동
 				fn_setBookingParamMove(param);
			}
        }
    });
}

//페이지 이동
function fn_mvPage(page){
	$("#bokdMForm").attr("method","post");
	$("#bokdMForm").attr("action",page);
	$("#bokdMForm").submit();
}

//언어변환
function setLangChg(){
    if(localeCode == "en"){
        location.href="/booking?megaboxLanguage=kr";
    }
    else {
        location.href="/booking?megaboxLanguage=en";
    }
}


//페이지 리로드
function fn_bokdReload(page){
	fn_goPrePagePcntSeatChoi();
}

</script>
<form id="bokdMForm">
	<input type="hidden" name="returnURL" value="info">
</form>
<!-- container -->
<div id="bokdContainer" class="container" style="padding-bottom:200px; display:none">
<input type="hidden" id="playDe" name="playDe" value="">
    <div class="page-util">
        <div class="inner-wrap">
            <div class="location"></div>

        </div>
    </div>

    <div id="bokdMSeat" style="overflow:hidden; display:none; height:736px;">
        <iframe id="frameBokdMSeat" src="./timetable_files/selectPcntSeatChoi.html" title="관람인원선택 프레임" scrolling="no" frameborder="0" class="reserve-iframe" style="width:100%; height:736px;"></iframe>
	</div>

    <div id="bokdMPayBooking" style="overflow:hidden; display:none; height:736px;">
       <iframe id="framePayBooking" src="./timetable_files/completeSeat.html" title="예매 결제" scrolling="no" frameborder="0" class="reserve-iframe" style="width:100%; height:736px;"></iframe>
	</div>

</div>
<!--// container -->
<script src="./timetable_files/megabox-brch.js"></script>
<script src="./timetable_files/megabox-simpleBokd.js"></script>
<script src="./timetable_files/jquery.mCustomScrollbar.concat.min.js"></script>

<script type="text/javascript">

	var arrList = new Array();
	var tmpData = {tabIndx : 0};
	var tabChangeAt = 'N';	//상영일 초기화 여부

	$(function(){

		$(document).ready(function() {
			areaList();
		});

		// 항목 클릭
		$('#contents').on('click', '.tab-left-area li', function() {
			tmpData.tabIndx = $('#contents .tab-left-area li').index(this);
			tabChangeAt = "Y";	//상영일 초기화 여부

			if ($('#contents .tab-area').eq(tmpData.tabIndx).find('button.on').length == 0) {
				$('#contents .tab-area').eq(tmpData.tabIndx).find('button:first').click();
			} else {
				$('#contents .tab-area').eq(tmpData.tabIndx).find('.tab-list-choice a.on').click();
			}

			fn_setMeta();
		});

		// 항목별 분류 클릭
		$('#contents').on('click', '.tab-list-choice li', function() {
			var idx = $('#contents .tab-list-choice li').index(this);

			if ($('.tab-layer-cont').eq(idx).find('button.on').length != 0) {
				$('.tab-layer-cont').eq(idx).find('button.on').click();
			}

			if (idx == 0 && $('.tab-layer-cont').eq(idx).find('button.on').length == 0) {
				$('.tab-layer-cont').eq(idx).find('button:first').click();
			}
		});

		// 영화명, 극장명 클릭
		$('#contents').on('click', '.list-section button', function() {
			var leftIdx = $('#contents .tab-left-area li.on').index();
			if(leftIdx > 0 && leftIdx < 3)	tabChangeAt = "Y";	//상영일 초기화 여부

			var $this = $(this);
			var paramData = {};
			var option    = {movieObj  : $('#contents h3:last'), list : arrList, movieData : paramData, tabChangeAt:tabChangeAt};

			// 상영 시간표명 변경
			$('#contents .font-green').html($this.text());

			// 영화별 - 영화 포스터 설정
			if (tmpData.tabIndx == 0) {
				var imgAttr = {src  : $this.data('imgPath'), alt : $this.data('movieNm')};
				var lnkAttr = {href : '/movie-detail?rpstMovieNo='+ $this.data('movieNo'), title : $.parseHTML(String($this.data('movieNm')))[0].textContent +' 상세보기'};

				$('div.poster-section div.td').html($('<a>').attr(lnkAttr));
				$('div.poster-section div.td a').html($('<img class="poster" onerror="noImg(this, \'del\')"/>').attr(imgAttr));
			}

			// 값 설정
			switch(tmpData.tabIndx) {
			case 0 : //영화별
				paramData.masterType  = 'movie';
				paramData.movieNo     = $this.data('movieNo');
				break;

			case 1 : //극장별
				paramData.masterType  = 'brch';
				paramData.detailType  = 'area';
				paramData.brchNo      = $this.data('brchNo');
				break;

			case 2 : //특별관
				paramData.masterType  = 'brch';
				paramData.detailType  = 'spcl';
				paramData.theabKindCd = $this.data('areaCd');
				paramData.brchNo      = $this.data('brchNo');
				break;
			}
			MegaboxUtil.Brch.init(option);
			tabChangeAt = "N";
		});
	});

	// 영화관 조회
	function areaList() {

		gfn_logdingModal();

		var paramData = { playDe : '20230207'};

		$.ajaxMegaBox({
			url    : '/on/oh/ohb/PlayTime/selectPlayTimeMasterList.do',
			data   : JSON.stringify(paramData),

			success: function (data, textStatus   , jqXHR) {
				fn_movieListUpt(data.movieList    , 'all' );
				fn_movieListUpt(data.crtnMovieList, 'crtn');
				fn_brchListUpt(data.areaBrchList  , 'area');
				fn_brchListUpt(data.spclbBrchList , 'spcl');

				$('#contents .tab-left-area li:first').click();

				gfn_logdingModal();
			}
		});
	}

	// 영화목록 갱신
	function fn_movieListUpt(list,type){

		var arr = [];
		var $button, $li;

		$.each(list, function(i, param) {

			// 클릭변경
			param.disabled = (param.formAt != 'Y')? 'disabled' : '';

			// 객체
			$button = $('<button type="button" class="btn '+ param.disabled +'">');
			arr.push($('<li>').html($button));

			// 영화이미지
			param.movieImgPath = '' + nvl(param.movieImgPath).posterFormat('_316');

			// 버튼정보
			$button.attr({'data-movie-nm' : param.movieNm
						, 'data-movie-no' : param.movieNo
						, 'data-img-path' : param.movieImgPath}).html(param.movieNm);
		});

		switch(type) {
		case 'all' : $('#masterMovie_AllMovie  .list').html(arr); break;
		default    : $('#masterMovie_CrtnMovie .list').html(arr);
		}
	}

	// 극장정보 갱신
	function fn_brchListUpt(list, type){

		var $div, $li, areaCd;

		var areaList = [];
		var brchList = [];

		var html  = '<div class="theater-section">';
			html += '	<div class="table">';
			html += '		<div class="td">';
			html += '			<a href="#1" title="#2 특별관 페이지로 이동">';
			html += '				<p><strong>#2</strong>#3</p>';
			html += '				<i class="iconset ico-arrow-half"></i>';
			html += '				<img src="#4" alt="#2 특별관 페이지로 이동" class="poster">';
			html += '			</a>';
			html += '		</div>';
			html += '	</div>';
			html += '</div>';

		$.each(list, function(i, param) {

			if (areaCd != param.areaCd) {

				areaCd = param.areaCd;

				var titleTxt = "";
				if(type == 'spcl') {
					titleTxt ="특별관 선택";
				}
				else {
					titleTxt ="지점 선택";
				}

				// 객채 설정
				$li  = $('<li><a href="#tab'+areaCd+'" title="'+param.areaCdNm+titleTxt+'" data-area-cd="'+ areaCd +'">'+ param.areaCdNm +'</a></li>');
				$div = $('<div id="tab'+ areaCd +'" class="tab-layer-cont"><div class="scroll m-scroll"><ul class="list"></ul><div></div>');

				// 첫번째 객체
				if (i == 0) {
					$div.addClass('on');
					$li.find('a').addClass('on');
				}

				// 특별관여부
				if(type == 'spcl') {

					switch(areaCd) {

					case 'MX' :
						param.curAreaCdNm  = "MX";
						param.welComeHtml  = "진정한 영화 사운드를 통한<br />최고의 영화! <br />메가박스의 차세대 <br />표준 상영관";
						param.splcBrchLink = "/specialtheater/mx";
						param.imgUrl       = '/static/pc/images/reserve/img-theater-mx.png';
						break;
					case 'CFT' :
						param.curAreaCdNm  = "COMFORT";
						param.welComeHtml  = "더욱 편안한 영화 관람을<br />위한 다양한 여유 공간";
						param.splcBrchLink = "/specialtheater/comfort";
						param.imgUrl       = '/static/pc/images/reserve/img-theater-comfort.png';
						break;
					case 'TBQ' :
						param.curAreaCdNm  = "THE BOUTIQUE";
						param.welComeHtml  = "영화를 본다는 것,<br />그 놀라운 경험을 위하여";
						param.splcBrchLink = "/specialtheater/boutique";
						param.imgUrl       = '/static/pc/images/reserve/img-theater-boutique.png';
						break;
					case 'MKB' :
						param.curAreaCdNm  = "MEGA KIDS";
						param.welComeHtml  = "아이와 가족이 함께 머물며<br />삶의 소중한 가치를 배우는<br />더 행복한 놀이공간";
						param.splcBrchLink = "/specialtheater/megakids";
						param.imgUrl       = '/static/pc/images/reserve/img-theater-kids.png';
						break;
					case 'BCY' :
						param.curAreaCdNm  = "BALCONY";
						param.welComeHtml  = "CINEMA IN CINEMA,<br />영화관 속<br />나만의 개인 영화관";
						param.imgFileNm    = "balcony";
						param.splcBrchLink = "/specialtheater/balcony";
						param.imgUrl       = '/static/pc/images/reserve/img-theater-balcony.png';
						break;
					case 'TFC' :
						param.curAreaCdNm  = "THE FIRST CLUB";
						param.welComeHtml  = "특별한 날,<br />특별한 당신을 위한<br />단 하나의<br />THE FIRST CLUB";
						param.splcBrchLink = "/specialtheater/firstclub";
						param.imgUrl       = '/static/pc/images/reserve/img-theater-firstclub.png';
						break;
					case 'DBC' :
						param.curAreaCdNm  = "DOLBY";
						param.welComeHtml  = "국내 최초로 메가박스가 <br />선보이는 세계 최고 <br />기술력의 몰입 시네마";
						param.splcBrchLink = "/specialtheater/dolby";
						param.imgUrl       = '/static/pc/images/reserve/img-theater-dolby.png';
						break;
					case 'PTC' :
						param.curAreaCdNm 	= "PUPPY CINEMA";
						param.welComeHtml 	= "최초의 반려동물 동반 <br />멀티플렉스 <br />영화관람은 물론 <br />다양한 부대시설까지";
						param.splcBrchLink	= "/specialtheater/puppy";
						param.imgUrl		= '/static/pc/images/reserve/img-theater-puppycinema.png';
						break;
					}

					// 특별관 이미지등록
					$div.append(html.replace('#1', param.splcBrchLink).replaceAll('#2', param.curAreaCdNm).replace('#3', param.welComeHtml).replace('#4', param.imgUrl));

				} else {
					arrList.push({areaCd : areaCd , areaNm : param.areaCdNm});
				}

				areaList.push($li);
				brchList.push($div);
			}

			// 극장추가
			$div.find('ul').append('<li><button type="button" class="btn" data-area-cd="'+ areaCd +'" data-brch-no="'+ param.brchNo +'">'+ param.brchNm +'</button></li>');

			// 극장상태 추가
			if (param.brchOnlineExpoAt == 'Y') {
				switch(param.brchOnlineExpoStatCd) {
				case 'OES01' : $div.find('button:last').append('&nbsp;<i class="iconset ico-theater-new"></i>'    ); break;
				case 'OES02' : $div.find('button:last').append('&nbsp;<i class="iconset ico-theater-renewal"></i>'); break;
				case 'OES03' : $div.find('button:last').append('&nbsp;<i class="iconset ico-theater-open"></i>'   ); break;
				case 'OES04' : $div.find('button:last').append('&nbsp;<i class="iconset ico-theater-open"></i>'   ); break;
				}
			}
		});

		// 극장 갯수 설정
		$.each(areaList, function(i, data) {
			data.find('a').append('('+ brchList[i].find('li').length +')');
		});

		switch(type) {
		case 'area' :
			$('#masterBrch .list-section').html(brchList);
			$('#masterBrch .tab-list-choice ul').html(areaList);
			break;
		default     :
			$('#masterSpclBrch .list-section').html(brchList);
			$('#masterSpclBrch .tab-list-choice ul').html(areaList);
			$('div.m-scroll').mCustomScrollbar();	//스크롤 기능 추가
		}
	}

</script>

<div id="schdlContainer" class="container">
	<input type="hidden" id="playDe" name="playDe" value="">
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
				<a href="/booking" title="예매 페이지로 이동">예매</a>
				<a href="/booking/timetable" title="상영시간표 페이지로 이동">상영시간표</a>
			</div>
			
		</div>
	</div>

	<div id="contents">
		<div class="inner-wrap">
			<div class="time-table-page">
				<div class="movie-choice-area">
					<div class="tab-left-area">
						<ul>
							<li class="on"><a href="/booking/timetable#masterMovie" title="영화별 선택" class="btn"><i class="iconset ico-tab-movie"></i> 영화별</a></li>
							<li><a href="/booking/timetable#masterBrch" title="극장별 선택" class="btn"><i class="iconset ico-tab-theater"></i> 극장별</a></li>
							<li><a href="/booking/timetable#masterSpclBrch" title="특별관 선택" class="btn"><i class="iconset ico-tab-special"></i> 특별관</a></li>
						</ul>
					</div>

					<div class="ltab-layer-wrap">
						<div id="masterMovie" class="ltab-layer-cont has-img on"><a href="/booking/timetable" class="ir"></a>
							<div class="wrap tab-area">
								<div class="tab-list-choice">
									<ul>
										<li><a href="/booking/timetable#masterMovie_AllMovie" title="전체영화 선택" class="btn on">전체영화</a></li>
										<li><a href="/booking/timetable#masterMovie_CrtnMovie" title="큐레이션 선택" class="btn">큐레이션</a></li>
									</ul>
								</div>
								<div class="list-section">
									<div id="masterMovie_AllMovie" class="tab-layer-cont on"><a href="/booking/timetable" class="ir"></a>
										<div class="scroll m-scroll mCustomScrollbar _mCS_2"><div id="mCSB_2" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0"><div id="mCSB_2_container" class="mCSB_container" style="position:relative; top:0; left:0;" dir="ltr">
											<ul class="list"><li><button type="button" class="btn disabled on" data-movie-nm="타이타닉" data-movie-no="23004000" data-img-path="/SharedImg/2023/02/02/ym0dktzCLlIcYSlKLVW6y39GYa1Vg04l_316.jpg">타이타닉</button></li><li><button type="button" class="btn" data-movie-nm="더 퍼스트 슬램덩크" data-movie-no="22103500" data-img-path="/SharedImg/2022/12/19/whzCk46ejtIoWU1eavvF9lJ8rC2Wbvf7_316.jpg">더 퍼스트 슬램덩크</button></li><li><button type="button" class="btn" data-movie-nm="아바타: 물의 길" data-movie-no="22029100" data-img-path="/SharedImg/2022/12/16/9vUySe7DNMro6tdYRPEbjzF2ebr48MwE_316.jpg">아바타: 물의 길</button></li><li><button type="button" class="btn disabled" data-movie-nm="다음 소희" data-movie-no="23000400" data-img-path="/SharedImg/2023/01/12/WYpvrot3KxuIj3hVvnsRf7SGZDfDZgg4_316.jpg">다음 소희</button></li><li><button type="button" class="btn disabled" data-movie-nm="[10th REPLAY] 헤어질 결심" data-movie-no="23002500" data-img-path="/SharedImg/2023/01/10/l5Xk0admyRtAuzrBRuac8sv2usMPBnfX_316.jpg">[10th REPLAY] 헤어질 결심</button></li><li><button type="button" class="btn" data-movie-nm="바빌론" data-movie-no="23000500" data-img-path="/SharedImg/2023/02/02/QU7FdcxjBTaHusZSFDeJO7Ti4SLaakYA_316.jpg">바빌론</button></li><li><button type="button" class="btn disabled" data-movie-nm="[10th REPLAY] 에브리씽 에브리웨어 올 앳 원스" data-movie-no="23002200" data-img-path="/SharedImg/2023/01/09/Sem462xlBQ5TL5JJOcK1UQMFjQcgtvgI_316.jpg">[10th REPLAY] 에브리씽 에브리웨어 올 앳 원스</button></li><li><button type="button" class="btn disabled" data-movie-nm="원 웨이" data-movie-no="23007900" data-img-path="/SharedImg/2023/01/26/0YK4k2ufWV8fyX35OVrDmYXvwk06yHpR_316.jpg">원 웨이</button></li><li><button type="button" class="btn disabled" data-movie-nm="울프 하운드" data-movie-no="23007800" data-img-path="/SharedImg/2023/01/26/nQjdH9Lm0jufkqpnWS8XUrtEloSlhQ1P_316.jpg">울프 하운드</button></li><li><button type="button" class="btn" data-movie-nm="상견니" data-movie-no="23000200" data-img-path="/SharedImg/2023/01/30/intGSqw2gFJInt9iyFrRAxkWNBtCnYfk_316.jpg">상견니</button></li><li><button type="button" class="btn" data-movie-nm="영웅" data-movie-no="22085800" data-img-path="/SharedImg/2022/12/27/H5raSfICeSpI1ZSeYmFVBRvgPrkSBZwi_316.jpg">영웅</button></li><li><button type="button" class="btn disabled" data-movie-nm="서치 2" data-movie-no="23003800" data-img-path="/SharedImg/2023/02/02/UmgxlJgwWqM6ueiP32rhQhr2Cpq2GA5P_316.jpg">서치 2</button></li><li><button type="button" class="btn" data-movie-nm="교섭" data-movie-no="22102600" data-img-path="/SharedImg/2023/01/02/jaP2f1q8F51aGyRb804y51pU7pHe8mhV_316.jpg">교섭</button></li><li><button type="button" class="btn" data-movie-nm="극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연" data-movie-no="22100300" data-img-path="/SharedImg/2023/01/03/nrQUhgkUlGUzPCu81twxvZbDuXNi1AGQ_316.jpg">극장판 전생했더니 슬라임이었던 건에 대하여: 홍련의 인연</button></li><li><button type="button" class="btn" data-movie-nm="오늘 밤, 세계에서 이 사랑이 사라진다 해도" data-movie-no="22091200" data-img-path="/SharedImg/2022/11/04/vRDxzQ7BT5UZJSCxjBXTtxdbKA7eYktj_316.jpg">오늘 밤, 세계에서 이 사랑이 사라진다 해도</button></li><li><button type="button" class="btn" data-movie-nm="유령" data-movie-no="22103600" data-img-path="/SharedImg/2023/01/11/MbxcpuwuUGAutqH9LNFvpsecv8iSZdB4_316.jpg">유령</button></li><li><button type="button" class="btn disabled" data-movie-nm="궁지에 몰린 쥐는 치즈 꿈을 꾼다" data-movie-no="23000900" data-img-path="/SharedImg/2023/01/30/t2ZSsHcOUt7xJZFDUvPVmqeu006Fe6uK_316.jpg">궁지에 몰린 쥐는 치즈 꿈을 꾼다</button></li><li><button type="button" class="btn disabled" data-movie-nm="[10th REPLAY] 매스" data-movie-no="23002100" data-img-path="/SharedImg/2023/01/10/r5MlUQeDqOjzU8l0Oeg2JI8FXFaLHrtV_316.jpg">[10th REPLAY] 매스</button></li><li><button type="button" class="btn disabled" data-movie-nm="[10th REPLAY] 레 미제라블" data-movie-no="23002300" data-img-path="/SharedImg/2023/01/09/DgDsqbEUW43hiGRphiVfF2Z03IZsjBGY_316.jpg">[10th REPLAY] 레 미제라블</button></li><li><button type="button" class="btn disabled" data-movie-nm="[10th REPLAY] 자마" data-movie-no="23002400" data-img-path="/SharedImg/2023/01/09/ciyKTuRtKh4OSUdPI7tBd0hTiHX0WEz8_316.jpg">[10th REPLAY] 자마</button></li><li><button type="button" class="btn disabled" data-movie-nm="[10th REPLAY] 피닉스" data-movie-no="23002000" data-img-path="/SharedImg/2023/01/09/Mw6MXPKz7oyyoBNGiyKKUhZ8zm9WTg2H_316.jpg">[10th REPLAY] 피닉스</button></li><li><button type="button" class="btn" data-movie-nm="[베로나 오페라 페스티벌] 투란도트" data-movie-no="22105600" data-img-path="/SharedImg/2022/12/28/xo1VEjALK6IBcdM9VnsHH8MMRYBm3cCT_316.jpg">[베로나 오페라 페스티벌] 투란도트</button></li><li><button type="button" class="btn" data-movie-nm="애프터썬" data-movie-no="23003900" data-img-path="/SharedImg/2023/02/02/M2u6jNAAz96xptBsFnk1x3azxuMP0GHt_316.jpg">애프터썬</button></li><li><button type="button" class="btn disabled" data-movie-nm="[ROH 발레] 달콤 쌉사름한 초콜릿" data-movie-no="23007300" data-img-path="/SharedImg/2023/01/20/xAw5101zkwxSk1pwnyjyE5TONTRX0vM1_316.jpg">[ROH 발레] 달콤 쌉사름한 초콜릿</button></li><li><button type="button" class="btn disabled" data-movie-nm="[사건 읽는 영화관] 의뢰인 : 시체 없는 살인사건의 공판" data-movie-no="23007200" data-img-path="/SharedImg/2023/01/20/FIjRakrajy6UjCwHMkB6dRGQvT7jdcu1_316.jpg">[사건 읽는 영화관] 의뢰인 : 시체 없는 살인사건의 공판</button></li><li><button type="button" class="btn disabled" data-movie-nm="네가 떨어뜨린 푸른 하늘" data-movie-no="23003400" data-img-path="/SharedImg/2023/02/02/aq58qqgpvr3HCHp2ZbiUohVk0rcK1iUF_316.jpg">네가 떨어뜨린 푸른 하늘</button></li><li><button type="button" class="btn" data-movie-nm="메간" data-movie-no="23000300" data-img-path="/SharedImg/2023/01/02/EZIn5rUGAuvOI8JR1IHz7zia6VmUMpAj_316.jpg">메간</button></li><li><button type="button" class="btn" data-movie-nm="장화신은 고양이: 끝내주는 모험" data-movie-no="22096500" data-img-path="/SharedImg/2022/12/02/ghLL5wsWOyHLBLVissIgFVvjwryf2zni_316.jpg">장화신은 고양이: 끝내주는 모험</button></li><li><button type="button" class="btn disabled" data-movie-nm="[베로나 오페라 페스티벌 앙코르] 카르멘" data-movie-no="22105700" data-img-path="/SharedImg/2022/12/28/6axAuOaqs6C9kE60Hj6SvvEqIM4jDxEO_316.jpg">[베로나 오페라 페스티벌 앙코르] 카르멘</button></li><li><button type="button" class="btn disabled" data-movie-nm="트윈" data-movie-no="22071500" data-img-path="/SharedImg/2023/01/26/FrX1seJRH7w7dP9e8u2eIcMGvZUOrLUA_316.jpg">트윈</button></li><li><button type="button" class="btn disabled" data-movie-nm="너의 이름은." data-movie-no="01152300" data-img-path="/SharedImg/2021/09/07/KbLPdrF5WBGN5OemdEEAl9TJ3ncdvOIQ_316.jpg">너의 이름은.</button></li><li><button type="button" class="btn disabled" data-movie-nm="새비지 맨" data-movie-no="23003200" data-img-path="/SharedImg/2023/01/11/pycVkEkiw2GDEfc9VoZwha2KnNjqRM5h_316.jpg">새비지 맨</button></li><li><button type="button" class="btn" data-movie-nm="울브스 오브 워" data-movie-no="23003700" data-img-path="">울브스 오브 워</button></li><li><button type="button" class="btn disabled" data-movie-nm="성스러운 거미" data-movie-no="23001200" data-img-path="/SharedImg/2023/01/26/Szq8Jau5KmzoKpZS1553dKmvAAP5gFzN_316.jpg">성스러운 거미</button></li><li><button type="button" class="btn disabled" data-movie-nm="날씨의 아이" data-movie-no="01580700" data-img-path="/SharedImg/2021/09/07/Wkl5GF5kvfFE3TxE7QgXqhmY6H14GMeT_316.jpg">날씨의 아이</button></li><li><button type="button" class="btn" data-movie-nm="몬스터 하우스2: 인비져블 피닉스" data-movie-no="23003000" data-img-path="/SharedImg/2023/01/26/aPIcMbskojPRT4DXL6FNTSHtVEbEP7Wo_316.jpg">몬스터 하우스2: 인비져블 피닉스</button></li><li><button type="button" class="btn disabled" data-movie-nm="어쩌면 우린 헤어졌는지 모른다" data-movie-no="23007000" data-img-path="/SharedImg/2023/01/26/9lHbnqQBmNoguVfAETE8bWEpmuzKomDN_316.jpg">어쩌면 우린 헤어졌는지 모른다</button></li><li><button type="button" class="btn" data-movie-nm="이마 베프" data-movie-no="23001000" data-img-path="/SharedImg/2023/01/05/JepQCZVsnJQSHLbVGN1rMnSEo6K8Sxu1_316.jpg">이마 베프</button></li><li><button type="button" class="btn" data-movie-nm="캐리와 슈퍼콜라" data-movie-no="22101400" data-img-path="/SharedImg/2023/02/02/r340p2nbAw9ddyrL8TXSipv6zSCYyVb4_316.jpg">캐리와 슈퍼콜라</button></li><li><button type="button" class="btn" data-movie-nm="단순한 열정" data-movie-no="22105800" data-img-path="/SharedImg/2023/01/11/mUgMEbDj9ohHWT5w8cEMPGKdNgUQQOG8_316.jpg">단순한 열정</button></li><li><button type="button" class="btn disabled" data-movie-nm="[시네마캐슬] 너의 이름은." data-movie-no="21002200" data-img-path="/SharedImg/2021/01/08/Oa63iBAVVdn6Iu8By4FoNhHwkqpYh3Tg_316.jpg">[시네마캐슬] 너의 이름은.</button></li><li><button type="button" class="btn disabled" data-movie-nm="프로메어" data-movie-no="22070900" data-img-path="/SharedImg/2022/10/06/JTLCBnOyPhh7mivLHdWEqqebElgaxLq6_316.jpg">프로메어</button></li><li><button type="button" class="btn disabled" data-movie-nm="극장판 주술회전 0" data-movie-no="22001100" data-img-path="/SharedImg/2022/02/17/djm7aYuL9bQGZRsxyUH75wATz9ub9ouk_316.jpg">극장판 주술회전 0</button></li><li><button type="button" class="btn disabled" data-movie-nm="안녕, 소중한 사람" data-movie-no="23003300" data-img-path="/SharedImg/2023/01/13/AfQCEmxDEevQFgYMBs1W4Rb2mfZOjTiX_316.jpg">안녕, 소중한 사람</button></li><li><button type="button" class="btn" data-movie-nm="라일 라일 크로커다일" data-movie-no="22102700" data-img-path="/SharedImg/2022/12/27/pAgB1JstN3jyvnzccPeSVLusglPA1PEc_316.jpg">라일 라일 크로커다일</button></li><li><button type="button" class="btn" data-movie-nm="원피스 필름 레드" data-movie-no="22069700" data-img-path="/SharedImg/2022/10/27/KyM9M62zht16gWm8cArDqiD8oXWNByTz_316.jpg">원피스 필름 레드</button></li><li><button type="button" class="btn" data-movie-nm="페르시아어 수업" data-movie-no="22095600" data-img-path="/SharedImg/2022/12/06/nrur8Ql69isJGwriNRh1Y5SgaMEXsQx5_316.jpg">페르시아어 수업</button></li><li><button type="button" class="btn" data-movie-nm="[시네마캐슬] 극장판 겁쟁이 페달" data-movie-no="23008400" data-img-path="/SharedImg/2023/01/30/z7AeaAoR5VnUnfhOyRb3ei5gAG9sdilU_316.jpg">[시네마캐슬] 극장판 겁쟁이 페달</button></li><li><button type="button" class="btn disabled" data-movie-nm="양자경의 더 모든 날 모든 순간" data-movie-no="22094400" data-img-path="/SharedImg/2022/11/22/pPNQYR7Gu6Ujjm7hpxgrK7wEvr9Ks36R_316.jpg">양자경의 더 모든 날 모든 순간</button></li><li><button type="button" class="btn disabled" data-movie-nm="뱅드림! 필름 라이브 세컨드 스테이지" data-movie-no="21068600" data-img-path="/SharedImg/2021/11/02/JITv65LlMRHqBhtmjCKeG2jYg5SXjG3P_316.jpg">뱅드림! 필름 라이브 세컨드 스테이지</button></li><li><button type="button" class="btn" data-movie-nm="[시네마캐슬] 언어의 정원" data-movie-no="21028800" data-img-path="/SharedImg/2023/01/30/CqrUfjU30vyD3fAsIlebHvONboFXrupp_316.jpg">[시네마캐슬] 언어의 정원</button></li><li><button type="button" class="btn" data-movie-nm="[시네마캐슬] 별의 목소리 X 초속5센티미터" data-movie-no="21032500" data-img-path="/SharedImg/2023/01/30/0W50gDPcyZ3pnY72JfT1hMvuNsnHzxnc_316.jpg">[시네마캐슬] 별의 목소리 X 초속5센티미터</button></li><li><button type="button" class="btn disabled" data-movie-nm="[시네마캐슬] 릴리 슈슈의 모든 것" data-movie-no="21006900" data-img-path="/SharedImg/2021/01/19/Kif0WybIwDEMjgI5DHKXTQbHK0UXFHXu_316.jpg">[시네마캐슬] 릴리 슈슈의 모든 것</button></li><li><button type="button" class="btn" data-movie-nm="데몬러버" data-movie-no="23008100" data-img-path="/SharedImg/2023/01/26/pKLKma3BnD73uAT3XsCaxFHmEC6MJIRv_316.jpg">데몬러버</button></li><li><button type="button" class="btn" data-movie-nm="400번의 구타" data-movie-no="23002700" data-img-path="/SharedImg/2023/01/16/LzBU7zrFckEA17gNeybNGqFOBEQM6fwx_316.jpg">400번의 구타</button></li><li><button type="button" class="btn disabled" data-movie-nm="헤어질 결심" data-movie-no="22022900" data-img-path="/SharedImg/2022/06/07/S3GJQZbpshoIx0Lelerscl9rlI14FHqK_316.jpg">헤어질 결심</button></li><li><button type="button" class="btn" data-movie-nm="라인" data-movie-no="22105100" data-img-path="/SharedImg/2023/01/03/hS9JchsqP6tQw3AQvYR75C9SguD56TKv_316.jpg">라인</button></li><li><button type="button" class="btn" data-movie-nm="쥴 앤 짐" data-movie-no="23002800" data-img-path="/SharedImg/2023/01/16/KZPUwKSBMoeviMGDOarKjhTWwvovqtCZ_316.jpg">쥴 앤 짐</button></li><li><button type="button" class="btn" data-movie-nm="3000년의 기다림" data-movie-no="22096600" data-img-path="/SharedImg/2023/01/11/ihLSRezSYXahijW6XssUpi6kCEPxEZ1i_316.jpg">3000년의 기다림</button></li><li><button type="button" class="btn disabled" data-movie-nm="가가린" data-movie-no="22096300" data-img-path="/SharedImg/2022/12/06/P6N4ed70JfYGoNKlktRoSBGk1bYfbCiN_316.jpg">가가린</button></li><li><button type="button" class="btn disabled" data-movie-nm="디텍티브 나이트: 가면의 밤" data-movie-no="23002900" data-img-path="/SharedImg/2023/01/20/LAyiqFcUWVEu6o1OyMTlyJWuZvxlOHPt_316.jpg">디텍티브 나이트: 가면의 밤</button></li><li><button type="button" class="btn disabled" data-movie-nm="라스트 버스" data-movie-no="23003500" data-img-path="/SharedImg/2023/01/16/zmiOOAO1DB6JEyCCji8bJoHgCaqLXEw1_316.jpg">라스트 버스</button></li><li><button type="button" class="btn" data-movie-nm="올빼미" data-movie-no="22085900" data-img-path="/SharedImg/2022/11/24/xFO8r2xbXzxoMD9iXbuKC1n5Bo79InhQ_316.jpg">올빼미</button></li><li><button type="button" class="btn disabled" data-movie-nm="[시네마캐슬] 날씨의 아이" data-movie-no="21001700" data-img-path="/SharedImg/2021/01/08/bOG90pEAe94xQJiejfLfjiCbDh9inkXD_316.jpg">[시네마캐슬] 날씨의 아이</button></li><li><button type="button" class="btn disabled" data-movie-nm="신비아파트 극장판 차원도깨비와 7개의 세계" data-movie-no="22095200" data-img-path="/SharedImg/2022/12/19/rzmVB93EfJgU4p0gDh0taIRDsRGslBNX_316.jpg">신비아파트 극장판 차원도깨비와 7개의 세계</button></li><li><button type="button" class="btn disabled" data-movie-nm="[시네마캐슬] 구름의 저편, 약속의 장소" data-movie-no="21032600" data-img-path="/SharedImg/2023/01/30/H5uo2pMGHxg6BzTQTurzZRTkwlnw52eU_316.jpg">[시네마캐슬] 구름의 저편, 약속의 장소</button></li><li><button type="button" class="btn disabled" data-movie-nm="[시네마캐슬] 별을 쫓는 아이" data-movie-no="21015100" data-img-path="/SharedImg/2022/12/27/ONy3YZv9kb4iTOgxL5QHDBkAytXEDoXk_316.jpg">[시네마캐슬] 별을 쫓는 아이</button></li><li><button type="button" class="btn disabled" data-movie-nm="[라이브뷰잉] Boy George &amp;amp; Culture Club LIVE - One World, One Love" data-movie-no="23008900" data-img-path="/SharedImg/2023/02/01/rSe4PxWVMh3tM7E3uBmdl071zeOB6adL_316.jpg">[라이브뷰잉] Boy George &amp; Culture Club LIVE - One World, One Love</button></li><li><button type="button" class="btn disabled" data-movie-nm="시간을 꿈꾸는 소녀" data-movie-no="22102800" data-img-path="/SharedImg/2022/12/27/D8xYluS9ylMNNq6v1MruAn7wCVQu84QM_316.jpg">시간을 꿈꾸는 소녀</button></li><li><button type="button" class="btn" data-movie-nm="유랑의 달" data-movie-no="22106100" data-img-path="/SharedImg/2023/01/11/YdKpMtieuu7ae3PdoxzOfzgoBfjwX6Rs_316.jpg">유랑의 달</button></li><li><button type="button" class="btn disabled" data-movie-nm="[시네마캐슬] 견왕: 이누오" data-movie-no="22104700" data-img-path="/SharedImg/2022/12/27/SAg1MlBH5cem9aI9ygEmzD1VldRANGaq_316.jpg">[시네마캐슬] 견왕: 이누오</button></li><li><button type="button" class="btn disabled" data-movie-nm="유어 아이즈 텔" data-movie-no="21011600" data-img-path="/SharedImg/2021/02/22/2SXcib4zwpAf7GtUN0RYptZULgMOmb74_316.jpg">유어 아이즈 텔</button></li><li><button type="button" class="btn disabled" data-movie-nm="극장판 파워레인저 캡틴포스: 지구를 위한 싸움" data-movie-no="22096200" data-img-path="/SharedImg/2023/01/20/STDcPhi3KOV38EbIXOZ69ZhTrJCctzxx_316.jpg">극장판 파워레인저 캡틴포스: 지구를 위한 싸움</button></li><li><button type="button" class="btn disabled" data-movie-nm="눈의 여왕5: 스노우 프린세스와 미러랜드의 비밀" data-movie-no="22096400" data-img-path="/SharedImg/2022/12/22/Lo263FenuvZJTAk2okC4nZOqwOJsn4g4_316.jpg">눈의 여왕5: 스노우 프린세스와 미러랜드의 비밀</button></li><li><button type="button" class="btn disabled" data-movie-nm="뱅드림! 필름 라이브" data-movie-no="01624600" data-img-path="/SharedImg/asis/system/mop/poster/2019/55/66AEF2-4199-4C3A-93BF-3130FF6ED86D.medium.jpg">뱅드림! 필름 라이브</button></li><li><button type="button" class="btn disabled" data-movie-nm="앤트맨과 와스프: 퀀텀매니아" data-movie-no="22088100" data-img-path="/SharedImg/2023/01/20/YkwwbbiNjktu8JDQnSTYchhGTs7mAB0U_316.jpg">앤트맨과 와스프: 퀀텀매니아</button></li><li><button type="button" class="btn" data-movie-nm="엄마의 땅: 그리샤와 숲의 주인" data-movie-no="22103000" data-img-path="/SharedImg/2023/01/02/Mu31nkjB1IkGzEEYMMhg8FdstIrc0RU3_316.jpg">엄마의 땅: 그리샤와 숲의 주인</button></li><li><button type="button" class="btn" data-movie-nm="천룡팔부: 교봉전" data-movie-no="22105900" data-img-path="/SharedImg/2023/01/12/urMAvFFYpK5ycp2849BIbXIZgVlkBPey_316.jpg">천룡팔부: 교봉전</button></li><li><button type="button" class="btn disabled" data-movie-nm="핑크퐁 시네마 콘서트 2: 원더스타 콘서트 대작전" data-movie-no="22094700" data-img-path="/SharedImg/2022/12/06/mkXvGKlb0UiWrq7Ny99IarjG8WwXl9cN_316.jpg">핑크퐁 시네마 콘서트 2: 원더스타 콘서트 대작전</button></li></ul>
										</div><div id="mCSB_2_scrollbar_vertical" class="mCSB_scrollTools mCSB_2_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: block;"><div class="mCSB_draggerContainer"><div id="mCSB_2_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; display: block; height: 55px; max-height: 190px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div>
									</div>
									<div id="masterMovie_CrtnMovie" class="tab-layer-cont"><a href="/booking/timetable" class="ir"></a>
										<div class="scroll m-scroll mCustomScrollbar _mCS_3 mCS_no_scrollbar"><div id="mCSB_3" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_3_container" class="mCSB_container mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr">
											<ul class="list"><li><button type="button" class="btn " data-movie-nm="[베로나 오페라 페스티벌] 투란도트" data-movie-no="22105600" data-img-path="/SharedImg/2022/12/28/xo1VEjALK6IBcdM9VnsHH8MMRYBm3cCT_316.jpg">[베로나 오페라 페스티벌] 투란도트</button></li><li><button type="button" class="btn " data-movie-nm="애프터썬" data-movie-no="23003900" data-img-path="/SharedImg/2023/02/02/M2u6jNAAz96xptBsFnk1x3azxuMP0GHt_316.jpg">애프터썬</button></li><li><button type="button" class="btn disabled" data-movie-nm="[ROH 발레] 달콤 쌉사름한 초콜릿" data-movie-no="23007300" data-img-path="/SharedImg/2023/01/20/xAw5101zkwxSk1pwnyjyE5TONTRX0vM1_316.jpg">[ROH 발레] 달콤 쌉사름한 초콜릿</button></li><li><button type="button" class="btn disabled" data-movie-nm="[사건 읽는 영화관] 의뢰인 : 시체 없는 살인사건의 공판" data-movie-no="23007200" data-img-path="/SharedImg/2023/01/20/FIjRakrajy6UjCwHMkB6dRGQvT7jdcu1_316.jpg">[사건 읽는 영화관] 의뢰인 : 시체 없는 살인사건의 공판</button></li><li><button type="button" class="btn disabled" data-movie-nm="[베로나 오페라 페스티벌 앙코르] 카르멘" data-movie-no="22105700" data-img-path="/SharedImg/2022/12/28/6axAuOaqs6C9kE60Hj6SvvEqIM4jDxEO_316.jpg">[베로나 오페라 페스티벌 앙코르] 카르멘</button></li><li><button type="button" class="btn disabled" data-movie-nm="성스러운 거미" data-movie-no="23001200" data-img-path="/SharedImg/2023/01/26/Szq8Jau5KmzoKpZS1553dKmvAAP5gFzN_316.jpg">성스러운 거미</button></li><li><button type="button" class="btn " data-movie-nm="이마 베프" data-movie-no="23001000" data-img-path="/SharedImg/2023/01/05/JepQCZVsnJQSHLbVGN1rMnSEo6K8Sxu1_316.jpg">이마 베프</button></li><li><button type="button" class="btn " data-movie-nm="단순한 열정" data-movie-no="22105800" data-img-path="/SharedImg/2023/01/11/mUgMEbDj9ohHWT5w8cEMPGKdNgUQQOG8_316.jpg">단순한 열정</button></li><li><button type="button" class="btn disabled" data-movie-nm="안녕, 소중한 사람" data-movie-no="23003300" data-img-path="/SharedImg/2023/01/13/AfQCEmxDEevQFgYMBs1W4Rb2mfZOjTiX_316.jpg">안녕, 소중한 사람</button></li><li><button type="button" class="btn " data-movie-nm="페르시아어 수업" data-movie-no="22095600" data-img-path="/SharedImg/2022/12/06/nrur8Ql69isJGwriNRh1Y5SgaMEXsQx5_316.jpg">페르시아어 수업</button></li><li><button type="button" class="btn " data-movie-nm="쥴 앤 짐" data-movie-no="23002800" data-img-path="/SharedImg/2023/01/16/KZPUwKSBMoeviMGDOarKjhTWwvovqtCZ_316.jpg">쥴 앤 짐</button></li><li><button type="button" class="btn " data-movie-nm="3000년의 기다림" data-movie-no="22096600" data-img-path="/SharedImg/2023/01/11/ihLSRezSYXahijW6XssUpi6kCEPxEZ1i_316.jpg">3000년의 기다림</button></li><li><button type="button" class="btn " data-movie-nm="유랑의 달" data-movie-no="22106100" data-img-path="/SharedImg/2023/01/11/YdKpMtieuu7ae3PdoxzOfzgoBfjwX6Rs_316.jpg">유랑의 달</button></li></ul>
										</div><div id="mCSB_3_scrollbar_vertical" class="mCSB_scrollTools mCSB_3_scrollbar mCS-light mCSB_scrollTools_vertical"><div class="mCSB_draggerContainer"><div id="mCSB_3_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; display: none; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div>
									</div>
								</div>
							</div>
							<div class="poster-section">
								<div class="table">
									<div class="td"><a href="/movie-detail?rpstMovieNo=23004000" title="타이타닉 상세보기"><img class="poster" onerror="noImg(this, &#39;del&#39;)" src="./timetable_files/ym0dktzCLlIcYSlKLVW6y39GYa1Vg04l_316.jpg" alt="타이타닉"></a></div>
								</div>
							</div>
						</div>

						<div id="masterBrch" class="ltab-layer-cont"><a href="/booking/timetable" class="ir"></a>
							<div class="wrap tab-area">
								<div class="tab-list-choice">
									<ul><li><a href="/booking/timetable#tab10" title="서울지점 선택" data-area-cd="10" class="on">서울(20)</a></li><li><a href="/booking/timetable#tab30" title="경기지점 선택" data-area-cd="30">경기(31)</a></li><li><a href="/booking/timetable#tab35" title="인천지점 선택" data-area-cd="35">인천(5)</a></li><li><a href="/booking/timetable#tab45" title="대전/충청/세종지점 선택" data-area-cd="45">대전/충청/세종(15)</a></li><li><a href="/booking/timetable#tab55" title="부산/대구/경상지점 선택" data-area-cd="55">부산/대구/경상(25)</a></li><li><a href="/booking/timetable#tab65" title="광주/전라지점 선택" data-area-cd="65">광주/전라(9)</a></li><li><a href="/booking/timetable#tab70" title="강원지점 선택" data-area-cd="70">강원(5)</a></li></ul>
								</div>
								<div class="list-section"><div id="tab10" class="tab-layer-cont on"><div class="scroll m-scroll mCustomScrollbar _mCS_4 mCS_no_scrollbar"><div id="mCSB_4" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0"><div id="mCSB_4_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1372">강남</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="0023">강남대로(씨티)</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1341">강동</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1431">군자</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="0041">더 부티크 목동현대백화점</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1003">동대문</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1572">마곡</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1581">목동</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1311">상봉</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1211">상암월드컵경기장</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1331">성수</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1371">센트럴</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1381">송파파크하비오</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1202">신촌</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1561">이수</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1321">창동</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1351">코엑스</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1212">홍대</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1571">화곡</button></li><li><button type="button" class="btn" data-area-cd="10" data-brch-no="1562">ARTNINE</button></li></ul><div></div></div><div id="mCSB_4_scrollbar_vertical" class="mCSB_scrollTools mCSB_4_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_4_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; height: 0px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div></div><div id="tab30" class="tab-layer-cont"><div class="scroll m-scroll mCustomScrollbar _mCS_5 mCS_no_scrollbar"><div id="mCSB_5" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_5_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4121">고양스타필드</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="0029">광명AK플라자</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="0034">광명소하</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="0035">금정AK플라자</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4152">김포한강신도시</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="0039">남양주</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="0019">남양주현대아울렛 스페이스원</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4451">동탄</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4652">미사강변</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4113">백석</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4722">별내</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4221">부천스타필드시티</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4631">분당</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="0030">수원</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="0042">수원남문</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="0036">수원호매실</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4291">시흥배곧</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4253">안산중앙</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="0020">안성스타필드</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4821">양주</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4431">영통</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="0012">용인기흥</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4462">용인테크노밸리</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4804">의정부민락</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4111">일산</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4104">일산벨라시타</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4112">킨텍스</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4132">파주금촌</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4115">파주운정</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4131">파주출판도시</button></li><li><button type="button" class="btn" data-area-cd="30" data-brch-no="4651">하남스타필드</button></li></ul><div></div></div><div id="mCSB_5_scrollbar_vertical" class="mCSB_scrollTools mCSB_5_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_5_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div></div><div id="tab35" class="tab-layer-cont"><div class="scroll m-scroll mCustomScrollbar _mCS_6 mCS_no_scrollbar"><div id="mCSB_6" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_6_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="35" data-brch-no="4041">검단</button></li><li><button type="button" class="btn" data-area-cd="35" data-brch-no="4062">송도</button></li><li><button type="button" class="btn" data-area-cd="35" data-brch-no="4001">영종</button></li><li><button type="button" class="btn" data-area-cd="35" data-brch-no="4051">인천논현</button></li><li><button type="button" class="btn" data-area-cd="35" data-brch-no="0027">청라지젤</button></li></ul><div></div></div><div id="mCSB_6_scrollbar_vertical" class="mCSB_scrollTools mCSB_6_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_6_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div></div><div id="tab45" class="tab-layer-cont"><div class="scroll m-scroll mCustomScrollbar _mCS_7 mCS_no_scrollbar"><div id="mCSB_7" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_7_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="45" data-brch-no="3141">공주</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="0018">논산</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="3021">대전</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="0028">대전신세계 아트앤사이언스</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="0009">대전유성</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="3011">대전중앙로</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="0017">대전현대아울렛</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="3391">세종(조치원)</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="3392">세종나성</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="0008">세종청사</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="3631">오창</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="3651">진천</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="3301">천안</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="0013">청주사창</button></li><li><button type="button" class="btn" data-area-cd="45" data-brch-no="3501">홍성내포</button></li></ul><div></div></div><div id="mCSB_7_scrollbar_vertical" class="mCSB_scrollTools mCSB_7_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_7_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div></div><div id="tab55" class="tab-layer-cont"><div class="scroll m-scroll mCustomScrollbar _mCS_8 mCS_no_scrollbar"><div id="mCSB_8" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_8_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="55" data-brch-no="0040">경북도청</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="7122">경산하양</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="0043">경주</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="7303">구미강동</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="7401">김천</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="7901">남포항</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="7011">대구신세계(동대구)</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="0022">대구이시아</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="6161">덕천</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="6312">마산</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="7451">문경</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="6001">부산극장</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="6906">부산대</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="0025">북대구(칠곡)</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="0032">사상</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="6642">삼천포</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="6261">양산</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="6262">양산라피에스타</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="6811">울산</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="6191">정관</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="0045">진주(중안)</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="6421">창원</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="0014">창원내서</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="0038">포항</button></li><li><button type="button" class="btn" data-area-cd="55" data-brch-no="0046">해운대(장산)</button></li></ul><div></div></div><div id="mCSB_8_scrollbar_vertical" class="mCSB_scrollTools mCSB_8_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_8_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div></div><div id="tab65" class="tab-layer-cont"><div class="scroll m-scroll mCustomScrollbar _mCS_9 mCS_no_scrollbar"><div id="mCSB_9" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_9_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="65" data-brch-no="5021">광주상무</button></li><li><button type="button" class="btn" data-area-cd="65" data-brch-no="5061">광주하남</button></li><li><button type="button" class="btn" data-area-cd="65" data-brch-no="5302">목포하당(포르모)</button></li><li><button type="button" class="btn" data-area-cd="65" data-brch-no="5401">순천</button></li><li><button type="button" class="btn" data-area-cd="65" data-brch-no="5552">여수웅천</button></li><li><button type="button" class="btn" data-area-cd="65" data-brch-no="0010">전대(광주)</button></li><li><button type="button" class="btn" data-area-cd="65" data-brch-no="5612">전주송천</button></li><li><button type="button" class="btn" data-area-cd="65" data-brch-no="0021">전주혁신</button></li><li><button type="button" class="btn" data-area-cd="65" data-brch-no="5064">첨단</button></li></ul><div></div></div><div id="mCSB_9_scrollbar_vertical" class="mCSB_scrollTools mCSB_9_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_9_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div></div><div id="tab70" class="tab-layer-cont"><div class="scroll m-scroll mCustomScrollbar _mCS_10 mCS_no_scrollbar"><div id="mCSB_10" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_10_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="70" data-brch-no="2001">남춘천</button></li><li><button type="button" class="btn" data-area-cd="70" data-brch-no="2171">속초</button></li><li><button type="button" class="btn" data-area-cd="70" data-brch-no="2201">원주</button></li><li><button type="button" class="btn" data-area-cd="70" data-brch-no="2202">원주센트럴</button></li><li><button type="button" class="btn" data-area-cd="70" data-brch-no="0037">춘천석사</button></li></ul><div></div></div><div id="mCSB_10_scrollbar_vertical" class="mCSB_scrollTools mCSB_10_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_10_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div></div></div>
							</div>
						</div>

						<div id="masterSpclBrch" class="ltab-layer-cont has-img"><a href="/booking/timetable" class="ir"></a>
							<div class="wrap tab-area">
								<div class="tab-list-choice">
									<ul><li><a href="/booking/timetable#tabDBC" title="DOLBY CINEMA특별관 선택" data-area-cd="DBC" class="on">DOLBY CINEMA(5)</a></li><li><a href="/booking/timetable#tabTBQ" title="THE BOUTIQUE특별관 선택" data-area-cd="TBQ">THE BOUTIQUE(9)</a></li><li><a href="/booking/timetable#tabMX" title="MX특별관 선택" data-area-cd="MX">MX(9)</a></li><li><a href="/booking/timetable#tabCFT" title="COMFORT특별관 선택" data-area-cd="CFT">COMFORT(47)</a></li><li><a href="/booking/timetable#tabPTC" title="PUPPY CINEMA특별관 선택" data-area-cd="PTC">PUPPY CINEMA(1)</a></li><li><a href="/booking/timetable#tabMKB" title="MEGABOX KIDS특별관 선택" data-area-cd="MKB">MEGABOX KIDS(2)</a></li></ul>
								</div>
								<div class="list-section"><div id="tabDBC" class="tab-layer-cont on"><div class="scroll m-scroll mCustomScrollbar _mCS_11 mCS_no_scrollbar"><div id="mCSB_11" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0"><div id="mCSB_11_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="DBC" data-brch-no="0019">남양주현대아울렛 스페이스원</button></li><li><button type="button" class="btn" data-area-cd="DBC" data-brch-no="7011">대구신세계(동대구)</button></li><li><button type="button" class="btn" data-area-cd="DBC" data-brch-no="0028">대전신세계 아트앤사이언스</button></li><li><button type="button" class="btn" data-area-cd="DBC" data-brch-no="0020">안성스타필드</button></li><li><button type="button" class="btn" data-area-cd="DBC" data-brch-no="1351">코엑스</button></li></ul><div></div></div><div id="mCSB_11_scrollbar_vertical" class="mCSB_scrollTools mCSB_11_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_11_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; height: 0px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div><div class="theater-section">	<div class="table">		<div class="td">			<a href="/specialtheater/dolby" title="DOLBY 특별관 페이지로 이동">				<p><strong>DOLBY</strong>국내 최초로 메가박스가 <br>선보이는 세계 최고 <br>기술력의 몰입 시네마</p>				<i class="iconset ico-arrow-half"></i>				<img src="./timetable_files/img-theater-dolby.png" alt="DOLBY 특별관 페이지로 이동" class="poster">			</a>		</div>	</div></div></div><div id="tabTBQ" class="tab-layer-cont"><div class="scroll m-scroll mCustomScrollbar _mCS_12 mCS_no_scrollbar"><div id="mCSB_12" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_12_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="TBQ" data-brch-no="0028">대전신세계 아트앤사이언스</button></li><li><button type="button" class="btn" data-area-cd="TBQ" data-brch-no="0041">더 부티크 목동현대백화점</button></li><li><button type="button" class="btn" data-area-cd="TBQ" data-brch-no="4631">분당</button></li><li><button type="button" class="btn" data-area-cd="TBQ" data-brch-no="1331">성수</button></li><li><button type="button" class="btn" data-area-cd="TBQ" data-brch-no="1371">센트럴</button></li><li><button type="button" class="btn" data-area-cd="TBQ" data-brch-no="4104">일산벨라시타</button></li><li><button type="button" class="btn" data-area-cd="TBQ" data-brch-no="1351">코엑스</button></li><li><button type="button" class="btn" data-area-cd="TBQ" data-brch-no="4112">킨텍스</button></li><li><button type="button" class="btn" data-area-cd="TBQ" data-brch-no="4651">하남스타필드</button></li></ul><div></div></div><div id="mCSB_12_scrollbar_vertical" class="mCSB_scrollTools mCSB_12_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_12_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div><div class="theater-section">	<div class="table">		<div class="td">			<a href="/specialtheater/boutique" title="THE BOUTIQUE 특별관 페이지로 이동">				<p><strong>THE BOUTIQUE</strong>영화를 본다는 것,<br>그 놀라운 경험을 위하여</p>				<i class="iconset ico-arrow-half"></i>				<img src="./timetable_files/img-theater-boutique.png" alt="THE BOUTIQUE 특별관 페이지로 이동" class="poster">			</a>		</div>	</div></div></div><div id="tabMX" class="tab-layer-cont"><div class="scroll m-scroll mCustomScrollbar _mCS_13 mCS_no_scrollbar"><div id="mCSB_13" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_13_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="MX" data-brch-no="4121">고양스타필드</button></li><li><button type="button" class="btn" data-area-cd="MX" data-brch-no="0017">대전현대아울렛</button></li><li><button type="button" class="btn" data-area-cd="MX" data-brch-no="1581">목동</button></li><li><button type="button" class="btn" data-area-cd="MX" data-brch-no="1211">상암월드컵경기장</button></li><li><button type="button" class="btn" data-area-cd="MX" data-brch-no="1331">성수</button></li><li><button type="button" class="btn" data-area-cd="MX" data-brch-no="4062">송도</button></li><li><button type="button" class="btn" data-area-cd="MX" data-brch-no="4431">영통</button></li><li><button type="button" class="btn" data-area-cd="MX" data-brch-no="0038">포항</button></li><li><button type="button" class="btn" data-area-cd="MX" data-brch-no="4651">하남스타필드</button></li></ul><div></div></div><div id="mCSB_13_scrollbar_vertical" class="mCSB_scrollTools mCSB_13_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_13_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div><div class="theater-section">	<div class="table">		<div class="td">			<a href="/specialtheater/mx" title="MX 특별관 페이지로 이동">				<p><strong>MX</strong>진정한 영화 사운드를 통한<br>최고의 영화! <br>메가박스의 차세대 <br>표준 상영관</p>				<i class="iconset ico-arrow-half"></i>				<img src="./timetable_files/img-theater-mx.png" alt="MX 특별관 페이지로 이동" class="poster">			</a>		</div>	</div></div></div><div id="tabCFT" class="tab-layer-cont"><div class="scroll m-scroll mCustomScrollbar _mCS_14 mCS_no_scrollbar"><div id="mCSB_14" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_14_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="4041">검단</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0043">경주</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0029">광명AK플라자</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="5021">광주상무</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="5061">광주하남</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0035">금정AK플라자</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0039">남양주</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0019">남양주현대아울렛 스페이스원</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0022">대구이시아</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="3021">대전</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0028">대전신세계 아트앤사이언스</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="6161">덕천</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="1003">동대문</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="4451">동탄</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="6312">마산</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="1581">목동</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="4113">백석</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="6906">부산대</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0032">사상</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="1311">상봉</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="1211">상암월드컵경기장</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0008">세종청사</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="4062">송도</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0042">수원남문</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0036">수원호매실</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="4291">시흥배곧</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="1202">신촌</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="6261">양산</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="6262">양산라피에스타</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="4821">양주</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0012">용인기흥</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="4462">용인테크노밸리</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="6811">울산</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="2202">원주센트럴</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="4051">인천논현</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0021">전주혁신</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0045">진주(중안)</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0014">창원내서</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="3301">천안</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0027">청라지젤</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0013">청주사창</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0037">춘천석사</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="1351">코엑스</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="4112">킨텍스</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="4132">파주금촌</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0038">포항</button></li><li><button type="button" class="btn" data-area-cd="CFT" data-brch-no="0046">해운대(장산)</button></li></ul><div></div></div><div id="mCSB_14_scrollbar_vertical" class="mCSB_scrollTools mCSB_14_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_14_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div><div class="theater-section">	<div class="table">		<div class="td">			<a href="/specialtheater/comfort" title="COMFORT 특별관 페이지로 이동">				<p><strong>COMFORT</strong>더욱 편안한 영화 관람을<br>위한 다양한 여유 공간</p>				<i class="iconset ico-arrow-half"></i>				<img src="./timetable_files/img-theater-comfort.png" alt="COMFORT 특별관 페이지로 이동" class="poster">			</a>		</div>	</div></div></div><div id="tabPTC" class="tab-layer-cont"><div class="scroll m-scroll mCustomScrollbar _mCS_15 mCS_no_scrollbar"><div id="mCSB_15" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_15_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="PTC" data-brch-no="4431">영통</button></li></ul><div></div></div><div id="mCSB_15_scrollbar_vertical" class="mCSB_scrollTools mCSB_15_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_15_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div><div class="theater-section">	<div class="table">		<div class="td">			<a href="/specialtheater/puppy" title="PUPPY CINEMA 특별관 페이지로 이동">				<p><strong>PUPPY CINEMA</strong>최초의 반려동물 동반 <br>멀티플렉스 <br>영화관람은 물론 <br>다양한 부대시설까지</p>				<i class="iconset ico-arrow-half"></i>				<img src="./timetable_files/img-theater-puppycinema.png" alt="PUPPY CINEMA 특별관 페이지로 이동" class="poster">			</a>		</div>	</div></div></div><div id="tabMKB" class="tab-layer-cont"><div class="scroll m-scroll mCustomScrollbar _mCS_16 mCS_no_scrollbar"><div id="mCSB_16" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 200px;" tabindex="0"><div id="mCSB_16_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr"><ul class="list"><li><button type="button" class="btn" data-area-cd="MKB" data-brch-no="6312">마산</button></li><li><button type="button" class="btn" data-area-cd="MKB" data-brch-no="4651">하남스타필드</button></li></ul><div></div></div><div id="mCSB_16_scrollbar_vertical" class="mCSB_scrollTools mCSB_16_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_16_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div><div class="theater-section">	<div class="table">		<div class="td">			<a href="/specialtheater/megakids" title="MEGA KIDS 특별관 페이지로 이동">				<p><strong>MEGA KIDS</strong>아이와 가족이 함께 머물며<br>삶의 소중한 가치를 배우는<br>더 행복한 놀이공간</p>				<i class="iconset ico-arrow-half"></i>				<img src="./timetable_files/img-theater-kids.png" alt="MEGA KIDS 특별관 페이지로 이동" class="poster">			</a>		</div>	</div></div></div></div>
								
							</div>
						</div>
					</div>
				</div>

				<div class="box-alert mt40" style="display:none">
					<i class="iconset ico-bell"></i>
					<strong></strong>
					<span></span>
				</div>

				<h3 class="tit mt60" style="display:none"><span class="font-green">타이타닉</span> 무대인사</h3>
				<div class="reserve movie-greeting" style="display:none"></div>

				<h3 class="tit mt60"><span class="font-green">타이타닉</span> 상영시간표</h3><div class="time-schedule mb30">	<div class="wrap">		<button type="button" title="이전 날짜 보기" class="btn-pre" disabled="true">			<i class="iconset ico-cld-pre"></i> <em>이전</em>		</button>		<div class="date-list">			<div class="year-area">				<div class="year" style="left: 30px; z-index: 1; opacity: 1;">2023.02</div>				<div class="year" style="left: 450px; z-index: 1; opacity: 0;"></div>			</div>			<div class="date-area"><div class="wrap" style="position: relative; width: 2100px; border: none; left: -70px;"><button class="disabled" type="button" date-data="2023.02.06" month="1" tabindex="-1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">6<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">월</span><span class="day-en" style="pointer-events:none;display:none">Mon</span></button><button class="disabled" type="button" date-data="2023.02.07" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">7<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">오늘</span><span class="day-en" style="pointer-events:none;display:none">Tue</span></button><button class="on" type="button" date-data="2023.02.08" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">8<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">내일</span><span class="day-en" style="pointer-events:none;display:none">Wed</span></button><button class="" type="button" date-data="2023.02.09" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">9<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">목</span><span class="day-en" style="pointer-events:none;display:none">Thu</span></button><button class="" type="button" date-data="2023.02.10" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">10<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">금</span><span class="day-en" style="pointer-events:none;display:none">Fri</span></button><button class="sat" type="button" date-data="2023.02.11" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">11<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">토</span><span class="day-en" style="pointer-events:none;display:none">Sat</span></button><button class="holi" type="button" date-data="2023.02.12" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">12<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">일</span><span class="day-en" style="pointer-events:none;display:none">Sun</span></button><button class="" type="button" date-data="2023.02.13" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">13<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">월</span><span class="day-en" style="pointer-events:none;display:none">Mon</span></button><button class="" type="button" date-data="2023.02.14" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">14<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">화</span><span class="day-en" style="pointer-events:none;display:none">Tue</span></button><button class="disabled" type="button" date-data="2023.02.15" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">15<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">수</span><span class="day-en" style="pointer-events:none;display:none">Wed</span></button><button class="disabled" type="button" date-data="2023.02.16" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">16<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">목</span><span class="day-en" style="pointer-events:none;display:none">Thu</span></button><button class="disabled" type="button" date-data="2023.02.17" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">17<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">금</span><span class="day-en" style="pointer-events:none;display:none">Fri</span></button><button class="disabled sat" type="button" date-data="2023.02.18" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">18<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">토</span><span class="day-en" style="pointer-events:none;display:none">Sat</span></button><button class="disabled holi" type="button" date-data="2023.02.19" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">19<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">일</span><span class="day-en" style="pointer-events:none;display:none">Sun</span></button><button class="disabled" type="button" date-data="2023.02.20" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">20<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">월</span><span class="day-en" style="pointer-events:none;display:none">Mon</span></button><button class="disabled" type="button" date-data="2023.02.21" month="1" tabindex="-1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">21<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">화</span><span class="day-en" style="pointer-events:none;display:none">Tue</span></button></div></div>		</div>		<button type="button" title="다음 날짜 보기" class="btn-next" disabled="true">			<i class="iconset ico-cld-next"></i> <em>다음</em>		</button>		<div class="bg-line">			<input type="hidden" name="datePicker" id="dp1675750578835" class="hasDatepicker" value="2023.02.08">			<button type="button" class="btn-calendar-large" title="달력보기"> 달력보기</button>		</div>	</div></div><div class="movie-option mb20">	<div class="option">		<ul>			<li><i class="iconset ico-stage" title="무대인사"></i>무대인사</li>			<li><i class="iconset ico-user" title="회원시사"></i>회원시사</li>			<li><i class="iconset ico-open" title="오픈시사"></i>오픈시사</li>			<li><i class="iconset ico-goods" title="굿즈패키지"></i>굿즈패키지</li>			<li><i class="iconset ico-singalong" title="싱어롱"></i>싱어롱</li>			<li><i class="iconset ico-gv" title="GV"></i>GV</li>			<li><i class="iconset ico-sun" title="조조"></i>조조</li>			<li><i class="iconset ico-brunch" title="브런치"></i>브런치</li>			<li><i class="iconset ico-moon" title="심야"></i>심야</li>		</ul>	</div>	<div class="rateing-lavel">		<a href="/booking/timetable" class="" title="관람등급안내">관람등급안내</a>	</div></div><div class="reserve theater-list-box">	<div class="tab-block tab-layer mb30">		<ul><li class="on"><a href="/booking/timetable" class="btn" data-area-cd="10" title="서울 선택">서울</a></li><li><a href="/booking/timetable" class="btn" data-area-cd="30" title="경기 선택">경기</a></li><li><a href="/booking/timetable" class="btn" data-area-cd="35" title="인천 선택">인천</a></li><li><a href="/booking/timetable" class="btn" data-area-cd="45" title="대전/충청/세종 선택">대전/충청/세종</a></li><li><a href="/booking/timetable" class="btn" data-area-cd="55" title="부산/대구/경상 선택">부산/대구/경상</a></li><li><a href="/booking/timetable" class="btn" data-area-cd="65" title="광주/전라 선택">광주/전라</a></li><li><a href="/booking/timetable" class="btn" data-area-cd="70" title="강원 선택">강원</a></li></ul>	</div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1372" title="강남 상세보기">강남</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">1관</p>		<p class="chair">총 232석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1372" play-schdl-no="2302081372001" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="1">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-sun"></i></div>				<p class="time">10:00</p>				<p class="chair">19석</p>								<div class="play-time">					<p>10:00~13:25</p>					<p>1회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1372" play-schdl-no="2302081372002" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">13:45</p>				<p class="chair">171석</p>								<div class="play-time">					<p>13:45~17:10</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1372" play-schdl-no="2302081372003" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">17:30</p>				<p class="chair">166석</p>								<div class="play-time">					<p>17:30~20:55</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1372" play-schdl-no="2302081372004" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">21:15</p>				<p class="chair">218석</p>								<div class="play-time">					<p>21:15~24:40</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1341" title="강동 상세보기">강동</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">1관</p>		<p class="chair">총 249석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1341" play-schdl-no="2302081341024" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">16:35</p>				<p class="chair">233석</p>								<div class="play-time">					<p>16:35~20:00</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1341" play-schdl-no="2302081341001" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="5">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">20:20</p>				<p class="chair">232석</p>								<div class="play-time">					<p>20:20~23:45</p>					<p>5회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">5관</p>		<p class="chair">총 74석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1341" play-schdl-no="2302081341030" rpst-movie-no="23004000" theab-no="05" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">11:25</p>				<p class="chair">57석</p>								<div class="play-time">					<p>11:25~14:50</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1341" play-schdl-no="2302081341029" rpst-movie-no="23004000" theab-no="05" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">15:10</p>				<p class="chair">66석</p>								<div class="play-time">					<p>15:10~18:35</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=0041" title="더 부티크 목동현대백화점 상세보기">더 부티크 목동현대백화점</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">더부티크 102호</p>		<p class="chair">총 135석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="0041" play-schdl-no="2302080041125" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="1">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-sun"></i></div>				<p class="time">10:00</p>				<p class="chair">79석</p>								<div class="play-time">					<p>10:00~13:25</p>					<p>1회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="0041" play-schdl-no="2302080041025" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">16:40</p>				<p class="chair">116석</p>								<div class="play-time">					<p>16:40~20:05</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="0041" play-schdl-no="2302080041024" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">20:30</p>				<p class="chair">110석</p>								<div class="play-time">					<p>20:30~23:55</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">[오픈특가] 스위트 108호</p>		<p class="chair">총 86석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="0041" play-schdl-no="2302080041031" rpst-movie-no="23004000" theab-no="08" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">11:20</p>				<p class="chair">79석</p>								<div class="play-time">					<p>11:20~14:45</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="0041" play-schdl-no="2302080041030" rpst-movie-no="23004000" theab-no="08" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">15:20</p>				<p class="chair">71석</p>								<div class="play-time">					<p>15:20~18:45</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="0041" play-schdl-no="2302080041029" rpst-movie-no="23004000" theab-no="08" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">19:20</p>				<p class="chair">63석</p>								<div class="play-time">					<p>19:20~22:45</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1003" title="동대문 상세보기">동대문</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">6관</p>		<p class="chair">총 190석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1003" play-schdl-no="2302081003016" rpst-movie-no="23004000" theab-no="06" play-de="20230208" play-seq="1">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">10:30</p>				<p class="chair">85석</p>								<div class="play-time">					<p>10:30~13:55</p>					<p>1회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1003" play-schdl-no="2302081003018" rpst-movie-no="23004000" theab-no="06" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">17:55</p>				<p class="chair">115석</p>								<div class="play-time">					<p>17:55~21:20</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1003" play-schdl-no="2302081003019" rpst-movie-no="23004000" theab-no="06" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">21:40</p>				<p class="chair">171석</p>								<div class="play-time">					<p>21:40~25:05</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1572" title="마곡 상세보기">마곡</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">1관</p>		<p class="chair">총 123석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1572" play-schdl-no="2302081572014" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">22:25</p>				<p class="chair">113석</p>								<div class="play-time">					<p>22:25~25:50</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">3관</p>		<p class="chair">총 132석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1572" play-schdl-no="2302081572010" rpst-movie-no="23004000" theab-no="03" play-de="20230208" play-seq="1">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-sun"></i></div>				<p class="time">10:00</p>				<p class="chair">42석</p>								<div class="play-time">					<p>10:00~13:25</p>					<p>1회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1572" play-schdl-no="2302081572011" rpst-movie-no="23004000" theab-no="03" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">13:45</p>				<p class="chair">94석</p>								<div class="play-time">					<p>13:45~17:10</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1572" play-schdl-no="2302081572015" rpst-movie-no="23004000" theab-no="03" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">20:00</p>				<p class="chair">111석</p>								<div class="play-time">					<p>20:00~23:25</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1581" title="목동 상세보기">목동</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">MX관</p>		<p class="chair">총 332석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D ATMOS(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1581" play-schdl-no="2302081581001" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="1">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-sun"></i></div>				<p class="time">10:00</p>				<p class="chair">217석</p>								<div class="play-time">					<p>10:00~13:25</p>					<p>1회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1581" play-schdl-no="2302081581002" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">13:45</p>				<p class="chair">273석</p>								<div class="play-time">					<p>13:45~17:10</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1581" play-schdl-no="2302081581003" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">17:30</p>				<p class="chair">277석</p>								<div class="play-time">					<p>17:30~20:55</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1581" play-schdl-no="2302081581004" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">21:15</p>				<p class="chair">308석</p>								<div class="play-time">					<p>21:15~24:40</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">3관</p>		<p class="chair">총 114석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1581" play-schdl-no="2302081581007" rpst-movie-no="23004000" theab-no="03" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">12:05</p>				<p class="chair">91석</p>								<div class="play-time">					<p>12:05~15:30</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1581" play-schdl-no="2302081581005" rpst-movie-no="23004000" theab-no="03" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">19:30</p>				<p class="chair">84석</p>								<div class="play-time">					<p>19:30~22:55</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1311" title="상봉 상세보기">상봉</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">4층 1관</p>		<p class="chair">총 155석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1311" play-schdl-no="2302081311007" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="1">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">10:05</p>				<p class="chair">94석</p>								<div class="play-time">					<p>10:05~13:30</p>					<p>1회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1311" play-schdl-no="2302081311012" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">17:35</p>				<p class="chair">128석</p>								<div class="play-time">					<p>17:35~21:00</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1311" play-schdl-no="2302081311010" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">21:20</p>				<p class="chair">144석</p>								<div class="play-time">					<p>21:20~24:45</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1211" title="상암월드컵경기장 상세보기">상암월드컵경기장</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">MX관</p>		<p class="chair">총 342석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D ATMOS(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1211" play-schdl-no="2302081211002" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="1">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-sun"></i></div>				<p class="time">10:00</p>				<p class="chair">238석</p>								<div class="play-time">					<p>10:00~13:25</p>					<p>1회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1211" play-schdl-no="2302081211003" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">13:45</p>				<p class="chair">303석</p>								<div class="play-time">					<p>13:45~17:10</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1211" play-schdl-no="2302081211004" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">17:30</p>				<p class="chair">308석</p>								<div class="play-time">					<p>17:30~20:55</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1211" play-schdl-no="2302081211005" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">21:15</p>				<p class="chair">306석</p>								<div class="play-time">					<p>21:15~24:40</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">3관</p>		<p class="chair">총 305석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1211" play-schdl-no="2302081211037" rpst-movie-no="23004000" theab-no="03" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">15:00</p>				<p class="chair">286석</p>								<div class="play-time">					<p>15:00~18:25</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1331" title="성수 상세보기">성수</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">MX관</p>		<p class="chair">총 279석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D ATMOS(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1331" play-schdl-no="2302081331002" rpst-movie-no="23004000" theab-no="03" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">12:00</p>				<p class="chair">170석</p>								<div class="play-time">					<p>12:00~15:25</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1331" play-schdl-no="2302081331004" rpst-movie-no="23004000" theab-no="03" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">15:45</p>				<p class="chair">189석</p>								<div class="play-time">					<p>15:45~19:10</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1371" title="센트럴 상세보기">센트럴</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">더부티크 102호</p>		<p class="chair">총 159석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1371" play-schdl-no="2302081371001" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="1">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-sun"></i></div>				<p class="time">10:00</p>				<p class="chair">100석</p>								<div class="play-time">					<p>10:00~13:25</p>					<p>1회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1371" play-schdl-no="2302081371002" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">13:45</p>				<p class="chair">132석</p>								<div class="play-time">					<p>13:45~17:10</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1371" play-schdl-no="2302081371003" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">17:30</p>				<p class="chair">130석</p>								<div class="play-time">					<p>17:30~20:55</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1371" play-schdl-no="2302081371004" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">21:10</p>				<p class="chair">147석</p>								<div class="play-time">					<p>21:10~24:35</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1381" title="송파파크하비오 상세보기">송파파크하비오</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">9관</p>		<p class="chair">총 124석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1381" play-schdl-no="2302081381001" rpst-movie-no="23004000" theab-no="09" play-de="20230208" play-seq="1">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">13:35</p>				<p class="chair">74석</p>								<div class="play-time">					<p>13:35~17:00</p>					<p>1회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1381" play-schdl-no="2302081381002" rpst-movie-no="23004000" theab-no="09" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">20:00</p>				<p class="chair">82석</p>								<div class="play-time">					<p>20:00~23:25</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1202" title="신촌 상세보기">신촌</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">컴포트1관</p>		<p class="chair">총 400석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1202" play-schdl-no="2302081202005" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="1">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-sun"></i></div>				<p class="time">10:10</p>				<p class="chair">273석</p>								<div class="play-time">					<p>10:10~13:35</p>					<p>1회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1202" play-schdl-no="2302081202006" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">13:55</p>				<p class="chair">330석</p>								<div class="play-time">					<p>13:55~17:20</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1202" play-schdl-no="2302081202007" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">17:40</p>				<p class="chair">341석</p>								<div class="play-time">					<p>17:40~21:05</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1202" play-schdl-no="2302081202008" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">21:20</p>				<p class="chair">377석</p>								<div class="play-time">					<p>21:20~24:45</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1561" title="이수 상세보기">이수</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">5관</p>		<p class="chair">총 198석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="end-time">	<p class="time">10:00</p>	<p class="chair">매진</p></td><td class="" brch-no="1561" play-schdl-no="2302081561007" rpst-movie-no="23004000" theab-no="05" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">13:45</p>				<p class="chair">145석</p>								<div class="play-time">					<p>13:45~17:10</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1561" play-schdl-no="2302081561008" rpst-movie-no="23004000" theab-no="05" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">17:30</p>				<p class="chair">151석</p>								<div class="play-time">					<p>17:30~20:55</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1561" play-schdl-no="2302081561009" rpst-movie-no="23004000" theab-no="05" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">21:15</p>				<p class="chair">175석</p>								<div class="play-time">					<p>21:15~24:40</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1351" title="코엑스 상세보기">코엑스</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">Dolby Cinema</p>		<p class="chair">총 378석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D Dolby(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1351" play-schdl-no="2302081351011" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">11:50</p>				<p class="chair">95석</p>								<div class="play-time">					<p>11:50~15:15</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1351" play-schdl-no="2302081351042" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">15:45</p>				<p class="chair">145석</p>								<div class="play-time">					<p>15:45~19:10</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1351" play-schdl-no="2302081351012" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">19:40</p>				<p class="chair">81석</p>								<div class="play-time">					<p>19:40~23:05</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1351" play-schdl-no="2302081351013" rpst-movie-no="23004000" theab-no="01" play-de="20230208" play-seq="5">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">23:35</p>				<p class="chair">246석</p>								<div class="play-time">					<p>23:35~27:00</p>					<p>5회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">컴포트 3관</p>		<p class="chair">총 348석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1351" play-schdl-no="2302081351023" rpst-movie-no="23004000" theab-no="03" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">13:05</p>				<p class="chair">235석</p>								<div class="play-time">					<p>13:05~16:30</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1351" play-schdl-no="2302081351022" rpst-movie-no="23004000" theab-no="03" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">16:55</p>				<p class="chair">274석</p>								<div class="play-time">					<p>16:55~20:20</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">컴포트 7관</p>		<p class="chair">총 285석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1351" play-schdl-no="2302081351024" rpst-movie-no="23004000" theab-no="07" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">10:40</p>				<p class="chair">135석</p>								<div class="play-time">					<p>10:40~14:05</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1351" play-schdl-no="2302081351025" rpst-movie-no="23004000" theab-no="07" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">14:30</p>				<p class="chair">172석</p>								<div class="play-time">					<p>14:30~17:55</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1351" play-schdl-no="2302081351027" rpst-movie-no="23004000" theab-no="07" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">18:20</p>				<p class="chair">143석</p>								<div class="play-time">					<p>18:20~21:45</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1351" play-schdl-no="2302081351020" rpst-movie-no="23004000" theab-no="07" play-de="20230208" play-seq="5">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">22:10</p>				<p class="chair">236석</p>								<div class="play-time">					<p>22:10~25:35</p>					<p>5회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1212" title="홍대 상세보기">홍대</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">정원관 (9층 2관)</p>		<p class="chair">총 170석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1212" play-schdl-no="2302081212007" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">11:55</p>				<p class="chair">103석</p>								<div class="play-time">					<p>11:55~15:20</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1212" play-schdl-no="2302081212009" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">15:40</p>				<p class="chair">84석</p>								<div class="play-time">					<p>15:40~19:05</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1212" play-schdl-no="2302081212010" rpst-movie-no="23004000" theab-no="02" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">19:35</p>				<p class="chair">69석</p>								<div class="play-time">					<p>19:35~23:00</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div><div class="theater-list"><div class="theater-area-click"><a href="/theater?brchNo=1571" title="화곡 상세보기">화곡</a></div><div class="theater-type-box">	<div class="theater-type">		<p class="theater-name">5관</p>		<p class="chair">총 174석</p>	</div>	<div class="theater-time">		<div class="theater-type-area">3D(자막)</div>		<div class="theater-time-box">			<table class="time-list-table">				<caption>상영시간을 보여주는 표 입니다.</caption>				<colgroup>					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">					<col style="width:99px;">				</colgroup>				<tbody>				<tr><td class="" brch-no="1571" play-schdl-no="2302081571004" rpst-movie-no="23004000" theab-no="05" play-de="20230208" play-seq="2">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">11:30</p>				<p class="chair">146석</p>								<div class="play-time">					<p>11:30~14:55</p>					<p>2회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1571" play-schdl-no="2302081571005" rpst-movie-no="23004000" theab-no="05" play-de="20230208" play-seq="3">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">15:15</p>				<p class="chair">147석</p>								<div class="play-time">					<p>15:15~18:40</p>					<p>3회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1571" play-schdl-no="2302081571006" rpst-movie-no="23004000" theab-no="05" play-de="20230208" play-seq="4">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">19:00</p>				<p class="chair">153석</p>								<div class="play-time">					<p>19:00~22:25</p>					<p>4회차</p>				</div>			</a>		</div>	</div></td><td class="" brch-no="1571" play-schdl-no="2302081571007" rpst-movie-no="23004000" theab-no="05" play-de="20230208" play-seq="5">	<div class="td-ab">		<div class="txt-center">			<a href="/booking/timetable" title="영화예매하기">				<div class="ico-box"><i class="iconset ico-off"></i></div>				<p class="time">22:45</p>				<p class="chair">163석</p>								<div class="play-time">					<p>22:45~26:10</p>					<p>5회차</p>				</div>			</a>		</div>	</div></td></tr></tbody>			</table>		</div>	</div></div></div></div><div class="box-border v1 mt30" style="display: none;">	<ul class="dot-list gray"></ul></div>
			</div>
		</div>
	</div>
</div>

<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="/booking/timetable" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="/booking/timetable" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/booking/timetable#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div><div id="ui-datepicker-div" class="ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all"></div></body></html>