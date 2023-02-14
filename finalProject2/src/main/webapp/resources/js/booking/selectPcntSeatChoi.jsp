<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumBarunGothic@latest/nanumbarungothicsubset.css">
	
<link rel="stylesheet" href="/resources/css/megabox.min.css" media="all" />
     		<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-30006739-3"></script>
<script>window.dataLayer = window.dataLayer || []; function gtag(){dataLayer.push(arguments);} gtag('js', new Date()); gtag('config', 'UA-30006739-3');</script>
<script src="/resources/js/megabox.api.min.js"></script>
<script src="/resources/js/lozad.min.js"></script>
<script src="/resources/js/megabox.common.min.js"></script>
<script src="/resources/js/dist/megabox.netfunnel.min.js"></script>
<script src="//cast.imp.joins.com/persona.js" async></script>
	
<script src="/resources/js/masonry.pkgd.min.js"></script>
<script src="/resources/js/booking/booking_1.js"></script>
	
<body class="body-iframe">
	<input type="hidden" id="playSchdlNo" name="playSchdlNo"
		value="2204111371025">
	<input type="hidden" id="brchNo" name="brchNo" value="1371">
	<section id="layer_age_alert" class="modal-layer" style="z-index: 900">
		<a
			href="https://www.megabox.co.kr/on/oh/ohz/PcntSeatChoi/selectPcntSeatChoi.do"
			class="focus">레이어로 포커스 이동 됨</a>
		<div class="wrap"
			style="width: 750px; height: 350px; margin-left: -375px; margin-top: 0px; top: 140px;">
			<header class="layer-header">
				<h3 class="tit">알림</h3>
			</header>
			<div class="layer-con">
				<div class="alert-age-layer age12">
					<div class="age-box age-12">
						<div class="left">
							<p class="circle">12</p>
						</div>
						<div class="right">
							<p class="tit">12세이상관람가</p>
							<p class="txt">
							<p>
								만 12 세 미만의 고객님은(영,유아 포함)<br>반드시 성인 보호자의 동반하에 관람이 가능합니다.<br>(확인불가
								시 입장제한)<br> <br> <strong><font color="red">◆
										접종유무에 관계없이 최대 10명까지 관람 가능 ◆</font><br>- 상영관 내 물, 음료(무알콜)만 취식가능 /
									- 띄어앉기 운영<br> <br>※극장 이용시 항상 마스크 착용을 부탁드립니다※</strong>
							</p>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="btn-group-fixed">
				<button type="button" class="button purple close-layer">확인</button>
			</div>
			<button type="button" class="btn-modal-close">레이어 닫기</button>
		</div>
	</section>
	<div class="inner-wrap" style="padding-top: 40px; padding-bottom: 100px;">
		<div class="quick-reserve">
			<h2 class="tit">빠른예매</h2>
			<script type="text/javascript">
var requestPayAt = "N";

$(function(){
	//RIA의 경우
    if(parent.sellChnlCd != ""){
        $('.inner-wrap')
        	.css('padding-bottom','')
        	.css('padding-top','');	//하단 상단 공백 제거
//         $('#btnLangChg').hide();    //언어전환 버튼숨김

        //로그인 되었으면
        if(parent.riaLoginAt == "Y"){
        	$('.cti-area input[name=riaName]').attr('value',parent.riaParamName);	//고객명
            $('.cti-area input[name=riaMobileNo]').attr('value',parent.riaParamMobileNo);	//고객전화번호
            $('.cti-area input[name=riaBirthday]').attr('value',parent.riaParamBirthday);	//고객생년월일
        	$('.cti-area input[name=riaMemberYn]').attr('value',parent.riaMemberYn == "Y" ? "회원" : "비회원");	//회원여부

        	$('.cti-area input[name=riaName]').attr("readonly",true);		//고객명
            $('.cti-area input[name=riaMobileNo]').attr("readonly",true);	//고객전화번호
            $('.cti-area input[name=riaBirthday]').attr("readonly",true);	//고객생년월일

            $('.cti-area input[name=riaMemberYn]').attr("readonly",true);	//회원여부

        	$('.cti-area button').attr('login-at',"Y");

            //결제화면이 아니면
            if("N" == requestPayAt){
            	$('.cti-area button').html('재인증');
            }
        }
        //로그인 되지 않았으면
        else {
        	$('.cti-area input[name=riaName]').attr('value',parent.riaParamName);	//고객명
            $('.cti-area input[name=riaMobileNo]').attr('value',parent.riaParamMobileNo);	//고객전화번호
            $('.cti-area input[name=riaBirthday]').attr('value',parent.riaParamBirthday);	//고객생년월일
            $('.cti-area input[name=riaMemberYn]').attr('value','');	//회원여부

        	$('.cti-area input[name=riaName]').attr("readonly",false);		//고객명
            $('.cti-area input[name=riaMobileNo]').attr("readonly",false);	//고객전화번호
            $('.cti-area input[name=riaBirthday]').attr("readonly",false);	//고객생년월일

            $('.cti-area input[name=riaMemberYn]').attr("readonly",true);	//회원여부

            $('.cti-area button').attr('login-at',"N");	//회원여부
          	//결제화면이 아니면
            if("N" == requestPayAt){
        		$('.cti-area button').html('인증요청');
            }
        }

        //드림센터의 경우
		if(parent.sellChnlCd == "TELLER"){
			$('.cti-area').show();	//cti 로그인창 표시
		}
		else {
			$('.cti-area').hide();	//cti 로그인창 표시
		}


		//회원정보 확인을 위한 초기 파라메타 셋팅

		//파라메타 셋팅후
		//회원여부확인				부모창
		//나머지 화면 disable 처리	부모창

	}
    else {
        $('.quick-reserve-ad-area').show();	//광고영역 표시
//         $('#btnLangChg').show();	//언어전환 버튼표시 사용안함 20200106 김민영
    }

    /* RIA 재인증 버튼 클릭 */
    $('.cti-area button').on("click", function(){

		//입력값 검증
		if($('.cti-area button').attr('login-at') == "N"){

// 			if($(".cti-area input[name=riaName]").val().length == 0){
// 				gfn_alertMsgBoxSize('이름은  필수 입력 항목 입니다.',400,250);	//{0} 필수 입력 항목 입니다.
// 				return;
// 			}

			if(!fn_validateDateYn($(".cti-area input[name=riaBirthday]").val())){
				gfn_alertMsgBoxSize('생년월일을 정확히 입력해주세요.',400,250);	//생년월일을 정확히 입력해주세요.
				return;
			}

			if($(".cti-area input[name=riaMobileNo]").val().length < 10){
				gfn_alertMsgBoxSize('휴대폰번호를 정확히 입력해주세요.',400,250);	//휴대폰번호를 정확히 입력해주세요.
				return;
			}

			if($(".cti-area input[name=riaMobileNo]").val().substr(0,2) != "01"){
				gfn_alertMsgBoxSize('휴대폰번호를 정확히 입력해주세요.',400,250);	//휴대폰번호를 정확히 입력해주세요.
				return;
			}
		}
		parent.fn_setRiaLoginToggle( [$('.cti-area button').attr('login-at')
    								 ,$(".cti-area input[name=riaName]").val()
    								 ,$(".cti-area input[name=riaBirthday]").val()
    								 ,$(".cti-area input[name=riaMobileNo]").val()]
    								);
    });


    /* 이름 숫자를 제외한 입력 여부판단 */
	$(".cti-area input[name=riaName]").on("keyup", function(e){
		var partton = /[^ㄱ-힣a-zA-Z]/g;
		if(partton.test($(this).val())) {
			var value = $(this).val().replace(/[^ㄱ-힣a-zA-Z]/g,"");
			$(this).val(value);
		}
 	});
	$(".cti-area input[name=riaName]").focusout(function(){
		var partton = /[^ㄱ-힣a-zA-Z]/g;
		if(partton.test($(this).val())) {
			var value = $(this).val().replace(/[^ㄱ-힣a-zA-Z]/g,"");
			$(this).val(value);
		}
	});

    /* 생년월일 숫자만 입력 여부판단 */
	$(".cti-area input[name=riaBirthday]").on("keyup", function(e){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	$(".cti-area input[name=riaBirthday]").focusout(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});

    /* 휴대폰번호 숫자만 입력 여부판단 */
	$(".cti-area input[name=riaMobileNo]").on("keyup", function(e){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
    });
	$(".cti-area input[name=riaMobileNo]").focusout(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
});


/*날짜 형태 확인*/
function fn_validateDateYn(param) {
	try
	{
		var yearFront = "";
		var year = "";
		var month = "";
		var day = "";

		param = param.replace(/-/g,'');

		// 자리수가 맞지않을때
		if( isNaN(param) || param.length < 6 || param.length == 7) {
			return false;
		}

		if(param.length == 6){
			year = Number(param.substring(0, 2));
			month = Number(param.substring(2, 4));
			day = Number(param.substring(4, 6));
		}
		else if (param.length == 8){
			var date = new Date();
			yearFront = Number(param.substring(0, 4));
			year = Number(param.substring(2, 4));
			month = Number(param.substring(4, 6));
			day = Number(param.substring(6, 8));

			if(yearFront > date.getFullYear()){
				return false;
			}
		}
		var dd = day / 0;

		if( month<1 || month>12 ) {
			return false;
		}

		var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		var maxDay = maxDaysInMonth[month-1];

		// 윤년 체크
		if( month==2 && ( year%4==0 && year%100!=0 || year%400==0 ) ) {
			maxDay = 29;
		}

		if( day<=0 || day>maxDay ) {
			return false;
		}
		return true;

	} catch (err) {
		return false;
	}
}

</script>
			<!-- cti 일때만 출력 -->
			<div class="cti-area" style="display: none">
				<p>이름</p>
				<input maxlength="20" name="riaName" type="text" title="이름 출력" class="input-text a-c w120px" placeholder="이름" value="">

				<p>생년월일</p>
				<input maxlength="8" name="riaBirthday" type="text" title="생년월일 출력" class="input-text a-c w150px" placeholder="6자리 또는 8자리" value="">

				<p>휴대폰번호</p>
				<input maxlength="11" name="riaMobileNo" type="text" title="휴대폰번호 출력" class="input-text a-c w150px"
					placeholder="- 없이 입력" value="">

				<p>회원</p>
				<input name="riaMemberYn" type="text" title="회원여부 출력" class="input-text a-c w100px" value="" readyonly="readyonly">

				<button type="button" class="button gray ml10" login-at="N"></button>

			</div>

			<script>
function btnUpDown(seat,way){
	var totalCnt = fTotalCnt();
	var cnt = $('#' + seat + 'Count').text();
	if(way=='down'){
		if(cnt>0){
			cnt--;
		}
	} else if(way=='up'){
		if(totalCnt>=8){
			alert("8명이상 예매불가");
			return;
		}
		cnt++;
	}
	$('#' + seat + 'Count').text(cnt);
	$('#' + seat + 'Count').val(cnt);
	$('#' + seat + 'Count_value').val(cnt);
	fTotalCnt();
	sum();
}
</script>

<input id="totalCount" type="hidden" value="0" />
<!-- 합계 -->
<script>
function fTotalCnt(){
	var adultCnt = Number($('#adultCount').val());
	var youngCnt = Number($('#youngCount').val());
	var favorCnt = Number($('#favorCount').val());

	var totalCnt = adultCnt + youngCnt + favorCnt;
	$('#totalCount').val(totalCnt);
	return totalCnt;
}
</script>

<script>
function sum(){

	var adultPrice = $('#adultCount').val() * 14000;
	$('#adultPrice_value').val(adultPrice);
	
	var youngPrice = $('#youngCount').val() * 7000;
	$('#youngPrice_value').val(youngPrice);
	
	var favorPrice = $('#favorCount').val() * 5000;
	$('#favorPrice_value').val(favorPrice);
	
	totalPrice = adultPrice + youngPrice + favorPrice;
	
	$('#totalPrice').text(totalPrice);
	$('#totalPrice_value').val(totalPrice);
}
</script>



			<!-- 초기화 -->
			<script>
$(function() {
	
	iframeData();
	
	test1();
	
});
</script>

			<!-- iframeData -->
			<script>

function iframeData(){
	
	var tagName_value = parent.document.all["tagName_value"].value;
	$('#tagName').text(tagName_value);
	$('#tagName_value').val(tagName_value);
	$('#tagName').addClass(tagName_value);
	
	var hangle_value = parent.document.all["hangle_value"].value;
	$('#hangle').text(hangle_value);
	$('#hangle_value').val(hangle_value);
	
	var movieNm_value = parent.document.all["movieNm_value"].value;
	$('#movieNm').text(movieNm_value);
	$('#movieNm_value').val(movieNm_value);
	
	var movieImg_value = parent.document.all["movieImg_value"].value;
	$('#movieImg_value').val(movieImg_value);
	$("#movieImg").attr("src", "/poster/" + movieImg_value);
	
	var playKindNm_value = parent.document.all["playKindNm_value"].value;
	$('#playKindNm').text(playKindNm_value);
	$('#playKindNm_value').val(playKindNm_value);
	
	var brchNm_value = parent.document.all["brchNm_value"].value;
	$('#brchNm').text(brchNm_value);
	$('#brchNm_value').val(brchNm_value);
	
	var theater_value = parent.document.all["theater_value"].value;
	$('#theater').text(theater_value);
	$('#theater_value').val(theater_value);
	
	var playDe_value = parent.document.all["playDe_value"].value;
	$('#playDe').text(playDe_value);
	$('#playDe_value').val(playDe_value);
	
	var dowNm_value = parent.document.all["dowNm_value"].value;
	$('#dowNm').text(dowNm_value);
	$('#dowNm_value').val(dowNm_value);
	
	var playTime_value = parent.document.all["playTime_value"].value;
	$('#playTime').text(playTime_value);
	$('#playTime_value').val(playTime_value);
	
}

</script>

			<form action="" method="post" name="myForm">

				<div class="seat-select-section">
					<div class="seat-section">
						<div class="tit-util">
							<h3 class="tit small">관람인원선택</h3>
							<div class="right">
								<button type="button" class="button gray-line small" id="seatMemberCntInit">
									<i class="iconset ico-reset-small"></i>초기화
								</button>
							</div>
						</div>
						<div class="seat-area">
							<div class="seat-count" style="min-height: 52px">
								<div class="cell">
									<p class="txt">성인</p>
									<div class="count">
										<button type="button" class="down" title="성인 좌석 선택 감소" onclick="btnUpDown('adult','down');">-</button>
										<div class="number">
											<button type="button" class="now" title="성인 현재 좌석 선택 수" ticketgrpcd="TKA" id="adultCount" value="0">0</button>
											<input type="hidden" id="adultCount_value" name="adultCount_value"/>
											<ul class="num-choice">
												<li><button type="button" class="btn">0</button></li>
											</ul>
										</div>
										<button type="button" class="up" title="성인 좌석 선택 증가"
											onclick="btnUpDown('adult','up');">+</button>
									</div>
								</div>
								<div class="cell">
									<p class="txt">청소년</p>
									<div class="count">
										<button type="button" class="down" title="청소년 좌석 선택 감소" onclick="btnUpDown('young','down');">-</button>
										<div class="number">
											<button type="button" class="now" title="청소년 현재 좌석 선택 수" ticketgrpcd="TKY" id="youngCount" value="0">0</button>
											<input type="hidden" id="youngCount_value" name="youngCount_value"/>
											<ul class="num-choice">
												<li><button type="button" class="btn on">0</button></li>
											</ul>
										</div>
										<button type="button" class="up" title="청소년 좌석 선택 증가" onclick="btnUpDown('young','up');">+</button>
									</div>
								</div>
								<div class="cell">
									<p class="txt">우대</p>
									<div class="count">
										<button type="button" class="down" title="우대 좌석 선택 감소" onclick="btnUpDown('favor','down');">-</button>
										<div class="number">
											<button type="button" class="now" title="우대 현재 좌석 선택 수" ticketgrpcd="TKS" id="favorCount" value="0">0</button>
											<input type="hidden" id="favorCount_value" name="favorCount_value"/>
											<ul class="num-choice">
												<li><button type="button" class="btn on">0</button></li>
											</ul>
										</div>
										<button type="button" class="up" title="우대 좌석 선택 증가"
											onclick="btnUpDown('favor','up');">+</button>
									</div>
								</div>
							</div>
							<div class="seat-layout">
								<div class="alert" style="display: none;"></div>
								<div class="seat-count-before off" style="top: 0px">관람인원을 선택하십시요</div>
								<div
									class="scroll m-scroll mCustomScrollbar _mCS_1 mCS_no_scrollbar">
									<div id="mCSB_1" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
										style="max-height: none;" tabindex="0">
										<div id="mCSB_1_container" class="mCSB_container mCS_no_scrollbar_y" style="position: relative; top: 0px; left: 0px; height: 290px;" dir="ltr">

<input id="seatCnt" type="hidden" value="0" />
<script>
function f_btn_click(seat) {
	
	var totalCnt = $('#totalCount').val();
	var seatCnt = $('#seatCnt').val();
	
	if(totalCnt==0){
		return;
	}
	
	if($('#btn_' + seat).hasClass('choice')){
		
		$('#btn_' + seat).removeClass('choice');
		$('#btn_' + seat + '_value').val('N');
		
		$('#seat' + seatCnt).text("-");
		$('#seat' + seatCnt).removeClass("possible");
		$('#seat' + seatCnt).addClass("all");
		$('#seat' + seatCnt + '_value').val("N");
		
		seatCnt--;
		
	} else {
		
		seatCnt++;
		
		if(totalCnt < seatCnt) {
			return;
		}
		
		$('#btn_' + seat).addClass('choice');
		$('#btn_' + seat + '_value').val('Y');
		
		$('#seat' + seatCnt).text(seat);
		$('#seat' + seatCnt).removeClass("all");
		$('#seat' + seatCnt).addClass("possible");
		$('#seat' + seatCnt + '_value').val(seat);
		
	}
	
	$('#seatCnt').val(seatCnt);
	
}
</script>



<div id="seatLayout" style="width: 100%; height: 290px;">
<img src="/resources/reserve/img-theater-screen.png" alt="screen" style="position: absolute; left: 62px; top: 10px;" class="mCS_img_loaded">
<div class'row'="">
												
<script>
function test1(){
	
	for(i=0;i<11;i++){
		test2(i);
		for(j=0;j<12;j++){
			test3(i,j);
			
		}
	}
	
}
</script>
			
<script>
function test2(i){

	var node = document.createElement("button");
	
	var list = ["A","B","C","D","E","F","G","H","I","J","K"];
	
	node.type = "button";
	node.className = "btn-seat-row";
	node.style.position = "absolute";
	node.style.left = 216 + "px";
	node.style.top = 52+(i*20) + "px";
	  
	var text = document.createTextNode(list[i]);
	node.appendChild(text);
	
	document.getElementById("seatLayout").appendChild(node);
}
</script>

<script>
function test3(i,j){
	
	var empty = 0;
	
	if(j>2){
		empty = empty + 20;
		if(j>8){
			empty = empty + 20;
		}
	}
	
	var node = document.createElement("button");
	
	var list = ["A","B","C","D","E","F","G","H","I","J","K"];
	
	node.type = "button";
	node.className = "jq-tooltip seat-condition standard common";
	node.style.position = "absolute";
	node.style.left = 261+(j*20)+empty + "px";
	node.style.top = 50+(i*20) + "px";
	
	var idNum = parseInt(j + 1);
	var idString = String(idNum);
	
	node.id = "btn_" + list[i] + idString;
	
	node.onclick=function(){
		f_btn_click(list[i] + idString);
	}
	
	node.appendChild(document.createTextNode(idString));
	
	document.getElementById("seatLayout").appendChild(node);
	
	var node2 = document.createElement("span");
	
	node2.className = "num";
	
	node2.appendChild(document.createTextNode(idString));
	
	document.getElementById("btn_" + list[i] + idString).appendChild(node2);
}
</script>
												
													
												</div>
												<img src="/resources/reserve/img-door-top-bottom.png" alt="상하단측 출입구" style="position: absolute; left: 321px; top: 270px; width: 16px; height: 16px;"
													class="mCS_img_loaded"> <img src="/resources/reserve/img-door-top-bottom.png" alt="상하단측상하단측 출입구" style="position: absolute; left: 461px; top: 270px; width: 16px; height: 16px;" class="mCS_img_loaded">
											</div>
										</div>
										<div id="mCSB_1_scrollbar_vertical" class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_vertical">
											<div class="mCSB_draggerContainer">
												<div id="mCSB_1_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; display: none; height: 530px; top: 0px; max-height: 382px;">
													<div class="mCSB_dragger_bar" style="line-height: 30px;"></div>
												</div>
												<div class="mCSB_draggerRail"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="zone-legend" style="display: none"></div>
						</div>
					</div>
					<div class="seat-result">
						<div class="wrap">
							<div class="tit-area">
								<span class="movie-grade small" id="tagName"></span>
								<input type="hidden" id="tagName_value" name="tagName_value" />
								<input type="hidden" id="hangle_value" name="hangle_value" />

								<p class="tit" id="movieNm"></p>
								<input type="hidden" id="movieNm_value" name="movieNm_value" />

								<p class="cate" id="playKindNm"></p>
								<input type="hidden" id="playKindNm_value"
									name="playKindNm_value" />

							</div>
							<div class="info-area">
								<p class="theater" id="brchNm"></p>
								<input type="hidden" id="brchNm_value" name="brchNm_value" />
								<p class="special" id="theater"></p>
								<input type="hidden" id="theater_value" name="theater_value" />
								
								<p class="date">
									<span id="playDe"></span> <input type="hidden" id="playDe_value" name="playDe_value" /> <em id="dowNm"></em>
									<input type="hidden" id="dowNm_value" name="dowNm_value" />

								</p>
								<div class="other-time">
									<button type="button" class="now" id="playTime">
										<i class="arr"></i>
									</button>
									<input type="hidden" id="playTime_value" name="playTime_value" />

									<ul class="other">
										<li><button type="button" choicnt="83" playschdlno="2204111371025" class="btn on "></button></li>
									</ul>
								</div>
								<p class="poster">
									<img id="movieImg" src="">
									<input type="hidden" id="movieImg_value" name="movieImg_value" />
								</p>
							</div>
							<div class="choice-seat-area">
								<div class="legend">
									<ul class="list">
										<li><div class="seat-condition choice" title="선택한 좌석"></div>
											<em>선택</em></li>
										<li><div class="seat-condition finish" title="예매 완료"></div>
											<em>예매완료</em></li>
										<li><div class="seat-condition impossible" title="선택 불가"></div>
											<em>선택불가</em></li>
										<li><div class="seat-condition pos" title="띄어앉기석"></div>
											<em>띄어앉기석</em></li>
										<li><div class="seat-condition common" title="일반"></div>
											<em> 일반</em></li>
									</ul>
								</div>
								<div class="seat-num">
									<p class="tit">선택좌석</p>
									<div class="my-seat">
										<div class="seat all" title="구매가능 좌석" id="seat1">-</div>
										<input id="seat1_value" type="hidden" name="seat1_value"/>

										<div class="seat all" title="구매가능 좌석" id="seat2">-</div>
										<input id="seat2_value" type="hidden" name="seat2_value"/>

										<div class="seat all" title="구매가능 좌석" id="seat3">-</div>
										<input id="seat3_value" type="hidden" name="seat3_value"/>

										<div class="seat all" title="구매가능 좌석" id="seat4">-</div>
										<input id="seat4_value" type="hidden" name="seat4_value"/>

										<div class="seat all" title="구매가능 좌석" id="seat5">-</div>
										<input id="seat5_value" type="hidden" name="seat5_value"/>

										<div class="seat all" title="구매가능 좌석" id="seat6">-</div>
										<input id="seat6_value" type="hidden" name="seat6_value"/>

										<div class="seat all" title="구매가능 좌석" id="seat7">-</div>
										<input id="seat7_value" type="hidden" name="seat7_value"/>

										<div class="seat all" title="구매가능 좌석" id="seat8">-</div>
										<input id="seat8_value" type="hidden" name="seat8_value"/>

									</div>
								</div>
							</div>
							<div class="pay-area">
								<p class="count"></p>
								<div class="pay">
									<p class="tit">최종결제금액</p>
									<div class="money">
										<em id="totalPrice">0</em> 
										<input type="hidden" id="adultPrice_value" name="adultPrice_value" /> 
										<input type="hidden" id="youngPrice_value" name="youngPrice_value" /> 
										<input type="hidden" id="favorPrice_value" name="favorPrice_value" /> 
										<input type="hidden" id="totalPrice_value" name="totalPrice_value" /> 
										<span>원</span>
									</div>
								</div>
							</div>
							
<script>
function sendIt(){
	
	var f = document.myForm;
	var totalCnt = $('#totalCount').val();
	var seatNum = "#seat" + totalCnt + "_value";
	
	if($(seatNum).val()===""){
		alert("나머지 좌석을 선택하세요.");
		return;
	}
	
	f.action = "/booking_2_ok";
	f.submit();
}
</script>							
							
							<div class="btn-group">
								<a href="javaScript:void(0)" class="button" id="pagePrevious" title="이전">이전</a> <a href="javaScript:void(0)" class="button active" id="pageNext" title="다음"
									onclick="sendIt();">다음</a>
							</div>
						</div>
					</div>
				</div>

			</form>


		</div>
	</div>

	<div class="normalStyle"
		style="display: none; position: fixed; top: 0; left: 0; background: #000; opacity: 0.7; text-indent: -9999px; width: 100%; height: 100%; z-index: 100;">닫기</div>
	<div class="alertStyle"
		style="display: none; position: fixed; top: 0px; left: 0px; background: #000; opacity: 0.7; width: 100%; height: 100%; z-index: 5005;"></div>
</body>
</html>