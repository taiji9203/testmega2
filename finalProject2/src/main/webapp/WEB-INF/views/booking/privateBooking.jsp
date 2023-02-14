<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<!--<div id="bodyContent"> -->
 
<style type="text/css">
	/* FDK 결제용 CSS */
	/*
	table { margin: 1em; border-collapse: collapse; }
	td, th { padding: .3em; border: 1px #ccc solid; font-size:12px; }
	thead { background: #fc9; }
	thead .white { background: #fff; }
	input { background-color: #ffffff; border: #bbbbbb 1px solid; font-size: 9pt; height: 20px; width: 250px;}
	select { background-color: #ffffff; border-bottom: #a5a4a4 1px solid; border-left: #a5a4a4  1px solid; border-right: #a5a4a4  1px solid; border-top: #a5a4a4 1px solid; font-size: 9pt; height: 20px }
	*/

	/* LAYER POPUP STYLE START */
	.fdLayer {display:none; position: absolute; left: 50%; height:auto;  background-color:#fff; border: 5px solid rgb(0, 66, 101); z-index: 10;}
	.fdLayer .fdContainer {padding: 3px;}
	.fdLayer .fdBtn {width: 100%; margin:10px 0 0; padding-top: 10px; border-top: 1px solid #DDD; text-align:right;}
	a.closeBtn {display:inline-block; height:25px; padding:0 14px 0; border:1px solid #304a8a; background-color:rgb(0, 32, 61); font-size:13px; color:#fff; line-height:25px;}
	a.closeBtn:hover {border: 1px solid #091940; background-color:#1f326a; color:#fff;}
	#mask { position:absolute; left:0; top:0; z-index:9; background-color:#000; display:none;}
	/* LAYER POPUP STYLE END */
</style>
<script type="text/javascript">
var bOnLoadPage = true;
var crtDe = "";
var theabNo = '20';
var brchNo = '1351';
var allPlayDates = [];                          //달력 선택 가능한 날짜 상단 날짜부분
var disdaysFromServer = [];
var dowKorNmList = [];
var option = {};

var _init = {
		cache	: Date.now(),
		path	: '../../../static/pc/js/'
};

$(function(){
	crtDe = '20230207';	//서버일자
	var paramPlayDe = '20230208';	//파라메터일자

	allPlayDates = []; //달력활성일자
	disdaysFromServer = [];

	option.crtDe           = '20230207';		//"20221115"
	option.playDe          = '20230208';		// "20221231"

	// 상영 날짜목록 생성
	mbThCalendar.arrCkFlag     = false;

	mbThCalendar.tempMthd      = fn_tempMthd;	// 달력셋팅, 스케쥴 가져옴
	mbThCalendar.init({
		target       : 'date-area'
		, fetchHoliday : setHldyAdopt
		, fetchDisday  : setDisdyAdopt
		, holidays     : 'holidaysFromServer'
		, disdays      : 'disdaysFromServer' });

	$('#crtDe').val(crtDe.maskDate());
	$('#playDe').val(paramPlayDe);
	$('#datePicker').val(paramPlayDe.maskDate());

	$('#todayDate').val(crtDe.maskDate());

	$('#paymentAgree').hide();

	fn_playDateList();	//상영관에 맞는 날짜조회

	// 신용카드로 초기화 처리
	$('#div_href a').attr('href', 'javascript:void(0)').attr('id', 'credit');
	$("#sel_pay").attr('disabled', true);

	// 상영관 선택
	$(document).on('click', 'div.roomBox div.room span', function(e){
		e.preventDefault();

        $(this).parent().siblings().removeClass('on');
        $(this).parent().addClass('on');

		$(this).removeClass('on');

		theabNo = $(this).attr('theabno');

        var seatrow = 0;
        var theabExpoNo = '';
        $('div.roomBox div').each(function(){
            if($(this).hasClass('on')){
                seatrow = $(this).find('span').attr('seatrow');
                theabexpono = $(this).find('span').attr('theabexpono');
            }
        });

        // 이용안내 상영관 별로 처리
        var payInfoTxt = '선택하신 상영관은 프라이빗 '+theabexpono+'호입니다. 관람 인원 포함 입장 수용 인원이 총 '+seatrow+'명입니다. 입장 인원초과시 현장에서는 이용제한 또는 추가 요금이 부과될 수 있습니다.';

		fn_playDateList();
		// fn_playTimeList(playDe);
		// fn_playMovieList(playDe);

		// 초기화
		$('#selectTheabNo').html('<span>극장</span>코엑스 더 부티크 프라이빗 ' + theabexpono + '호');
		$("#selectTime").html("<span>일시</span>원하시는 시간을 선택해 주세요"); // 원하시는 시간을 선택해 주세요
		$("#selectMovie").html("<span>영화</span>원하시는 영화를 선택해 주세요"); // 원하시는 영화를 선택해 주세요
		$("#seatViewFormPlaySchdlNo").val('');
		$("#movieNo").val('');
		$("#movieGrade").val('');
		$('.total').find('em').text("0");
		$('#paymentAgree').hide();
		$("#rdoPayCredit").prop("checked",true);
		$('#payInfo').text(payInfoTxt)
        $("#sel_pay option:eq(0)").prop("selected", true);
        $("#sel_pay").attr('disabled', true);
        $(":checkbox[id='privPayChk']").prop('checked', false);
		//$("#playKindNm").html('');			// 영화 상영타입

		// 패키지 이미지체크박스 초기화
		$(":checkbox[name='privPackCd']").removeAttr('checked');
		$('#privPackContents').html('');
		$('#reqCtnt').val('');
		$("#textareaCnt").text('0/700');

        $('#smallImage').attr('src', '/static/pc/images/reserve/notimg.png');
        $('#smallImage').attr('alt', '');

	});

	// 시간 선택
	$(document).on('click', '.time-sel :radio', function(e){

		var dateVal = $('[name=datePicker]').val();
		var timeVal = $("input[name=time]:checked").val();
		var convertSelectDate = '';

		// 결재연동(상영스케줄)
		var playSchdlNo = $(this).attr('play-schdl-no');
		$("#seatViewFormPlaySchdlNo").val(playSchdlNo);

		if(dowKorNmList.length > 0){
			$.each(dowKorNmList, function(i, param){
				dateVal = dateVal.replaceAll('.', '');
				if(dateVal == param.playDe){
					convertSelectDate = param.playDe.substr(0, 4) + '. ' + param.playDe.substr(4, 2) + '. ' + param.playDe.substr(6, 2) + '(' + param.dowKorNm + ')';
				}
			});
		}
		timeVal = timeVal.substr(0, 2) + ':' + timeVal.substr(2);
		$("#selectTime").html("<span>일시</span>"+convertSelectDate + " " + timeVal);

		//영화목록 다시 그리기
        //fn_playMovieList($('[name=datePicker]').val().replaceAll('.', ''), 'N');

		// 결재금액
		fn_playApprPrice(playSchdlNo);

		/*// 티켓 금액 정보
		fn_ticketAmtInfo();*/

		// 초기화
		$("#selectMovie").html("<span>영화</span>원하시는 영화를 선택해 주세요"); // 원하시는 영화를 선택해 주세요
		$("#movieNo").val('');
		$("#movieGrade").val('');
		$('.total').find('em').text("0");
		$('#paymentAgree').hide();
		$("#rdoPayCredit").prop("checked",true);
		$('#playMovieList div').removeClass('on');		// 영화목록 지우기
        $("#sel_pay option:eq(0)").prop("selected", true);
        $("#sel_pay").attr('disabled', true);
        $(":checkbox[id='privPayChk']").prop('checked', false);
		//$("#playKindNm").html('');						// 영화 상영타입

		// 패키지 이미지체크박스 초기화
		$(":checkbox[name='privPackCd']").removeAttr('checked');
		$('#privPackContents').html('<dt>패키지 신청내역<span>총 0건</span></dt><dd><span>0건</span></dd>');
		$('#reqCtnt').val('');
		$("#textareaCnt").text('0');

        $('#smallImage').attr('src', '/static/pc/images/reserve/notimg.png');
        $('#smallImage').attr('alt', '');

	});

	// 상영시간표 > 달력 클릭
	$('.time-schedule').on('click', '.btn-calendar-large', function() {

		if (allPlayDates.length != 0) {
			$('[name=datePicker]').datepicker('show');
		}
	});

	// 대관예매 영화 선택
	$(document).on('click', '.choice-movie .cell a', function(e){
		e.preventDefault();
		$(this).closest('.cell').addClass('on').siblings('.cell').removeClass('on');

		var movieNm = $(this).attr('movie-nm');
		var movieGrade = $(this).attr('movie-grade');
		var playKindNm = $(this).attr('play-kind-nm');
		var imagePath = $(this).find('img').attr('src');

		// 결재:영화명 설정
		$("#selectMovie").html("<span>영화</span>"+movieNm + ' ' + playKindNm);

		// 결제:상영타입 설정
		// $("#playKindNm").html(playKindNm);

		// 결재연동(영화정보)
		var movieNo = $(this).attr('movie-no');
		$("#movieNo").val(movieNo);

		$("#movieGrade").val(movieGrade);

		// 관람등급 체크박스 문구 설정
		var movieGradeDesc1 = "";
		var movieGradeDesc2 = "";

		if ("AD01" == movieGrade) { // 전체관람가

		} else if ("AD02" == movieGrade) { // 12세이상관람가
			movieGradeDesc1 = '선택하신 영화는 12세 이상 관람가입니다.'; // 선택하신 영화는 12세 이상 관람가입니다.
			movieGradeDesc2 = '만 12세 미만의 고객님은(영,유아포함) 반드시 부모님 또는 성인 보호자의 동반하에 관람이 가능 합니다.'; // 만 12세 미만의 고객님은(영,유아포함) 반드시 부모님 또는 성인 보호자의 동반하에 관람이 가능 합니다.
		} else if ("AD03" == movieGrade) { // 15세이상관람가
			movieGradeDesc1 = '선택하신 영화는 15세 이상 관람가입니다.'; // 선택하신 영화는 15세 이상 관람가입니다.
			movieGradeDesc2 = '만 15세 미만의 고객님은(영,유아포함) 반드시 부모님 또는 성인 보호자의 동반하에 관람이 가능 합니다.'; // 만 15세 미만의 고객님은(영,유아포함) 반드시 부모님 또는 성인 보호자의 동반하에 관람이 가능 합니다.
		} else if ("AD04" == movieGrade) { // 청소년관람불가
			movieGradeDesc1 = '선택하신 영화는 청소년 관람불가입니다.'; // 선택하신 영화는 청소년 관람불가입니다.
			movieGradeDesc2 = '본 영화는 보호자를 동반하여도 만 18세 미만의 고객님은 (영,유아포함) 영화관람이 불가하며, 만 18세 이상이라도 고등학교 재학중인 고객님은 영화관람이 불가합니다.'; // 본 영화는 보호자를 동반하여도 만 18세 미만의 고객님은 (영,유아포함) 영화관람이 불가하며, 만 18세 이상이라도 고등학교 재학중인 고객님은 영화관람이 불가합니다.
		} else if ("AD06" == movieGrade) { // TODO 미정
			movieGradeDesc1 = '미정';
			movieGradeDesc2 = '미정';
		}

		var appendHtml = "";
		var obj = null;
		obj = $('#paymentAgree');
		obj.empty(); //초기화

		//if ("AD01" != movieGrade && "AD06" != movieGrade) {
		if ("AD02" == movieGrade || "AD03" == movieGrade || "AD04" == movieGrade) {
			appendHtml += "<input type=\"checkbox\" id=\"agree\"> ";
			appendHtml += "<label for=\"agree\"><span>" + movieGradeDesc1 + "</span><br><em>" + movieGradeDesc2+"</em></label>";

			obj.append(appendHtml);

			$('#paymentAgree').show();
		} else {
			$('#paymentAgree').hide();
		}

		$('#smallImage').attr('src', imagePath);
		$('#smallImage').attr('alt', movieNm);

        $(":checkbox[id='privPayChk']").prop('checked', false);
	});

	// 패키지 신청 더보기
	$(document).on('click', 'button.btnCls', function(e){
		e.preventDefault();
		if($('#packageBox').hasClass('act')){
            $('#packageBox').removeClass('act');
            $(this).text('상품 더보기');
        } else {
            $('#packageBox').addClass('act');
            $(this).text('상품 접기');
        }
	});

	//패키지 신청
	$(":checkbox[name='privPackCd']").change(function(){
	    var privSelectCntHtml = '<dt>패키지 신청내역<span>총 0건</span></dt>';
		var contents = '';
		var cnt = 0;
		$(":checkbox[name='privPackCd']").each(function(index) {
			if($(this).is(':checked') == true){
				var $id = $(this).val();

				contents += '<dd>'+$('#'+$id).text() + '<span>1건</span></dd>';
				cnt++;
			}

            privSelectCntHtml = '<dt>패키지 신청내역<span>총 ' + cnt +'건</span></dt>';
		});

		if(cnt == 0){
            contents = '<dd><span>0건</span></dd>';
        }

		$('#privPackContents').html(privSelectCntHtml+contents);
	});

	// 요청사항 더보기
    $(document).on('click', 'div.reqCk', function(e){
        e.preventDefault();
        if($('div.requestBox').hasClass('act')){
            $('div.requestBox').removeClass('act');
        } else {
            $('div.requestBox').addClass('act');
        }

    });

	// 바이트 계산
	$("#reqCtnt").on('input', function(e){
		var target = e.target;
		var targetVal = target.value;

		var RegExp = /[\{\}\[\]\/.,;:|\)*`^\-_┼<>@#$%&\'\"\\\(\=]/gi;
		var RegExp2 = /(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])/g;
		if (RegExp.test(targetVal)) {
            gfn_alertMsgBox({ msg: "특수문자(+,?,!,~,.)또는 이모티콘 사용이 제한됩니다." });
			target.value = targetVal.substring(0, targetVal.length - 1);
			return;
		}
		if (RegExp2.test(targetVal)) {
			gfn_alertMsgBox({ msg: "특수문자(+,?,!,~,.)또는 이모티콘 사용이 제한됩니다." });
			target.value = targetVal.replace(RegExp2, '');
			return;
		}
		if(target.length > 100) {
			target.value = targetVal.substring(0, 700);
			return;
		}
		$("#textareaCnt").text($("#reqCtnt").val().length+'/700');
	});

	//결제버튼 클릭
	$("#btn_private").click(function() {
		privateBooking();
	});

	//fdk결제창, 관람권 닫기 버튼 클릭
	$('#fdpayWin a.closeBtn, #layer_private_mcoupon .close-layer, #layer_private_scoupon .close-layer, #layer_private_annus .close-layer,'+
	  '#layer_private_mcoupon .btn-modal-close, #layer_private_scoupon .btn-modal-close, #layer_private_annus .btn-modal-close,'+
	  '#layer_private_mgift .close-layer, #layer_private_mgift .btn-modal-close').click(function() {

		deleteRedis();
	});

	//라디오 버튼 선택
	$('input:radio[name="rdo_pay"]').change(function(){

		if($(this).val() == 'mcoupon'){
			$("#sel_pay").removeAttr('disabled');
		} else {
			$("#sel_pay").attr('disabled', true);
		}

		var $val = $(this).val();
		var $id = '';
		var $href = '';

		if($val == 'annus'){		// 아너스
			$href = '#layer_private_annus';
			$id= 'open_layer_private_annus';
		}

		$('#div_href a').attr('href', $href).attr('id', $id);
	});


	$("#sel_pay").change(function() {
// 		var idx = $("input:radio[name='rdo_pay']:checked").index('[name="rdo_pay"]');

// 		$('.btn-group>.large').eq(idx).css({'display':'inline-block'});
// 		$('.btn-group>.large').eq(idx).siblings().hide();


		var $val = $(this).val();
		var $id = '';
		var $href = 'javaScript:void(0)';

		if($val == 'mcoupon'){	// 관람권
			$href = '#layer_private_mcoupon';
			$id= 'open_layer_private_mcoupon';
		} else if($val == 'scoupon'){  	// 스토어
			$href = '#layer_private_scoupon';
			$id= 'open_layer_private_scoupon';
		} else if($val == 'mgift'){		// 아이넘버
			$href = '#layer_private_mgift';
			$id= 'open_layer_private_mgift';
		}

		$('#div_href a').attr('href', $href).attr('id', $id);

	});

	
		try {
			var options = {};
			options.msg = $.parseHTML('&lt;p&gt;★프라이빗2호 GRAND OPEN★&lt;br&gt;많은 관심 부탁드립니다&lt;br&gt;*****************&lt;br&gt;&lt;br&gt;[더 부티크 프라이빗 이용 안내]&lt;br&gt;- ARS 번호: 1544-0070 &rarr; 5번&lt;br&gt;&#40;월~금｜12:00~19:00, 공휴일 제외&#41;&lt;br&gt;- 방문 2~3일 전 1544-0070 번호로 예약 안내 MMS 발송&lt;br&gt;※해당 번호가 차단되어 있지 않은지 확인부탁드리며, 예약 시 정확한 전화번호를 기입해주시기 바랍니다.&lt;br&gt;&lt;br&gt;[아바타: 물의 길 &#40;3D&#41; 안내]&lt;br&gt;- 프라이빗 1호 : 2D 관람 가능&lt;br&gt;- 프라이빗 2호 : 2D, 3D 관람 가능&lt;br&gt;※2호에서 &lt;아바타: 물의 길&gt; 관람 시 원하는 컨텐트를 요청 사항에 기재해주시기 바랍니다.&lt;br&gt;*****************&lt;br&gt;&lt;br&gt;[와인 콜키지 서비스 안내]&lt;br&gt;- 와인잔 8잔&#40;10잔&#41; 기준 20,000원&lt;br&gt;- 와인 구매 시 콜키지 서비스 무료&lt;br&gt;※이용 원하는 경우 요청 사항 기재해주시기 바랍니다.&lt;/p&gt;')[0].textContent;
			options.minWidth = 500;
			gfn_alertMsgBox(options);
		} catch (e) {
			console.error(e.message);
		}
	

	// 달력 오늘 선택
	$.datepicker._gotoToday = function(id) {
		var target = $(id);
		var inst   = this._getInst(target[0]);

		var arr    = option.crtDe.maskDate().split('.');

		inst.selectedDay = arr[2]
		inst.drawMonth   = inst.selectedMonth = arr[1] -1;
		inst.drawYear    = inst.selectedYear  = arr[0].toNumber();

		this._setDateDatepicker(target, new Date());
		this._selectDate(id, this._getDateDatepicker(target));
	}
});

//일자 선택 이후 콜백 메소드
function fn_tempMthd(opts, dates) {
	// 상영시간표에서 옴
	if (dates != undefined) {
		mbThCalendar.lastSavedDate = dates;

		// 상영관람가능일자 여부
		if ($.inArray(dates, allPlayDates) > -1) {

			// 달력날짜 설정
			$('[name=datePicker]').val(dates);

			// 일자 설정
			$(document.querySelector('[date-data="'+ dates +'"]')).addClass('on');

			// 상영목록 조회
			fn_playTimeList(dates);
		}

        // 패키지 이미지체크박스 초기화
        $(":checkbox[name='privPackCd']").removeAttr('checked');
        $('#privPackContents').html('<dt>패키지 신청내역<span>총 0건</span></dt><dd><span>0건</span></dd>');
        $('#reqCtnt').val('');
        $("#textareaCnt").text('0/700');
        $(":checkbox[id='privPayChk']").prop('checked', false);
	}
};


//달력 초기화 셋팅
function fn_setDatePicker(crtDe){

	// 달력 삭제
	$('[name=datePicker]').datepicker('destroy');

	// 달력 설정
	$('[name=datePicker]').datepicker({
		tempHtmlShow         : true
		, allPlayDateClassName : 'meagBox-selected-day'
		, allPlayDates         : allPlayDates
		, showButtonPanel      : true
		, minDate              : mbThCalendar.globalSvrDate.maskDate()
		, showAnim             : 'fadeIn'
		, onSelect             : fn_setFormDeOnclickCalendar
		, beforeShow           : function(input, inst) {

			// 달력위치 변경
			var _cal = inst.dpDiv;

			setTimeout(function(){
				_cal.position({
					of        : $('.time-schedule')
					, my        : 'right top'
					, at        : 'right top'
					, collision : 'none none'
				});
			}, 0);
		}
	});

	// 달력값 설정
	$('[name=datePicker]').val(crtDe);
}



/*달력 클릭으로 일자 이동*/
function fn_setFormDeOnclickCalendar(){

	var playDe = $('[name=datePicker]').val();

	// 상영대상일 여부
	if ($.inArray(playDe, allPlayDates) > -1) {

		// 상영 시간표의 날짜 이동
		mbThCalendar.events.trimdate({'mnDate' : playDe});

		// 상영 시간표에 날짜 선택
		$(document.querySelector('[date-data="'+ playDe +'"]')).addClass('on');

		// 상영목록 조회
		fn_playTimeList(playDe);

		// 패키지 이미지체크박스 초기화
		$(":checkbox[name='privPackCd']").removeAttr('checked');
		$('#privPackContents').html('<dt>패키지 신청내역<span>총 0건</span></dt><dd><span>0건</span></dd>');
		$('#reqCtnt').val('');
		$("#textareaCnt").text('0/700');
	} else {
		// 예매 불가시 예매가능일로 셋팅
		$('[name=datePicker]').val(option.playDe.maskDate());

		gfn_alertMsgBoxSize('예매가능일이 아닙니다.', 400, 170);
	}
}


// 상영날짜 목록
function fn_playDateList(){

	var paramData = { brchNo:brchNo, theabNo:theabNo };

	$.ajaxMegaBox({
		url: "/on/oh/ohb/BoutiqPrivate/playDateList.do",
		data: JSON.stringify(paramData),
		success: function (data, textStatus, jqXHR) {

			var playDeArray = [];
            allPlayDates = [];                  //달력활성일자
            disdaysFromServer = [];
			dowKorNmList = [];
			if( 0 < data.dateList.length){
				$.each(data.dateList, function(i, param) {
					// 관 변경시 상영일자 변경
					if(i == 0){
						option.playDe = param.playDe;
					}

					playDeArray.push(param.playDe);
					// 휴일일자셋팅
					if (param.scrdtDivCd == 'HLDY') {
						setHldyAdopt(param.playDe.maskDate());
					}
					setDisdyAdopt(param.playDe.maskDate());     //영화편성일자셋팅
					allPlayDates.push(param.playDe.maskDate()); //달력셋팅
					dowKorNmList.push({playDe:param.playDe, dowKorNm:param.dowKorNm});
				});
			} else {

				// 달력 초기화 셋팅
				option.playDe = option.crtDe;
				playDeArray.push(data.nextDe);

			}

			fn_playTimeList(playDeArray[0]);

			$('#playDe').val(playDeArray[0]);
			$('#datePicker').val(playDeArray[0].maskDate());

			mbThCalendar.globalSvrDate = option.crtDe;		// 서버일자

			mbThCalendar.setUI();

			// 달력 설정 및 날짜 설정
			fn_setDatePicker(playDeArray[0].maskDate());	// 스케쥴일자

			// 예매 가능일
			if (allPlayDates.length > 0) {

				var $obj = $(document.querySelector('[date-data="'+ playDeArray[0].maskDate() +'"]'));

				// 상영 시간표의 날짜 이동
				if ($obj.length == 0 || $obj.attr('tabindex') == '-1') {

					// 상영 시간표에 날짜 설정
					mbThCalendar.events.trimdate({'mnDate' : playDeArray[0].maskDate()});
				}

				// 상영 시간표에 조회 날짜 선택
				$(document.querySelector('[date-data="'+ playDeArray[0].maskDate() +'"]')).addClass('on');
			} /*else {
				mbThCalendar.events.trimdate({ mnDate: playDeArray[0].maskDate(), callback:''});
			}*/

		},
		error: function(xhr,status,error){
			var err = JSON.parse(xhr.responseText);
			alert(xhr.status);
			alert(err.message);
		},
		complete: function() {

		}
	});
}

// 상영시간 목록(매진정보 포함)
function fn_playTimeList(playDate){

	playDate = playDate.replaceAll('.', '');
	$("input:radio[name='time']").prop('checked',false);
	//var playDate = $(obj).attr('play-date');

	var paramData = { playDate:playDate, brchNo:brchNo, theabNo:theabNo };

	$.ajaxMegaBox({
		url: "/on/oh/ohb/BoutiqPrivate/playTimeList.do",
		data: JSON.stringify(paramData),
		success: function (data, textStatus, jqXHR) {

			fn_playTimeListUpt(data.timeList);
			fn_ticketAmtInfo(data.timeList);

			if(0 < data.timeList.length){
				$.each(data.timeList, function(i){
                    fn_playMovieList(data.timeList[i].playDe);
                    return false;
				});
			} else {
				fn_playMovieListUpt([]);
			}

		},
		error: function(xhr,status,error){
			var err = JSON.parse(xhr.responseText);
			alert(xhr.status);
			alert(err.message);
		}
	});
}

// 상영시간 갱신
function fn_playTimeListUpt(list){
	var appendHtml = "";
	var obj = null;

	obj = $('#playTimeList');
	obj.empty(); //초기화

	if(0 < list.length){
		for(var i=0; i<list.length; i++) {
			var soldOutYn = list[i].soldOut;
			var sDisabled = "";

			if (soldOutYn == "Y") { // 매진
				sDisabled = "disabled";
			}

			appendHtml += "<span class=\"time-sel";
			if (soldOutYn == "Y") {
				appendHtml += " soldout";
			}
			appendHtml += "\">";
			appendHtml += "<input type=\"radio\" id=\"t"+(i+1)+"\" name=\"time\" play-schdl-no=\""+list[i].playSchdlNo+"\" brch-no=\""+list[i].brchNo+"\" theab-no=\""+list[i].theabNo+"\" ";
			appendHtml += "value=\"" + list[i].playStartTime.replaceAll( ":", "") + "\" " + sDisabled + ">";
			appendHtml += "<label for=\"t"+(i+1)+"\"><em class=\"font-roboto regular\">" + list[i].playStartTime + "</em> ";
			if (soldOutYn == "Y") {
				appendHtml += "<span>판매완료</span></label>";
			}
			appendHtml += "</span>";
		}
		obj.append(appendHtml);
	}
}

// 부티크프라이빗 대관요금 조회
function fn_ticketAmtInfo(list){
	var paramData = {playSchdlNo:null, brchNo:brchNo};

	if(0 < list.length){
		$.each(list, function(i, value){
			if('N' == list[i].soldOut){
				paramData = {playSchdlNo: list[i].playSchdlNo, brchNo:brchNo};
				return false;
			}
		});
    }

    $.ajaxMegaBox({
        url: "/on/oh/ohb/BoutiqPrivate/ticketAmtInfo.do",
        data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {
            var ticketAmtList = data.ticketAmtList;
            var html = '';

            $.each(ticketAmtList, function(index, value){
                html += '<tr>';
                html += '<td>프라이빗 '+ (index+1) + ' 호</td>';
                html += '<td><span>'+ticketAmtList[index].wkdayAmt+'</span>원</td>';
                html += '<td><span>'+ticketAmtList[index].wkendAmt+'</span>원</td>';
                html += '<td >'+ticketAmtList[index].seatRow+'</td>';
                if(index == 0){
                    html += '<td rowspan="2">3시간</td>';
                }
                html += '</tr>';
            });

            $('#ticketAmtTable').html(html);
        },
        error: function(xhr,status,error){
            var err = JSON.parse(xhr.responseText);
            alert(xhr.status);
            alert(err.message);
        }
    });
}

//영화 목록
function fn_playMovieList(playDate){

	$("input:radio[name='time']").prop('checked',false);

	// var playDate = $(obj).attr('play-date');

	var paramData = { playDate:playDate, brchNo:brchNo, theabNo:theabNo };

	$.ajaxMegaBox({
		url: "/on/oh/ohb/BoutiqPrivate/playMovieList.do",
		data: JSON.stringify(paramData),
		success: function (data, textStatus, jqXHR) {
			fn_playMovieListUpt(data.movieList);
		},
		error: function(xhr,status,error){
			var err = JSON.parse(xhr.responseText);
			alert(xhr.status);
			alert(err.message);
		}
	});
}

//영화목록 갱신
function fn_playMovieListUpt(list){
	var appendHtml = "";
	var obj = null;

	obj = $('#playMovieList');
	obj.empty(); //초기화

	if(0 < list.length){
		$('.plan-slider-control').show();

		appendHtml += "<div class=\"swiper-wrapper\">";

		for(var i=0; i<list.length; i++) {

			var admisClassCd = list[i].admisClassCd;
			var movieGrade = "";

			if ("AD01" == admisClassCd) { // 전체관람가
				movieGrade = "age-all";
			} else if ("AD02" == admisClassCd) { // 12세이상관람가
				movieGrade = "age-12";
			} else if ("AD03" == admisClassCd) { // 15세이상관람가
				movieGrade = "age-15";
			} else if ("AD04" == admisClassCd) { // 청소년관람불가
				movieGrade = "age-19";
			}

			appendHtml += "<div class=\"cell swiper-slide \" style=\"width: 144px;\">";
			appendHtml += "<a href=\"#\" title=\"" + list[i].movieNm + "\" movie-nm=\"" + list[i].movieNm + "\" movie-no=\"" + list[i].movieNo + "\" movie-grade=\""+admisClassCd+"\" play-kind-nm=\""+ list[i].playKindNm+"\">";
			//appendHtml += "<a href=\"#\" movie-nm=\"" + list[i].movieNm + "\" movie-no=\"" + list[i].movieNo + "\" movie-grade=\""+admisClassCd+"\">";
			appendHtml += "<p class=\"img\"><img src=\"" + nvl(list[i].movieImgPath).posterFormat('_420') + "\" alt=\"" + list[i].movieNm + "\" onerror=\"noImg(this);\"/></p>";
			appendHtml += "<p class=\"tit\"><span class=\"movie-grade " + movieGrade + "\">" + list[i].admisClassCdNm + "</span>" + list[i].movieNm + "</p>";
			appendHtml += "<div class=\"btn\">선택</div>";
			appendHtml += "</a>";
			appendHtml += "</div>";
		}
		appendHtml += "</div>";

		obj.append(appendHtml);

		// 대관예매 영화 선택
		if( $('.choice-movie').length > 0 ){

			$cell_leng = $('.choice-movie').find('.cell').length;

			// 대관예매 영화 선택
			if( $cell_leng >= 6 ){
				var plan_store_swiper = new Swiper('.choice-movie', {
					init : false,
					loop : false,
					speed : 300,
					// spaceBetween: 30,
					slidesPerView: 5,
					centeredSlides : false,
					navigation : {
						prevEl : '.btn-plan-prev',
						nextEl : '.btn-plan-next',
					},
					ally : {
						enabled : false
					}
				});
			}

			else if( $cell_leng < 6 ){
				$('.plan-slider-control').hide();
				var plan_store_swiper = new Swiper('.choice-movie', {
					init : false,
					loop : false,
					speed : 300,
					// spaceBetween: 30,
					slidesPerView: 5,
					centeredSlides : false,
					navigation : false,
					ally : {
						enabled : false
					}
				});
			}

			plan_store_swiper.init();
		}

	} else {
		$('.plan-slider-control').hide();
	}
}

//결재금액
function fn_playApprPrice(playSchdlNo){
	paramData = { playSchdlNo:playSchdlNo };

	$.ajaxMegaBox({
		url: "/on/oh/ohb/BoutiqPrivate/playPriceList.do",
		data: JSON.stringify(paramData),
		success: function (data, textStatus, jqXHR) {
			var apprPrice = data.approvalPrice;
			$('.total').find('em').text(apprPrice.format());
		},
		error: function(xhr,status,error){
			var err = JSON.parse(xhr.responseText);
			alert(xhr.status);
			alert(err.message);
		}
	});
}

//프라이빗 대관예매
function privateBooking() {
	var mGrade = $('input[name="movieGrade"]').val();

	if ($('input[name="playSchdlNo"]').val() == "") {
		gfn_alertMsgBox({ msg: '관람하실 시간을 선택해주세요. ' });

		return;
	}

	if ($('input[name="movieNo"]').val() == "") {
		gfn_alertMsgBox({ msg: '관람하실 영화를 선택해주세요.' });

		return;
	}


	if($('input:radio[name=rdo_pay]:checked').val() == 'mcoupon' && $("#sel_pay option:selected").val() == ''){
		gfn_alertMsgBox({ msg: '관람권/상품권을 선택해주세요.' });
		return;
	}

	if ("AD02" == mGrade || "AD03" == mGrade || "AD04" == mGrade) {
		if ($(":checkbox[id='agree']").is(':checked') == false) {
			gfn_alertMsgBox({ msg: '상영등급 확인 후 체크해주세요.' });
			$(":checkbox[id='agree']").focus();

			return;
		}
	}

	var gubun = $("input:radio[name='rdo_pay']:checked").val();

	if($("input:radio[name='rdo_pay']:checked").val() == 'mcoupon'){
		gubun = $("#sel_pay option:selected").val();
	}

	if($(":checkbox[id='privPayChk']").is(':checked') == false){
        gfn_alertMsgBox({ msg: '환불규정 확인 후 체크해주세요.' });
        return;
    }

	//결제준비
	preparePayPrivate(gubun);
}

//결제 준비
function preparePayPrivate(gubun) {
	var playSchdlNo = $("#seatViewFormPlaySchdlNo").val();
	var totalAmt    = $('.total').find('em').text().replaceAll(',', '').nvlNum(0);
	var movieNo     = $('#movieNo').val();
	var drnkAddAt   = 'N';
	var lastPayMethod = gubun;
	var privPackList = [];

    $(":checkbox[name='privPackCd']").each(function() {
        if($(this).is(':checked') == true){
            var $id = $(this).val();
            var $amt = $('#'+$id).attr('price');

            privPackList.push({privPackCd: $id, privPackAmt:$amt});

			drnkAddAt = 'Y';
        }
    });

	var reqCtnt = $('#reqCtnt').val();
	privPackList.push({privPackCd: 'PPKC00', privPackAmt:0, reqCtnt:reqCtnt});

	var paramData   = {playSchdlNo:playSchdlNo, totalAmt:totalAmt, movieNo:movieNo, lastPayMethod:lastPayMethod, drnkAddAt:drnkAddAt, privPackList:privPackList};

	$.ajaxMegaBox({
        url: "/on/oh/ohz/PayPrivate/preparePrivate.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
		clickLmtChk: true, //중복클릭 방지 실행
        success: function (data, textStatus, jqXHR) {
        	var lastPayInfo = data.returnMap;

        	if (!msgPrivateChk(data)) {
        		return;
        	}

			//거래번호 세팅
			$("#lastPayMethod").val(gubun);
        	$("#transNo").val(data.returnMap.sellTranNo);
        	$("#completeTransNo").val(data.returnMap.sellTranNo);

        	if (gubun == 'credit') {
        		//fdk 결제창 호출
            	fdkPayProc();
        	} else if (gubun == 'mcoupon') {
        		$("#open_layer_private_mcoupon").trigger("click");
        		searchMcouponChg();
        	} else if (gubun == 'scoupon') {
        		$("#open_layer_private_scoupon").trigger("click");
        		searchStoreChg();
        	} else if (gubun == 'annus') {
                $("#open_layer_private_annus").trigger("click");
            } else if (gubun == 'mgift') {
                $("#open_layer_private_mgift").trigger("click");
//                 layer_private_mgift
            }
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg: err.msg });
        	if (gubun == 'mcoupon') {
        		$('#layer_private_mcoupon .close-layer').click();
        	}
        },
        complete: function(xhr){
         	clearLmt(); //중복제한 초기화
        }
	});
}

//결제메시지 체크
function msgPrivateChk(data) {
	//알림메시지 노출
	if (data.statCd != "0") {  //비로그인
		$('#layer_private_mcoupon .close-layer').click();
		$('#layer_private_scoupon .close-layer').click();

		if (data.statCd == "-777") {  //비로그인
			var options        = {};
			options.msg        = '로그인 후 이용가능한 서비스 입니다.\\n로그인 하시겠습니까?';
			//options.msg        = '마케팅 수신 동의일로부터 2년이 경과되어, 수신에 대한 재동의 안내를 시행하고 있습니다. \n메가박스의 다양한 소식 및 이벤트를 받고 싶으시면 수신동의 재설정이 필요합니다.  \n수신동의 재설정을 진행 하시겠습니까?\n\n[수신동의 정보]\n&#39;+lstSmsRcvAgreeDt+&#39;'.replaceAll('\n','<br/>');
			options.confirmFn  = fn_ViewLoginPopupForBoutiq;
// 			options.okBtnTxt     = "확인";
// 		    options.cancelBtnTxt = "다음에 하기";
			options.minWidth  = 400;
			options.minHeight = 300;
			gfn_confirmMsgBox(options);
			return;


    	}
		else {
			if (data.msg != null && data.msg !="") {
				gfn_alertMsgBox({ msg: data.msg });
			}
		}
		return false;
	}

	return true;
}

//로그인 팝업창 호출
function fn_ViewLoginPopupForBoutiq(){
	fn_viewLoginPopup('BoutiqPrivateL','pc','','','N');
}

//레디스 삭제
function deleteRedis() {

	var transNo = $("#transNo").val();
	if( '' != transNo ){
		var paramData = { transNo:transNo};

		$.ajax({
			url: "/on/oh/ohz/PayPrivate/deleteRedis.do",
			type: "POST",
			contentType: "application/json;charset=UTF-8",
			dataType: "json",
			data: JSON.stringify(paramData),
			success: function (data, textStatus, jqXHR) {
				//메시지 없음
			},
			error: function(xhr,status,error){
				var err = JSON.parse(xhr.responseText);
				//메시지 없음
			}
		});
	}
}

//========================================================================================
//fdk 결제
//========================================================================================
function fdkPayProc() {
	var transNo  = $("#transNo").val();
	var useAmt   = $('.total').find('em').text().replaceAll(',', '').nvlNum(0);
	var lastPayMethod = $("#lastPayMethod").val();

	$("#ifrm_transNo").val(transNo);
	$("#ifrm_useAmt").val(useAmt);

	document.ifrm.submit();
	layer_open('fdpayWin');	//"FD_PAY_FRAME" 프레임을 가지고 있는 DIV 영역의 ID를 입력(sample 이용 시 : id="fdpayWin")
}

//레이어 팝업 호출 시 처리
function layer_open(el){
	wrapWindowByMask();			//레이어 팝업 활성화 시 하단 MASKING 처리를 위한 함수

	var fdlayer = $('#' + el);	//레이어의 id를 fdlayer변수에 저장
	fdlayer.fadeIn();			//레이어 실행

	// 화면의 중앙에 레이어를 띄운다.
	fdlayer.css('margin-top' , '-'+fdlayer.outerHeight()/2+'px');
	fdlayer.css('margin-left', '-'+fdlayer.outerWidth()/2+'px');
	fdlayer.center();
	fdlayer.find('a.closeBtn').click(function(e){
		fdlayer.fadeOut();			//'Close'버튼을 클릭하면 레이어가 사라진다.
		e.preventDefault();
		document.getElementById("mask").style.display = "none";	//레이어 팝업 비활성화 시 하단 MASKING 표시 해제
		FD_PAY_FRAME.location.href = "/on/oh/ohz/PayBooking/blank.do";	//빈 페이지로 프레임 영역 변경
	});
}

//레이어 팝업 하단 영역 마스킹 처리(레이어 팝업 호출 시 사용)
function wrapWindowByMask(){
  //화면의 높이와 너비를 구한다.
  var maskHeight = $(document).height();
  var maskWidth  = $(window).width();

  //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
  $('#mask').css({'width':maskWidth,'height':maskHeight});

  //애니메이션 효과
  $('#mask').fadeIn(1000);
  $('#mask').fadeTo("slow",0.6);
}

//최종결제
function fdkAuthResult(fdkResultData) {
	//alert("rtncode: " + rtncode + " , rtnmsg:" + rtnmsg + ",fdtid:"+fdtid);
	if (fdkResultData.Code != '0000') {	//오류시 alert 메시지 팝업 후 레이어 닫기
		gfn_alertMsgBox({ msg: fdkResultData.Msg });
		$('#fdpayWin').find('a.closeBtn').click();
		return false;
	}
	var transNo = $("#transNo").val();

	var paramData = {transNo:transNo, Code:fdkResultData.Code, Msg:fdkResultData.Msg , FDTid:fdkResultData.FDTid };
	$.ajax({
      	url: "/on/oh/ohz/PayPrivate/execPrivatePayment.do",
      	type: "POST",
      	contentType: "application/json;charset=UTF-8",
      	dataType: "json",
		data: JSON.stringify(paramData),
      	success: function (data, textStatus, jqXHR) {
	      	//최종 결제 테스트

	      	if (data.statCd != "0") {
	      		gfn_alertMsgBox({ msg: data.msg });
	      		$('#fdpayWin').find('a.closeBtn').click();
	      	} else {
	      		//완료페이지 이동
	          	goCompleteBooking();
	      	}

      	},
      	error: function(xhr,status,error){
      		var err = JSON.parse(xhr.responseText);
      		//err.statCd 에 따라서 이전화면으로 리턴 가능토록
      		gfn_alertMsgBox({ msg: err.msg });
      	}
	});
}

//예매 완료 페이지 이동
function goCompleteBooking() {
	var contentUrl = "/booking/payment-successcomplete";
	$("#returnUrl").val(top.location.pathname);
  	$("#seatViewForm").attr("method","post");
  	$("#seatViewForm").attr("action",contentUrl);
  	$("#seatViewForm").submit();
}

//현금 영수증 팝업 여부 체크
function chkCshRec() {
	var transNo       = $("#transNo").val();
	var paramData     = {transNo:transNo};
	var lastPayMethod = $('#lastPayMethod').val();

	$.ajax({
        url: "/on/oh/ohz/PayPrivate/chkCshRecAt.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {

        	$('#cashBillYn').val('N');
    		$('#cashrecIssueCd').val('');
        	var cshRecInfo = data.cshRecInfo;

        	if (cshRecInfo != null && cshRecInfo != undefined) {
        		var tktCashrecAmt = cshRecInfo.tktCashrecAmt;

				//현금 영수증 금액이 0 이상인 경우
        		if (tktCashrecAmt > 0) {
        			$('#cashBillAmt').text(String(tktCashrecAmt).maskNumber());
        			$('#cash_pop').click();
        		} else {
        			//최종결제
        			execPrivatePayment();
        		}
        	}
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	$('#cashBillYn').val('N');
    		$('#cashrecIssueCd').val('');
    		errBookingChk(err.msg);
        }
	});
}


//최종 결제 실행
function execPrivatePayment() {
	var transNo         = $("#transNo").val();
	var cashBillYn      = $('#cashBillYn').val();
	var cashrecIssueCd  = $('#cashrecIssueCd').val();
	var bizmDivCd       = $(':radio[name="bizmDivCd"]:checked').val();
	var cashBillPhoneNo = $('#cashBillPhoneNo').val();
	var cashrecPubAmt   = $('#cashBillAmt').text().replaceAll(',', '');


	var paramData = { transNo:transNo,
					  cashBillYn:cashBillYn,
	          		  cashrecIssueCd:cashrecIssueCd,
	          		  bizmDivCd:bizmDivCd,
	          		  cashBillPhoneNo:cashBillPhoneNo,
	          		  cashrecPubAmt:cashrecPubAmt };

	$.ajax({
        url: "/on/oh/ohz/PayPrivate/execPrivatePayment.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {
        	remainAmt = data.returnMap.remainAmt;

        	if (data.statCd != "0") {
        		gfn_alertMsgBox({ msg: data.msg });
        		//경우에 따라서 back 등 결정 필요
        		return;
        	}

        	//예매 완료 페이지 이동
        	goCompleteBooking();
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg: err.msg });
        }
	});
}



jQuery.fn.center = function () {
  this.css("position","absolute");
  this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + 350 + "px");
  return this;
}



///////////////////////////////////////////////////////////////////////////////
// TODO 스크립트 추가 /////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

$.fn.megaBoxCardNumberCheck = function() {
    $(this).on("keypress",function(e){
        if ( !e.key.isNumber() && e.key != '-') return false;
    })
    $(this).on("focus",function(e){
        $(this).val($('#'+$(this).attr('id')+'_hid').val());
    })
    $(this).on("focusout",function(e){
        var val = $(this).val().replace(/[^0-9]+/g, '');
        $(this).val(val);
        $('#'+$(this).attr('id')+'_hid').val(val);

        var makNo = $(this).val().maskCardNo();
        var varArr = makNo.split('-');
        if (varArr.length > 3) {
            varArr[2] = varArr[2].replaceAll(/[0-9]/g, '*');
        }

        $(this).val(varArr.join("-"));
    })
};



//오류메시지 체크 : 999 로 시작되는 오류 메시지 처음페이지로 리턴
function errBookingChk(msg) {
    //알림메시지 노출
    if (msg != null && msg != "") {
        if (msg.indexOf("999:") == 0) {  //온라인 999 좌석도로
            var almsg = msg.substring(4, msg.length).replaceAll('9999:', '');
            if (almsg == "msg.pay.overPayTime") {  //결제가능 시간이 초과되어 좌석선택부터 다시 진행바랍니다. 메시지는 예매화면에서 팝업한다.(ria 체크 필요)
                goPrePageInitSeat('BookingPay_msg94');
            } else if (almsg == "msg.pay.over.session") {  //결제가능 시간이 초과되어 좌석선택부터 다시 진행바랍니다. 메시지는 예매화면에서 팝업한다.(ria 체크 필요)
                
                var sessMsg = "로그인 가능시간이 초과되었습니다.<br/> 재 로그인 후 이용 바랍니다.";
                gfn_alertMsgBox({ msg: sessMsg, callback:goBookingFrist });
                
                
            } else {
                gfn_alertMsgBox({ msg: almsg, callback:goPrePageInitSeat });
            }
        } else if (msg.indexOf("888:") == 0) {  //온라인 888 예매 처음으로
            var almsg = msg.substring(4, msg.length).replaceAll('9999:', '');
            gfn_alertMsgBox({ msg: almsg, callback:goBookingFrist });
        } else {
            if (msg.indexOf("9999:") == 0) {  //현장용. 9999 제외 메시지 노출
                var almsg = msg.substring(5, msg.length);
                gfn_alertMsgBox({ msg: almsg });
            } else {
                gfn_alertMsgBox({ msg: msg });
            }
        }
    }
}

//메시지 체크
function msgBookingLoginChk(data) {
    //알림메시지 노출
    if (data.statCd == "-777") {  //비로그인
        //메가박스는 예매 또는 상영스케쥴로 이동
        
        gfn_alertMsgBox({ msg: data.msg, callback:goBookingFrist });
        
        //리아는 예매창 닫고 다시 진행 alert
        

        return false;
    } else if (data.statCd == "0") {
        try {
            var chkAddAmt = data.returnMap.chkAddAmt;
            if (chkAddAmt > 0) {
                gfn_alertMsgBox('해당 관람권은 '+String(chkAddAmt).maskNumber()+'원 추가금액 지불시\n관람이 가능합니다.')

            }
        } catch(e) {
            //console.log("추가금액 누락.....");
        }
    }

    return true;
}

//할인내역 적용
function setMovieDcInfo(policyList) {
    $('.price-process > .box').eq(1).find('.data').remove();
    var prependText = '';
    var sumApplyAmt = 0;
    var sumAddAmt   = 0;

    for(var i=0;i<policyList.length;i++) {
        var applyAmt = policyList[i].applyAmt;
        if (applyAmt > 0) {
            prependText = '<div class="data"><span class="tit">' + policyList[i].meanPrnNm;
            if (policyList[i].cponType == 'CMBND' || policyList[i].cponType == 'CPON') {
                prependText += ' <em>' + policyList[i].applyCponCnt + '</em> 매</span>';
            } else {
                prependText += ' <em>' + policyList[i].applyCnt + '</em> 매</span>';
            }

            prependText += '<span class="price">' + String(policyList[i].applyAmt).maskNumber() + '</span>';
            if (policyList[i].methodName == 'skt-normal') {
                prependText += '<button type="button" class="btn-delete" method="skt">삭제</button></div>';
            } else {
                prependText += '<button type="button" class="btn-delete" method="' + policyList[i].methodName + '">삭제</button></div>';
            }

            sumApplyAmt += applyAmt;

            if (policyList[i].applyAddAmt != null && policyList[i].applyAddAmt != undefined) {
                sumAddAmt   += policyList[i].applyAddAmt;
            }

            $('.price-process > .box').eq(1).prepend(prependText);

            if (policyList[i].methodName == 'skt-normal') {
                $('#btn_pay_skt').closest('div').addClass('on')
            } else {
                $('#btn_pay_' + policyList[i].methodName).closest('div').addClass('on')
            }

        } else {

            if (policyList[i].methodName == 'skt-normal') {
                $('#btn_pay_skt').closest('div').removeClass('on')
            } else {
                $('#btn_pay_' + policyList[i].methodName).closest('div').removeClass('on')
            }
        }
    }

    $('.price-process > .box').eq(1).find('.all').find('em').text(sumApplyAmt==0?'0':'-'+String(sumApplyAmt).maskNumber());

    //추가결제금액
    if (sumAddAmt > 0) {
        $('.pay-area > .add-thing').eq(0).find('.money').text( '+' + String(sumAddAmt).maskNumber() );
    } else {
        $('.pay-area > .add-thing').eq(0).find('.money').text( '0' );
    }

    //최종 결제 금액 적용
    setLastPayAmt(policyList);

    //삭제 이벤트 적용
    setCancelEvent();

    if ($('#pre_disc_all_text').text() != '') {  //bc 선할인 초기화
        pre_disc_init();
    }
}



//최종 결제 금액 적용
function setLastPayAmt(policyList) {
    //전체금액
    var allSumAmt = parseInt($('.price-process > .box').eq(0).find('.all').find('em').text().replaceAll(',', '').nvlNum(0));

    //할인금액
    var allDiscAmt = parseInt($('.price-process > .box').eq(1).find('.all').find('em').text().replaceAll(',', '').replaceAll('-', '').nvlNum(0));

    //추가금액
    var allAddAmt = parseInt($('.pay-area > .add-thing').eq(0).find('.money').text().replaceAll(',', '').replaceAll('-', '').nvlNum(0).replaceAll('+', '').nvlNum(0));

    //최종결제금액
    var remainAmt = allSumAmt + allAddAmt - allDiscAmt;
    $('.pay-area > .pay').eq(0).find('.money').find('em').text( String(remainAmt).maskNumber() );

    //최종 결제 금액 0인경우 disabled 처리
    if (allSumAmt + allAddAmt - allDiscAmt == 0) {
        setAllButtonDispInfo(policyList, 'disable');

        //결제수단 disabled
        $('#lastPayMethod').val('');
        $(':radio[name="radio_payment"]').prop('checked', false);
        $(':radio[name="radio_payment"]').attr('disabled', true);

        $('.select-payment-card').hide();
    } else {
        setAllButtonDispInfo(policyList, 'enable');

        //결제수단 enabled
        $(':radio[name="radio_payment"]').attr('disabled', false);

        if ($('#lastPayMethod').val() == 'credit') {
            $('.select-payment-card').show();
        } else {
            $('.select-payment-card').hide();
        }
    }

    //실시간 변경
    setButtonPolicyInfo(policyList);

    //현대 M 포인트, 문화누리 사용시 결제수단 disabled
    var hyCultApply = '';
    for(var i=0;i<policyList.length;i++) {
        if (('hydm' == policyList[i].methodName || 'culturenuri' == policyList[i].methodName) && policyList[i].applyAmt > 0) {
            hyCultApply = policyList[i].methodName;
            break;
        }
    }

    if (hyCultApply != '') {
        //$('.select-payment > button').attr('disabled', true);
        $(':radio[name="radio_payment"]').attr('disabled', true);

        $('.select-payment-card').hide();

        if ('hydm' == hyCultApply) {
            $('#btn_pay_culturenuri').addClass('disabled');
            $('#btn_pay_hydm').removeClass('disabled');
        } else {
            $('#btn_pay_hydm').addClass('disabled');
            $('#btn_pay_culturenuri').removeClass('disabled');
        }

        $('#lastPayMethod').val('credit');
    }

    //최종 결제수단 명칭 세팅
    changePaymentName(policyList);

}



///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


</script>
<!-- 레이어 팝업 처리 시 화면 영역 시작 -->
<div id="mask"></div>
<div id="fdpayWin" class="fdLayer">
	<div class="fdContainer">
		<div class="pop-conts">
			<iframe id="FD_PAY_FRAME" name="FD_PAY_FRAME" title="결제팝업창" frameborder="1" width="560" height="600" style="background-color:#FFFFFF;" src="/resources/booking/saved_resource.html"></iframe>
			<div class="fdBtn">
				<a href="javaScript:void(0)" title="팝업 닫기" class="closeBtn">Close</a>
			</div>
		</div>
	</div>
</div>
<!-- 레이어 팝업 처리 시 화면 영역 끝 -->

<!-- container -->
<div class="container">

	<!-- 페이지 타이틀 마크업 완전 변경 class 주의 -->
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
				<a href="/booking" title="예매 페이지로 이동">예매</a>
				<a href="/booking/privatebooking" title="빠른예매 페이지로 이동">더 부티크 프라이빗 대관예매</a>
			</div>

			<!-- 2019-07-24 include로 변경 -->
			
			<!--// 2019-07-24 include로 변경 -->
		</div>
	</div>

	<!-- contents -->
	<div id="contents" class="pt00">

		<!-- boutique-reserve-top  -->
		<div class="private2022">
			<div class="inner-wrap">
                <div class="headline">
                    <h3 class="tit">코엑스 더 부티크 프라이빗 대관예매</h3>
                    <img src="/resources/booking/private_01.png">
                </div>

                <!-- 영화선택부분 -->
				<div class="b_reserve_box">
                    <!-- time-schedule -->
                    <div class="time-schedule">
                        <div class="wrap">

                            <!-- 이전날짜 -->
                            <button type="button" title="이전 날짜 보기" class="btn-pre" disabled="true">
                                <i class="iconset ico-cld-pre"></i> <em>이전</em>
                            </button>
                            <!--// 이전날짜 -->

                            <div class="date-list">
                                <!-- 년도, 월 표시 -->
                                <div class="year-area">
                                    <div class="year" style="left: 30px; z-index: 1; opacity: 1;">2023.02</div>
                                    <div class="year" style="left: 450px; z-index: 1; opacity: 0;"></div>
                                </div>


                                <div class="date-area"><div class="wrap" style="position: relative; width: 2100px; border: none; left: -70px;"><button class="disabled" type="button" date-data="2023.02.06" month="1" tabindex="-1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">6<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">월</span><span class="day-en" style="pointer-events:none;display:none">Mon</span></button><button class="disabled" type="button" date-data="2023.02.07" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">7<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">오늘</span><span class="day-en" style="pointer-events:none;display:none">Tue</span></button><button class="on" type="button" date-data="2023.02.08" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">8<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">내일</span><span class="day-en" style="pointer-events:none;display:none">Wed</span></button><button class="" type="button" date-data="2023.02.09" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">9<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">목</span><span class="day-en" style="pointer-events:none;display:none">Thu</span></button><button class="" type="button" date-data="2023.02.10" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">10<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">금</span><span class="day-en" style="pointer-events:none;display:none">Fri</span></button><button class="sat" type="button" date-data="2023.02.11" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">11<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">토</span><span class="day-en" style="pointer-events:none;display:none">Sat</span></button><button class="holi" type="button" date-data="2023.02.12" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">12<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">일</span><span class="day-en" style="pointer-events:none;display:none">Sun</span></button><button class="" type="button" date-data="2023.02.13" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">13<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">월</span><span class="day-en" style="pointer-events:none;display:none">Mon</span></button><button class="" type="button" date-data="2023.02.14" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">14<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">화</span><span class="day-en" style="pointer-events:none;display:none">Tue</span></button><button class="" type="button" date-data="2023.02.15" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">15<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">수</span><span class="day-en" style="pointer-events:none;display:none">Wed</span></button><button class="" type="button" date-data="2023.02.16" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">16<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">목</span><span class="day-en" style="pointer-events:none;display:none">Thu</span></button><button class="" type="button" date-data="2023.02.17" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">17<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">금</span><span class="day-en" style="pointer-events:none;display:none">Fri</span></button><button class="sat" type="button" date-data="2023.02.18" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">18<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">토</span><span class="day-en" style="pointer-events:none;display:none">Sat</span></button><button class="holi" type="button" date-data="2023.02.19" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">19<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">일</span><span class="day-en" style="pointer-events:none;display:none">Sun</span></button><button class="" type="button" date-data="2023.02.20" month="1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">20<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">월</span><span class="day-en" style="pointer-events:none;display:none">Mon</span></button><button class="" type="button" date-data="2023.02.21" month="1" tabindex="-1"><span class="ir">2023년 2월</span><em style="pointer-events:none;">21<span style="pointer-events:none;" class="ir">일</span></em><span class="day-kr" style="pointer-events:none;display:inline-block">화</span><span class="day-en" style="pointer-events:none;display:none">Tue</span></button></div></div>
                            </div>

                            <!-- 다음날짜 -->
                            <button type="button" title="다음 날짜 보기" class="btn-next">
                                <i class="iconset ico-cld-next"></i> <em>다음</em>
                            </button>
                            <!--// 다음날짜 -->

                            <!-- 달력보기 -->
                            <div class="bg-line">
                                <input type="hidden" id="datePicker" name="datePicker" value="2023.02.08" class="hasDatepicker">
                                <button type="button" class="btn-calendar-large" title="달력보기">달력보기</button>

                            </div>
                            <!--// 달력보기 -->
                        </div>
                    </div>
                    <!--// time-schedule -->

                    <div class="boxitem date">
                        <p class="tit">상영관</p>
                        <div class="roomBox">
                            
                            
                                
                                
                                    
                                
                                <div class="room on"> <!--on 선택시 추가-->
                                    <span theabno="20" seatrow="10" theabexpono="2" class="new">
                                        프라이빗 2호<br>(10석)
                                    </span>
                                </div>
                            
                                
                                
                                <div class="room"> <!--on 선택시 추가-->
                                    <span theabno="19" seatrow="8" theabexpono="1">
                                        프라이빗 1호<br>(8석)
                                    </span>
                                </div>
                            
                        </div>
                    </div>

					<div class="boxitem time">
						<p class="tit">시간</p>
						<!-- 매진일때만 label 안에  <span>매진</span>  추가 -->
						<div id="playTimeList" class="boutique-time"><span class="time-sel soldout"><input type="radio" id="t1" name="time" play-schdl-no="2302081351001" brch-no="1351" theab-no="20" value="1000" disabled=""><label for="t1"><em class="font-roboto regular">10:00</em> <span>판매완료</span></label></span><span class="time-sel soldout"><input type="radio" id="t2" name="time" play-schdl-no="2302081351002" brch-no="1351" theab-no="20" value="1400" disabled=""><label for="t2"><em class="font-roboto regular">14:00</em> <span>판매완료</span></label></span><span class="time-sel"><input type="radio" id="t3" name="time" play-schdl-no="2302081351003" brch-no="1351" theab-no="20" value="1800"><label for="t3"><em class="font-roboto regular">18:00</em> </label></span><span class="time-sel"><input type="radio" id="t4" name="time" play-schdl-no="2302081351004" brch-no="1351" theab-no="20" value="2200"><label for="t4"><em class="font-roboto regular">22:00</em> </label></span></div>
					</div>

					<div class="boxitem movie">
						<p class="tit">영화</p>
						<!-- chice-movie -->
						<div class="choice-movie-wrap">
							<div id="playMovieList" class="choice-movie swiper-container-initialized swiper-container-horizontal"><div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px);"><div class="cell swiper-slide swiper-slide-active" style="width: 144px;"><a href="/booking/privatebooking#" title="바빌론" movie-nm="바빌론" movie-no="23000501" movie-grade="AD04" play-kind-nm="2D(자막)"><p class="img"><img src="/resources/booking/QU7FdcxjBTaHusZSFDeJO7Ti4SLaakYA_420.jpg" alt="바빌론" onerror="noImg(this);"></p><p class="tit"><span class="movie-grade age-19">청소년관람불가</span>바빌론</p><div class="btn">선택</div></a></div><div class="cell swiper-slide swiper-slide-next" style="width: 144px;"><a href="/booking/privatebooking#" title="교섭" movie-nm="교섭" movie-no="22102601" movie-grade="AD02" play-kind-nm="2D"><p class="img"><img src="/resources/booking/jaP2f1q8F51aGyRb804y51pU7pHe8mhV_420.jpg" alt="교섭" onerror="noImg(this);"></p><p class="tit"><span class="movie-grade age-12">12세이상관람가</span>교섭</p><div class="btn">선택</div></a></div><div class="cell swiper-slide" style="width: 144px;"><a href="/booking/privatebooking#" title="다음 소희" movie-nm="다음 소희" movie-no="23000401" movie-grade="AD03" play-kind-nm="2D"><p class="img"><img src="/resources/booking/WYpvrot3KxuIj3hVvnsRf7SGZDfDZgg4_420.jpg" alt="다음 소희" onerror="noImg(this);"></p><p class="tit"><span class="movie-grade age-15">15세이상관람가</span>다음 소희</p><div class="btn">선택</div></a></div><div class="cell swiper-slide" style="width: 144px;"><a href="/booking/privatebooking#" title="메간" movie-nm="메간" movie-no="23000301" movie-grade="AD03" play-kind-nm="2D(자막)"><p class="img"><img src="/resources/booking/EZIn5rUGAuvOI8JR1IHz7zia6VmUMpAj_420.jpg" alt="메간" onerror="noImg(this);"></p><p class="tit"><span class="movie-grade age-15">15세이상관람가</span>메간</p><div class="btn">선택</div></a></div><div class="cell swiper-slide" style="width: 144px;"><a href="/booking/privatebooking#" title="장화신은 고양이: 끝내주는 모험" movie-nm="장화신은 고양이: 끝내주는 모험" movie-no="22096501" movie-grade="AD01" play-kind-nm="2D(자막)"><p class="img"><img src="/resources/booking/ghLL5wsWOyHLBLVissIgFVvjwryf2zni_420.jpg" alt="장화신은 고양이: 끝내주는 모험" onerror="noImg(this);"></p><p class="tit"><span class="movie-grade age-all">전체관람가</span>장화신은 고양이: 끝내주는 모험</p><div class="btn">선택</div></a></div><div class="cell swiper-slide" style="width: 144px;"><a href="/booking/privatebooking#" title="더 퍼스트 슬램덩크" movie-nm="더 퍼스트 슬램덩크" movie-no="22103501" movie-grade="AD02" play-kind-nm="2D(자막)"><p class="img"><img src="/resources/booking/whzCk46ejtIoWU1eavvF9lJ8rC2Wbvf7_420.jpg" alt="더 퍼스트 슬램덩크" onerror="noImg(this);"></p><p class="tit"><span class="movie-grade age-12">12세이상관람가</span>더 퍼스트 슬램덩크</p><div class="btn">선택</div></a></div><div class="cell swiper-slide" style="width: 144px;"><a href="/booking/privatebooking#" title="스위치" movie-nm="스위치" movie-no="22095801" movie-grade="AD02" play-kind-nm="2D"><p class="img"><img src="/resources/booking/3DJ0X15tusGSF0cA0PhiqFuFDLxvyonj_420.jpg" alt="스위치" onerror="noImg(this);"></p><p class="tit"><span class="movie-grade age-12">12세이상관람가</span>스위치</p><div class="btn">선택</div></a></div><div class="cell swiper-slide" style="width: 144px;"><a href="/booking/privatebooking#" title="아바타: 물의 길" movie-nm="아바타: 물의 길" movie-no="22029101" movie-grade="AD02" play-kind-nm="2D(자막)"><p class="img"><img src="/resources/booking/9vUySe7DNMro6tdYRPEbjzF2ebr48MwE_420.jpg" alt="아바타: 물의 길" onerror="noImg(this);"></p><p class="tit"><span class="movie-grade age-12">12세이상관람가</span>아바타: 물의 길</p><div class="btn">선택</div></a></div></div><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>

							<div class="plan-slider-control">
								<button type="button" class="btn-plan-prev swiper-button-disabled" tabindex="0" role="button" aria-label="Previous slide" aria-disabled="true">이전 배너 보기</button>
								<button type="button" class="btn-plan-next" tabindex="0" role="button" aria-label="Next slide" aria-disabled="false">다음 배너 보기</button>
							</div>
						</div>
						<!--// chice-movie -->
					</div>
				</div>
                <!--//영화선택부분 end -->

                <div class="pr_check" id="paymentAgree" style="display: none;">
                    <input type="checkbox" id="chekcb" name="chekcb">
                    <label for="chekcb">
                        <span>선택하신 영화는 15세 이상 관람가 입니다.</span><br>
                        <em>만 15세 미만의 고객님은(영,유아포함) 반드시 부모님 또는 성인 보호자의 동반하에 관람이 가능합니다.</em>
                    </label>
                </div>

                <!-- 대관요금 -->
                <div class="rentalInfo">
                    <h3 class="tit">대관요금</h3>
                    <div class="table-wrap">
                        <table class="board-form2 va-m">
                            <caption>문의지점, 문의유형, 이름, 연락처, 이메일, 제목, 내용, 사진첨부 항목을 가진 1:1 문의 작성 표</caption>
                            <colgroup>
                                <col style="width:199px;">
                                <col style="width:249px;">
                                <col style="width:249px;">
                                <col style="width:199px;">
                                <col style="width:;">
                            </colgroup>
                            <thead>
                            <tr>
                                <th>상영관</th>
                                <th>주중(월, 화, 수, 목)</th>
                                <th>주말(금, 토, 일)</th>
                                <th>최대 이용인원</th>
                                <th>최대 이용시간</th>
                            </tr>
                            </thead>
                            <tbody id="ticketAmtTable"><tr><td>프라이빗 1 호</td><td><span>500,000</span>원</td><td><span>600,000</span>원</td><td>8</td><td rowspan="2">3시간</td></tr><tr><td>프라이빗 2 호</td><td><span>600,000</span>원</td><td><span>700,000</span>원</td><td>10</td></tr></tbody>
                        </table>
                    </div>
                    <ul class="dot_list">
                        <li>더 부티크 프라이빗 총 이용시간은 3시간 입니다.(라운지 이용 +영화관람)</li>
                        <li>[더 부티크 프라이빗 1호 전용관람권]으로2호 관람시 추가금액 10만원이 발생되며, 일반결제 예약 후 ARS문의 부탁드립니다.<br>
                            (*2호전용관람권으로 1호 관람시 일반결제 예약 후 ARS 문의)
                        </li>
                    </ul>
                </div>
                <!--//대관요금 end -->

                <!-- 패키지 신청 -->
                <div class="packageArea">
                    <h3 class="tit">패키지 신청</h3>
                    <div class="pg_text">더 부티크 프라이빗에서는 영화 관람과 함께 다양한 패키지를 이용해보실 수 있습니다. 이용 원하시는 패키지를 클릭해주세요! (당일 신청 불가)</div>
                    <div class="packageBox" id="packageBox"><!--act 더보기 되면 클래스 추가-->

                        <div class="itemWrap">
                            <div class="item">
                                <input type="checkbox" id="itemck01" name="privPackCd" value="PPKC01">
                                <label for="itemck01">
                                    <div class="img"><img src="/resources/booking/private2022_1.png" alt="크래프트비어 세트"></div>
                                    <div class="food-info">
                                        <div class="name-area">
                                            <p class="name" id="PPKC01" price="150000">크래프트비어 세트</p>

                                            <p class="price">
                                                <em>150,000</em>
                                                <span>원</span>
                                            </p>
                                        </div>

                                        <ul class="dot_list">
                                            <li>크레프트 비어 8잔</li>
                                            <li>츄러스 2개</li>
                                            <li>순살 치킨 2개</li>
                                            <li>미니크루아상 2개</li>
                                            <li>프렌치프라이 2개</li>
                                            <li>크루아상샌드위치 2개</li>
                                            <li>치즈살사 나쵸 2개</li>
                                        </ul>
                                    </div>
                                </label>
                            </div>

                            <div class="item">
                                <input type="checkbox" id="itemck02" name="privPackCd" value="PPKC02">
                                <label for="itemck02">
                                    <div class="img"><img src="/resources/booking/private2022_2.png" alt="풀보틀와인 세트"></div>
                                    <div class="food-info">
                                        <div class="name-area">
                                            <p class="name" id="PPKC02" price="150000">풀보틀와인 세트</p>

                                            <p class="price">
                                                <em>150,000</em>
                                                <span>원</span>
                                            </p>
                                        </div>

                                        <ul class="dot_list">
                                            <li>풀보틀와인 2병</li>
                                            <li>츄러스 2개</li>
                                            <li>순살 치킨 2개</li>
                                            <li>미니크루아상 2개</li>
                                            <li>프렌치프라이 2개</li>
                                            <li>크루아상샌드위치 2개</li>
                                            <li>치즈살사 나쵸 2개</li>
                                        </ul>
                                    </div>
                                </label>
                            </div>

                            <div class="item">
                                <input type="checkbox" id="itemck03" name="privPackCd" value="PPKC03">
                                <label for="itemck03">
                                    <div class="img"><img src="/resources/booking/private2022_3.png" alt="플레이팅 세트"></div>
                                    <div class="food-info">
                                        <div class="name-area">
                                            <p class="name" id="PPKC03" price="70000">플레이팅 세트</p>

                                            <p class="price">
                                                <em>70,000</em>
                                                <span>원</span>
                                            </p>
                                        </div>

                                        <ul class="dot_list">
                                            <li>순살 치킨 2개</li>
                                            <li>미니크루아상 2개</li>
                                            <li>프렌치프라이 2개</li>
                                            <li>크루아상샌드위치 2개</li>
                                            <li>치즈살사 나쵸 2개</li>
                                            <li class="none"></li>
                                            <li>츄러스 2개</li>
                                        </ul>
                                    </div>
                                </label>
                            </div>
                        </div>

                        <div class="itemWrap">
                            <div class="item">
                                <input type="checkbox" id="itemck04" name="privPackCd" value="PPKC04">
                                <label for="itemck04">
                                    <div class="img"><img src="/resources/booking/private2022_4.png" alt="더 플레이스 패키지"></div>
                                    <div class="food-info">
                                        <div class="name-area">
                                            <p class="name" id="PPKC04" price="200000">더 플레이스 패키지(8인)</p>

                                            <p class="price">
                                                <em>200,000</em>
                                                <span>원</span>
                                            </p>
                                        </div>

                                        <ul class="dot_list">
                                            <li>딸리아따 디 만조 1개</li>
                                            <li>크림 페스카토레 리조또 1개</li>
                                            <li>페스카토레 리조또 1개</li>
                                            <li>프레시 마르게리따 피자 1개</li>
                                            <li>트러플 풍기 피자 1개</li>
                                            <li>리코타 프루타 샐러드 1개</li>
                                            <li>양념 감자 프라이즈 1개</li>
                                            <li>잠봉 시저 샐러드 1개</li>
                                        </ul>
                                    </div>
                                </label>
                            </div>
                            <div class="item">
                                <input type="checkbox" id="itemck05" name="privPackCd" value="PPKC05">
                                <label for="itemck05">
                                    <div class="img"><img src="/resources/booking/private2022_5.png" alt="더 플레이스 패키지"></div>
                                    <div class="food-info">
                                        <div class="name-area">
                                            <p class="name" id="PPKC05" price="250000">더 플레이스 패키지(10인)</p>

                                            <p class="price">
                                                <em>250,000</em>
                                                <span>원</span>
                                            </p>
                                        </div>

                                        <ul class="dot_list">
                                            <li>딸리아따 디 만조 2개</li>
                                            <li>크림 페스카토레 리조또 1개</li>
                                            <li>페스카토레 리조또 1개</li>
                                            <li>프레시 마르게리따 피자 1개</li>
                                            <li>트러플 풍기 피자 1개</li>
                                            <li>리코타 프루타 샐러드 1개</li>
                                            <li>양념 감자 프라이즈 2개</li>
                                            <li>잠봉 시저 샐러드 1개</li>
                                        </ul>
                                    </div>
                                </label>
                            </div>
                        </div>

                        <div class="itemWrap">
                            <div class="item">
                                <input type="checkbox" id="itemck06" name="privPackCd" value="PPKC06">
                                <label for="itemck06">
                                    <div class="img"><img src="/resources/booking/private2022_6.png" alt="프로포즈 베이직"></div>
                                    <div class="food-info">
                                        <div class="name-area">
                                            <p class="name" id="PPKC06" price="300000">프러포즈 베이직</p>

                                            <p class="price">
                                                <em>300,000</em>
                                                <span>원</span>
                                            </p>
                                        </div>

                                        <ul class="dot_list w100">
                                            <li>꽃다발(화이트)</li>
                                            <li>홀 케이크</li>
                                            <li>센터피스장식(2ea)</li>
                                            <li>샴페인 375ml</li>
                                        </ul>
                                    </div>
                                </label>
                            </div>

                            <div class="item">
                                <input type="checkbox" id="itemck07" name="privPackCd" value="PPKC07">
                                <label for="itemck07">
                                    <div class="img"><img src="/resources/booking/private2022_7.png" alt="프로포즈 스페셜"></div>
                                    <div class="food-info">
                                        <div class="name-area">
                                            <p class="name" id="PPKC07" price="400000">프러포즈 스페셜</p>

                                            <p class="price">
                                                <em>400,000</em>
                                                <span>원</span>
                                            </p>
                                        </div>

                                        <ul class="dot_list w100">
                                            <li>꽃다발(유색)</li>
                                            <li>홀 케이크</li>
                                            <li>센터피스장식(3ea)</li>
                                            <li>샴페인 375ml</li>
                                        </ul>
                                    </div>
                                </label>
                            </div>
                        </div>


                    </div>
                    <ul class="dot_list mt20">
                        <li>이해를 돕기 위한 이미지로 실제와 다를 수 있습니다.</li>
                        <li>구성 메뉴는 시즌이나 업체 사정에 따라 변경될 수 있습니다.</li>
                    </ul>
                    <button class="btnCls">상품 더보기</button><!--"상품 더보기" 텍스트에서 변경-->

                    <div class="totalInfo">
                        <dl id="privPackContents">
                            <dt>패키지 신청내역<span>총 0건</span></dt>
                            <dd><span>0건</span></dd>
                        </dl>
                        <ul class="dot_list">
                            <li>프라이빗 예매완료 후 패키지상품 신청 확인을 위해 해당 극장에서 사전 연락이 진행됩니다. (*1544-0070)</li>
                            <li>패키지 상품에 대한 결제는 관람 당일 현장에서 진행되오니 이용에 참고하시기 바랍니다.</li>
                            <li>패키지 주문 및 취소는 48시간 전 까지 가능하며, 업체 사정에 따라 주문이 불가능 할 수 있습니다.</li>
                        </ul>
                    </div>
                </div>
                <!--//패키지 신청 end -->

                <!-- 요청사항 -->
                <div class="requestBox"> <!--'reqCk 클릭시 act 추가'-->
                    <h3 class="tit">요청사항</h3>
                    <div class="reqCk">부티크 프라이빗 대관 이용시 특별히 요청하실 사항이 있으시면 입력해주세요.</div>
                    <div class="showBox">
                        <div class="textarea">
                            <textarea id="reqCtnt" name="reqCtnt" placeholder="부티크 프라이빗 대관 이용시 특별히 요청하실 사항이 있으시면 입력해주세요."></textarea>
                            <span id="textareaCnt">0/700</span>
                        </div>
                        <ul class="dot_list">
                            <li>요청하실 사항이 있으신 경우 기입해주세요.<p>예시) 자체 영상 송출요청(10분이내), 휠체어 탑승 고객 입장, 식음료 알레르기 유무, 예약자와 방문자명 다름(호스트명: 김메가)</p></li>
                            <li>특수문자(+, ?, !, ~, . 제외)또는 이모티콘 사용이 제한되오니, 가급적 텍스트를 입력해주시기 바랍니다.</li>
                        </ul>

                    </div>
                </div>
                <!--//요청사항 end -->

                <!-- 유의사항 -->
                <div class="noticeBox">
                    <div class="tit">유의사항</div>
                    <ul class="dot_list">
                        <li>더 부티크 프라이빗은 상영관별 최대 인원 내에서 이용가능하며, 초과시 이용이 제한될 수 있습니다.</li>
                        <li class="h2">전용 라운지는 영화 관람 시간을 포함하여 최대 3시간 동안 이용할 수 있습니다.<br>(관람 영화의 러닝타임이 120분 이상일 경우 라운지 이용 시간이 줄어들 수 있습니다)</li>
                        <li>더 부티크 프라이빗은 대관전용 극장으로 멤버십 포인트 적립 및 사용이 불가합니다.</li>
                        <li>프라이빗 대관예매는 메가박스 홈페이지 및 어플에서만 가능하며, 유선 상담에서는 부가서비스 추가 결제만 가능합니다.</li>
                        <li>선택 가능한 영화 외에 다른 영화를 원하시면 문의해주시기 바랍니다.</li>
                        <li>프라이빗 전용 ARS : 1544-0070 → 5번 (월~금 | 12:00 ~ 19:00, 주말 및 공휴일 제외) </li>
                        <li>프라이빗 예약 외에 다른 문의에 대해서는 안내가 제한됩니다.</li>
                        <li>프라이빗 내 스크린 훼손, 벽면 도색 손상 등의 기타 시설물 파손이 발생하게 될 경우 손해 배상을 청구할 수 있음을 이용 시 참고 부탁 드립니다.</li>
                    </ul>
                    <div class="tit">환불규정</div>
                    <ul class="dot_list">
                        <li class="h2">프라이빗은 당일 예매는 불가능하며, 환불은 티켓 시간 기준 48시간 이전까지 가능합니다. <br>Ex) 4월 12일 2회차 14:00 예약 → 4월 10일 13:59까지 환불 가능]</li>
                    </ul>
                </div>
                <!--//유의사항 end -->

                <!-- 결제 -->
                <div class="paymentBox">
                    <h3 class="tit">결제</h3>
                    <div class="paymentArea">
                        <div class="info">
                            <div class="img"><img id="smallImage" src="/resources/booking/notimg.png" alt=""></div>
                            <ul class="dot_list">
                                <li id="selectTheabNo"><span>극장</span>코엑스 더 부티크 프라이빗 2호</li>
                                <li id="selectTime"><span>일시</span>원하시는 시간을 선택해 주세요</li>
                                <li id="selectMovie"><span>영화</span>원하시는 영화를 선택해 주세요</li>
                            </ul>
                        </div>

                        <div class="payment">
                            <div class="top">
                                <div class="tit">결제수단</div>
                                <ul class="pay">
                                    <li><input type="radio" id="rdoPayCredit" name="rdo_pay" value="credit" checked="checked"> <label for="rdoPayCredit" class="w100">신용/체크카드</label></li>
                                    <li><input type="radio" id="rdoPayMCoupon" name="rdo_pay" value="mcoupon"> <label for="rdoPayMCoupon" class="w100">관람권/상품권</label>
                                        <select id="sel_pay" class="w180px x-small" disabled="disabled">
                                            <option value="">관람권/상품권 선택</option>
                                            <option value="mcoupon">더 부티크 프라이빗 관람권</option>
                                            <option value="scoupon">스토어 교환권</option>
                                            <option value="mgift">모바일 상품권</option>
                                        </select>
                                    </li>
                                    <li><input type="radio" id="rdoPayAnnus" name="rdo_pay" value="annus"> <label for="rdoPayAnnus" class="w140">메가박스 아너스카드</label></li>
                                </ul>
                            </div>
                            <div class="total">최종 결제금액<span><em>0</em>원</span></div>

                        </div>
                        <div class="noti">
                            <dl class="dot_list_dl">
                                <dt>이용안내</dt>
                                <dd id="payInfo">선택하신 상영관은 프라이빗 2호입니다. 관람 인원 포함 입장 수용 인원이 총 10명입니다. 입장 인원초과시 현장에서는 이용제한 또는 추가 요금이 부과될 수 있습니다.</dd>
                                <dt>환불 및 배상 규정</dt>
                                <dd>프라이빗은 당일 예매는 불가능하며, 환불은 티켓 시간 기준 48시간 이전까지 가능합니다.</dd>
                                <dd>프라이빗 이용 중 고객 부주의로 인해 시설물 훼손 및 파손이 발생할 경우 손해 배상이 청구될 수 있습니다.</dd>
                            </dl>
                            <div class="ck"><input type="checkbox" id="privPayChk"><label for="privPayChk">위의 유의사항 및 환불, 배상 규정 확인하였으며, 이에 동의합니다.</label></div>
                        </div>

                    </div>

                </div>
                <!--//결제 end -->

                <div class="btn-group pt40">
                    <button type="button" class="button purple large" id="btn_private" name="btn_private_pay">결제하기</button>

                    <div style="display:none;" id="div_href">
                        <a href="javascript:void(0)" title="결제하기" w-data="600" h-data="550" class="button purple large btn-modal-open" id="credit">결제하기</a>
                    </div>
                </div>

                <!-- 레이어 : 프라이빗 관람권 -->
                





<script type="text/javascript">
var mcouponChgList = new Array();

//초기화 공통 sMethodName.init
function mcoupon_init() {
	setInitMcouponChg();
	mcouponChgList = new Array();
	$('#mcouponNo').val('');
	$('#mcouponCertNo').val('');
}

$(function() {
	//영화관람권 문자만 사용
	$("#mcouponCertNo").megaBoxNumberCheck();

	//교환권 등록버튼 클릭
	$('#btn_reg_mcoupon').on('click', function() {
		registMcoupon();
	});

	//적용버튼 클릭
	$('#btn_apply_mcoupon').on('click', function() {
		applyMcouponChg();
	});


});

//영화관람권 존재여부
function getInitMcouponChgCnt() {
	return $('#layer_private_mcoupon .table-wrap > table > tbody> tr').length;
}

//영화관람권 초기화
function setInitMcouponChg() {
	$('#layer_private_mcoupon .table-wrap > table > tbody> tr').remove();
}

//영화관람권 등록
function registMcoupon() {
	//초기화
	var transNo     = $("#transNo").val();
	var mcouponNo   = $("#mcouponNo").val();
	var mcouponCertNo = $("#mcouponCertNo").val();

	//영화관람권 자릿수 체크
	if (mcouponNo.length != 12) {

		gfn_alertMsgBox({ msg:'메가박스 관람권 번호 12자리를  입력하세요.'});	//영화관람권 12자리를 입력하세요
		$("#mcouponNo").focus();
		return;
	}

	//인증번호
	if (mcouponCertNo.length != 4) {
		gfn_alertMsgBox({ msg:'인증번호 번호 4자리를  입력하세요.'});	//인증번호 4자리를 입력하세요
		$("#mcouponNo").focus();
		return;
	}

	//기 조회여부 체크
	if(mcouponChgList != null){

		for(var i=0;i<mcouponChgList.length;i++) {
			if (mcouponNo.substring(0, 12) == mcouponChgList[i].cmbndNo) {
				gfn_alertMsgBox({ msg:'이미 조회 되었습니다.'});
				return;
			}
		}
	}
	var scouponNo  = mcouponNo + mcouponCertNo;
	var methodName = "mcoupon";
	var paramData  = {scouponNo:scouponNo, methodName:methodName, brchNo:brchNo, theabNo:theabNo };
	$.ajax({
        url: "/on/oh/ohz/PayPrivate/registVcCmbnd.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {
			if (data.resultStatus == 'Y') {
				addMcouponChg(mcouponNo.substring(0, 12));
			} else {
				gfn_alertMsgBox({ msg:'기명처리 불가한 교환권입니다.'});
			}
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg:err.msg});
        }
	});

}

//영화관람권 추가
function addMcouponChg(mcouponNo) {
	//초기화
	var transNo     = $("#transNo").val();
	var paramData  = {transNo:transNo, cmbndNo:mcouponNo, theabNo: theabNo };

	$.ajax({
        url: "/on/oh/ohz/PayPrivate/searchMovieCpon.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {
        	//쿠폰 전역변수 세팅
        	var vcCmbndList = data.vcCmbndList[0];

        	mcouponChgList.push(vcCmbndList);
        	var i = mcouponChgList.length-1;

    		cponListText = '<tr> ';
    		cponListText += '	<td class="a-l">'+mcouponChgList[i].cmbndNm+'</td> ';
    		cponListText += '	<td class="a-l"> ';
    		//cponListText += '		총(0/1) | 주간(0/1) | 월간(0/1)<br /> '; 현재 영어에서 제한횟수 관리가 되고 있지 않음. 추후 추가 필요
    		cponListText += '		'+String(mcouponChgList[i].validStartDe).maskDate()+'~'+String(mcouponChgList[i].validExprDe).maskDate()+' ';
    		cponListText += '	</td> ';
    		cponListText += '	<td><input type="radio" title="영화관람권 사용" name="chkMCpon" idx="'+i+'" cponno="'+mcouponChgList[i].cmbndNo+'"/></td> ';

    		cponListText += '</tr> ';
    		$('#layer_private_mcoupon .table-wrap > table > tbody').append(cponListText);

    		$('#mcouponNo').val('');
    		$('#mcouponCertNo').val('');
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg:err.msg});
        }
	});
}


//영화관람권 조회
function searchMcouponChg() {
	var transNo    = $("#transNo").val();
	var paramData  = {transNo:transNo, theabNo: theabNo };

	$.ajax({
        url: "/on/oh/ohz/PayPrivate/searchMovieCpon.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {

        	//쿠폰 전역변수 세팅
        	mcouponChgList = data.vcCmbndList;

        	//쿠폰 목록 세팅
        	setMcouponChg(mcouponChgList);
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg:err.msg });
        }
	});
}


//영화관람권 목록 세팅
function setMcouponChg(cponList) {
	setInitMcouponChg();
	var cponListText = "";
	if(cponList != null){
		for(var i=0;i<cponList.length;i++) {

			cponListText = '<tr> ';
			cponListText += '	<td class="a-l">'+cponList[i].cmbndNm+'</td> ';
			cponListText += '	<td class="a-l"> ';
			//cponListText += '		총(0/1) | 주간(0/1) | 월간(0/1)<br /> '; 현재 영어에서 제한횟수 관리가 되고 있지 않음. 추후 추가 필요
			cponListText += '		'+String(cponList[i].validStartDe).maskDate()+'~'+String(cponList[i].validExprDe).maskDate()+' ';
			cponListText += '	</td> ';
			cponListText += '	<td><input type="radio" title="스토어권 사용" name="chkMCpon" idx="'+i+'" cponno="'+cponList[i].cmbndNo+'"/></td> ';
			cponListText += '</tr> ';

			$('#layer_private_mcoupon .table-wrap > table > tbody').append(cponListText);
		}
	}
}

//영화관람권 적용
function applyMcouponChg() {
	var transNo     = $("#transNo").val();
	var playSchdlNo = $("#playSchdlNo").val();
	var paramCpon   = new Array();
	var idx = $("input:radio[name='chkMCpon']:checked").index('[name="chkMCpon"]');

	if ( idx < 0 ) {
		gfn_alertMsgBox({ msg:'선택된 쿠폰 정보가 없습니다.'});
		return;
	}

	mcouponChgList[idx].transNo = transNo;
	paramCpon.push(mcouponChgList[idx]);

	var paramData = {transNo:transNo, cponList:paramCpon, playSchdlNo:playSchdlNo};
	$.ajax({
        url: "/on/oh/ohz/PayPrivate/applyMovieCpon.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {

        	if (data.returnMap.remainAmt > 0) {
        		gfn_alertMsgBox({ msg: '해당 관람권을 적용할 수 없습니다.' });
        		$('#layer_private_mcoupon .close-layer').click();
        		return;
        	}

        	$('#layer_private_mcoupon').hide();

        	//현금영수증 팝업여부
        	chkCshRec();
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg: err.msg });
        }
	});
}

</script>


<!-- 레이어 : 메가박스 관람권 -->
<section id="layer_private_mcoupon" class="modal-layer"><a href="/booking/privatebooking" class="focus">레이어로 포커스 이동 됨</a>
	<div class="wrap">
		<header class="layer-header">
			<h3 class="tit">프라이빗 관람권</h3>
		</header>

		<div class="layer-con">
			<div class="reset mb10">
				사용하실 '더 부티크 프라이빗 관람권'을 선택해주세요.<br>
				보유하신 관람권은 등록 후 사용하실 수 있습니다.
			</div>

			<div class="popup-gray mid-info-box">
				<div class="pop-search-area">
					<p class="sh-txt reset"><span class="label">관람권번호</span></p>

					<div class="sh-input">
						<input type="text" placeholder="관람권번호 12자리" title="메가박스 관람권 번호 입력" class="input-text w150px" id="mcouponNo" maxlength="12">
						<input type="text" placeholder="인증번호 4자리" title="메가박스 관람권 인증번호 입력" class="input-text w120px ml05" id="mcouponCertNo" maxlength="4">
					</div>

					<div class="sh-btn gray">
						<a href="/booking/privatebooking#layer_private_mcoupon_regi" title="관람권등록 하기" w-data="600" h-data="350" class="button small gray btn-modal-open" id="btn_reg_mcoupon">관람권등록</a>
					</div>
				</div>
			</div>

			<div class="table-wrap">
				<table class="board-list line">
					<caption>영화관람권을 관람권, 유효기간, 사용 순서로 보여주는 표</caption>
					<colgroup>
						<col>
						<col style="width:200px;">
						<col style="width:56px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">관람권</th>
							<th scope="col">유효기간</th>
							<th scope="col">사용</th>
						</tr>
					</thead>
					<tbody>
						<!--
						<tr>
							<td class="a-l">
								<strong>관람권명</strong><br />
								1234-5678-1234-****
							</td>
							<td>2019-01-08~2019-01-31</td>
							<td>
								<input type="checkbox" title="사용" />
							</td>
						</tr>
						<tr>
							<td class="a-l">
								<strong>부티크프라이빗 관람권</strong><br />
								1234-5678-1234-****
							</td>
							<td>2019-01-08~2019-01-31</td>
							<td>
								<input type="checkbox" title="사용" />
							</td>
						</tr>
						<tr>
							<td class="a-l">
								<strong>부티크프라이빗 관람권</strong><br />
								1234-5678-1234-****
							</td>
							<td>2019-01-08~2019-01-31</td>
							<td>
								<input type="checkbox" title="사용" />
							</td>
						</tr>
						 -->
					</tbody>
				</table>
			</div>

			<ul class="dash-list mt10">
				<li>더 부티크 프라이빗 관람권만 등록 및 사용 가능합니다.</li>
				<li>등록된 관람권은 '나의 메가박스 &gt; 관람권'에서 확인하실 수 있습니다.</li>
			</ul>

			<!-- 사용할수 없을 때 -->
			<!-- <p class="reset mt10 font-red">사용할 수 없는 관람권 입니다. 고객센터 (1544-0070)으로 문의주세요.</p> -->
		</div>
		<div class="btn-group-fixed">
			<button type="button" class="button close-layer">닫기</button>
			<button type="button" class="button purple" id="btn_apply_mcoupon">결제</button>
		</div>

		<button type="button" class="btn-modal-close">레이어 닫기</button>
	</div>
</section>
<!--// 레이어 : 메가박스 관람권 -->

                <!-- 레이어 : 프라이빗 관람권 -->

                <!-- 레이어 : 스토어 관람권 -->
                





<script type="text/javascript">
var storeChgList = new Array();

//초기화 공통 sMethodName.init
function scoupon_init() {
	setInitStoreChg();
	storeChgList = new Array();
	$('#scouponNo').val('');
}

$(function() {
	//스토어 교환권 문자만 사용
	$("#scouponNo").megaBoxNumberCheck();

	//교환권 등록버튼 클릭
	$('#btn_reg_scoupon').on('click', function() {
		registStore();
	});

	//적용버튼 클릭
	$('#btn_apply_scoupon').on('click', function() {
		applyStoreChg();
	});

});

//스토어교환권 존재여부
function getInitStoreChgCnt() {
	return $('#layer_private_scoupon .table-wrap > table > tbody> tr').length;
}

//스토어교환권 초기화
function setInitStoreChg() {
	$('#layer_private_scoupon .table-wrap > table > tbody> tr').remove();
}

//스토어교환권 등록
function registStore() {
	//초기화
	var transNo     = $("#transNo").val();
	var scouponNo   = $("#scouponNo").val();

	//스토어교환권 자릿수 체크
	if (scouponNo.length != 16) {
		alert('스토어교환권 번호 16자리를  입력하세요.');	//스토어교환권 16자리를 입력하세요
		$("#scouponNo").focus();
		return;
	}

	//기 조회여부 체크
	if(storeChgList != null){
		for(var i=0;i<storeChgList.length;i++) {
			if (scouponNo.substring(0, 16) == storeChgList[i].cmbndNo) {
				alert('이미 조회 되었습니다.');
				return;
			}
		}
	}


	var methodName = "scoupon";
	var paramData  = {scouponNo:scouponNo, methodName:methodName, cmbnd_type:'store', brchNo:brchNo, theabNo:theabNo };
	$.ajax({
        url: "/on/oh/ohz/PayPrivate/registVcCmbnd.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {
			if (data.resultStatus == 'Y') {
				addStoreChg(scouponNo.substring(0, 16));
			} else {
				gfn_alertMsgBox({ msg:'기명처리 불가한 교환권입니다.'});
			}
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg:err.msg});
        }
	});

}

//스토어교환권 추가
function addStoreChg(scouponNo) {
	//초기화
	var transNo     = $("#transNo").val();
	var paramData  = {transNo:transNo, cmbndNo:scouponNo, theabNo: theabNo };

	$.ajax({
        url: "/on/oh/ohz/PayPrivate/searchVcCmbnd.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {
        	//쿠폰 전역변수 세팅
        	var vcCmbndList = data.vcCmbndList[0];

        	storeChgList.push(vcCmbndList);
        	var i = storeChgList.length-1;

    		cponListText = '<tr> ';
    		cponListText += '	<td class="a-l">'+storeChgList[i].cmbndNm+'</td> ';
    		cponListText += '	<td class="a-l"> ';
    		//cponListText += '		총(0/1) | 주간(0/1) | 월간(0/1)<br /> '; 현재 영어에서 제한횟수 관리가 되고 있지 않음. 추후 추가 필요
    		cponListText += '		'+String(storeChgList[i].validStartDe).maskDate()+'~'+String(storeChgList[i].validExprDe).maskDate()+' ';
    		cponListText += '	</td> ';
    		cponListText += '	<td><input type="radio" title="스토어권 사용" name="chkSCpon" idx="'+i+'" cponno="'+storeChgList[i].cmbndNo+'"/></td> ';
    		cponListText += '</tr> ';
    		$('#layer_private_scoupon .table-wrap > table > tbody').append(cponListText);

    		$('#scouponNo').val('');
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg:err.msg});
        }
	});
}


//스토어교환권 조회
function searchStoreChg() {
	//초기화
	var transNo     = $("#transNo").val();
	var paramData  = {transNo:transNo, theabNo: theabNo };

	$.ajax({
        url: "/on/oh/ohz/PayPrivate/searchVcCmbnd.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {
        	//쿠폰 전역변수 세팅
        	storeChgList = data.vcCmbndList;

        	//쿠폰 목록 세팅
        	setStoreChg(storeChgList);
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg:err.msg });
        }
	});
}


//스토어교환권 목록 세팅
function setStoreChg(cponList) {
	setInitStoreChg();
	var cponListText = "";

	if(cponList != null){

		for(var i=0;i<cponList.length;i++) {

			cponListText = '<tr> ';
			cponListText += '	<td class="a-l">'+cponList[i].cmbndNm+'</td> ';
			cponListText += '	<td class="a-l"> ';
			//cponListText += '		총(0/1) | 주간(0/1) | 월간(0/1)<br /> '; 현재 영어에서 제한횟수 관리가 되고 있지 않음. 추후 추가 필요
			cponListText += '		'+String(cponList[i].validStartDe).maskDate()+'~'+String(cponList[i].validExprDe).maskDate()+' ';
			cponListText += '	</td> ';
			cponListText += '	<td><input type="radio" title="스토어권 사용" name="chkSCpon" idx="'+i+'" cponno="'+cponList[i].cmbndNo+'"/></td> ';
			cponListText += '</tr> ';

			$('#layer_private_scoupon .table-wrap > table > tbody').append(cponListText);
		}
	}
}

//스토어교환권 적용
function applyStoreChg() {
	var transNo     = $("#transNo").val();
	var playSchdlNo = $("#playSchdlNo").val();
	var paramCpon   = new Array();
	var idx = $("input:radio[name='chkSCpon']:checked").index('[name="chkSCpon"]');

	if ( idx < 0 ) {
		gfn_alertMsgBox({ msg:'선택된 쿠폰 정보가 없습니다.'});
		return;
	}

	storeChgList[idx].transNo = transNo;
	paramCpon.push(storeChgList[idx]);

	var paramData = {transNo:transNo, cponList:paramCpon, playSchdlNo:playSchdlNo};
	$.ajax({
        url: "/on/oh/ohz/PayPrivate/applyVcCmbnd.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {

        	if (data.returnMap.remainAmt > 0) {
        		gfn_alertMsgBox({ msg: '해당 관람권을 적용할 수 없습니다.' });
        		$('#layer_private_scoupon .close-layer').click();
        		return;
        	}

        	$('#layer_private_scoupon').hide();

        	//현금영수증 팝업여부
        	chkCshRec();
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg: err.msg });
        }
	});
}

</script>

<!-- 레이어 : 스토어교환권 -->
<section id="layer_private_scoupon" class="modal-layer"><a href="/booking/privatebooking" class="focus">레이어로 포커스 이동 됨</a>
	<div class="wrap">
		<header class="layer-header">
			<h3 class="tit">스토어교환권</h3>
		</header>

		<div class="layer-con">
			<div class="popup-gray mid-info-box mt0">
				<div class="pop-search-area">
					<p class="sh-txt reset"><span class="label">교환권번호</span></p>

					<div class="sh-input"><input type="text" title="스토어교환권 번호입력" class="input-text w200px" id="scouponNo" name="scouponNo" maxlength="16"></div>

					<div class="sh-btn gray">
						<button type="button" class="button small gray" id="btn_reg_scoupon">교환권등록</button>
					</div>
				</div>
			</div>

			<div class="table-wrap">
				<table class="board-list line">
					<caption>기프티콘 예매권을 예매권 명, 예매권번호, 사용 순서로 보여주는 표</caption>
					<colgroup>
						<col style="width:220px;">
						<col>
						<col style="width:60px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">교환권 정보</th>
							<th scope="col">사용내역/유효기간</th>
							<th scope="col">사용</th>
						</tr>
					</thead>
					<tbody>
						<!--
						<tr>
							<td class="a-l">러브콤보패키지 러브콤보교환권</td>
							<td class="a-l">
								총(0/1) | 주간(0/1) | 월간(0/1)<br />
								/ 2019.03.25~2021.03.24
							</td>
							<td><input type="checkbox" title="아이넘버 1인권 사용여부 체크" /></td>
						</tr>
						<tr>
							<td class="a-l">러브콤보패키지 러브콤보교환권</td>
							<td class="a-l">
								총(0/1) | 주간(0/1) | 월간(0/1)<br />
								/ 2019.03.25~2021.03.24
							</td>
							<td><input type="checkbox" title="아이넘버 1인권 사용여부 체크" /></td>
						</tr>
						 -->
					</tbody>
				</table>
			</div>
		</div>

		<div class="btn-group-fixed">
			<button type="button" class="button close-layer">닫기</button>
			<button type="button" class="button purple" id="btn_apply_scoupon">결제</button>
		</div>

		<button type="button" class="btn-modal-close">레이어 닫기</button>
	</div>
</section>
<!-- 레이어 : 스토어교환권 -->

                <!-- 레이어 : 스토어 관람권 -->

                <!-- TODO 레이어 : 아너스카드 -->
                





<script type="text/javascript">
var annusChgInfo = new Object();

//초기화 공통 sMethodName.init
function annus_init() {  //아너스카드 전체초기화
	setInitAnnus();
	annusChgInfo = new Object();

	$('#annusCardNum').val('');
	$('#annusCardNum_hid').val('');
	$('#annusUseAbleAmt').text('0');
}

$(function() {

	//숫자만 입력가능
	$('#annusCardNum').megaBoxCardNumberCheck();

	//조회버튼 클릭
	$('#btn_select_annus').on('click', function() {
		searchAnnus();
	});

	//아너스카드 적용
	$('#btn_apply_annus').on('click', function() {
		applyAnnus();
	});

	//적용취소버튼 클릭
	$('#btn_cancel_apply_annus').on('click', function() {
		var sMethodName = "annus";
		cancelMbxSellCpInfo(sMethodName);

		//닫기버튼 클릭
     	$('#layer_annus_card .close-layer').click();
	});

	//닫기버튼 클릭
	$('#btn_close_annus, #btn_close_modal_annus').on('click', function() {
		if (!$('#btn_cancel_apply_annus').is(':visible')) {
			annus_init();
		}
	});
});


//아너스카드 초기화
function setInitAnnus() {
	$('#selAnnus > option').remove();
	$('#selAnnus').append('<option value="0">선택</option>');
}

//아너스카드 조회
function searchAnnus() {
	var transNo    = $("#transNo").val();
	var cardNo     = $("#annusCardNum_hid").val();

	//기존에 적용된 동일 수단이 있으면 초기화 후 재조회
	if ($('#btn_cancel_apply_annus').is(':visible')) {
		//이미 적용된 결제 수단은 재조회 할 수 없습니다. \\n[적용 취소]후 재조회 할 수 있습니다.
		gfn_alertMsgBox('이미 적용된 결제 수단은 재조회 할 수 없습니다. \n[적용 취소]후 재조회 할 수 있습니다.');
		return;
	}

	if (cardNo == "" || cardNo.length < 10) {
		gfn_alertMsgBox('카드 번호를 입력하세요.');
		return;
	}

	var paramData  = {transNo:transNo, cardNo:cardNo};


	$.ajax({
      url: "/on/oh/ohz/PayPrivate/searchAnnus.do",
      type: "POST",
      contentType: "application/json;charset=UTF-8",
      dataType: "json",
	  data: JSON.stringify(paramData),
      success: function (data, textStatus, jqXHR) {


      	//console.log(data);
    	if (!msgBookingLoginChk(data)) {
    		return;
    	}

      	//쿠폰 전역변수 세팅
      	annusChgInfo = data.annusInfo;

      	//쿠폰 목록 세팅
      	setAnnusChg(annusChgInfo);
      },
      error: function(xhr,status,error){
      	var err = JSON.parse(xhr.responseText);
      	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
      	errBookingChk(err.msg);
      }
      , beforeSend : function() {
            $('#btn_select_annus').prop("disabled", true);
            $('#btn_select_annus').addClass('disabled');
  	  }
  	  , complete : function() {

            setTimeout(function(){
                $('#btn_select_annus').removeClass('disabled');
                $('#btn_select_annus').prop("disabled", false);
            },100);
  	  }

	});
}

//아너스카드 목록 세팅
function setAnnusChg(cponInfo) {
	setInitAnnus();
	var cponListText = "";

	$('#annusUseAbleAmt').text(String(cponInfo.useAbleAmt).maskNumber());

	var cponList = cponInfo.comboList;
	var useAmt   = 0;
	if(cponList != undefined){
		for(var i=0;i<cponList.length;i++) {
			useAmt += cponList[i].useAmt;
			cponListText =  '<option value="'+cponList[i].useCnt+'">'+cponList[i].useCnt+'매'+' (-'+String(useAmt)+')</option>';
			$('#selAnnus').append(cponListText);
		}
	}
}

//아너스카드 적용
function applyAnnus() {

	var transNo  = $("#transNo").val();
	var cardNo   = $("#annusCardNum_hid").val();
	var useCnt   = $('#selAnnus option:selected').val();




	if ( useCnt == 0 ) {
		//할인 적용할 매수를 선택하세요.
		gfn_alertMsgBox('할인 적용할 매수를 선택하세요.');
		return;
	}

	if (cardNo == "" || cardNo.length < 10) {
		gfn_alertMsgBox('카드 번호를 입력하세요.');
		return;
	}

	var paramData  = {transNo:transNo, cardNo:cardNo, useCnt:useCnt, theabNo:theabNo};

	$.ajax({
	  url: "/on/oh/ohz/PayPrivate/applyAnnus.do",
      type: "POST",
      contentType: "application/json;charset=UTF-8",
      dataType: "json",
	  data: JSON.stringify(paramData),
      success: function (data, textStatus, jqXHR) {
            //console.log(data);
            if (!msgBookingLoginChk(data)) {
                return;
            }


            //할인내역 갱신
            //setMovieDcInfo(data.policyList);

            /*
            $('#btn_cancel_annus').show(); //취소버튼
            $('#btn_cancel_apply_annus').show(); //적용취소버튼
            */
            //닫기버튼 클릭
            //$('#layer_annus_card .close-layer').click();
            $('#layer_annus_card').hide();

            //최종결제
            execPrivatePayment();

      },
      error: function(xhr,status,error){
      	var err = JSON.parse(xhr.responseText);
      	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
      	errBookingChk(err.msg);
      }
	});
}
</script>

	<!-- 레이어 : 아너스카드 -->
	<input type="hidden" id="annusCardNum_hid">
	<section id="layer_private_annus" class="modal-layer"><a href="/booking/privatebooking" class="focus">레이어로 포커스 이동 됨</a>
		<div class="wrap">
			<header class="layer-header">
				<h3 class="tit">메가박스 아너스카드 <!-- 메가박스 아너스카드 --></h3>
			</header>

			<div class="layer-con">
				<div class="popup-gray mid-info-box mt0">
					<div class="pop-search-area">
						<p class="sh-txt reset mr08"><span class="label">카드번호 <!-- 카드번호 --></span></p>

						<div class="sh-input">
							<input type="text" title="메가박스 아너스카드 카드번호 입력 &lt;!-- 메가박스 아너스카드 카드번호 입력 --&gt;" class="input-text w200px" id="annusCardNum" maxlength="20">
						</div>

						<div class="sh-btn gray">
							<button type="button" class="button small gray" id="btn_select_annus">조회 <!-- 조회 --></button>
						</div>
					</div>
				</div>

				<div class="table-wrap">
					<table class="board-form">
						<caption>메가박스 아너스카드를 본인 관람가, 동반자 관람단가, 월 제한수, 일 제한수, 주말가능, 관람가능일, 잔여금액 순서로 입력하는 표 <!-- 메가박스 아너스카드를 본인 관람가, 동반자 관람단가, 월 제한수, 일 제한수, 주말가능, 관람가능일, 잔여금액 순서로 입력하는 표 --></caption>
						<colgroup>
							<col style="width:125px;">
							<col>
							<col style="width:125px;">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="selAnnus">적용매수 <!-- 본인 관람가 --></label></th>
								<td colspan="3">
									<select id="selAnnus" class="w150px x-small">
										<option>선택 <!-- 매수선택 --></option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">잔여금액 <!-- 잔여금액 --></th>
								<td colspan="3" id="annusUseAbleAmt"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			<div class="btn-group-fixed">
				<button type="button" class="button small close-layer" id="btn_close_annus">닫기 <!-- 닫기 --></button>
				
				<button type="button" class="button small purple" id="btn_apply_annus">결제 <!-- 적용 --></button>
			</div>

			<button type="button" class="btn-modal-close" id="btn_close_modal_annus">레이어 닫기 <!-- 레이어 닫기 --></button>
		</div>
	</section>
	<!-- 레이어 : 아너스카드 -->

                <!--// 레이어 : 아너스카드 -->

                <!-- TODO 레이어 : 아너스카드 -->
                





<script type="text/javascript">
var mgiftChgList = new Array();

//초기화 공통 sMethodName.init
function mgift_init() {
	setInitMgiftChg();
	mgiftChgList = new Array();
	$('#mgiftNo').val('');
}

$(function() {
	//모바일 상품권 문자만 사용
	$("#mgiftNo").megaBoxNumberCheck();

	//모바일 상품권 조회버튼 클릭
	$('#btn_select_mgift').click(function() {
		selectMgift();
	});

	//적용버튼 클릭
	$('#btn_apply_mgift').click(function() {
		applyMgiftChg();
	});

});

//모바일 상품권 존재여부
function getInitMgiftChgCnt() {
	return $('#layer_private_mgift .table-wrap > table > tbody> tr').length;
}

//모바일 상품권 초기화
function setInitMgiftChg() {
	$('#layer_private_mgift .table-wrap > table > tbody> tr').remove();
}

//모바일 상품권 조회
function selectMgift() {
	//초기화
	var transNo     = $("#transNo").val();
	var mgiftNo   = $("#mgiftNo").val();

	//모바일 상품권 자릿수 체크
	if (mgiftNo.length != 12) {
		alert('모바일 관람권 번호 12자리를  입력하세요.');	//모바일 상품권 16자리를 입력하세요
		$("#mgiftNo").focus();
		return;
	}

    if (mgiftNo == "") {
        gfn_alertMsgBox('쿠폰 번호를 입력하세요.');
        return;
    }

    //기 조회여부 체크
	if(mgiftChgList != null){
		for(var i=0;i<mgiftChgList.length;i++) {
			if (mgiftNo == mgiftChgList[i].cmbndNo) {
				gfn_alertMsgBox('이미 조회 되었습니다.');
				return;
			}
		}
	}

	var transNo     = $("#transNo").val();
	var paramData  = {transNo: transNo, cardNo: mgiftNo, theabNo: theabNo};

	$.ajax({
        url: "/on/oh/ohz/PayPrivate/searchMgift.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {
        	//쿠폰 전역변수 세팅
        	mgiftChgList = data.vcCmbndList;

        	//쿠폰 목록 세팅
        	setMobileGiftChg(mgiftChgList);
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg:err.msg });
        }
	});

}



//모바일 상품권 목록 세팅
function setMobileGiftChg(cponList) {
	setInitMgiftChg();
	var cponListText = "";
	for(var i=0;i<cponList.length;i++) {

		cponListText = '<tr> ';
		cponListText += '	<td class="a-l">'+cponList[i].cmbndNm+'</td> ';
		cponListText += '	<td class="a-l"> ';
		//cponListText += '		총(0/1) | 주간(0/1) | 월간(0/1)<br /> '; 현재 영어에서 제한횟수 관리가 되고 있지 않음. 추후 추가 필요
		cponListText += '		'+String(cponList[i].validStartDe).maskDate()+'~'+String(cponList[i].validExprDe).maskDate()+' ';
		cponListText += '	</td> ';
		cponListText += '	<td><input type="radio" title="모바일 상품권상품권 사용" name="chkMgift" idx="'+i+'" cponno="'+cponList[i].cmbndNo+'"/></td> ';
		cponListText += '</tr> ';

		$('#layer_private_mgift .table-wrap > table > tbody').append(cponListText);
	}

	$('#mgiftNo').val('');
}

//모바일 상품권 적용
function applyMgiftChg() {
	var transNo     = $("#transNo").val();
	var playSchdlNo = $("#playSchdlNo").val();
	var paramCpon   = new Array();
	var idx = $("input:radio[name='chkMgift']:checked").index('[name="chkMgift"]');

	if ( idx < 0 ) {
		gfn_alertMsgBox({ msg:'선택된 쿠폰 정보가 없습니다.'});
		return;
	}

	mgiftChgList[idx].transNo = transNo;
	paramCpon.push(mgiftChgList[idx]);

	var paramData = {transNo:transNo, cponList:paramCpon, playSchdlNo:playSchdlNo, brchNo:brchNo, theabNo:theabNo};
	$.ajax({
        url: "/on/oh/ohz/PayPrivate/applyMgift.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
		data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {

        	if (data.returnMap.remainAmt > 0) {
        		gfn_alertMsgBox({ msg: '해당 관람권을 적용할 수 없습니다.' });
        		$('#layer_private_mgift .close-layer').click();
        		return;
        	}

        	$('#layer_private_mgift').hide();

        	//현금영수증 팝업여부
        	chkCshRec();

//         	gfn_alertMsgBox({ msg: '해당 관람권을 적용할 수 없습니다.' });
//     		$('#layer_private_mgift .close-layer').click();
//     		return;
        },
        error: function(xhr,status,error){
        	var err = JSON.parse(xhr.responseText);
        	//err.statCd 에 따라서 이전화면으로 리턴 가능토록
        	gfn_alertMsgBox({ msg: err.msg });
        }
	});
}

</script>

<!-- 레이어 : 모바일 상품권 -->
<section id="layer_private_mgift" class="modal-layer"><a href="/booking/privatebooking" class="focus">레이어로 포커스 이동 됨</a>
	<div class="wrap">
		<header class="layer-header">
			<h3 class="tit">모바일 상품권</h3>
		</header>

		<div class="layer-con">
			<div class="popup-gray mid-info-box mt0">
				<div class="pop-search-area">
					<p class="sh-txt reset"><span class="label">모바일 상품권 번호</span></p>

					<div class="sh-input"><input type="text" title="모바일 상품권 번호입력" class="input-text w200px" id="mgiftNo" name="mgiftNo" maxlength="16"></div>

					<div class="sh-btn gray">
						<button type="button" class="button small gray" id="btn_select_mgift">조회</button>
					</div>
				</div>
			</div>

			<div class="table-wrap">
				<table class="board-list line">
					<caption>모바일 상품권을 예매권 명, 유효기간, 사용 순서로 보여주는 표</caption>
					<colgroup>
						<col style="width:220px;">
						<col>
						<col style="width:60px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">교환권 정보</th>
							<th scope="col">유효기간</th>
							<th scope="col">사용</th>
						</tr>
					</thead>
					<tbody>
						<!--
						<tr>
							<td class="a-l">러브콤보패키지 러브콤보교환권</td>
							<td class="a-l">
								총(0/1) | 주간(0/1) | 월간(0/1)<br />
								/ 2019.03.25~2021.03.24
							</td>
							<td><input type="checkbox" title="아이넘버 1인권 사용여부 체크" /></td>
						</tr>
						<tr>
							<td class="a-l">러브콤보패키지 러브콤보교환권</td>
							<td class="a-l">
								총(0/1) | 주간(0/1) | 월간(0/1)<br />
								/ 2019.03.25~2021.03.24
							</td>
							<td><input type="checkbox" title="아이넘버 1인권 사용여부 체크" /></td>
						</tr>
						 -->
					</tbody>
				</table>
			</div>
		</div>

		<div class="btn-group-fixed">
			<button type="button" class="button close-layer">닫기</button>
			<button type="button" class="button purple" id="btn_apply_mgift">결제</button>
		</div>

		<button type="button" class="btn-modal-close">레이어 닫기</button>
	</div>
</section>
<!-- 레이어 : 모바일 상품권 -->

                <!--// 레이어 : 아너스카드 -->

                <!-- 레이어 : 현금영수증 -->
                





<script type="text/javascript">


$(function() {

	//숫자만 입력가능
	$("#cashBillPhoneNo").megaBoxNumberCheck();

	//닫기 클릭 이벤트
	$('#btn_bill_close, #btn_bill_layer_close').on('click', function() {
		$('#cashBillYn').val('Y');
		$('#cashrecIssueCd').val('SELFPRN');	//자진발급

		//최종결제
		execPrivatePayment();
	});

	//구분탭 변경
	$(':radio[name=bizmDivCd]').on('change', function() {
		if ($(this).val() == 'PERSON') {
			$('#cashBillPhoneNo').next().html('휴대폰 번호를 입력해 주세요.');
		} else {
			$('#cashBillPhoneNo').next().html('사업자번호를 입력해 주세요.');
		}
	});

	//즉시발급 클릭 이벤트
	$('#btn_bill_print').on('click', function() {

		var msg = '', cashBillNo = $('#cashBillPhoneNo').val();

		if ($(':radio[name=bizmDivCd]:checked').val() == 'PERSON') {
			if (cashBillNo == '') {
				msg = "휴대폰 번호를 입력해 주세요."; //휴대폰 번호를 입력해 주세요.
			} else if (!cashBillNo.isHpPhoneCode()) {
				msg = '011, 016, 017, 019, 010으로 시작하는 휴대폰 번호로 입력해주세요.'; //011, 016, 017, 019, 010으로 시작하는 휴대폰 번호로 입력해주세요.
			} else if (!cashBillNo.isHpPhoneNo()){
				msg = "올바른 휴대폰 번호를 입력해 주세요."; //올바른 휴대폰 번호를 입력해 주세요.
			}
		} else {
			if (cashBillNo == '') {
				msg = "사업자번호를 입력해 주세요."; //사업자번호를 입력해 주세요.
			} else if (!cashBillNo.isBizNo()){
				msg = "올바른 사업자번호를 입력해 주세요."; //올바른 사업자번호를 입력해 주세요.
			}
		}

		if (msg != '') {
			gfn_alertMsgBox(msg);
			$('#cashBillPhoneNo').focus();
			return false;
		}

		$('#cashBillYn').val('Y');
		$('#cashrecIssueCd').val('GERNPRN');	//일반발급

		//최종결제
		execPrivatePayment();
	});
});

</script>
	<!-- 레이어 : 현금영수증 -->
	<section id="layer_cash_bill" class="modal-layer"><a href="/booking/privatebooking" class="focus">레이어로 포커스 이동 됨</a>
		<div class="wrap">
			<header class="layer-header">
				<h3 class="tit">현금영수증 발급 <!-- 현금영수증 발급 --></h3>
			</header>

			<div class="layer-con">
				<div class="pop-tit">
					현금영수증 발행을 위해 아래 정보를 입력해 주세요. <!-- 현금영수증 발행을 위해 아래 정보를 입력해 주세요.-->
				</div>

				<div class="popup-gray mid-info-box mb15">
					<div class="pop-search-area line-sht">
						<div class="pop-search-area-line ">
							<p class="sh-txt reset">금액 <!-- 금액 --></p>
							<strong id="cashBillAmt">12,000</strong>원 <!-- 원 -->
						</div>

						<div class="pop-search-area-line longline">
							<p class="sh-txt reset">거래구분 <!-- 거래구분 --></p>

							<div class="sh-input">
								<div>
									<span>
										<input type="radio" id="radio_cash_bill01" name="bizmDivCd" checked="checked" value="PERSON">
										<label for="radio_cash_bill01">개인소득공제용 <!-- 개인소득공제용 --></label>
									</span>

									<span class="ml20">
										<input type="radio" id="radio_cash_bill02" name="bizmDivCd" value="BIZM">
										<label for="radio_cash_bill02">사업자증빙용 <!-- 사업자증빙용 --></label>
									</span>
								</div>

								<div class="mt05">

									<!-- 개인소득공제용 선택되었을때 -->
									<input type="text" title="휴대폰 번호 입력" class="input-text w200px" maxlength="12" id="cashBillPhoneNo" name="cashBillPhoneNo" autocomplete="off"><!-- 휴대폰 번호 입력 -->
									<span class="ml10">휴대폰 번호를 입력해 주세요. <!-- 휴대폰 번호를 입력해 주세요. --></span>

									<!--사업자증빙용 선택되었을때 -->
									<!--
									<input type="text" title="사업자 번호 입력" class="input-text w200px">
									<span class="ml10">사업자 번호를 입력해 주세요.</span>
									 -->
									<!-- //사업자증빙용 선택되었을때 -->
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>

			<div class="btn-group-fixed">
				<button type="button" class="button small close-layer" id="btn_bill_close">자진발급 <!-- 자진발급 --></button>
				<button type="button" class="button small purple close-layer" id="btn_bill_print">즉시발급 <!-- 즉시발급 --></button>
			</div>

			<button type="button" class="btn-modal-close" id="btn_bill_layer_close">레이어 닫기 <!-- 레이어 닫기 --></button>
		</div>
	</section>
	<!--// 레이어 : 현금영수증 -->


                <!--// 레이어 : 현금영수증 -->

                <a href="/booking/privatebooking#layer_cash_bill" title="현금영수증 보기" w-data="600" h-data="400" class="button active btn-modal-open target" id="cash_pop" style="display:none;">현금영수증<!-- 현금영수증 --></a>
			</div>
		</div>
		<!--// boutique-reserve-top -->


	</div>
	<!--// contents -->
</div>
<!--// container -->
<form id="seatViewForm">
	<input type="hidden" id="seatViewFormPlaySchdlNo" name="playSchdlNo" value="">
	<input type="hidden" id="movieNo" name="movieNo" value="">
	<input type="hidden" id="transNo" name="transNo" value="">
	<input type="hidden" id="completeTransNo" name="completeTransNo" value="">
	<input type="hidden" name="cashBillYn" id="cashBillYn" value="">
	<input type="hidden" name="cashrecIssueCd" id="cashrecIssueCd" value="">
	<input type="hidden" id="lastPayMethod" name="lastPayMethod" value="">
	<input type="hidden" id="returnUrl" name="returnUrl" value="">
</form>

<input type="hidden" id="todayDate" name="todayDate" value="2023.02.07">
<input type="hidden" id="movieGrade" name="movieGrade" value="">
<input type="hidden" id="playDe" name="playDe" value="20230208">
<input type="hidden" id="crtDe" name="crtDe" value="2023.02.07">

<form name="ifrm" method="POST" target="FD_PAY_FRAME" action="/on/oh/ohz/PayPrivate/applyCreditCard.do">
    <input type="hidden" name="transNo" id="ifrm_transNo">
    <input type="hidden" name="useAmt" id="ifrm_useAmt">
</form>



<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="/booking/privatebooking" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="/booking/privatebooking" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/store#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>