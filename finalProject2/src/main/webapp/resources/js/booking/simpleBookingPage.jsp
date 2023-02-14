<!DOCTYPE html>
<!-- saved from url=(0154)https://www.megabox.co.kr/on/oh/ohb/SimpleBooking/simpleBookingPage.do?rpstMovieNo=22004700&theabKindCode1=&brchNo1=&sellChnlCd=&playDe=&naverPlaySchdlNo= -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=yes">
<title>Megabox</title>




<link rel="stylesheet" href="./megabox.min.css" media="all">




<script src="./jquery-1.12.4.js.다운로드"></script>
<script src="./jquery-ui.1.12.1.js.다운로드"></script>
<script src="./gsaps.js.다운로드"></script>
<script src="./jquery.mCustomScrollbar.concat.min.js.다운로드"></script>
<script src="./megaboxCom.js.다운로드"></script>
<script src="./mega.prototype.js.다운로드"></script>
<script src="./commons.js.다운로드"></script>
<script src="./bootstrap-custom.js.다운로드"></script>
<script src="./bootstrap-select.js.다운로드"></script>
<script type="text/javascript" src="./netfunnel.js.다운로드" charset="UTF-8"></script>
<script type="text/javascript" src="./netfunnel_skin.js.다운로드"
	charset="UTF-8"></script>
<script type="text/javascript" src="./netfunnel_frm.js.다운로드"
	charset="UTF-8"></script>

<!-- 2019.07.30 hjchoi 예매관련 팝업 js분리 -->
<script src="./megabox-simpleBokd.js.다운로드"></script>

<script type="text/javascript">
    var _init = {
        cache    : Date.now(),
        path    : '/static/pc/js/'
    };


    document.write(
        '<script src="'+_init.path+'ui.common.js?v='+_init.cache+'"><\/script>'+
        '<script src="'+_init.path+'front.js?v='+_init.cache+'"><\/script>'
    );

    var sysCd = 'ON';

    //넷퍼넬 스킨 타입 지정
	NetfunnelChk.setting( sysCd, MegaboxUtil.Common.isApp() );
//영화에서 왔을때 초기 영화 셋팅

/*
    영화편성일자목록조회   편성일자 클릭시 처리 안함.
    영화목록조회           영화 클릭시 처리안함
    큐레이션영화목록조회   영화 클릭시 처리안함
    지역지점목록조회
    특별관지점목록조회
    회원일경우
        선호지점목록조회
    영화명선택있는경우
        영화명셋팅
    지점명선택있는경우
        지점명셋팅
        영화편성목록조회
    최초화면진입인경우
        회원인경우
            선호지점자동선택
 */

var localeCode = "kr";               //한영 구분 코드
var allPlayDates = [];                          //달력 선택 가능한 날짜 상단 날짜부분
var loginPopupCallScn = "SimpleBokdM";          //로그인 레이어 팝업 띄울때 필요한 PARAM
var movieScnEntry = "22004700";
var movieScnTheabKindCd1 = ""; // 2019.07.23 hjchoi 영화정보에서 상영관종류코드로 넘어온 경우
var movieScnBrchNo1 = ""; // 2019.07.23 hjchoi 영화정보에서 지점코드로 넘어온 경우

//일자 선택 이후 콜백 메소드
function tempMthd(opts, dates) {
    var tgt = "";
    var cls = "";

    if(opts === undefined){
        if(dates !== undefined)    tgt = document.querySelector('[date-data="'+ dates +'"]');
    }
    else {
        tgt = document.querySelector('.date-area button.on');
    }

    if(tgt != ""){
        var cls = tgt.getAttribute('class');
        $(tgt).addClass('on');
        mbThCalendar.lastSavedDate = dates;
    }

    if (cls.indexOf('disabled') !== -1) {
        gfn_alertMsgBoxSize('예매가능한 날짜가 아닙니다.',400,250);    //예매가능한 날짜가 아닙니다.
        return;
    }
    else {
        if(tgt != ""){
            palyDe = tgt.getAttribute('date-data');
            //console.log(palyDe);
            if(palyDe != $('#playDe').val()){
                $('#datePicker').val(palyDe);
                $('#playDe').val(palyDe);
            }
        }
        fn_selectBokdList(false,'movieFormDe');
    }
};

$(function(){
    $('#choiceMovieList').hide();
    $('#choiceBrchList').hide();
    var crtDe = '20220411';  //서버일자
    var crtDt = '2134';  //서버시간
    var paramPlayDe = '20220411';	//파라메터일자
    mbThCalendar.globalSvrDate = crtDe;
    mbThCalendar.tempMthd = tempMthd;
    //fn_setDatePicker(crtDe);
    //console.log(crtDe);
    mbThCalendar.init();
    mbThCalendar.arrCkFlag = true; //날짜 플래그 시작부분
    //mbThCalendar.setUI();
    //mbThCalendar.events.trimdate({ mnDate:crtDe.maskDate()});   //현재서버일자를 셋팅한다. 2019.05.27 주석처리
    $('#crtDe').val(crtDe.maskDate());
    $('#playDe').val(paramPlayDe.maskDate());
    $('#datePicker').val(paramPlayDe.maskDate());

    /*영화선택후 들어오면 영화세팅*/
    if("" != "22004700"){
        //fn_movieListChange("22004700", "set");
    }
    fn_selectBokdList(true);   //한판조회 param onLoad 여부

    /* 영화 전체 영화선택 */
    $("#movieList").on("click",".btn", function(){
        mbThCalendar.arrCkFlag = false; //날짜 플래그 시작부분
        if($(this).hasClass("on") ==  true){
            fn_deleteMovieChoice($(this).attr("movie-no"));
        }
        else {
            fn_validateMovieChoi($(this));
        }
    });

    /*영화 큐레이션 영화선택*/
    $("#crtnMovieList").on("click",".btn", function(){
        mbThCalendar.arrCkFlag = false; //날짜 플래그 시작부분
        if($(this).hasClass("on") ==  true){
            fn_deleteMovieChoice($(this).attr("movie-no"));
        }
        else {
            fn_validateMovieChoi($(this));
        }
    });

    /*영화관 전체 지점클릭*/
    $("#brchList").on("click","#btn", function(){
        mbThCalendar.arrCkFlag = false; //날짜 플래그 시작부분
        if($(this).hasClass("on") ==  true){
            fn_deleteBrchChoice($(this).attr("brch-no"), $(this).attr("area-cd"));
        }
        else {
            fn_validateBrchChoi($(this), "area");
        }
    });

    /*영화관 특별관 지점클릭*/
    $("#specialBrchList").on("click","#btn", function(){
        mbThCalendar.arrCkFlag = false; //날짜 플래그 시작부분
        if($(this).hasClass("on") ==  true){
            fn_deleteBrchChoice($(this).attr("brch-no"), $(this).attr("area-cd"));
        }
        else {
            fn_validateBrchChoi($(this), "spcl");
        }
    });

    /*상영스케쥴 클릭*/
    $(".movie-schedule-area").on("click",".btn", function(){
    	//남은 좌석수 체크
		var restSeatCnt = Number($(this).attr("rest-seat-cnt"));
    	if(restSeatCnt == 0){
    		gfn_alertMsgBoxSize('선택하신 회차는 매진으로 예매진행이 불가합니다.',400,250);    //선택하신 회차는 매진으로 예매진행이 불가합니다.
    		return;
    	}

    	// TODO 라이브 중계일 경우 넷퍼넬 (오류로 잠시 제거)
        fn_mainValidAndPopup($(this),"simpleBokd");
        /*
    	if( $(this).attr("ctts-ty-div-cd") == "MVCT09" ){
    		NetfunnelChk.script("BOOK_STEP2",function(){
    			fn_mainValidAndPopup($(this),"simpleBokd");
    		});
    	}else{
    		// 2019.07.29 hjchoi 20분 미만 체크 및 팝업 조회 순서 변경
            //fn_valid20MinBlw($(this)); //20분 미만 체크
            fn_mainValidAndPopup($(this),"simpleBokd");
            //상영관 팝업 여부 체크
            //파라메타 넘김
    	}
    	*/
    });

    //달력 오늘 클릭
    $.datepicker._gotoToday = function(id) {
       var target = $(id);
       var inst   = this._getInst(target[0]);
       var arr    = $('#crtDe').val().split('.');
       inst.selectedDay = arr[2]
       inst.drawMonth   = inst.selectedMonth = arr[1] -1;
       inst.drawYear    = inst.selectedYear  = arr[0].toNumber();
       this._setDateDatepicker(target, new Date());
       this._selectDate(id, this._getDateDatepicker(target));
    }
});

//달력 삭제
function fn_setDatePickerDestory(){
    $("#datePicker").datepicker("destroy");
}

//달력 초기화 셋팅
function fn_setDatePicker(crtDe, param){

    $("#datePicker").datepicker({
         tempHtmlShow : true
        ,allPlayDateClassName : "meagBox-selected-day"
        ,allPlayDates : param
        ,showButtonPanel : true
        ,minDate : crtDe.maskDate()       //TODO 서버시간으로 변경
        ,onSelect : function(){ fn_setFormDeOnclickCalendar() }
        ,showAnim : 'fadeIn'
        // 달력 좌측으로 뜨기
        ,beforeShow : function(input, inst){
        var _cal = inst.dpDiv;

            setTimeout(function(){
                _cal.position({
                    of : $('.time-schedule'),
                    my : 'right top',
                    at : 'right top',
                    collision : 'none none'
                });
            }, 0);
        }
    });
}

/*달력 클릭으로 일자 이동*/
function fn_setFormDeOnclickCalendar(){
    var isBokd = false;

    for(var i=0; i<allPlayDates.length; i++){
        if(allPlayDates[i] == $('#datePicker').val()) {
            isBokd = true
        }
    }

    //일자 이동
    if(isBokd){
        $(".time-schedule").addClass("not-available");
         mbThCalendar.events.trimdate({ mnDate:$('#datePicker').val(), callback:mbThCalendar.tempMthd});
         // mbThCalendar.events.trimdate({ mnDate:$('#datePicker').val(), callback:tempMthd.bind(this, undefined, $('#datePicker').val())});
    }
    else {
        gfn_alertMsgBoxSize('예매가능한 날짜가 아닙니다.',400,250);    //예매가능한 날짜가 아닙니다.
        $('#datePicker').val($('#playDe').val());
    }

}

//서버시간조회
function fn_getCrtPlayTime(){
    var rtnVal = new Date();
    var paramData = {};
    $.ajaxMegaBox({
     //      url: "/on/oh/ohb/SimpleBooking/selectPlayScheduleList.do", 변경
         url: "/on/oh/ohb/SimpleBooking/selectCrtPlayTime.do",
         data: JSON.stringify(paramData),
         //async: false,
         success: function (data, textStatus, jqXHR) {
            var year = (data.crtPlayTimeMap.crtDe).substr(0,4);
            var mm   = (data.crtPlayTimeMap.crtDe).substr(4,2);
            var dd   = (data.crtPlayTimeMap.crtDe).substr(6,2);
            var hh   = (data.crtPlayTimeMap.crtDt).substr(0,2);
            var mi   = (data.crtPlayTimeMap.crtDt).substr(2,2);
            rtnVal = new Date(year, Number(mm)-1, dd, hh, mi);
         },
         error: function(xhr,status,error){
             var err = JSON.parse(xhr.responseText);
             alert(xhr.status);
             alert(err.message);
         }
    });
    return rtnVal;
}

//영화 선택전 벨리데이션 체크
function fn_validateMovieChoi(obj){
    var rowCnt = 0;
    $("#choiceMovieList .bg").each(function(idx){
        if($.trim($(this).html()) == ""){
            if(rowCnt == 0){
                rowCnt++;
            }
        }
    });
    if(rowCnt == 0){
        gfn_alertMsgBoxSize('영화는 최대 3개까지 선택이 가능합니다.',400,250);    //영화는 최대 3개까지 선택이 가능합니다.
        return false;
    }
    //빠른일자 검색
    fn_selectMinBokdAbleDe(obj);
}

//영화전체 큐레이션 영화선택
function fn_setMovieChoi(arrayParam){
    var obj         = arrayParam[0];
    var uptUnableAt = arrayParam[1];
    var movieNo     = $(obj).attr("movie-no");
    var movieNm	    = $(obj).attr("movie-nm");
    var imgPath     = $(obj).attr("img-path");
    var rowCnt      = 0;

    $("#choiceMovieList .bg").each(function(idx){
        if($.trim($(this).html()) == ""){
            if(rowCnt == 0){
                var appendHtml = "";
                appendHtml += "<div class=\"wrap\">";
                appendHtml += "    <div class=\"img\"><img src=\""+imgPath+"\" alt=\""+movieNm+"\" movie-no=\""+movieNo+"\" onerror=\"noImg(this);\" /></div>";
                appendHtml += "    <button type=\"button\" class=\"del\" onclick=\"fn_deleteMovieChoice('"+movieNo+"')\">삭제</button>";
                appendHtml += "</div>";
                $(this).append(appendHtml);
                rowCnt++;
            }
        }
    });
    if(typeof uptUnableAt != 'undefined' && (uptUnableAt == 'N' || uptUnableAt == '')){
        fn_movieListChange(movieNo, "ins");
    }
}


//영화 특별관 지점선택전 벨리데이션 체크
function fn_validateBrchChoi(obj, type){
    var brchNo = $(obj).attr("brch-no");
    var areaCd = $(obj).attr("area-cd");
    var rowCnt = 0;

    $("#choiceBrchList .bg").each(function(idx){

    	var tarBrchNo = $(this).find(".del").attr("brch-no");
    	var tarAreaCd = $(this).find(".del").attr("area-cd");

        if($.trim($(this).html()) == ""){
            rowCnt ++;
        }
        if(tarBrchNo == brchNo){
        	rowCnt ++;
        }
    });
    if(rowCnt == 0){
        gfn_alertMsgBoxSize('극장은 최대 3개까지 선택이 가능합니다.',400,250);    //극장은 최대 3개까지 선택이 가능합니다.
        return false;
    }

    fn_getBrchBokdUnablePopup(obj, type);
}



//영화관 특별관 지점선택
function fn_setBrchChoi(arrayParam){
    var obj = arrayParam[0];
    var type = arrayParam[1];
    var uptAt = typeof arrayParam[2] != 'undefined' ? arrayParam[2] : "N";
    var brchNo = $(obj).attr("brch-no");
    var brchNm = $(obj).attr("brch-nm");
    var brchEngNm = $(obj).attr("brch-eng-nm");
    var areaCd = $(obj).attr("area-cd");
    var spclbYn = $(obj).attr("spclb-yn");
    var theabKind = $(obj).attr("area-cd-nm");
    var theabKindCd = $(obj).attr("area-cd");


    var rowCnt = 0;
    //fn_brchPopup(brchNo ,unableAt, popupAt, popupNo);

    //같은건이 있으면 삭제
    $("#choiceBrchList .bg").each(function(idx){
        if($(this).find(".del").attr("brch-no") == brchNo){
            $(this).empty()
        }
    });

    $("#choiceBrchList .bg").each(function(idx){
        //극장에서 선택했을때 동일극장이 특별관에도 있는지 확인하여 체크해제
        if(type =="area"){
            $("#specialBrchList #btn").each(function(idx){
                if($(this).attr("brch-no") == brchNo){
                    $(this).removeClass("on");
                }
            });
        }

        //특별관에서 선택했을때 동일극장이 전체극장에도 있는지 확인하여 체크해제
        if(type =="spcl"){
            $("#brchList #btn").each(function(idx){
                if($(this).attr("brch-no") == brchNo){
                    $(this).removeClass("on");
                }
            });
        }

        if($.trim($(this).html()) == ""){
            if(rowCnt == 0){
                var appendHtml = "";
                appendHtml += "<div class=\"wrap\">";
                appendHtml += "<p class=\"txt\">";
                if(localeCode == 'en'){
                    appendHtml +=brchEngNm;
                }
                else {
                    appendHtml +=brchNm;
                }

                if(type =="spcl"){
                    appendHtml += "</br>"+theabKind+"</p>";
                }
                appendHtml += "<button type=\"button\" class=\"del\" ";
                appendHtml += "onclick=\"fn_deleteBrchChoice('"+brchNo+"', '"+areaCd+"')\" ";
                appendHtml += "brch-no=\""+brchNo+"\" area-cd=\""+areaCd+"\" spclb-yn=\""+spclbYn+"\" theab-kind-cd=\""+theabKindCd+"\">";
                appendHtml += "삭제";
                appendHtml += "</button>";
                appendHtml += "</div>";

                $(this).append(appendHtml);
                rowCnt++;
            }
        }
    });
    fn_brchListChange(brchNo, "ins", areaCd);

    if(uptAt != "N"){
        fn_selectBokdList(false,"brchList") //예매 목록 갱신
    }
    return;
}

/*선택한 영화 삭제*/
function fn_deleteMovieChoice(movieNo){
    var obj = $('#choiceMovieList');
    var movieChoiCnt = $('#choiceMovieList .img').size();
    var brchChoiCnt = $('#choiceBrchList .txt').size();
    $("#choiceMovieList .bg").each(function(idx){
        if($(this).find("img").attr("movie-no") == movieNo){
            //$(this).empty();
            $(this).remove();
            var appendHtml = "";
            appendHtml += "<div class=\"bg\"></div>";
            $(obj).append(appendHtml);
        }
    });

    if($('#choiceBrchList .txt').size() == 0 && $("#choiceMovieList .del").size() == 0){
    	fn_selectBokdList(true,"reLoad") //예매 목록 갱신 초기화상태
    }
    else {
    	fn_movieListChange(movieNo, "del");
    }

}


/*선택한 지점 삭제*/
function fn_deleteBrchChoice(brchNo, areaCd){
	var allDisabled = true;
    var obj = $('#choiceBrchList');
    var movieChoiCnt = $('#choiceMovieList .img').size();
    var brchChoiCnt = $('#choiceBrchList .txt').size();
    $("#choiceBrchList .bg").each(function(idx){
        if($(this).find(".del").attr("brch-no") == brchNo && areaCd == $(this).find(".del").attr("area-cd")){
            //$(this).empty();
            $(this).remove();
            var appendHtml = "";
            appendHtml += "<div class=\"bg\"></div>";
            $(obj).append(appendHtml);
        }
    });
	fn_brchListChange(brchNo, "del", areaCd);

	$('#brchList li ul button.on').each(function(idx){
    	if(!$(this).hasClass("disabled")){
    		allDisabled = false;
    	}
    });

	$('#specialBrchTab li ul button.on').each(function(idx){
    	if(!$(this).hasClass("disabled")){
    		allDisabled = false;
    	}
    });

	if(!allDisabled || $('#choiceBrchList .txt').size() == 0){
		if($('#choiceBrchList .txt').size() == 0 && $("#choiceMovieList .del").size() == 0){
			fn_selectBokdList(true,"reLoad") //예매 목록 갱신 초기화상태
		}
		else {
			fn_selectBokdList(false,"brchList") //예매 목록 갱신
		}

	}
	else {
    	if($('#choiceBrchList .txt').size() > 0){
    		fn_selectMinBokdAbleDe(undefined);
    	}
    }
}

/*목록에서 영화선택, 삭제후 UI변경*/
function fn_movieListChange(movieNo, type){
	var allDisabled = true;
    $("#movieList .btn").each(function(idx){
        if($(this).attr("movie-no") == movieNo){
            if(type=="del"){
                $(this).removeClass("on");
            }else{
                $(this).addClass("on");
            }
        }
    });
    $("#crtnMovieList .btn").each(function(idx){
        if($(this).attr("movie-no") == movieNo){
            if(type=="del"){
                $(this).removeClass("on");
            }else{
                $(this).addClass("on");
            }
        }
    });

    $("#movieList .btn.on").each(function(idx){
    	if(!$(this).hasClass("disabled")){
    		allDisabled = false;
    	}
    });

	if("set" != type){
		if(!allDisabled || $('#choiceMovieList .img').size() == 0){
			fn_selectBokdList(false,"movieList");
		}
		else {
	    	if($('#choiceMovieList .img').size() > 0){
	    		fn_selectMinBokdAbleDe(undefined);
	    	}
	    }
    }
}

/*목록에서 지점선택, 삭제후 UI변경*/
function fn_brchListChange(brchNo, type, areaCd){
    //console.log("fn_brchListChange param : "+brchNo+"/"+type+"/"+areaCd)
    $("#brchList #btn").each(function(idx){
        if($(this).attr("brch-no") == brchNo){
            if(type=="del"){
                if(areaCd == $(this).attr("area-cd")){
                    $(this).removeClass("on");
                }
            }else{
                if(areaCd == $(this).attr("area-cd")){
                    $(this).addClass("on");
                }
            }
        }
    });
    $("#specialBrchList #btn").each(function(idx){
        if($(this).attr("brch-no") == brchNo){
            if(type=="del"){
                if(areaCd == $(this).attr("area-cd")){
                    $(this).removeClass("on");
                }
            }else{
                if(areaCd == $(this).attr("area-cd")){
                    $(this).addClass("on");
                }
            }
        }
    });
}

//영화편성일자목록 갱신
function fn_movieFormDeListUpt(bOnLoad, list, crtPlayTimeMap, paramMap){
    var crtDe = crtPlayTimeMap.crtDe; //서버일자
    holidaysFromServer = [];            //상단 일자부분 서버 휴일 설정
    disdaysFromServer = [];             //
    allPlayDates = [];                  //달력활성일자
    if("" != $('#playDe').val()){
        fn_setDatePickerDestory();
    }

    for(var i=0; i<list.length; i++) {

        if(list[i].hldyDivAt == "Y"){
            setHldyAdopt(list[i].playDe);    //휴일일자셋팅
        }
        if(list[i].formAt == "Y"){
            setDisdyAdopt((list[i].playDe).maskDate());  //영화편성일자셋팅
            allPlayDates.push((list[i].playDe).maskDate()); //달력셋팅
        }
    }
    fn_setDatePicker(crtDe, allPlayDates);

    if(bOnLoad){
		$('#playDe').val(paramMap.playDe.maskDate());
        $('#crtDe').val(crtDe.maskDate());
        $('#datePicker').val($('#playDe').val());
    }
    //if (typeof mbThCalendar === 'object') mbThCalendar.init({ target:'date-area', fetchHoliday:setHldyAdopt, holidays:'holidaysFromServer' });  //상단일자부분 휴일설정
}

//영화목록 갱신
function fn_movieListUpt(list,type, paramMap){
    if(type == "crtn"){
        //console.log("fn_crtnMovieListUpt in");
        $("#crtnMovieList div div:eq(0)").empty();
    }
    else {
        //console.log("fn_movieListUpt in");
        $("#movieList div div:eq(0)").empty();
    }
    if(0 < list.length){
        var appendHtml = "<ul>";
           for(var i=0; i<list.length; i++) {
                appendHtml += "<li>";
                appendHtml += "<button type=\"button\" class=\"btn";
                //최초 로딩상황
                if(typeof paramMap.onLoad !== "undefined" && paramMap.onLoad != "" && paramMap.onLoad == "Y"){
                    if($.trim(paramMap.movieNo1) == list[i].movieNo){
                        appendHtml += " on";
                    }

                    if((typeof $.trim(paramMap.movieNo1) !==  "undefined"
                            && $.trim(paramMap.movieNo1) !=  ""
                            && list[i].formAt != "Y"
                            && "" == parent.sellChnlCd)
                        ||
                        (typeof $.trim(paramMap.brchNo1) !==  "undefined"
                            && $.trim(paramMap.brchNo1) !=  ""
                            && list[i].formAt != "Y"
                            && "" == parent.sellChnlCd)){
                        appendHtml += " disabled";
                    }
                }
                else {
                    //편성여부
                    if(list[i].formAt != "Y"){
                        appendHtml += " disabled";
                    }
                }
//                 else {
//                     var splitMovieNo = paramMap.arrMovieNo.split(",");
//                     for(var j=0;j<splitMovieNo.length;j++){
//                         if($.trim(splitMovieNo[j]) == list[i].movieNo){
//                             appendHtml += " on";
//                         }
//                     }
//                 }
                var movieImgPath = list[i].movieImgPath != null ? list[i].movieImgPath : '';

                appendHtml += "\" movie-nm=\""+list[i].movieNm+"\" movie-no=\""+list[i].movieNo+"\" img-path=\""+movieImgPath+"\" movie-popup-at=\""+list[i].moviePopupAt+"\" movie-popup-no=\""+list[i].moviePopupNo;
                appendHtml += "\" form-at=\""+list[i].formAt;
                appendHtml += "\" >";

                //등급
                if(list[i].admisClassCd == "AD01"){
                    appendHtml += "<span class=\"movie-grade small age-all\">"+list[i].admisClassCdNm+"</span>";
                }
                else if(list[i].admisClassCd == "AD02"){
                    appendHtml += "<span class=\"movie-grade small age-12\">"+list[i].admisClassCdNm+"</span>";
                }
                else if(list[i].admisClassCd == "AD03"){
                    appendHtml += "<span class=\"movie-grade small age-15\">"+list[i].admisClassCdNm+"</span>";
                }
                else if(list[i].admisClassCd == "AD04"){
                    appendHtml += "<span class=\"movie-grade small age-19\">"+list[i].admisClassCdNm+"</span>";
                }
                else if(list[i].admisClassCd == "AD06"){
                    appendHtml += "<span class=\"movie-grade small age-no\">"+list[i].admisClassCdNm+"</span>";
                }

                //보고싶어 여부
                if("" == parent.sellChnlCd){	//RIA가 아닌경우
                	if(list[i].intrstMovieAt == "Y"){
	                    appendHtml += "<i class=\"iconset ico-heart-on-small\">보고싶어 설정함</i>";

	                }
	                else {
	                    appendHtml += "<i class=\"iconset ico-heart-small\">보고싶어 설정안함</i>";
	                }
                }
                appendHtml += "<span class=\"txt\">";

                //영화명 한/영
                if(localeCode == 'en'){
                    appendHtml +=list[i].movieEngNm+"</span>";
                }
                else {
                    appendHtml +=list[i].movieNm+"</span>";
                }
                appendHtml += "</button></li>";
            }
        if(type == "crtn"){
            $("#crtnMovieList div div:eq(0)").append(appendHtml);
        }
        else {
            $("#movieList div div:eq(0)").append(appendHtml);
        }
    }
}


//선호지점표시
function fn_favorBrchDisp(bOnLoad, uptType) {
    //console.log("fn_favorBrchDisp in");
    var appendHtml = "";
    appendHtml += "<li id=\"liFavorBrch\"><button id=\"btnFavorBrch\" type=\"button\" class=\"btn";
    if(bOnLoad && uptType == undefined){
        appendHtml += " on";
    }

    appendHtml += "\">";
    appendHtml += "<span calss=\"txt\">선호극장</span></button>";
    appendHtml += "<div class=\"depth on\" id=\"favorite\"></div>";
    if(bOnLoad){
        $("#brchList>ul").append(appendHtml);
    }
}


//선호지점목록갱신
function fn_favorBrchListUpt(bOnload, uptType, list){
    //console.log("fn_favorBrchListUpt in");
    var brchOnlineExpoAt = false;
    var innerHtml = "";
    if(list != null && list.length > 0){    //선호지점 있는경우
        if(bOnload && uptType == undefined){
            $("#favorite").append("<div class=\"detail-list m-scroll\"><ul></ul></div>");
        }

        for(var i=0; i<list.length; i++){
            if(list[i].brchOnlineExpoAt == "Y"){
                brchOnlineExpoAt = true;
            }
            innerHtml += "<li><button id=\"btn\" type=\"button\" ";
            if(list[i].formAt != "Y"){
                innerHtml += "class=\"disabled\" ";
            }
            innerHtml += "brch-no=\""+list[i].brchNo+"\" brch-nm=\""+list[i].brchNm+"\" brch-eng-nm=\""+list[i].brchEngNm+"\" ";
            innerHtml += "area-cd=\""+list[i].areaCd+"\" area-cd-nm=\""+list[i].areaCdNm+"\" ";
            innerHtml += "spclb-yn=\"N\" ";
            innerHtml += "form-at=\""+list[i].formAt+"\" ";
            innerHtml += "brch-bokd-unable-at=\""+list[i].brchBokdUnableAt+"\" brch-popup-at=\""+list[i].brchPopupAt+"\" brch-popup-no=\""+list[i].brchPopupNo+"\">";

            if(list[i].brchOnlineExpoAt == "Y"){
                innerHtml += "<span class=\"jq-tooltip\" title=\"";
                if(localeCode == 'en'){
                    innerHtml += list[i].brchOnlineExpoStatCdEngNm;
                }
                else {
                    innerHtml += list[i].brchOnlineExpoStatCdNm;
                }

                innerHtml += "\">";

                if(localeCode == 'en'){
                    innerHtml += list[i].brchEngNm;
                }
                else {
                    innerHtml += list[i].brchNm;
                }

                innerHtml += "</span>";
            }
            else {
                if(localeCode == 'en'){
                    innerHtml += list[i].brchEngNm;
                }
                else {
                    innerHtml += list[i].brchNm;
                }
            }
            if(list[i].brchOnlineExpoAt == "Y"){

                var expoStatHtml = "";
                if(localeCode == 'en'){
                    expoStatHtml += list[i].brchOnlineExpoStatCdEngNm+"\">"+list[i].brchOnlineExpoStatCdEngNm+"</i>";
                }
                else {
                    expoStatHtml += list[i].brchOnlineExpoStatCdNm+"\">"+list[i].brchOnlineExpoStatCdNm+"</i>";
                }

                if(list[i].brchOnlineExpoStatCd == 'OES01'){
                    innerHtml += "<i class=\"iconset ico-theater-new\" title=\""+expoStatHtml;
                }
                else if (list[i].brchOnlineExpoStatCd == 'OES02'){
                    innerHtml += "<i class=\"iconset ico-theater-renewal\" title=\""+expoStatHtml;
                }
                else if (list[i].brchOnlineExpoStatCd == 'OES03'){
                    innerHtml += "<i class=\"iconset ico-theater-open\" title=\""+expoStatHtml;
                }
                else if (list[i].brchOnlineExpoStatCd == 'OES04'){
                    innerHtml += "<i class=\"iconset ico-theater-open\" title=\""+expoStatHtml;
                }
            }
            innerHtml += "</button></li>";
        }
        $("#favorite ul").append(innerHtml);
    }

    innerHtml = "";
    innerHtml +="<div class=\"no-favorite\">";
    innerHtml +="<div class=\"wrap\">";
    innerHtml +="<i class=\"iconset ico-theater-favorite\"></i>";
    innerHtml +="<div class=\"txt\">";
    innerHtml +="자주가는 극장을<br />";
    innerHtml +="등록해 보세요!";
    innerHtml +="</div>";
    innerHtml +="<div class=\"setting\">";
    innerHtml +="<a href=\"javaScript:fn_favorBrchReg()\" title=\"선호극장 설정\"><i class=\"iconset ico-theater-chk-purple\"></i> 선호극장 설정</a>";
    innerHtml +="</div>";
    innerHtml +="</div>";
    innerHtml +="</div>";
    $("#favorite").append(innerHtml);

    if(brchOnlineExpoAt){
        $("#btnFavorBrch").addClass("has-issue");
    }
}


function fn_favorBrchReg(){
    var paramFavorBrchReg = { localeCode : localeCode };
    gfn_favorBrchReg(fn_simpleBokdComplFavorBrch, paramFavorBrchReg);
}


function fn_simpleBokdComplFavorBrch(){
    location.reload();
}

//지역지점, 특별관지점 목록갱신
function fn_brchListUpt(list, type, paramMap) {

    //최초 로딩 아닌경우 지점 상세 초기화
    if(typeof paramMap.onLoad === "undefined" || paramMap.onLoad == "" || paramMap.onLoad != "Y" || paramMap.uptType =="reLoad"){
        if(type != "area") {
            $('#specialBrchList li ul').empty();    //특별관 상세 초기화
        }
    }
    var curAreaCd = "";    //현재 지역코드


    for(var i=0; i<list.length; i++) {
        var appendHtml = "";    //지점 마스터
        var innerHtml = "";        //지점 상세

        //최초 로딩인경우
        if(typeof paramMap.onLoad !== "undefined" && paramMap.onLoad != "" && paramMap.onLoad == "Y" && paramMap.uptType === undefined){
            var appendHtml = "";
            var toAreaCd = list[i].areaCd;        //데이터 지역코드

            var innerHtml = "";
            if(curAreaCd != toAreaCd){    //현재 지역코드와 데이터에서 조회된 지역코드가 다르면
                curAreaCd = toAreaCd;    //지역코드값 셋팅

                appendHtml += "<li><button type=\"button\" class=\"btn";
                if(list[i].areaOnlineExpoAt == "Y"){
                    appendHtml += " has-issue";
                }
                //전체 극장 지역 on
                if(type == "area" && paramMap.brchAll == curAreaCd){
                    appendHtml += " on";
                }
                  //특별관 극장 극장 지역 on
                if(type == "spcl" && paramMap.brchSpcl == curAreaCd){
                    appendHtml += " on";
                }

                appendHtml += "\" id=\""+curAreaCd+"\">";
                appendHtml += "<span calss=\"txt\">";
                if(localeCode == 'en'){
                    appendHtml += list[i].areaCdEngNm+"("+ list[i].formBrchCnt+")";
                }
                else {
                    appendHtml += list[i].areaCdNm+"("+ list[i].formBrchCnt+")";
                }
                appendHtml +="</span></button>";
                appendHtml +="<div class=\"depth\">";
                appendHtml +="<div class=\"detail-list m-scroll area-cd"+curAreaCd.trim().replaceAll(" ","")+"\" ><ul></ul></div></div>";
                if(type == "area") {
                    $("#brchList>ul").append(appendHtml);
                }
                else {
                    $("#specialBrchList>ul").append(appendHtml);
                }
                //console.log(appendHtml)
            }
        }

        innerHtml += "<li><button id=\"btn\" type=\"button\" ";
        //최초 로딩이 아닌경우
        if(typeof paramMap.onLoad === "undefined" || paramMap.onLoad == "" || paramMap.onLoad != "Y"){

            if(list[i].brchFormAt != "Y"){
                innerHtml += "class=\"disabled\" ";
            }
        }
        //최초로딩인경우
        else {
            if((typeof $.trim(paramMap.movieNo1) !==  "undefined"
                && $.trim(paramMap.movieNo1) !=  ""
                && list[i].brchFormAt != "Y"
                && "" == parent.sellChnlCd)
            ||
            (typeof $.trim(paramMap.brchNo1) !==  "undefined"
                && $.trim(paramMap.brchNo1) !=  ""
                && list[i].brchFormAt != "Y"
                && "" == parent.sellChnlCd)){
                innerHtml += "class=\"disabled\" ";
            }
        }

        innerHtml += "brch-no=\""+list[i].brchNo+"\" brch-nm=\""+list[i].brchNm+"\" brch-eng-nm=\""+list[i].brchEngNm;
        innerHtml += "\" form-at=\""+list[i].brchFormAt;
        innerHtml += "\" area-cd=\""+list[i].areaCd+"\" area-cd-nm=\""+list[i].areaCdNm+"\" ";
        if(type == "area") {
            innerHtml += "spclb-yn=\"N\" ";
        }
        else {
            innerHtml += "spclb-yn=\"Y\" ori-area-cd =\""+list[i].oriAreaCd+"\" ";
        }
        innerHtml += "brch-bokd-unable-at=\""+list[i].brchBokdUnableAt+"\" brch-popup-at=\""+list[i].brchPopupAt+"\" brch-popup-no=\""+list[i].brchPopupNo+"\">";


        if(list[i].brchOnlineExpoAt == "Y"){
            innerHtml += "<span class=\"jq-tooltip\" title=\"";
            if(localeCode == 'en'){
                innerHtml += list[i].brchOnlineExpoStatCdEngNm;
            }
            else {
                innerHtml += list[i].brchOnlineExpoStatCdNm;
            }

            innerHtml += "\">";

            if(localeCode == 'en'){
                innerHtml += list[i].brchEngNm;
            }
            else {
                innerHtml += list[i].brchNm;
            }

            innerHtml += "</span>";
        }
        else {
            if(localeCode == 'en'){
                innerHtml += list[i].brchEngNm;
            }
            else {
                innerHtml += list[i].brchNm;
            }
        }
        if(list[i].brchOnlineExpoAt == "Y"){

            var expoStatHtml = "";
            if(localeCode == 'en'){
                expoStatHtml += list[i].brchOnlineExpoStatCdEngNm+"\">"+list[i].brchOnlineExpoStatCdEngNm+"</i>";
            }
            else {
                expoStatHtml += list[i].brchOnlineExpoStatCdNm+"\">"+list[i].brchOnlineExpoStatCdNm+"</i>";
            }

            if(list[i].brchOnlineExpoStatCd == 'OES01'){
                innerHtml += "<i class=\"iconset ico-theater-renewal\" title=\""+expoStatHtml;
            }
            else if (list[i].brchOnlineExpoStatCd == 'OES02'){
                innerHtml += "<i class=\"iconset ico-theater-new\" title=\""+expoStatHtml;
            }
            else if (list[i].brchOnlineExpoStatCd == 'OES03'){
                innerHtml += "<i class=\"iconset ico-theater-open\" title=\""+expoStatHtml;
            }
            else if (list[i].brchOnlineExpoStatCd == 'OES04'){
                innerHtml += "<i class=\"iconset ico-theater-open\" title=\""+expoStatHtml;
            }
        }

        innerHtml += "</button>";
        innerHtml += "</li>";

        //최초로딩인경우
        if(typeof paramMap.onLoad !== "undefined" && paramMap.onLoad != "" && paramMap.onLoad == "Y" && paramMap.uptType === undefined){
            $(".area-cd"+curAreaCd.trim().replaceAll(" ","")+">ul").append(innerHtml);
        }
        //최초로딩아닌경우
        else {
            $('#'+list[i].areaCd.trim().replaceAll(" ","")).next().find('ul').append(innerHtml);
        }

    }
}


//영화편성목록 갱신
function fn_movieFormListUpt(list, crtPlayTimeMap) {
    //console.log("fn_movieFormListUpt in");

    $("#playScheduleList").show();
    $("#playScheduleNonList").hide();

    var appendHtml = ""
    appendHtml = "<ul>";

    for(var i=0; i<list.length; i++) {
        appendHtml += "<li>";
        appendHtml += "<button type=\"button\" class=\"btn\" id=\""+list[i].playSchdlNo+"\" ";
        appendHtml += "play-start-time=\""+(list[i].playStartTime).replaceAll(":","")+"\" "; //시작시간
        appendHtml += "play-de=\"" + list[i].playDe + "\" play-seq=\"" + list[i].seq + "\" rpst-movie-no=\"" + list[i].movieNo + "\" brch-no=\""+list[i].brchNo+"\" theab-no=\""+list[i].theabNo+"\" play-schdl-no=\""+list[i].playSchdlNo+"\" "; //지점번호, 상영관 번호
        appendHtml += "rest-seat-cnt=\""+Number(list[i].restSeatCnt)+"\" "; //시작시간
        appendHtml += "ctts-ty-div-cd=\""+ list[i].cttsTyDivCd +"\" "; //콘텐츠 유형
        appendHtml += "theab-popup-At=\""+list[i].theabPopupAt+"\" theab-popup-no=\""+list[i].theabPopupNo+"\">";//상영관 팝업여부, 상영관 팝업 번호
        appendHtml += "<div class=\"legend\">";

        if(list[i].playTyCd == "ERYM"){
            appendHtml += "<i class=\"iconset ico-sun\" title=\"조조\">조조</i>";
        }
        else if(list[i].playTyCd == "BRUNCH"){
            appendHtml += "<i class=\"iconset ico-brunch\" title=\"브런치\">브런치</i>";
        }
        else if(list[i].playTyCd == "MNIGHT"){
            appendHtml += "<i class=\"iconset ico-moon\" title=\"심야\">심야</i>";
        }
        appendHtml += "</div>";

        appendHtml += "<span class=\"time\">";
        appendHtml += "<strong title=\"상영 시작\">"+list[i].playStartTime+"</strong>";
        appendHtml += "<em title=\"상영 종료\">~"+list[i].playEndTime+"</em>";
        appendHtml += "</span>";

        appendHtml += "<span class=\"title\">";

        if(list[i].eventDivCd != null && list[i].eventDivCd != "") {
        	var eventDivStr = "";

        	//무대인사
        	if(list[i].eventDivCd == "MEK01") {
        		eventDivStr = "fc01"	//무대인사
        	}
        	//오픈시사
        	else if(list[i].eventDivCd == "MEK02"){
        		eventDivStr = "fc03"	//오픈시사
        	}
        	//회원시사
        	else if(list[i].eventDivCd == "MEK03"){
        		eventDivStr = "fc02"	//회원시사
        	}
        	//굿즈패키지
        	else if(list[i].eventDivCd == "MEK04"){
        		eventDivStr = "fc04"	//굿즈패키지
        	}
        	//싱어롱
        	else if(list[i].eventDivCd == "MEK05"){
        		eventDivStr = "fc05"	//싱어롱
        	}
        	//GV
        	else if(list[i].eventDivCd == "MEK06"){
        		eventDivStr = "fc06"	//GV
        	}
        }

        if(localeCode == 'en'){
            appendHtml += "<strong title=\""+list[i].movieEngNm+"\">"+list[i].movieEngNm+"</strong>";
            appendHtml += "<em>"+list[i].playKindEngNm;
            if(list[i].eventDivCd != null && list[i].eventDivCd != "") {
            	appendHtml += "&middot; <b class=\"fw0 "+eventDivStr+"\">"+list[i].eventDivCdEngNm+"</b>"
            }
        }
        else {
            appendHtml += "<strong title=\""+list[i].movieNm+"\">"+list[i].movieNm+"</strong>";
            appendHtml += "<em>"+list[i].playKindNm;
            if(list[i].eventDivCd != null && list[i].eventDivCd != "") {
            	appendHtml += "&middot; <b class=\"fw0 "+eventDivStr+"\">"+list[i].eventDivCdNm+"</b>"
            }
        }

        appendHtml += "</em>"
        appendHtml += "</div>";
        appendHtml += "</span>";

        appendHtml += "<div class=\"info\">";
        appendHtml += "<span class=\"theater\" title=\"극장\">";
        if(localeCode == 'en'){
            appendHtml += ""+list[i].brchEngNm+"<br />"+list[i].theabEngNm;
        }
        else{
            appendHtml += ""+list[i].brchNm+"<br />"+list[i].theabExpoNm;
        }
        appendHtml += "</span>";

        appendHtml += "<span class=\"seat\">";

        if(Number(list[i].restSeatCnt) > 0){
        	appendHtml += "<strong class=\"now\" title=\"잔여 좌석\">";
            appendHtml += list[i].restSeatCnt;
            appendHtml += "</strong>";
            appendHtml += "<span>/</span>";
            appendHtml += "<em class=\"all\" title=\"전체 좌석\">"+list[i].totSeatCnt+"</em>";
        }
        else {
        	appendHtml += "<strong class=\"now\" title=\"잔여 좌석\">";
        	appendHtml += "매진";
        	appendHtml += "</strong>";
        }
        appendHtml += "</span>";
        appendHtml += "</div>";
        appendHtml += "</button>";
        appendHtml += "</li>";
    }
    appendHtml += "</ul>";
    $("#playScheduleList div div:eq(0)").append(appendHtml);
    var hour=crtPlayTimeMap.crtDt
    hour = hour.substr(0,2);
    //mbThCalendar.events.selhour({ hour:Number(hour) });

     $("#playScheduleList").mCustomScrollbar("destroy");
     $m_scroll();        //스크롤바 생성
}


/*파라메타 설정*/
function fn_setParamData(arrayParam){

    var fndMovieNo      = "";
    var fndBrchNo       = "";
    var fndAreaCd       = "";
    var fndSpclbYn      = "";
    var fndTheabKindCd  = "";

    if(typeof arrayParam != 'undefined' && arrayParam != ""){
        fndMovieNo      = typeof arrayParam[0] != 'undefined' && arrayParam[0] != '' ? arrayParam[0] : "";
        fndBrchNo       = typeof arrayParam[1] != 'undefined' && arrayParam[1] != '' ? arrayParam[1] : "";
        fndAreaCd       = typeof arrayParam[2] != 'undefined' && arrayParam[2] != '' ? arrayParam[2] : "";
        fndSpclbYn      = typeof arrayParam[3] != 'undefined' && arrayParam[3] != '' ? arrayParam[3] : "";
        fndTheabKindCd  = typeof arrayParam[4] != 'undefined' && arrayParam[4] != '' ? arrayParam[4] : "";
    }

    var brchCnt = 0;
    var movieNo = "";
    var playDe = "";
    var brchAll ="";
    var brchSpcl ="";
    var movieNo1 ="";
    var movieNo2 = "";
    var movieNo3 = "";
    var brchNo1 = "";
    var brchNo2 = "";
    var brchNo3 = "";
    var areaCd1 = "";
    var areaCd2 = "";
    var areaCd3 = "";
    var spclbYn1 = "";
    var spclbYn2 = "";
    var spclbYn3 = "";
    var theabKindCd1 = "";
    var theabKindCd2 = "";
    var theabKindCd3 = "";

    //선택한 영화 세팅
    $("#choiceMovieList .bg").find("img").each(function(idx){
        if(idx == 0){
               movieNo1 = $(this).attr("movie-no");
            movieNo = movieNo1;
        }
        else if(idx == 1){
            movieNo2 = $(this).attr("movie-no");
            movieNo += ","+movieNo2;
        }
        else{
            movieNo3 = $(this).attr("movie-no");
            movieNo += ","+movieNo3;
        }
    });

    if(fndMovieNo != "" && typeof fndMovieNo != 'undefined'){
        if(movieNo1 == ""){
            movieNo1 = fndMovieNo;
            movieNo = movieNo1;
        }
        else if(movieNo2 == ""){
            movieNo2 = fndMovieNo;
            movieNo += ","+movieNo2;
        }
        else if(movieNo3 == ""){
            movieNo3 = fndMovieNo;
            movieNo += ","+movieNo3;
        }
    }

    //선택한 지점 세팅
    $("#choiceBrchList .bg").find(".del").each(function(idx){
//       if(brchCnt == 0){
//           brchNo = $(this).attr("brch-no");
//       }else{
//           brchNo += ","+$(this).attr("brch-no");
//       }
        if(idx == 0){
            brchNo1  = $(this).attr("brch-no");
            areaCd1  = $(this).attr("area-cd");
            spclbYn1 = $(this).attr("spclb-yn");
            theabKindCd1 = $(this).attr("theab-kind-cd");
        }else if(idx == 1){
            brchNo2  = $(this).attr("brch-no");
            areaCd2  = $(this).attr("area-cd");
            spclbYn2 = $(this).attr("spclb-yn");
            theabKindCd2 = $(this).attr("theab-kind-cd");
        }else{
            brchNo3  = $(this).attr("brch-no");
            areaCd3  = $(this).attr("area-cd");
            spclbYn3 = $(this).attr("spclb-yn");
            theabKindCd3 = $(this).attr("theab-kind-cd");
        }
        brchCnt++;
    });

    if(fndBrchNo != "" && typeof fndBrchNo != 'undefined'){
        if(brchNo1 == ""){
            brchNo1      = fndBrchNo;
            areaCd1      = fndAreaCd;
            spclbYn1     = fndSpclbYn;
            theabKindCd1 = fndTheabKindCd;
        }
        else if(brchNo2){
            brchNo2      = fndBrchNo;
            areaCd2      = fndAreaCd;
            spclbYn2     = fndSpclbYn;
            theabKindCd2 = fndTheabKindCd;
        }
        else{
            brchNo3      = fndBrchNo;
            areaCd3      = fndAreaCd;
            spclbYn3     = fndSpclbYn;
            theabKindCd3 = fndTheabKindCd;
        }
    }

    theabKindCd1 = theabKindCd1.indexOf("TB") != -1 ? "TB" : theabKindCd1;
    theabKindCd2 = theabKindCd1.indexOf("TB") != -1 ? "TB" : theabKindCd2;
    theabKindCd3 = theabKindCd1.indexOf("TB") != -1 ? "TB" : theabKindCd3;

    if(brchCnt == 0){
//   if(movieCnt == 0 || brchCnt ==0){
        $("#playScheduleList div div:eq(0)").empty();
        $("#playScheduleList").hide();
        $("#playScheduleNonList").show();
        //return;
    }

    //선택한 날짜 세팅
    playDe = $('#playDe').val().replaceAll( ".", "");
    if(playDe == ""){
        return;
    }

    //전체극장 선택
    $("#brchList>ul>li>button.on").each(function(idx){
        brchAll = $(this).attr("id");
    });

    //특별관 선택
    $("#specialBrchList>ul>li>button.on").each(function(idx){
        brchSpcl = $(this).attr("id");
    });

    //specialBrchList find on

    var paramData = { arrMovieNo:movieNo, playDe:playDe
            , brchNoListCnt:brchCnt, brchNo1:brchNo1, brchNo2:brchNo2, brchNo3:brchNo3
            , areaCd1:areaCd1, areaCd2:areaCd2, areaCd3:areaCd3
            , spclbYn1:spclbYn1, spclbYn2:spclbYn2, spclbYn3:spclbYn3
            , theabKindCd1:theabKindCd1, theabKindCd2:theabKindCd2, theabKindCd3:theabKindCd3
            , brchAll:brchAll, brchSpcl:brchSpcl
            , movieNo1:movieNo1, movieNo2:movieNo2, movieNo3:movieNo3
            , sellChnlCd:parent.sellChnlCd };

    return paramData;
}


//예매목록조회
function fn_selectBokdList(bOnLoad,uptType){
	parent.$(".bg-loading").show();

    var paramData = null;

    if(bOnLoad){
        //console.log("fn_selectBokdList paramData onload param bOnLoad:"+bOnLoad+"/ uptType:"+uptType);
        // 2019.07.23 hjchoi 영화화면에서 상영관종류 또는 지점코드 추가
        //paramData = { playDe:$('#playDe').val().replaceAll( ".", ""), movieNo1:movieScnEntry, onLoad:"Y", sellChnlCd:parent.sellChnlCd}
        if(uptType != undefined && uptType == "reLoad"){
        	paramData = { playDe:$('#crtDe').val().replaceAll( ".", ""), onLoad:"Y", uptType:"reLoad", sellChnlCd:parent.sellChnlCd}
        }
        else {
        	paramData = { playDe:$('#playDe').val().replaceAll( ".", "")
        			, incomeMovieNo:movieScnEntry
        			, onLoad:"Y"
        			, sellChnlCd:parent.sellChnlCd
        			, incomeTheabKindCd:movieScnTheabKindCd1
        			, incomeBrchNo1:movieScnBrchNo1
        			, incomePlayDe:parent.bokdMPlayDe}
        }
    }
    else {
        //console.log("fn_selectBokdList paramData event param bOnLoad:"+bOnLoad+"/ uptType:"+uptType);
        paramData = fn_setParamData('','','','');
    }

    $.ajaxMegaBox({
//         url: "/on/oh/ohb/SimpleBooking/selectPlayScheduleList.do", 변경
        url: "/on/oh/ohb/SimpleBooking/selectBokdList.do",
        data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {
            //console.log("fn_selectBokdList success paramMap:"+JSON.stringify(data.paramMap));
            var choiceBrchCnt = 0;                 //선택된극장수
            var crtPlayTimeUptAt = false;          //현재일자
            var movieFormDeListUptAt = false;      //영화편성일자목록조회
            var favorBrchDispAt = false;           //선호지점표시여부
            var movieListUptAt = false;            //영화목록갱신여부
            var crtnMovieListUptAt = false;        //큐레이션영화목록갱신여부
            var favorBrchListUptAt = false;        //선호지점갱신여부
            var areaBrchListUptAt = false;         //지역지점목록갱신여부
            var spclbBrchListUptAt = false;        //특별관지점목록갱신여부
            var movieFormListUptAt = false;        //영화편성목록갱신여부

            //선택된 극장수 업데이트
            $("#choiceBrchList .bg").each(function(idx){
                if(typeof $(this).find(".del").attr("brch-no") != 'undefined'){
                    choiceBrchCnt++
                }
            });

            //갱신여부 업데이트
            if(bOnLoad){    //온로드일경우
                crtPlayTimeUptAt = true;
                movieFormDeListUptAt = true;
                movieListUptAt = true;
                crtnMovieListUptAt = true;
                if(typeof data.paramMap.loginAt !== "undefined" && data.paramMap.loginAt != null){favorBrchDispAt = true; }
                if(typeof data.paramMap.loginAt !== "undefined" && data.paramMap.loginAt != null){favorBrchListUptAt = true;}

                // 2019.07.24 hjchoi 영화정보에서 넘어온 상영관종류코드가 있을시 선호지점 무시
                if((typeof data.paramMap.incomeTheabKindCd != "undefined" && data.paramMap.incomeTheabKindCd != "") ||
                    (typeof data.paramMap.incomeBrchNo1 != "undefined" && data.paramMap.incomeBrchNo1 != "")
                ) {
                    favorBrchDispAt = false;
                    favorBrchListUptAt = false;
                }

                if(uptType == "reLoad"){
                	favorBrchDispAt = false;
                	if(typeof data.paramMap.loginAt !== "undefined" && data.paramMap.loginAt != null){favorBrchListUptAt = true;}
                	else favorBrchListUptAt = false;

                }

                areaBrchListUptAt = true;
                spclbBrchListUptAt = true;
                if(data.movieFormList != null && data.movieFormList.length > 0){movieFormListUptAt = true;}
            }
            else {  //온로드 아닐경우
                if(uptType == "movieFormDe"){
                    movieFormDeListUptAt = true;
                    movieListUptAt = true;
                    crtnMovieListUptAt = true;
                    if(typeof data.paramMap.loginAt !== "undefined"){favorBrchDispAt = true; }
                    if(typeof data.paramMap.loginAt !== "undefined"){favorBrchListUptAt = true;}
                    areaBrchListUptAt = true;
                    spclbBrchListUptAt = true;
                    if(choiceBrchCnt > 0 && data.movieFormList != null && data.movieFormList.length > 0){movieFormListUptAt = true;}
                }
                else if (uptType == "movieList"){
                    movieFormDeListUptAt = true;
                    movieListUptAt = true;
                    crtnMovieListUptAt = true;
                    if(typeof data.paramMap.loginAt !== "undefined"){favorBrchDispAt = true; }
                    if(typeof data.paramMap.loginAt !== "undefined"){favorBrchListUptAt = true;}
                    areaBrchListUptAt = true;
                    spclbBrchListUptAt = true;
                    if(choiceBrchCnt > 0 && data.movieFormList != null && data.movieFormList.length > 0){movieFormListUptAt = true;}
                }
                else if (uptType == "brchList"){
                    movieFormDeListUptAt = true;
                    movieListUptAt = true;
                    crtnMovieListUptAt = true;
                    if(typeof data.paramMap.loginAt !== "undefined"){favorBrchDispAt = true; }
                    if(typeof data.paramMap.loginAt !== "undefined"){favorBrchListUptAt = true;}
                    areaBrchListUptAt = true;
                    spclbBrchListUptAt = true;
                    if(choiceBrchCnt > 0 && data.movieFormList != null && data.movieFormList.length > 0 ){movieFormListUptAt = true;}
                }
            }

            //RIA는 선호지점 무시
            if("" != parent.sellChnlCd){
            	favorBrchDispAt = false;
                favorBrchListUptAt = false;
            }

            //전체 지점상세갱신
            if(favorBrchListUptAt || areaBrchListUptAt){
            	if(!bOnLoad){
            		$('#brchList li ul').empty();            //지점상세 초기화
            	}
            	else if(bOnLoad && uptType == "reLoad"){
            		$('#brchList li ul').empty();            //지점상세 초기화
            	}
            }

            //갱신
            if(movieFormDeListUptAt){ fn_movieFormDeListUpt(bOnLoad, data.movieFormDeList, data.crtPlayTimeMap, data.paramMap);} //편성일자갱신
            if(movieListUptAt)      { fn_movieListUpt(data.movieList,"all", data.paramMap); }            //영화목록갱신
            if(crtnMovieListUptAt)  { fn_movieListUpt(data.crtnMovieList,"crtn", data.paramMap); }       //큐레이션목록갱신
            if(favorBrchDispAt)     { fn_favorBrchDisp(bOnLoad, uptType); }                                       //선호지점표시
            if(favorBrchListUptAt)  { fn_favorBrchListUpt(bOnLoad, uptType, data.favorBrchList); }                         //선호지점갱신
            if(areaBrchListUptAt)   { fn_brchListUpt(data.areaBrchList,"area", data.paramMap); }         //지역지점목록갱신
            if(spclbBrchListUptAt)  { fn_brchListUpt(data.spclbBrchList,"spcl", data.paramMap); }        //특별관지점목록갱신



            // 2019.07.23 hjchoi 영화정보에서 넘어온 상영관종류코드가 있을시 특별관 설정
            if(typeof data.paramMap.incomeTheabKindCd != "undefined" && data.paramMap.incomeTheabKindCd != "") {
                fn_TheabKindCdUpt(data.paramMap.incomeTheabKindCd);
            }

            // 2019.07.24 hjchoi 영화정보에서 넘어온 지점코드가 있을시 설정
            if(typeof data.paramMap.incomeBrchNo1 != "undefined" && data.paramMap.incomeBrchNo1 != "") {
                fn_IncomeBrchNoUpt(data.paramMap.incomeBrchNo1);
            }

            if(movieFormListUptAt)  {
            	$("#playScheduleList div div:eq(0)").empty();
                $('.hour-schedule button.hour').removeClass('on');
                $('.hour-schedule button.hour').attr("disabled","disabled");
                $('.hour-schedule button.hour').attr("style","opacity: 0.5");
                fn_movieFormListUpt(data.movieFormList, data.crtPlayTimeMap);    //영화편성목록갱신
                mScrollUpdate();    //시간 스크롤바 업데이트
            }
            else {
                $m_scroll();        //스크롤바 생성
                $("#playScheduleList div div:eq(0)").empty();
                $('.hour-schedule button.hour').removeClass('on');
                $('.hour-schedule button.hour').attr("disabled","disabled");
                $('.hour-schedule button.hour').attr("style","opacity: 0.5");
                $("#playScheduleList").hide();
                $("#playScheduleNonList").show();
                mScrollUpdate();    //시간 스크롤바 업데이트
            }

            //if(crtPlayTimeUptAt)    { fn_crtPlayTimeUpt(data.crtPlayTimeMap);}    //현재일자표시
              //선호지점 갱신여부가 false일 경우
            if(favorBrchDispAt == false){
                $('.liFavorBrch').empty();
            }
            fn_requestSetParam(data.paramMap);//파라메타 갱신

            return;
        },
        error: function(xhr,status,error){
             var err = JSON.parse(xhr.responseText);
             alert(xhr.status);
             alert(err.message);
        },
        complete: function() {
            var dsDate = $('#playDe').val();

            if(!bOnLoad){
            	mbThCalendar.arrCkFlag = true; //날짜 플래그 끝부분
            	mbThCalendar.events.trimdate({ mnDate: '', callback:''});
            }
            else {
            	mbThCalendar.setUI();
            	mbThCalendar.events.trimdate({ mnDate: $('#playDe').val(), callback:''});
            }

            if (document.querySelector('[date-data="'+ dsDate +'"]') !== null){
                var timeObj = document.querySelector('[date-data="'+ dsDate +'"]');
                $(timeObj).addClass('on');
            }
            $jqTooltip();       //튤팁생성
            parent.$(".bg-loading").hide();

            if(bOnLoad){
            	parent.fn_getMsgStrToAlert();
            }

            // 네이버 진입영화 인경우
            if($('#naverPlaySchdlNo').val() != ''){
        		$('#'+$('#naverPlaySchdlNo').val()).attr("style","background-color:#ebebeb;");
        		//$('#'+$('#naverPlaySchdlNo').val()).focus();
            }
        }
    });
}

//2019.07.23 hjchoi 영화정보에서 넘어온 상영관종류코드가 있을시 특별관 설정
function fn_TheabKindCdUpt(theabKindCode1) {
    $('.theater-choice .all-list .btn-tab').removeClass('on');
    $('.theater-choice .all-list .list').hide();
    $('.theater-choice .other-list .btn-tab').addClass('on');
    $('.theater-choice .other-list .list').show();

    $('.theater-choice .other-list .list #'+theabKindCode1).trigger("click");
}

//2019.07.24 hjchoi 영화정보에서 넘어온 지점코드가 있을시 설정
function fn_IncomeBrchNoUpt(brchNo) {
    $('.theater-choice .all-list .list').find('button').each(function(index) {
        if ($(this).attr("brch-no") == brchNo) {
            var areaCd = $(this).attr("area-cd");

            $('.theater-choice .all-list .list #'+areaCd).trigger("click"); // 지역클릭
            $(this).trigger("click"); // 지점클릭
        }
    });
}

//리턴받은 파라메타 설정
function fn_requestSetParam(paramMap){
    //영화셋팅
//  if(typeof data.paramMap.movieNo1 !== "undefined" && data.paramMap.movieNo1 != ""){};
//  if(typeof data.paramMap.movieNo2 !== "undefined" && data.paramMap.movieNo2 != ""){};
//  if(typeof data.paramMap.movieNo3 !== "undefined" && data.paramMap.movieNo3 != ""){};

    //극장셋팅
    //최초진입시 선호극장 선택된목록에 표시처리
    if(typeof paramMap.onLoad != "undefined" && paramMap.onLoad == "Y" && paramMap.uptType != "reLoad"){
        $("#favorite #btn").each(function(idx){
            var type = "area";
            var spclbYn   = eval("paramMap.spclbYn"+(idx+1));
            if(spclbYn == 'Y') {type = "splc";}
            if(!$(this).hasClass("disabled")){
                fn_setBrchChoi([$(this), type,"N"]);
            }
        });
    }
    else {
        //선택한 극장을 극장 목록에서 에서 선택처리 셋팅
        $("#choiceBrchList .bg").each(function(idx){
            var brchNo = $(this).find(".del").attr("brch-no");
            var areaCd =  $(this).find(".del").attr("area-cd");
            if(typeof brchNo != 'undefined'){
                fn_brchListChange(brchNo, "ins", areaCd);
            }
        });

        //선택된 영화를 영화 목록에서 에서 선택처리 셋팅
        $("#choiceMovieList .bg").each(function(idx){
            var movieNo = $(this).find("img").attr("movie-no");
            if(typeof movieNo != 'undefined'){
                fn_movieListChange(movieNo, "set");
            }
        });
    }

    if(typeof paramMap.onLoad != "undefined" && paramMap.onLoad == "Y" && paramMap.movieNo1 != ""){
        fn_setMovieChoi($('#movieList button.on'));
    }

    //영화선택개수 카운팅
    var movieChoiCnt = 0;
    $("#choiceMovieList .bg").each(function(idx){
        if($.trim($(this).html()) == ""){
            movieChoiCnt++;
        }

    });
    if(movieChoiCnt == 3){
        $('#choiceMovieNone').show();
        $('#choiceMovieList').hide();
    }
    else{
        $('#choiceMovieNone').hide();
        $('#choiceMovieList').show();
    }

    //극장선택개수 카운팅
    var brchChoiCnt = 0;
    $("#choiceBrchList .bg").each(function(idx){
        if($.trim($(this).html()) == ""){
            brchChoiCnt++;
        }
    });
    if(brchChoiCnt == 3){
        $('#choiceBrchNone').show();
        $('#choiceBrchList').hide();
    }
    else{
        $('#choiceBrchNone').hide();
        $('#choiceBrchList').show();
    }

    //전체극장 탭 선택시 하위 지역 선택
    $("#brchList>ul>li>button").each(function(idx){
        if(paramMap.brchAll == $(this).attr("id")){
            $(this).trigger("click");
        }
    });

    //특별관 탭 선택시 선택 하위 특별관 목록 선택
    $("#specialBrchList>ul>li>button").each(function(idx){
        if(paramMap.brchSpcl == $(this).attr("id")){
            $(this).trigger("click");
        }
    });

    //지역 버튼 개수 카운팅
    var areaButton = $('.depth').prev();
    for(var i=0;i<areaButton.length;i++){    //지역버튼 개수만큼 반복
        var brchButton = $('#'+$(areaButton[i]).attr("id")).next().find('li button');    //지점 버튼 객체
        var brchFormSize = 0;
        //최초로딩의 경우
        if(typeof paramMap.onLoad != "undefined" && paramMap.onLoad == "Y"){
            if((typeof $.trim(paramMap.movieNo1) !==  "undefined"
                && $.trim(paramMap.movieNo1) !=  ""
                && "" == parent.sellChnlCd)
            ||
            (typeof $.trim(paramMap.brchNo1) !==  "undefined"
                && $.trim(paramMap.brchNo1) !=  ""
                && "" == parent.sellChnlCd)){
                $(brchButton).each(function(idx){
                    if("Y" == $(this).attr("form-at")){
                        brchFormSize++;
                    }
                });
            }else {
                brchFormSize = brchButton.size();    //전체 버튼 개수를 설정
            }
        }
        //최초로딩 아닌경우
        else {
            //반복하여 돌고 객체의 편성여부를 체크
            $(brchButton).each(function(idx){
                if("Y" == $(this).attr("form-at")){
                    brchFormSize++;
                }
            });
        }
        var areaSpan = $(areaButton[i]).find('span');
        var areaNm = $(areaSpan).html().replace(')','').split('(')[0];
        areaNm += "("+brchFormSize+")";
        $(areaSpan).html(areaNm);
    }

//  if(typeof data.paramMap.brchNo1 !== "undefined" && data.paramMap.brchNo1 != ""){};
//     if(typeof data.paramMap.brchNo2 !== "undefined" && data.paramMap.brchNo2 != ""){};
//     if(typeof data.paramMap.brchNo3 !== "undefined" && data.paramMap.brchNo3 != ""){};
}


//빠른일자 셋팅
function fn_setMinBokdDe(arrayParam){
    //console.log("fn_setMinBokdDe in param : "+arrayParam);
    var type              = arrayParam[0];
    var minBokdAbleDeList = arrayParam[1];
    var crtPlayTimeMap    = arrayParam[2];
    var obj               = arrayParam[3];
    var bIsRe             = typeof arrayParam[4] != 'undefined';
    var minBokdAbleDe     = "";

    //영화일때
    if(type == "movie"){
        //영화 하단 셋팅
        if(!bIsRe && typeof obj != 'undefined'){
            fn_setMovieChoi([obj,'Y']);
        }
    }
    //극장일때
    else if(type == "spcl" || type == "area") {
        //극장 하단 상단 셋팅
        var arrBrchChoi = [];
        var typeObj = document.querySelector('#brchTab button.on');
        arrBrchChoi[0] = obj;
        arrBrchChoi[1] = type;
        if(!bIsRe){
            fn_setBrchChoi(arrBrchChoi);
        }
    }

    //console.log(minBokdAbleDe);
    fn_movieFormDeListUpt(false, minBokdAbleDeList, crtPlayTimeMap);
    minBokdAbleDe = (minBokdAbleDeList[0].playDe).maskDate();

    mbThCalendar.events.trimdate({ mnDate:minBokdAbleDe, callback:mbThCalendar.tempMthd});
    if($('#crtDe').val() != minBokdAbleDe) {
         //$('#datePicker').datepicker('show');//    달력 자동으로 뜨는 기능대신 메시지 처리    김민영 과장 요청
    }
}

//빠른일자 찾기
function fn_selectMinBokdAbleDe(obj){
    var movieNo          = typeof $(obj).attr("movie-no") != 'undefined' ? $(obj).attr("movie-no") : "";
    var brchNo        = typeof $(obj).attr("brch-no")  != 'undefined' ? $(obj).attr("brch-no") : "";
    var areaCd        = typeof $(obj).attr("area-cd")  != 'undefined' ? $(obj).attr("area-cd") : "";
    var spclbYn         = typeof $(obj).attr("spclb-yn")  != 'undefined' ? $(obj).attr("spclb-yn") : "";
    var theabKindCd  = spclbYn == "Y" ? $(obj).attr("area-cd") : "";
    var type         = spclbYn == "" ? "movie" : spclbYn == "Y" ? 'spcl' : 'area';
    var paramData    = type == "movie" ? fn_setParamData([movieNo, '', '', '','']) : fn_setParamData(['', brchNo, areaCd, spclbYn, theabKindCd]);
    var formAt        = $(obj).attr("form-at") == "Y" ? true : false;
    var movieChoi    = $('#choiceMovieList .img').size() < 1 ? false : true;
    var brchChoi     = $('#choiceBrchList .txt').size() < 1 ? false : true;
    if(typeof obj == 'undefined' || (!formAt && ((!movieChoi && !brchChoi)
                    ||    (!movieChoi && brchChoi && type == "movie")
                    ||    (movieChoi && !brchChoi && type != "movie")
                    ))){
        $.ajaxMegaBox({
            url: "/on/oh/ohb/SimpleBooking/selectMinBokdAbleDe.do",
            data: JSON.stringify(paramData),
            success: function (data, textStatus, jqXHR) {
                //console.log("selectMinBokdAbleDe calback ===> "+JSON.stringify(data.minBokdAbleDeMap));
                var msg = "";
                var confirmFnName = "";
                var confirmFnParam = null;

                if(data.minBokdAbleDeList != null && data.minBokdAbleDeList.length > 0){    //있음
                    confirmFnName = fn_setMinBokdDe;
                    confirmFnParam = [];
                    confirmFnParam[0] = type;
                    confirmFnParam[1] = data.minBokdAbleDeList;
                    confirmFnParam[2] = data.crtPlayTimeMap;
                    confirmFnParam[3] = obj;

                    if(type == "movie") {    //영화
                        //빠른예매일로 변경
                        msg = '해당 일자에 상영 시간표가 없습니다.\n 선택하신 영화의 가장 빠른 예매일로 변경하시겠습니까?'; //해당 일자에 상영 시간표가 없습니다. 선택하신 영화의 가장 빠른 예매일로 변경하시겠습니까?
                    }
                    else if(type == "area" || type == "spcl") {    //극장
                        //영화관유지
                        //빠른예매일로변경
                        //영화유지
                        msg = '해당 일자에 상영 시간표가 없습니다.\n 선택하신 영화관의 가장 빠른 상영일로 변경하시겠습니까?'; //해당 일자에 상영 시간표가 없습니다. 선택하신 영화관의 가장 빠른 상영일로 변경하시겠습니까?
                    }

                    $(".time-schedule").addClass("not-available");
                }
                else {    //없음
                    if(type == "movie") {    //영화
                        //영화관 초기화
                        //빠른예매일로 변경
                        //영화유지
                        confirmFnName = fn_setReMinBokdAbleDe;
                        confirmFnParam = [obj, "R", "Y", "U", type];    //변경여부 param : obj 영화관 예매일 영화
                        msg ='해당 일자에 상영 시간표가 없습니다.\n 선택하신 영화가 상영중인 다른 영화관을 선택하시겠습니까?';    //해당 일자에 상영 시간표가 없습니다. 선택하신 영화가 상영중인 다른 영화관을 선택하시겠습니까?
                    }
                    else if(type == "area" || type == "spcl") {    //극장
                        //선택영화 카운팅
                        var movieCnt = 0;
                        $("#choiceMovieList .bg").each(function(idx){
                            if($.trim($(this).html()) == ""){
                                movieCnt++;
                            }
                        });

                        //선택된 영화가 있는경우
                        if(movieCnt < 3){
                            //영화관초기화
                            //날짜유지
                            //영화유지
                            confirmFnName = fn_setReMinBokdAbleDe;
                            confirmFnParam = [obj, "R", "N", "N", type];    //변경여부 param : obj 영화관 예매일 영화
                            msg ='해당 일자에 상영 시간표가 없습니다.\n 선택하신 영화가 상영중인 다른 영화관을 선택하시겠습니까?';    //해당 일자에 상영 시간표가 없습니다. 선택하신 영화가 상영중인 다른 영화관을 선택하시겠습니까?
                        }
                        //선택된 영화가 없는경우
                        else {
                            //선택한영화관
                              //빠른예매일 변경
                              //영화유지
                              confirmFnName = fn_setReMinBokdAbleDe;
                              confirmFnParam = [obj, "U", "Y", "N", type];    //변경여부 param : obj 영화관 예매일 영화
                              msg ='해당 일자에 상영 시간표가 없습니다.\n 선택하신 영화관의 가장 빠른 상영일로 변경하시겠습니까?'//해당 일자에 상영 시간표가 없습니다. 선택하신 영화관의 가장 빠른 상영일로 변경하시겠습니까
                        }
                    }
                }

                var options = {};
                options.msg          = msg;
                options.confirmFn    = confirmFnName;
                options.cancelFn     = '';
                options.okBtnTxt     = "확인";
                options.cancelBtnTxt = "취소";
                options.param        = {confirm:confirmFnParam ,cancel:""} ;
                options.minWidth     = 400
                options.minHeight    = 250
                gfn_confirmMsgBox(options);
            },
            error: function(xhr,status,error){
                var err = JSON.parse(xhr.responseText);
                alert(xhr.status);
                alert(err.message);
            }
        });
    }
    else {
        if(type == "movie"){
            //영화팝업
            // 2019.07.28 hjchoi 상영스케줄 클릭으로 이동
            //fn_selectMovieChoiPopup(obj); //영화 팝업 조회
        	fn_setMovieChoi([obj,"N"]);
        }
        else {
            //지점팝업
            // 2019.07.28 hjchoi 상영스케줄 클릭으로 이동
            //fn_selectBrchChoiPopup(obj);  //지점 팝업 조회
        	fn_setBrchChoi([obj, type,"Y"]);
        }
    }
}


//빠른일자 재조회를 위한 셋팅
function fn_setReMinBokdAbleDe(arrayParam){
    //console.log("fn_setReMinBokdAbleDe in param : "+arrayParam);
    var obj         = arrayParam[0];
    var brchUptCn   = arrayParam[1];
    var bokdDeUptAt = arrayParam[2];
    var movieUptCn  = arrayParam[3];
    var type        = arrayParam[4];
    //param : obj, brchUptCn, bokdDeUptAt, movieUptCn, type
    //영화관 R : 초기화               U : 선택영화관,
    //예매일 Y : 빠른예매일로 변경    N : 날짜유지
    //영화   R : 초기화               U : 선택영화, N : 영화관유지
    //type   movie: 영화목록선택 spcl,area: 극장목록선택

    //영화관
    if(brchUptCn == "R") {
        //영화관 초기화
        $('#choiceBrchList .bg').empty();
        $("#brchList #btn").removeClass("on");
        $("#specialBrchList #btn").removeClass("on");
    }
    else if(brchUptCn == "U") {
        fn_setBrchChoi([obj, type,"N"]);
    }

    //영화
    if(movieUptCn == "U") {
        fn_setMovieChoi([obj, 'Y']);
    }

    //일자
    if(bokdDeUptAt == "Y"){
        var  paramData = fn_setParamData();
        $.ajaxMegaBox({
//             url: "/on/oh/ohb/SimpleBooking/selectPlayScheduleList.do", 변경
            url: "/on/oh/ohb/SimpleBooking/selectMinBokdAbleDe.do",
            data: JSON.stringify(paramData),
            success: function (data, textStatus, jqXHR) {
                //console.log("fn_setReMinBokdAbleDe calback ===> "+JSON.stringify(data.minBokdAbleDeMap));
                if(typeof data.minBokdAbleDeList != 'undefined' && data.minBokdAbleDeList != null && data.minBokdAbleDeList.length > 0){    //있음
                    confirmFnParam = [];
                    confirmFnParam[0] = type;
                    confirmFnParam[1] = data.minBokdAbleDeList;
                    confirmFnParam[2] = data.crtPlayTimeMap;
                    confirmFnParam[3] = obj;
                    confirmFnParam[4] = true;
                    fn_setMinBokdDe(confirmFnParam);
                }
                else {    //없음
                    if(type == "movie"){
                        //영화날림
                        $("#choiceMovieList .bg").empty();
                        $("#movieList .btn").removeClass("on");
                        $("#crtnMovieList .btn").removeClass("on");
                        gfn_alertMsgBoxSize('선택한 극장에서 상영중인 스케줄이 없습니다.',400,250);    //선택한 극장에서 상영중인 스케줄이 없습니다.
                        if($('#choiceBrchList .txt').size() == 0 && $("#choiceMovieList .del").size() == 0){
                			fn_selectBokdList(true,"reLoad") //예매 목록 갱신 초기화상태
                		}
                        else {
                        	fn_selectBokdList(false,'movieFormDe');
                        }
                        mbThCalendar.arrCkFlag = true;    //날자 플래그 끝나는 부분
                    }else {
                        //지점날림
                        $('#choiceBrchList .bg').empty();
                        $("#brchList #btn").removeClass("on");
                        $("#specialBrchList #btn").removeClass("on");
                        gfn_alertMsgBoxSize('선택한 극장에서 상영중인 스케줄이 없습니다.',400,250);    //선택한 극장에서 상영중인 스케줄이 없습니다.
                        if($('#choiceBrchList .txt').size() == 0 && $("#choiceMovieList .del").size() == 0){
                			fn_selectBokdList(true,"reLoad") //예매 목록 갱신 초기화상태
                		}
                        else {
                        	fn_selectBokdList(false,'movieFormDe');
                        }
                        mbThCalendar.arrCkFlag = true;    //날자 플래그 끝나는 부분
                    }
                }
            },
            error: function(xhr,status,error){
                var err = JSON.parse(xhr.responseText);
                alert(xhr.status);
                alert(err.message);
            }
        });
    }
    else {
        mbThCalendar.arrCkFlag = true;    //날자 플래그 끝나는 부분
    }
}

//상영시간이 초과 되었을때 상영스케쥴 재조회
function fn_selectMovieFormDeBokdList(){
	fn_selectBokdList(false,'movieFormDe');
}

</script>
<script src="./ui.common.js(1).다운로드"></script>
<script src="./front.js(1).다운로드"></script>
</head>
<body class="body-iframe">
	<input type="hidden" id="naverPlaySchdlNo" name="naverPlaySchdlNo"
		value="">
	<!-- inner-wrap -->
	<div class="inner-wrap"
		style="padding-top: 40px; padding-bottom: 100px;">
		<input type="hidden" id="playDe" name="playDe" value="2022.04.11">
		<input type="hidden" id="crtDe" name="crtDe" value="2022.04.11">

		<!-- quick-reserve -->
		<div class="quick-reserve">
			<div class="tit-util">
				<h2 class="tit">빠른예매</h2>

				<div id="btnLangChg" class="right btn-ticket" style="display: none">
					<button type="button" class="button gray-line"
						onclick="parent.setLangChg()">English</button>
				</div>
			</div>








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
				<input maxlength="20" name="riaName" type="text" title="이름 출력"
					class="input-text a-c w120px" placeholder="이름" value="">

				<p>생년월일</p>
				<input maxlength="8" name="riaBirthday" type="text" title="생년월일 출력"
					class="input-text a-c w150px" placeholder="6자리 또는 8자리" value="">

				<p>휴대폰번호</p>
				<input maxlength="11" name="riaMobileNo" type="text"
					title="휴대폰번호 출력" class="input-text a-c w150px"
					placeholder="- 없이 입력" value="">

				<p>회원</p>
				<input name="riaMemberYn" type="text" title="회원여부 출력"
					class="input-text a-c w100px" value="" readyonly="readyonly">


				<button type="button" class="button gray ml10" login-at="N"></button>

			</div>

			<!-- mege-quick-reserve-inculde : 다른 페이지에서 iframe 으로 설정될 영역 -->
			<div class="mege-quick-reserve-inculde">

				<!-- time-schedule -->
				<div class="time-schedule quick">
					<div class="wrap">

						<!-- 이전날짜 -->
						<button type="button" title="이전 날짜 보기" class="btn-pre"
							disabled="true">
							<i class="iconset ico-cld-pre"></i> <em>이전</em>
						</button>
						<!--// 이전날짜 -->

						<div class="date-list">
							<!-- 년도, 월 표시 -->
							<div class="year-area">
								<div class="year" style="left: 30px; z-index: 1; opacity: 1;">2022.04</div>
								<div class="year" style="left: 450px; z-index: 1; opacity: 0;"></div>
							</div>


							<div class="date-area" id="formDeList">
								<div class="wrap"
									style="position: relative; width: 2100px; border: none; left: -70px;">
									<button class="disabled holi" type="button"
										date-data="2022.04.10" month="3" tabindex="-1">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">10<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">일</span><span
											class="day-en" style="pointer-events: none; display: none">Sun</span>
									</button>
									<button class="on" type="button" date-data="2022.04.11"
										month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">11<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">오늘</span><span
											class="day-en" style="pointer-events: none; display: none">Mon</span>
									</button>
									<button class="" type="button" date-data="2022.04.12" month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">12<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">내일</span><span
											class="day-en" style="pointer-events: none; display: none">Tue</span>
									</button>
									<button class="" type="button" date-data="2022.04.13" month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">13<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">수</span><span
											class="day-en" style="pointer-events: none; display: none">Wed</span>
									</button>
									<button class="" type="button" date-data="2022.04.14" month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">14<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">목</span><span
											class="day-en" style="pointer-events: none; display: none">Thu</span>
									</button>
									<button class="disabled" type="button" date-data="2022.04.15"
										month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">15<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">금</span><span
											class="day-en" style="pointer-events: none; display: none">Fri</span>
									</button>
									<button class="disabled sat" type="button"
										date-data="2022.04.16" month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">16<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">토</span><span
											class="day-en" style="pointer-events: none; display: none">Sat</span>
									</button>
									<button class="disabled holi" type="button"
										date-data="2022.04.17" month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">17<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">일</span><span
											class="day-en" style="pointer-events: none; display: none">Sun</span>
									</button>
									<button class="disabled" type="button" date-data="2022.04.18"
										month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">18<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">월</span><span
											class="day-en" style="pointer-events: none; display: none">Mon</span>
									</button>
									<button class="disabled" type="button" date-data="2022.04.19"
										month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">19<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">화</span><span
											class="day-en" style="pointer-events: none; display: none">Tue</span>
									</button>
									<button class="disabled" type="button" date-data="2022.04.20"
										month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">20<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">수</span><span
											class="day-en" style="pointer-events: none; display: none">Wed</span>
									</button>
									<button class="disabled" type="button" date-data="2022.04.21"
										month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">21<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">목</span><span
											class="day-en" style="pointer-events: none; display: none">Thu</span>
									</button>
									<button class="disabled" type="button" date-data="2022.04.22"
										month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">22<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">금</span><span
											class="day-en" style="pointer-events: none; display: none">Fri</span>
									</button>
									<button class="disabled sat" type="button"
										date-data="2022.04.23" month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">23<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">토</span><span
											class="day-en" style="pointer-events: none; display: none">Sat</span>
									</button>
									<button class="disabled holi" type="button"
										date-data="2022.04.24" month="3">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">24<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">일</span><span
											class="day-en" style="pointer-events: none; display: none">Sun</span>
									</button>
									<button class="disabled" type="button" date-data="2022.04.25"
										month="3" tabindex="-1">
										<span class="ir">2022년 4월</span><em
											style="pointer-events: none;">25<span
											style="pointer-events: none;" class="ir">일</span></em><span
											class="day-kr"
											style="pointer-events: none; display: inline-block">월</span><span
											class="day-en" style="pointer-events: none; display: none">Mon</span>
									</button>
								</div>
							</div>
						</div>

						<!-- 다음날짜 -->
						<button type="button" title="다음 날짜 보기" class="btn-next"
							disabled="true">
							<i class="iconset ico-cld-next"></i> <em>다음</em>
						</button>
						<!--// 다음날짜 -->

						<!-- 달력보기 -->
						<div class="bg-line">
							<input type="hidden" id="datePicker" value="2022.04.11"
								class="hasDatepicker">
							<button type="button" id="calendar"
								onclick="$(&#39;#datePicker&#39;).datepicker(&#39;show&#39;)"
								class="btn-calendar-large" title="달력보기">달력보기</button>

						</div>
						<!--// 달력보기 -->
					</div>
				</div>
				<!--// time-schedule -->

				<!-- quick-reserve-area -->
				<div class="quick-reserve-area">

					<!-- movie-choice : 영화 선택  -->
					<div class="movie-choice">
						<p class="tit">영화</p>

						<!-- list-area -->
						<div class="list-area">

							<!-- all : 전체 -->
							<div class="all-list">
								<button type="button" class="btn-tab on" id="movieAll">전체</button>
								<div class="list">
									<div
										class="scroll m-scroll mCustomScrollbar _mCS_1 mCS_no_scrollbar"
										id="movieList">
										<div id="mCSB_1"
											class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
											style="max-height: none;" tabindex="0">
											<div id="mCSB_1_container"
												class="mCSB_container mCS_no_scrollbar_y"
												style="position: relative; top: 0; left: 0;" dir="ltr">
												<ul>
													<li><button type="button" class="btn disabled"
															movie-nm="신비한 동물들과 덤블도어의 비밀" movie-no="22012400"
															img-path="/SharedImg/2022/03/25/p02Tj8NeXivFyhGgMGm3DD0kdeogGkkA_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">신비한 동물들과 덤블도어의 비밀</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="앵커" movie-no="22015100"
															img-path="/SharedImg/2022/04/04/Df3dRsIiNGeqWKx9GyXFNgHJixH0ipb9_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">앵커</span>
														</button></li>
													<li><button type="button" class="btn on"
															movie-nm="루이스 웨인: 사랑을 그린 고양이 화가" movie-no="22004700"
															img-path="/SharedImg/2022/04/06/lg0SbPk7EZK9se39mBRQeeODilFEezHP_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="Y">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">루이스 웨인: 사랑을 그린 고양이 화가</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="수퍼 소닉2" movie-no="22014900"
															img-path="/SharedImg/2022/04/06/HQHkK49cEMDhxxu6WGEDDUvX4DHVDWGl_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">수퍼 소닉2</span>
														</button></li>
													<li><button type="button" class="btn" movie-nm="앰뷸런스"
															movie-no="22013600"
															img-path="/SharedImg/2022/03/04/YSzxxqFZpvazDeIm9Ks9oPi6Y43VdltN_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="Y">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">앰뷸런스</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="불도저에 탄 소녀" movie-no="22009600"
															img-path="/SharedImg/2022/03/22/EFW5OybMsTtLyy0BxTXoVv1zHzBBxW4A_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">불도저에 탄 소녀</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="재춘언니" movie-no="22010500"
															img-path="/SharedImg/2022/03/04/BK32zYC02IOysHFayAeHn3ePf3k17a0L_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">재춘언니</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="스텔라" movie-no="22014600"
															img-path="/SharedImg/2022/03/18/mLeEY1GdKPwZcuL2Nadtig8Bky4OI4bu_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">스텔라</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="공기살인" movie-no="22016000"
															img-path="/SharedImg/2022/04/06/mcjbpIzfxyThnbEAjrnQV3lPuoO8ie5d_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">공기살인</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="극장판 주술회전 0" movie-no="22001100"
															img-path="/SharedImg/2022/02/17/djm7aYuL9bQGZRsxyUH75wATz9ub9ouk_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">극장판 주술회전 0</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="아메리칸 저스티스" movie-no="22018100" img-path=""
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">아메리칸 저스티스</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="극장판 금빛 모자이크 땡큐!!" movie-no="22013400"
															img-path="/SharedImg/2022/03/04/rQE0PPzZcRAkM4cqclvZsMlGyGyAzgNe_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">극장판 금빛 모자이크 땡큐!!</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="아비정전" movie-no="01182200"
															img-path="/SharedImg/asis/system/mop/poster/2017/E1/A79475-4946-4708-BD14-3D858D73ED98.small.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">아비정전</span>
														</button></li>
													<li><button type="button" class="btn" movie-nm="모비우스"
															movie-no="22012700"
															img-path="/SharedImg/2022/04/06/Ayk2cTFKPKuNU4pbbEB19bZ2WOsPDxCT_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="Y">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">모비우스</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="뜨거운 피" movie-no="22007500"
															img-path="/SharedImg/2022/03/25/LwVAzJfIL9YSTvPE198GuFG1O9R3WEGo_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">뜨거운 피</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="[오페라] 신데렐라 @The Met" movie-no="22016300"
															img-path="/SharedImg/2022/03/23/6Fdz9yhJ5t6utJ9jFdi4iDYF1SNlh8Br_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">[오페라] 신데렐라 @The Met</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="중경삼림" movie-no="00136300"
															img-path="/SharedImg/2021/02/16/D7gnxzwZhk6AonutaH0zUFdEEzvpiE5l_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">중경삼림</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="행복을 전하는 편지" movie-no="22020900"
															img-path="/SharedImg/2022/04/06/berXPMLvHRfsvZuudVBg4S8j4oPJM2F1_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">행복을 전하는 편지</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="이상한 나라의 수학자" movie-no="22006600"
															img-path="/SharedImg/2022/02/11/JBgUea1mB5KdHwOrBzKrMjT9eYQrvrDH_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">이상한 나라의 수학자</span>
														</button></li>
													<li><button type="button" class="btn" movie-nm="스펜서"
															movie-no="21065900"
															img-path="/SharedImg/2022/03/18/VjfoZHJwjVnYMj1vrXNprFyjcXDXa7Cp_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="Y">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">스펜서</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="[뉴니온] 앵콜 MINI 팬미팅" movie-no="22019100"
															img-path="/SharedImg/2022/04/04/OsafO0R07B2fbaajdEsSVYlHqrv6eRUT_150.png"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">[뉴니온] 앵콜 MINI 팬미팅</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="더 배트맨" movie-no="22003400"
															img-path="/SharedImg/2022/02/14/CoGWNhlBhUrWlBxBrrHoTSxlh8pgrIA4_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">더 배트맨</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="이도공간" movie-no="21050100"
															img-path="/SharedImg/2021/07/16/QUxXArrK6Ds4rDT8teO0kTotsNwg4lF1_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">이도공간</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="패왕별희 디 오리지널" movie-no="20004800"
															img-path="/SharedImg/2021/03/24/9rNkLXZrl8ZnQsKFjy9ddOkK553ISin4_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">패왕별희 디 오리지널</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="뱅드림! 팝핀’ 드림!" movie-no="22012900"
															img-path="/SharedImg/2022/03/14/C74L7F2auentVUVohxxcsZNXb1l9PaBj_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">뱅드림! 팝핀’ 드림!</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="드라이브 마이 카" movie-no="21084300"
															img-path="/SharedImg/2021/12/20/fowb9Ay3B0ZZIzg9v3udcuzYBFw8wwCy_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">드라이브 마이 카</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="그리스도 디 오리진" movie-no="22014300"
															img-path="/SharedImg/2022/04/04/QLn7ZGHW2EubUCZSantp3tSNvbnVwJMV_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">그리스도 디 오리진</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="[애니페스타] 시원찮은 그녀를 위한 육성방법 피날레"
															movie-no="22019500"
															img-path="/SharedImg/2022/04/04/zw1kUa3ojhJiomU0xqZXxJqWOtMWbwve_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">[애니페스타] 시원찮은 그녀를 위한 육성방법 피날레</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="코다" movie-no="21046800"
															img-path="/SharedImg/2021/12/20/sQz8Ejy67Qu6Zr1CtqEvmkvIEYlzAOOw_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">코다</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="[클루씨] MINI 팬미팅" movie-no="22019300"
															img-path="/SharedImg/2022/04/04/vBuMGt5vOdLuH2t7I8dH6CvNRyHbSD4D_150.png"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">[클루씨] MINI 팬미팅</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="파일럿: 배틀 포 서바이벌" movie-no="22008300"
															img-path="/SharedImg/2022/03/16/k2iQ4iA5iz3miomHcpW1cL4J2chw1ihc_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">파일럿: 배틀 포 서바이벌</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="패러렐 마더스" movie-no="22013900"
															img-path="/SharedImg/2022/03/22/OVM28A9mBoywtC4JKbIwjdF4yQLK9VsI_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">패러렐 마더스</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="금의위4 지존무사" movie-no="22021700" img-path=""
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">금의위4 지존무사</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="말임씨를 부탁해" movie-no="22013000"
															img-path="/SharedImg/2022/04/04/rhT1jykDz2kpF7xK3EpLkenlZpuJQNWE_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">말임씨를 부탁해</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="뱅드림! 필름 라이브 세컨드 스테이지" movie-no="21068600"
															img-path="/SharedImg/2021/11/02/JITv65LlMRHqBhtmjCKeG2jYg5SXjG3P_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">뱅드림! 필름 라이브 세컨드 스테이지</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="드라이" movie-no="22013800"
															img-path="/SharedImg/2022/03/18/X6pgM9I10KFWvD2cX84MB4uxcCVhun6D_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">드라이</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="태어나길 잘했어" movie-no="22016900"
															img-path="/SharedImg/2022/03/29/RlvbSfmOSd5RBUz7ILrqmZeWze1FTgvr_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">태어나길 잘했어</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="나의 집은 어디인가" movie-no="22014400"
															img-path="/SharedImg/2022/03/11/iiz3haNGHN5OLYjqoyMG9nBh0Vtha2zL_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">나의 집은 어디인가</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="레드 로켓" movie-no="22015000" img-path=""
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-19">청소년관람불가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">레드 로켓</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="[애니페스타] 극장판 시로바코 " movie-no="22019400"
															img-path="/SharedImg/2022/04/04/9uogsJSne8XdvGAPvAseKVR5bEd7nGkT_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">[애니페스타] 극장판 시로바코 </span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="키즈 리턴" movie-no="01143900"
															img-path="/SharedImg/asis/system/mop/poster/2016/41/0685B9-9659-432B-A2A9-D03D70CDDC30.small.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">키즈 리턴</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="벨파스트" movie-no="22009400"
															img-path="/SharedImg/2022/02/21/GDI4VTZahTKfL7O0sMNADFF3pnJRHAh4_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">벨파스트</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="나의 히어로 아카데미아 더 무비: 월드 히어로즈 미션"
															movie-no="22008000"
															img-path="/SharedImg/2022/02/24/f9rjoA1ImhrE5MbWHZsJKFSyazyq127R_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">나의 히어로 아카데미아 더 무비: 월드 히어로즈 미션</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="로스트 시티" movie-no="21089900"
															img-path="/SharedImg/2022/03/22/0RODnWCM5UyviP0Q4tkVlcHOo5jSwMNX_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">로스트 시티</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="해피 투게더 리마스터링" movie-no="21003800"
															img-path="/SharedImg/2021/01/11/HyzWsqq4DwYWjs6q1bXciaCIonOUx8Rb_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">해피 투게더 리마스터링</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="문폴" movie-no="22004200"
															img-path="/SharedImg/2022/02/28/8Gi9uOs6cSYiZlJx3Dg44ZaCzy11LH1B_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">문폴</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="천국에서 무덤까지" movie-no="22013100"
															img-path="/SharedImg/2022/03/08/Z29C055JUsGJP0rpumKz0WS8eoOFfJAl_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">천국에서 무덤까지</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="[애니페스타] 조제, 호랑이 그리고 물고기들" movie-no="22017800"
															img-path="/SharedImg/2022/03/31/Z0pjyEchNLF42jYt6AqaUBFCxhppwqzz_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">[애니페스타] 조제, 호랑이 그리고 물고기들</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="사랑 후의 두 여자" movie-no="21050700"
															img-path="/SharedImg/2022/04/04/r1FIS45A1AQYsiPO96rZv55m3VAC2WLg_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">사랑 후의 두 여자</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="고양이들의 아파트" movie-no="22009900"
															img-path="/SharedImg/2022/03/04/XgjgXxEVSPbsBdRZDfcEqf3iFxRPQz3A_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">고양이들의 아파트</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="우리가 사랑이라고 믿는 것" movie-no="22005200"
															img-path="/SharedImg/2022/02/28/KJeRC22JCcalHxFBdig21NWKEb6XLpQR_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">우리가 사랑이라고 믿는 것</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="어나더 라운드" movie-no="21084000"
															img-path="/SharedImg/2021/12/07/rH0ktL4oe1AZJgg4sRsLmI6Bp9uBT5Qe_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">어나더 라운드</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="뱅드림! 로젤리아 에피소드 Ⅱ : 송 아이 엠" movie-no="21058400"
															img-path="/SharedImg/2021/09/01/TaFxsDtwWlvJh0NTg27zze0chGBb3g83_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">뱅드림! 로젤리아 에피소드 Ⅱ : 송 아이 엠</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="뱅드림! 필름 라이브" movie-no="01624600"
															img-path="/SharedImg/asis/system/mop/poster/2019/55/66AEF2-4199-4C3A-93BF-3130FF6ED86D.small.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">뱅드림! 필름 라이브</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="고스팅 글로리아" movie-no="22014100"
															img-path="/SharedImg/2022/03/29/ii7yTYDr2xp52zERZrVN9QCQjo4uQRIp_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">고스팅 글로리아</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="배니싱: 미제사건" movie-no="22014800"
															img-path="/SharedImg/2022/03/30/6R37gOGtIzy6FtTKAiqceoruPUZBidnJ_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">배니싱: 미제사건</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="스파이더맨: 노 웨이 홈" movie-no="21058300"
															img-path="/SharedImg/2021/12/16/ixl5QxDVs5Gn8nQN3rslK8BUmgFVklj8_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">스파이더맨: 노 웨이 홈</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="[애니페스타] 목소리의 형태" movie-no="22017700"
															img-path="/SharedImg/2022/03/31/6eDZtWAfaftU8KjUlktpbA372ZLzLeEb_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">[애니페스타] 목소리의 형태</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="어거스트 버진" movie-no="22013500"
															img-path="/SharedImg/2022/03/04/FhbVdcQ8oDJ7J3cbawpqwg1XEVXYpJyp_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">어거스트 버진</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="리디밍 러브" movie-no="22007100"
															img-path="/SharedImg/2022/03/11/mgaCmVy4vNbsxuRKYx15tcUDn4NQd1xK_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">리디밍 러브</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="화양연화 리마스터링" movie-no="20064100"
															img-path="/SharedImg/2020/10/28/G1Ed3fMdNEtepxwo9OQcIuQ0jW174fmk_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">화양연화 리마스터링</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="뱅드림! 로젤리아 에피소드Ⅰ: 약속" movie-no="21027900"
															img-path="/SharedImg/2021/05/06/uPgb3HcwtNqw4oSjT4hsNW4N5vJmY8hJ_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">뱅드림! 로젤리아 에피소드Ⅰ: 약속</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="곡녀" movie-no="22012500"
															img-path="/SharedImg/2022/03/22/JMs7nRGolvYvUeyQCvgscYwuGxMQttl6_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">곡녀</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="극장판 안녕 자두야: 제주도의 비밀" movie-no="22002300"
															img-path="/SharedImg/2022/01/17/LzZMcj4TSM24Y9cZpv8amYzphVFprUf9_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">극장판 안녕 자두야: 제주도의 비밀</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="김재화 배우전 - 단편모음" movie-no="22021100"
															img-path="/SharedImg/2022/04/06/2JP3CQqU2KQtm6hSZUSqfuOWTpK2CSVP_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">김재화 배우전 - 단편모음</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="너에게 가는 길" movie-no="21073200"
															img-path="/SharedImg/2021/11/01/JSLiuBzfSh0944XsetBXVFZSSaXfPjO6_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">너에게 가는 길</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="레벤느망" movie-no="22005500"
															img-path="/SharedImg/2022/02/17/wivF4VOJNpwv98dqJTfuAqUwyzBlLygt_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">레벤느망</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="목동점 리뉴얼 중입니다 (03/15~5/2 예정)"
															movie-no="22014700" img-path="" movie-popup-at="N"
															movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-no">등급미정</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">목동점 리뉴얼 중입니다 (03/15~5/2 예정)</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="복지식당" movie-no="22012300"
															img-path="/SharedImg/2022/03/22/SDHavBznZYaXLwV6UYeUu7d3Aoif7o8K_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">복지식당</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="엄마와 나" movie-no="22016400"
															img-path="/SharedImg/2022/03/25/oACAAh39WN2CcoCBHJsb6CsrI8vOwRcM_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">엄마와 나</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="유어 러브 송" movie-no="22008200"
															img-path="/SharedImg/2022/02/18/EIFEgpSxDy3F3wXHnkEQN6eLHbftKWY8_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">유어 러브 송</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="하로동선" movie-no="22015300"
															img-path="/SharedImg/2022/03/25/iI0qbKUTezQbmqZ7jCngNAeIP6LNxwjB_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">하로동선</span>
														</button></li>
												</ul>
											</div>
											<div id="mCSB_1_scrollbar_vertical"
												class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_vertical"
												style="display: block;">
												<div class="mCSB_draggerContainer">
													<div id="mCSB_1_dragger_vertical" class="mCSB_dragger"
														style="position: absolute; min-height: 30px; display: none; max-height: 310px; top: 0px; height: 49px;">
														<div class="mCSB_dragger_bar" style="line-height: 30px;"></div>
													</div>
													<div class="mCSB_draggerRail"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--// all : 전체 -->

							<!-- other-list  : 큐레이션 -->
							<div class="other-list">
								<button type="button" class="btn-tab" id="movieCrtn">큐레이션</button>
								<div class="list">
									<div
										class="scroll m-scroll mCustomScrollbar _mCS_2 mCS_no_scrollbar"
										id="crtnMovieList">
										<div id="mCSB_2"
											class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
											style="max-height: none;" tabindex="0">
											<div id="mCSB_2_container"
												class="mCSB_container mCS_no_scrollbar_y"
												style="position: relative; top: 0; left: 0;" dir="ltr">
												<ul>
													<li><button type="button" class="btn disabled"
															movie-nm="재춘언니" movie-no="22010500"
															img-path="/SharedImg/2022/03/04/BK32zYC02IOysHFayAeHn3ePf3k17a0L_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">재춘언니</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="[오페라] 신데렐라 @The Met" movie-no="22016300"
															img-path="/SharedImg/2022/03/23/6Fdz9yhJ5t6utJ9jFdi4iDYF1SNlh8Br_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">[오페라] 신데렐라 @The Met</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="드라이브 마이 카" movie-no="21084300"
															img-path="/SharedImg/2021/12/20/fowb9Ay3B0ZZIzg9v3udcuzYBFw8wwCy_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">드라이브 마이 카</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="패러렐 마더스" movie-no="22013900"
															img-path="/SharedImg/2022/03/22/OVM28A9mBoywtC4JKbIwjdF4yQLK9VsI_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">패러렐 마더스</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="드라이" movie-no="22013800"
															img-path="/SharedImg/2022/03/18/X6pgM9I10KFWvD2cX84MB4uxcCVhun6D_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">드라이</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="태어나길 잘했어" movie-no="22016900"
															img-path="/SharedImg/2022/03/29/RlvbSfmOSd5RBUz7ILrqmZeWze1FTgvr_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">태어나길 잘했어</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="나의 집은 어디인가" movie-no="22014400"
															img-path="/SharedImg/2022/03/11/iiz3haNGHN5OLYjqoyMG9nBh0Vtha2zL_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">나의 집은 어디인가</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="천국에서 무덤까지" movie-no="22013100"
															img-path="/SharedImg/2022/03/08/Z29C055JUsGJP0rpumKz0WS8eoOFfJAl_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">천국에서 무덤까지</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="사랑 후의 두 여자" movie-no="21050700"
															img-path="/SharedImg/2022/04/04/r1FIS45A1AQYsiPO96rZv55m3VAC2WLg_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">사랑 후의 두 여자</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="고양이들의 아파트" movie-no="22009900"
															img-path="/SharedImg/2022/03/04/XgjgXxEVSPbsBdRZDfcEqf3iFxRPQz3A_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">고양이들의 아파트</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="우리가 사랑이라고 믿는 것" movie-no="22005200"
															img-path="/SharedImg/2022/02/28/KJeRC22JCcalHxFBdig21NWKEb6XLpQR_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">우리가 사랑이라고 믿는 것</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="고스팅 글로리아" movie-no="22014100"
															img-path="/SharedImg/2022/03/29/ii7yTYDr2xp52zERZrVN9QCQjo4uQRIp_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">고스팅 글로리아</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="어거스트 버진" movie-no="22013500"
															img-path="/SharedImg/2022/03/04/FhbVdcQ8oDJ7J3cbawpqwg1XEVXYpJyp_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">어거스트 버진</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="곡녀" movie-no="22012500"
															img-path="/SharedImg/2022/03/22/JMs7nRGolvYvUeyQCvgscYwuGxMQttl6_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">곡녀</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="레벤느망" movie-no="22005500"
															img-path="/SharedImg/2022/02/17/wivF4VOJNpwv98dqJTfuAqUwyzBlLygt_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-15">15세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">레벤느망</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="복지식당" movie-no="22012300"
															img-path="/SharedImg/2022/03/22/SDHavBznZYaXLwV6UYeUu7d3Aoif7o8K_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-12">12세이상관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">복지식당</span>
														</button></li>
													<li><button type="button" class="btn disabled"
															movie-nm="엄마와 나" movie-no="22016400"
															img-path="/SharedImg/2022/03/25/oACAAh39WN2CcoCBHJsb6CsrI8vOwRcM_150.jpg"
															movie-popup-at="N" movie-popup-no="0" form-at="N">
															<span class="movie-grade small age-all">전체관람가</span><i
																class="iconset ico-heart-small">보고싶어 설정안함</i><span
																class="txt">엄마와 나</span>
														</button></li>
												</ul>
											</div>
											<div id="mCSB_2_scrollbar_vertical"
												class="mCSB_scrollTools mCSB_2_scrollbar mCS-light mCSB_scrollTools_vertical">
												<div class="mCSB_draggerContainer">
													<div id="mCSB_2_dragger_vertical" class="mCSB_dragger"
														style="position: absolute; min-height: 30px; display: none; top: 0px;">
														<div class="mCSB_dragger_bar" style="line-height: 30px;"></div>
													</div>
													<div class="mCSB_draggerRail"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--// other-list  : 큐레이션 -->
						</div>
						<!--// list-area -->

						<!-- view-area -->
						<div class="view-area">

							<!-- 영화 선택 하지 않았을 때 -->
							<div class="choice-all" id="choiceMovieNone"
								style="display: none;">
								<strong>모든영화</strong> <span>목록에서 영화를 선택하세요.</span>
							</div>

							<!-- 영화를 한개라도 선택했을 때 -->
							<div class="choice-list" id="choiceMovieList"
								style="display: block;">
								<!-- 비어있는 영역 -->
								<div class="bg">
									<div class="wrap">
										<div class="img">
											<img src="./lg0SbPk7EZK9se39mBRQeeODilFEezHP_150.jpg"
												alt="루이스 웨인: 사랑을 그린 고양이 화가" movie-no="22004700"
												onerror="noImg(this);">
										</div>
										<button type="button" class="del"
											onclick="fn_deleteMovieChoice(&#39;22004700&#39;)">삭제</button>
									</div>
								</div>
								<div class="bg"></div>
								<div class="bg"></div>
							</div>
						</div>
						<!--// view-area -->
					</div>
					<!--// movie-choice : 영화 선택  -->

					<!-- theater-choice : 극장 선택  -->
					<div class="theater-choice">
						<div class="tit-area">
							<p class="tit">극장</p>
						</div>

						<!-- list-area -->
						<div class="list-area" id="brchTab">

							<!-- all-list : 전체 -->
							<div class="all-list">
								<button type="button" class="btn-tab on">전체</button>
								<div class="list">
									<div class="scroll" id="brchList">
										<ul>
											<li id="liFavorBrch"><button id="btnFavorBrch"
													type="button" class="btn">
													<span calss="txt">선호극장(0)</span>
												</button>
												<div class="depth" id="favorite">
													<div class="no-favorite">
														<div class="wrap">
															<i class="iconset ico-theater-favorite"></i>
															<div class="txt">
																자주가는 극장을<br>등록해 보세요!
															</div>
															<div class="setting">
																<a href="javaScript:fn_favorBrchReg()" title="선호극장 설정"><i
																	class="iconset ico-theater-chk-purple"></i> 선호극장 설정</a>
															</div>
														</div>
													</div>
													<div class="no-favorite">
														<div class="wrap">
															<i class="iconset ico-theater-favorite"></i>
															<div class="txt">
																자주가는 극장을<br>등록해 보세요!
															</div>
															<div class="setting">
																<a href="javaScript:fn_favorBrchReg()" title="선호극장 설정"><i
																	class="iconset ico-theater-chk-purple"></i> 선호극장 설정</a>
															</div>
														</div>
													</div>
												</div></li>
											<li><button type="button" class="btn on" id="10">
													<span calss="txt">서울(5)</span>
												</button>
												<div class="depth on">
													<div
														class="detail-list m-scroll area-cd10 mCustomScrollbar _mCS_4 mCS_no_scrollbar">
														<div id="mCSB_4"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_4_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1372" brch-nm="강남"
																			brch-eng-nm="Gangnam" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="998">강남</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0023" brch-nm="강남대로(씨티)"
																			brch-eng-nm="Gangnam-daero (City)" form-at="N"
																			area-cd="10" area-cd-nm="서울" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1945">강남대로(씨티)</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1341" brch-nm="강동"
																			brch-eng-nm="Gangdong" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="939">강동</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1431" brch-nm="군자"
																			brch-eng-nm="Gunja" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1669">군자</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1003" brch-nm="동대문"
																			brch-eng-nm="Dong Dae Moon" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="962">동대문</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1572" brch-nm="마곡"
																			brch-eng-nm="Magok" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="936">마곡</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1581" brch-nm="목동"
																			brch-eng-nm="Mokdong" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="968">목동</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1311" brch-nm="상봉"
																			brch-eng-nm="Sangbong" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="980">상봉</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1211" brch-nm="상암월드컵경기장"
																			brch-eng-nm="Sangam World Cup Stadium" form-at="N"
																			area-cd="10" area-cd-nm="서울" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1001">상암월드컵경기장</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1331" brch-nm="성수"
																			brch-eng-nm="SEOUNGSU" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1006">성수</button></li>
																	<li><button id="btn" type="button" brch-no="1371"
																			brch-nm="센트럴" brch-eng-nm="Central" form-at="Y"
																			area-cd="10" area-cd-nm="서울" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1002" class="on">센트럴</button></li>
																	<li><button id="btn" type="button" brch-no="1381"
																			brch-nm="송파파크하비오" brch-eng-nm="Songpa Park Habio"
																			form-at="Y" area-cd="10" area-cd-nm="서울" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1830">송파파크하비오</button></li>
																	<li><button id="btn" type="button" brch-no="1202"
																			brch-nm="신촌" brch-eng-nm="Sinchon" form-at="Y"
																			area-cd="10" area-cd-nm="서울" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1225">신촌</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1561" brch-nm="이수"
																			brch-eng-nm="Isu" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="997">이수</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1321" brch-nm="창동"
																			brch-eng-nm="Changdong" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="921">창동</button></li>
																	<li><button id="btn" type="button" brch-no="1351"
																			brch-nm="코엑스" brch-eng-nm="COEX" form-at="Y"
																			area-cd="10" area-cd-nm="서울" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="954">코엑스</button></li>
																	<li><button id="btn" type="button" brch-no="1212"
																			brch-nm="홍대" brch-eng-nm="Hongdae" form-at="Y"
																			area-cd="10" area-cd-nm="서울" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1003">홍대</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1571" brch-nm="화곡"
																			brch-eng-nm="Hwagok" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="999">화곡</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1562" brch-nm="ARTNINE"
																			brch-eng-nm="ARTNINE" form-at="N" area-cd="10"
																			area-cd-nm="서울" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="955">ARTNINE</button></li>
																</ul>
															</div>
															<div id="mCSB_4_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_4_scrollbar mCS-light mCSB_scrollTools_vertical"
																style="display: block;">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_4_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px; height: 192px; max-height: 310px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
											<li><button type="button" class="btn" id="30">
													<span calss="txt">경기(4)</span>
												</button>
												<div class="depth">
													<div
														class="detail-list m-scroll area-cd30 mCustomScrollbar _mCS_5 mCS_no_scrollbar">
														<div id="mCSB_5"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_5_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4121" brch-nm="고양스타필드"
																			brch-eng-nm="Goyang Starfield" form-at="N"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="976">고양스타필드</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0029" brch-nm="광명AK플라자"
																			brch-eng-nm="Megabox Gwangmyeong AKplaza Branch"
																			form-at="N" area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="2012">광명AK플라자</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4152" brch-nm="김포한강신도시"
																			brch-eng-nm="Gimpo Han River New City" form-at="N"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="990">김포한강신도시</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4721" brch-nm="남양주"
																			brch-eng-nm="Namyangju" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="922">남양주</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0019"
																			brch-nm="남양주현대아울렛 스페이스원"
																			brch-eng-nm="Namyangju Hyundai Outlet Space1 Branch"
																			form-at="N" area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1813">남양주현대아울렛 스페이스원</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4451" brch-nm="동탄"
																			brch-eng-nm="Dongtan" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="923">동탄</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4652" brch-nm="미사강변"
																			brch-eng-nm=" Misa Riverside" form-at="N"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="989">미사강변</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4113" brch-nm="백석"
																			brch-eng-nm="Baek Seok" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="940">백석</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4722" brch-nm="별내"
																			brch-eng-nm="Byeolnae" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="924">별내</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4221" brch-nm="부천스타필드시티"
																			brch-eng-nm="Bucheon Starfield City" form-at="N"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="991">부천스타필드시티</button></li>
																	<li><button id="btn" type="button" brch-no="4631"
																			brch-nm="분당" brch-eng-nm="Bundang" form-at="Y"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="958">분당</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0030" brch-nm="수원"
																			brch-eng-nm="Suwon" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="2028">수원</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4421" brch-nm="수원남문"
																			brch-eng-nm="Suwon Nammun" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="953">수원남문</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4291" brch-nm="시흥배곧"
																			brch-eng-nm="Siheung Baegod" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="938">시흥배곧</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4253" brch-nm="안산중앙"
																			brch-eng-nm="Ansan Jungang" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="983">안산중앙</button></li>
																	<li><button id="btn" type="button" brch-no="0020"
																			brch-nm="안성스타필드"
																			brch-eng-nm="Megabox Starfield Anseong Branch"
																			form-at="Y" area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1809">안성스타필드</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4821" brch-nm="양주"
																			brch-eng-nm="Yangju" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="925">양주</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4431" brch-nm="영통"
																			brch-eng-nm="Yeongtong" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="944">영통</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0012" brch-nm="용인기흥"
																			brch-eng-nm="Yongin Giheung" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1947">용인기흥</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4462" brch-nm="용인테크노밸리"
																			brch-eng-nm="Yongin Technoveli" form-at="N"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="961">용인테크노밸리</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4804" brch-nm="의정부민락"
																			brch-eng-nm="Uijeongbuminlag" form-at="N"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="993">의정부민락</button></li>
																	<li><button id="btn" type="button" brch-no="4111"
																			brch-nm="일산" brch-eng-nm="Ilsan" form-at="Y"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="926">일산</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4104" brch-nm="일산벨라시타"
																			brch-eng-nm="Ilsan Bellashita" form-at="N"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="942">일산벨라시타</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4112" brch-nm="킨텍스"
																			brch-eng-nm="KINTEX" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="981">킨텍스</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4132" brch-nm="파주금촌"
																			brch-eng-nm="Paju Geumchon" form-at="N" area-cd="30"
																			area-cd-nm="경기" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1973">파주금촌</button></li>
																	<li><button id="btn" type="button" brch-no="4115"
																			brch-nm="파주운정" brch-eng-nm="Paju Unjeong" form-at="Y"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1974">파주운정</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4131" brch-nm="파주출판도시"
																			brch-eng-nm="Paju Publishing City" form-at="N"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="960">파주출판도시</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4651" brch-nm="하남스타필드"
																			brch-eng-nm="Hanam Starfield" form-at="N"
																			area-cd="30" area-cd-nm="경기" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="982">하남스타필드</button></li>
																</ul>
															</div>
															<div id="mCSB_5_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_5_scrollbar mCS-light mCSB_scrollTools_vertical">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_5_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
											<li><button type="button" class="btn" id="35">
													<span calss="txt">인천(2)</span>
												</button>
												<div class="depth">
													<div
														class="detail-list m-scroll area-cd35 mCustomScrollbar _mCS_6 mCS_no_scrollbar">
														<div id="mCSB_6"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_6_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4041" brch-nm="검단"
																			brch-eng-nm="Geomdan" form-at="N" area-cd="35"
																			area-cd-nm="인천" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="945">검단</button></li>
																	<li><button id="btn" type="button" brch-no="4062"
																			brch-nm="송도" brch-eng-nm="Song-do" form-at="Y"
																			area-cd="35" area-cd-nm="인천" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="927">송도</button></li>
																	<li><button id="btn" type="button" brch-no="4001"
																			brch-nm="영종" brch-eng-nm="Yeongjong" form-at="Y"
																			area-cd="35" area-cd-nm="인천" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="978">영종</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4051" brch-nm="인천논현"
																			brch-eng-nm="Incheon Nonhyeon" form-at="N"
																			area-cd="35" area-cd-nm="인천" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1975">인천논현</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0027" brch-nm="청라지젤"
																			brch-eng-nm="Cheongna Giselle" form-at="N"
																			area-cd="35" area-cd-nm="인천" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1961">청라지젤</button></li>
																</ul>
															</div>
															<div id="mCSB_6_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_6_scrollbar mCS-light mCSB_scrollTools_vertical">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_6_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
											<li><button type="button" class="btn" id="45">
													<span calss="txt">대전/충청/세종(1)</span>
												</button>
												<div class="depth">
													<div
														class="detail-list m-scroll area-cd45 mCustomScrollbar _mCS_7 mCS_no_scrollbar">
														<div id="mCSB_7"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_7_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3141" brch-nm="공주"
																			brch-eng-nm="Gongju" form-at="N" area-cd="45"
																			area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1976">공주</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0018" brch-nm="논산"
																			brch-eng-nm="nonsan" form-at="N" area-cd="45"
																			area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1977">논산</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3021" brch-nm="대전"
																			brch-eng-nm="Daejeon" form-at="N" area-cd="45"
																			area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="975">대전</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0028"
																			brch-nm="대전신세계 아트앤사이언스"
																			brch-eng-nm="Megabox Daejeon Shinsegae Art &amp; Science Branch"
																			form-at="N" area-cd="45" area-cd-nm="대전/충청/세종"
																			spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="2000">대전신세계
																			아트앤사이언스</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0009" brch-nm="대전유성"
																			brch-eng-nm="Megabox Daejeon Yuseong Branch"
																			form-at="N" area-cd="45" area-cd-nm="대전/충청/세종"
																			spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1831">대전유성</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3011" brch-nm="대전중앙로"
																			brch-eng-nm="Daejeon Central Road" form-at="N"
																			area-cd="45" area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="971">대전중앙로</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0017" brch-nm="대전현대아울렛"
																			brch-eng-nm="Megabox Daejeon Hyundai Outlet Branch"
																			form-at="N" area-cd="45" area-cd-nm="대전/충청/세종"
																			spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1763">대전현대아울렛</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3391" brch-nm="세종(조치원)"
																			brch-eng-nm="Sejong" form-at="N" area-cd="45"
																			area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1000">세종(조치원)</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3392" brch-nm="세종나성"
																			brch-eng-nm="SejongNaseong" form-at="N" area-cd="45"
																			area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1004">세종나성</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0008" brch-nm="세종청사"
																			brch-eng-nm="SejongChungsa" form-at="N" area-cd="45"
																			area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="Y" brch-popup-at="Y"
																			brch-popup-no="1801">세종청사</button></li>
																	<li><button id="btn" type="button" brch-no="3631"
																			brch-nm="오창" brch-eng-nm="Ochang" form-at="Y"
																			area-cd="45" area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="965">오창</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3901" brch-nm="제천"
																			brch-eng-nm="Jecheon" form-at="N" area-cd="45"
																			area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1978">제천</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3651" brch-nm="진천"
																			brch-eng-nm="Jincheon" form-at="N" area-cd="45"
																			area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1979">진천</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3301" brch-nm="천안"
																			brch-eng-nm="Cheonan" form-at="N" area-cd="45"
																			area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="977">천안</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0013" brch-nm="청주사창"
																			brch-eng-nm="Cheongju Chungbuk" form-at="N"
																			area-cd="45" area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1980">청주사창</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3801" brch-nm="충주"
																			brch-eng-nm="Chungju" form-at="N" area-cd="45"
																			area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1981">충주</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3501" brch-nm="홍성내포"
																			brch-eng-nm="Hongseong Naepo" form-at="N"
																			area-cd="45" area-cd-nm="대전/충청/세종" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1982">홍성내포</button></li>
																</ul>
															</div>
															<div id="mCSB_7_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_7_scrollbar mCS-light mCSB_scrollTools_vertical">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_7_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
											<li><button type="button" class="btn" id="55">
													<span calss="txt">부산/대구/경상(2)</span>
												</button>
												<div class="depth">
													<div
														class="detail-list m-scroll area-cd55 mCustomScrollbar _mCS_8 mCS_no_scrollbar">
														<div id="mCSB_8"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_8_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="7602" brch-nm="경북도청"
																			brch-eng-nm="Gyeongbuk Provincial Office" form-at="N"
																			area-cd="55" area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1983">경북도청</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="7122" brch-nm="경산하양"
																			brch-eng-nm="Gyeongsan Hayang" form-at="N"
																			area-cd="55" area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="950">경산하양</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="7303" brch-nm="구미강동"
																			brch-eng-nm="Gumi Gangdong" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="930">구미강동</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="7401" brch-nm="김천"
																			brch-eng-nm="Gimcheon" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1984">김천</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="7901" brch-nm="남포항"
																			brch-eng-nm="Nampohang" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1985">남포항</button></li>
																	<li><button id="btn" type="button" brch-no="7022"
																			brch-nm="대구(칠성로)" brch-eng-nm="Daegu (Chilseong-ro)"
																			form-at="Y" area-cd="55" area-cd-nm="부산/대구/경상"
																			spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1800">대구(칠성로)</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="7011" brch-nm="대구신세계(동대구)"
																			brch-eng-nm="Daegu Shinsegae (Dongdaegu)" form-at="N"
																			area-cd="55" area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="967">대구신세계(동대구)</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0022" brch-nm="대구이시아"
																			brch-eng-nm="Daegu-Esia" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1829">대구이시아</button></li>
																	<li><button id="btn" type="button" brch-no="6161"
																			brch-nm="덕천" brch-eng-nm="Deokcheon" form-at="Y"
																			area-cd="55" area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="931">덕천</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6312" brch-nm="마산"
																			brch-eng-nm="Masan" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="986">마산</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="7451" brch-nm="문경"
																			brch-eng-nm="Mungyeong" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="985">문경</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6001" brch-nm="부산극장"
																			brch-eng-nm="Busan Theater" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="966">부산극장</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6906" brch-nm="부산대"
																			brch-eng-nm="Busan ​​National University" form-at="N"
																			area-cd="55" area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="941">부산대</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0025" brch-nm="북대구(칠곡)"
																			brch-eng-nm="Northern Daegu (Chilgok)" form-at="N"
																			area-cd="55" area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1953">북대구(칠곡)</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6642" brch-nm="삼천포"
																			brch-eng-nm="Samcheonpo" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="935">삼천포</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6261" brch-nm="양산"
																			brch-eng-nm="Yangsan" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="932">양산</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6262" brch-nm="양산라피에스타"
																			brch-eng-nm="Yangsan La Fiesta" form-at="N"
																			area-cd="55" area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="957">양산라피에스타</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6811" brch-nm="울산"
																			brch-eng-nm="Ulsan" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="956">울산</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6191" brch-nm="정관"
																			brch-eng-nm="Jeong-gwan" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="949">정관</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6421" brch-nm="창원"
																			brch-eng-nm=" Changwon" form-at="N" area-cd="55"
																			area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="963">창원</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0014" brch-nm="창원내서"
																			brch-eng-nm="Megabox Changwon Naeseo Branch"
																			form-at="N" area-cd="55" area-cd-nm="부산/대구/경상"
																			spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1799">창원내서</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6121" brch-nm="해운대(장산)"
																			brch-eng-nm=" Haeundae (Jangsan)" form-at="N"
																			area-cd="55" area-cd-nm="부산/대구/경상" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="973">해운대(장산)</button></li>
																</ul>
															</div>
															<div id="mCSB_8_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_8_scrollbar mCS-light mCSB_scrollTools_vertical">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_8_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
											<li><button type="button" class="btn" id="65">
													<span calss="txt">광주/전라(1)</span>
												</button>
												<div class="depth">
													<div
														class="detail-list m-scroll area-cd65 mCustomScrollbar _mCS_9 mCS_no_scrollbar">
														<div id="mCSB_9"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_9_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="5021" brch-nm="광주상무"
																			brch-eng-nm="Gwangju Sangmu" form-at="N" area-cd="65"
																			area-cd-nm="광주/전라" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="970">광주상무</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="5061" brch-nm="광주하남"
																			brch-eng-nm="Gwangju Hanam" form-at="N" area-cd="65"
																			area-cd-nm="광주/전라" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="969">광주하남</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="5302" brch-nm="목포하당(포르모)"
																			brch-eng-nm=" Mokpo Hadang (Formo)" form-at="N"
																			area-cd="65" area-cd-nm="광주/전라" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1986">목포하당(포르모)</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="5612" brch-nm="송천"
																			brch-eng-nm="Songcheon" form-at="N" area-cd="65"
																			area-cd-nm="광주/전라" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1987">송천</button></li>
																	<li><button id="btn" type="button" brch-no="5401"
																			brch-nm="순천" brch-eng-nm="Suncheon" form-at="Y"
																			area-cd="65" area-cd-nm="광주/전라" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="994">순천</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="5552" brch-nm="여수웅천"
																			brch-eng-nm="Yeosu Woongcheon" form-at="N"
																			area-cd="65" area-cd-nm="광주/전라" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1005">여수웅천</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0010" brch-nm="전대(광주)"
																			brch-eng-nm="Jeondae(Gwangju)" form-at="N"
																			area-cd="65" area-cd-nm="광주/전라" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1988">전대(광주)</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0021" brch-nm="전주혁신"
																			brch-eng-nm="jeonju hyeoksin" form-at="N"
																			area-cd="65" area-cd-nm="광주/전라" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1948">전주혁신</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="5064" brch-nm="첨단"
																			brch-eng-nm="Cheomdan" form-at="N" area-cd="65"
																			area-cd-nm="광주/전라" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="979">첨단</button></li>
																</ul>
															</div>
															<div id="mCSB_9_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_9_scrollbar mCS-light mCSB_scrollTools_vertical">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_9_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
											<li><button type="button" class="btn" id="70">
													<span calss="txt">강원(1)</span>
												</button>
												<div class="depth">
													<div
														class="detail-list m-scroll area-cd70 mCustomScrollbar _mCS_10 mCS_no_scrollbar">
														<div id="mCSB_10"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_10_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button" brch-no="2001"
																			brch-nm="남춘천" brch-eng-nm="Namchuncheon" form-at="Y"
																			area-cd="70" area-cd-nm="강원" spclb-yn="N"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="959">남춘천</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="2171" brch-nm="속초"
																			brch-eng-nm="Sokcho" form-at="N" area-cd="70"
																			area-cd-nm="강원" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1989">속초</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="2201" brch-nm="원주"
																			brch-eng-nm="Wonju" form-at="N" area-cd="70"
																			area-cd-nm="강원" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1990">원주</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="2202" brch-nm="원주센트럴"
																			brch-eng-nm="Wonju Central" form-at="N" area-cd="70"
																			area-cd-nm="강원" spclb-yn="N" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="934">원주센트럴</button></li>
																</ul>
															</div>
															<div id="mCSB_10_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_10_scrollbar mCS-light mCSB_scrollTools_vertical">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_10_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
										</ul>
									</div>
								</div>
							</div>
							<!--// all-list : 전체 -->

							<!-- other-list : 특별관 -->
							<div class="other-list">
								<button type="button" class="btn-tab">특별관</button>
								<!-- list -->
								<div class="list" id="specialBrchTab">
									<div class="scroll" id="specialBrchList">
										<ul>
											<li><button type="button" class="btn" id="DBC">
													<span calss="txt">Dolby Cinema(0)</span>
												</button>
												<div class="depth">
													<div
														class="detail-list m-scroll area-cdDBC mCustomScrollbar _mCS_11 mCS_no_scrollbar">
														<div id="mCSB_11"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_11_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0019"
																			brch-nm="남양주현대아울렛 스페이스원"
																			brch-eng-nm="Namyangju Hyundai Outlet Space1 Branch"
																			form-at="N" area-cd="DBC" area-cd-nm="Dolby Cinema"
																			spclb-yn="Y" ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1813">남양주현대아울렛
																			스페이스원</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0028"
																			brch-nm="대전신세계 아트앤사이언스"
																			brch-eng-nm="Megabox Daejeon Shinsegae Art &amp; Science Branch"
																			form-at="N" area-cd="DBC" area-cd-nm="Dolby Cinema"
																			spclb-yn="Y" ori-area-cd="45" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="2000">대전신세계
																			아트앤사이언스</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0020" brch-nm="안성스타필드"
																			brch-eng-nm="Megabox Starfield Anseong Branch"
																			form-at="N" area-cd="DBC" area-cd-nm="Dolby Cinema"
																			spclb-yn="Y" ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1809">안성스타필드</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1351" brch-nm="코엑스"
																			brch-eng-nm="COEX" form-at="N" area-cd="DBC"
																			area-cd-nm="Dolby Cinema" spclb-yn="Y"
																			ori-area-cd="10" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="954">코엑스</button></li>
																</ul>
															</div>
															<div id="mCSB_11_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_11_scrollbar mCS-light mCSB_scrollTools_vertical">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_11_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
											<li><button type="button" class="btn" id="TBQ">
													<span calss="txt">THE BOUTIQUE(1)</span>
												</button>
												<div class="depth">
													<div
														class="detail-list m-scroll area-cdTBQ mCustomScrollbar _mCS_12 mCS_no_scrollbar">
														<div id="mCSB_12"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_12_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0028"
																			brch-nm="대전신세계 아트앤사이언스"
																			brch-eng-nm="Megabox Daejeon Shinsegae Art &amp; Science Branch"
																			form-at="N" area-cd="TBQ" area-cd-nm="THE BOUTIQUE"
																			spclb-yn="Y" ori-area-cd="45" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="2000">대전신세계
																			아트앤사이언스</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4631" brch-nm="분당"
																			brch-eng-nm="Bundang" form-at="N" area-cd="TBQ"
																			area-cd-nm="THE BOUTIQUE" spclb-yn="Y"
																			ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="958">분당</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1331" brch-nm="성수"
																			brch-eng-nm="SEOUNGSU" form-at="N" area-cd="TBQ"
																			area-cd-nm="THE BOUTIQUE" spclb-yn="Y"
																			ori-area-cd="10" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1006">성수</button></li>
																	<li><button id="btn" type="button" brch-no="1371"
																			brch-nm="센트럴" brch-eng-nm="Central" form-at="Y"
																			area-cd="TBQ" area-cd-nm="THE BOUTIQUE" spclb-yn="Y"
																			ori-area-cd="10" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1002">센트럴</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4104" brch-nm="일산벨라시타"
																			brch-eng-nm="Ilsan Bellashita" form-at="N"
																			area-cd="TBQ" area-cd-nm="THE BOUTIQUE" spclb-yn="Y"
																			ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="942">일산벨라시타</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1351" brch-nm="코엑스"
																			brch-eng-nm="COEX" form-at="N" area-cd="TBQ"
																			area-cd-nm="THE BOUTIQUE" spclb-yn="Y"
																			ori-area-cd="10" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="954">코엑스</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4112" brch-nm="킨텍스"
																			brch-eng-nm="KINTEX" form-at="N" area-cd="TBQ"
																			area-cd-nm="THE BOUTIQUE" spclb-yn="Y"
																			ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="981">킨텍스</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4651" brch-nm="하남스타필드"
																			brch-eng-nm="Hanam Starfield" form-at="N"
																			area-cd="TBQ" area-cd-nm="THE BOUTIQUE" spclb-yn="Y"
																			ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="982">하남스타필드</button></li>
																</ul>
															</div>
															<div id="mCSB_12_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_12_scrollbar mCS-light mCSB_scrollTools_vertical">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_12_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
											<li><button type="button" class="btn" id="MX">
													<span calss="txt">MX(0)</span>
												</button>
												<div class="depth">
													<div
														class="detail-list m-scroll area-cdMX mCustomScrollbar _mCS_13 mCS_no_scrollbar">
														<div id="mCSB_13"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_13_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4121" brch-nm="고양스타필드"
																			brch-eng-nm="Goyang Starfield" form-at="N"
																			area-cd="MX" area-cd-nm="MX" spclb-yn="Y"
																			ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="976">고양스타필드</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="7011" brch-nm="대구신세계(동대구)"
																			brch-eng-nm="Daegu Shinsegae (Dongdaegu)" form-at="N"
																			area-cd="MX" area-cd-nm="MX" spclb-yn="Y"
																			ori-area-cd="55" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="967">대구신세계(동대구)</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0017" brch-nm="대전현대아울렛"
																			brch-eng-nm="Megabox Daejeon Hyundai Outlet Branch"
																			form-at="N" area-cd="MX" area-cd-nm="MX" spclb-yn="Y"
																			ori-area-cd="45" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1763">대전현대아울렛</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1581" brch-nm="목동"
																			brch-eng-nm="Mokdong" form-at="N" area-cd="MX"
																			area-cd-nm="MX" spclb-yn="Y" ori-area-cd="10"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="968">목동</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1211" brch-nm="상암월드컵경기장"
																			brch-eng-nm="Sangam World Cup Stadium" form-at="N"
																			area-cd="MX" area-cd-nm="MX" spclb-yn="Y"
																			ori-area-cd="10" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1001">상암월드컵경기장</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1331" brch-nm="성수"
																			brch-eng-nm="SEOUNGSU" form-at="N" area-cd="MX"
																			area-cd-nm="MX" spclb-yn="Y" ori-area-cd="10"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1006">성수</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4062" brch-nm="송도"
																			brch-eng-nm="Song-do" form-at="N" area-cd="MX"
																			area-cd-nm="MX" spclb-yn="Y" ori-area-cd="35"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="927">송도</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4431" brch-nm="영통"
																			brch-eng-nm="Yeongtong" form-at="N" area-cd="MX"
																			area-cd-nm="MX" spclb-yn="Y" ori-area-cd="30"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="944">영통</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4651" brch-nm="하남스타필드"
																			brch-eng-nm="Hanam Starfield" form-at="N"
																			area-cd="MX" area-cd-nm="MX" spclb-yn="Y"
																			ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="982">하남스타필드</button></li>
																</ul>
															</div>
															<div id="mCSB_13_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_13_scrollbar mCS-light mCSB_scrollTools_vertical">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_13_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
											<li><button type="button" class="btn" id="CFT">
													<span calss="txt">COMFORT(3)</span>
												</button>
												<div class="depth">
													<div
														class="detail-list m-scroll area-cdCFT mCustomScrollbar _mCS_14 mCS_no_scrollbar">
														<div id="mCSB_14"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_14_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4041" brch-nm="검단"
																			brch-eng-nm="Geomdan" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="35"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="945">검단</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0029" brch-nm="광명AK플라자"
																			brch-eng-nm="Megabox Gwangmyeong AKplaza Branch"
																			form-at="N" area-cd="CFT" area-cd-nm="COMFORT"
																			spclb-yn="Y" ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="2012">광명AK플라자</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="5021" brch-nm="광주상무"
																			brch-eng-nm="Gwangju Sangmu" form-at="N"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="65" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="970">광주상무</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="5061" brch-nm="광주하남"
																			brch-eng-nm="Gwangju Hanam" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="65"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="969">광주하남</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0019"
																			brch-nm="남양주현대아울렛 스페이스원"
																			brch-eng-nm="Namyangju Hyundai Outlet Space1 Branch"
																			form-at="N" area-cd="CFT" area-cd-nm="COMFORT"
																			spclb-yn="Y" ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1813">남양주현대아울렛
																			스페이스원</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="7022" brch-nm="대구(칠성로)"
																			brch-eng-nm="Daegu (Chilseong-ro)" form-at="N"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="55" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1800">대구(칠성로)</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0022" brch-nm="대구이시아"
																			brch-eng-nm="Daegu-Esia" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="55"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1829">대구이시아</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3021" brch-nm="대전"
																			brch-eng-nm="Daejeon" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="45"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="975">대전</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0028"
																			brch-nm="대전신세계 아트앤사이언스"
																			brch-eng-nm="Megabox Daejeon Shinsegae Art &amp; Science Branch"
																			form-at="N" area-cd="CFT" area-cd-nm="COMFORT"
																			spclb-yn="Y" ori-area-cd="45" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="2000">대전신세계
																			아트앤사이언스</button></li>
																	<li><button id="btn" type="button" brch-no="6161"
																			brch-nm="덕천" brch-eng-nm="Deokcheon" form-at="Y"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="55" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="931">덕천</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1003" brch-nm="동대문"
																			brch-eng-nm="Dong Dae Moon" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="10"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="962">동대문</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4451" brch-nm="동탄"
																			brch-eng-nm="Dongtan" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="30"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="923">동탄</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6312" brch-nm="마산"
																			brch-eng-nm="Masan" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="55"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="986">마산</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1581" brch-nm="목동"
																			brch-eng-nm="Mokdong" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="10"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="968">목동</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4113" brch-nm="백석"
																			brch-eng-nm="Baek Seok" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="30"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="940">백석</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6906" brch-nm="부산대"
																			brch-eng-nm="Busan ​​National University" form-at="N"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="55" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="941">부산대</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1311" brch-nm="상봉"
																			brch-eng-nm="Sangbong" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="10"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="980">상봉</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="1211" brch-nm="상암월드컵경기장"
																			brch-eng-nm="Sangam World Cup Stadium" form-at="N"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="10" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1001">상암월드컵경기장</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0008" brch-nm="세종청사"
																			brch-eng-nm="SejongChungsa" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="45"
																			brch-bokd-unable-at="Y" brch-popup-at="Y"
																			brch-popup-no="1801">세종청사</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4062" brch-nm="송도"
																			brch-eng-nm="Song-do" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="35"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="927">송도</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4421" brch-nm="수원남문"
																			brch-eng-nm="Suwon Nammun" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="30"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="953">수원남문</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4291" brch-nm="시흥배곧"
																			brch-eng-nm="Siheung Baegod" form-at="N"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="938">시흥배곧</button></li>
																	<li><button id="btn" type="button" brch-no="1202"
																			brch-nm="신촌" brch-eng-nm="Sinchon" form-at="Y"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="10" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1225">신촌</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6261" brch-nm="양산"
																			brch-eng-nm="Yangsan" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="55"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="932">양산</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6262" brch-nm="양산라피에스타"
																			brch-eng-nm="Yangsan La Fiesta" form-at="N"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="55" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="957">양산라피에스타</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4821" brch-nm="양주"
																			brch-eng-nm="Yangju" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="30"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="925">양주</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0012" brch-nm="용인기흥"
																			brch-eng-nm="Yongin Giheung" form-at="N"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1947">용인기흥</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4462" brch-nm="용인테크노밸리"
																			brch-eng-nm="Yongin Technoveli" form-at="N"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="961">용인테크노밸리</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6811" brch-nm="울산"
																			brch-eng-nm="Ulsan" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="55"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="956">울산</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0014" brch-nm="창원내서"
																			brch-eng-nm="Megabox Changwon Naeseo Branch"
																			form-at="N" area-cd="CFT" area-cd-nm="COMFORT"
																			spclb-yn="Y" ori-area-cd="55" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1799">창원내서</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="3301" brch-nm="천안"
																			brch-eng-nm="Cheonan" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="45"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="977">천안</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0027" brch-nm="청라지젤"
																			brch-eng-nm="Cheongna Giselle" form-at="N"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="35" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1961">청라지젤</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="0013" brch-nm="청주사창"
																			brch-eng-nm="Cheongju Chungbuk" form-at="N"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="45" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="1980">청주사창</button></li>
																	<li><button id="btn" type="button" brch-no="1351"
																			brch-nm="코엑스" brch-eng-nm="COEX" form-at="Y"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="10" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="954">코엑스</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4112" brch-nm="킨텍스"
																			brch-eng-nm="KINTEX" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="30"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="981">킨텍스</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4132" brch-nm="파주금촌"
																			brch-eng-nm="Paju Geumchon" form-at="N" area-cd="CFT"
																			area-cd-nm="COMFORT" spclb-yn="Y" ori-area-cd="30"
																			brch-bokd-unable-at="N" brch-popup-at="Y"
																			brch-popup-no="1973">파주금촌</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6121" brch-nm="해운대(장산)"
																			brch-eng-nm=" Haeundae (Jangsan)" form-at="N"
																			area-cd="CFT" area-cd-nm="COMFORT" spclb-yn="Y"
																			ori-area-cd="55" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="973">해운대(장산)</button></li>
																</ul>
															</div>
															<div id="mCSB_14_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_14_scrollbar mCS-light mCSB_scrollTools_vertical">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_14_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
											<li><button type="button" class="btn" id="MKB">
													<span calss="txt">MEGABOX KIDS(0)</span>
												</button>
												<div class="depth">
													<div
														class="detail-list m-scroll area-cdMKB mCustomScrollbar _mCS_15 mCS_no_scrollbar">
														<div id="mCSB_15"
															class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
															style="max-height: none;" tabindex="0">
															<div id="mCSB_15_container"
																class="mCSB_container mCS_no_scrollbar_y"
																style="position: relative; top: 0; left: 0;" dir="ltr">
																<ul>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6312" brch-nm="마산"
																			brch-eng-nm="Masan" form-at="N" area-cd="MKB"
																			area-cd-nm="MEGABOX KIDS" spclb-yn="Y"
																			ori-area-cd="55" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="986">마산</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="4651" brch-nm="하남스타필드"
																			brch-eng-nm="Hanam Starfield" form-at="N"
																			area-cd="MKB" area-cd-nm="MEGABOX KIDS" spclb-yn="Y"
																			ori-area-cd="30" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="982">하남스타필드</button></li>
																	<li><button id="btn" type="button"
																			class="disabled" brch-no="6121" brch-nm="해운대(장산)"
																			brch-eng-nm=" Haeundae (Jangsan)" form-at="N"
																			area-cd="MKB" area-cd-nm="MEGABOX KIDS" spclb-yn="Y"
																			ori-area-cd="55" brch-bokd-unable-at="N"
																			brch-popup-at="Y" brch-popup-no="973">해운대(장산)</button></li>
																</ul>
															</div>
															<div id="mCSB_15_scrollbar_vertical"
																class="mCSB_scrollTools mCSB_15_scrollbar mCS-light mCSB_scrollTools_vertical">
																<div class="mCSB_draggerContainer">
																	<div id="mCSB_15_dragger_vertical" class="mCSB_dragger"
																		style="position: absolute; min-height: 30px; display: none; top: 0px;">
																		<div class="mCSB_dragger_bar"
																			style="line-height: 30px;"></div>
																	</div>
																	<div class="mCSB_draggerRail"></div>
																</div>
															</div>
														</div>
													</div>
												</div></li>
										</ul>
									</div>
								</div>
								<!--// list -->
							</div>
							<!--// other-list : 특별관 -->
						</div>
						<!--// list-area -->

						<!-- view-area -->
						<div class="view-area">

							<!-- 영화관 선택 하지 않았을 때 -->
							<div class="choice-all" id="choiceBrchNone"
								style="display: none;">
								<strong>전체극장</strong> <span>목록에서 극장을 선택하세요.</span>
							</div>

							<!-- 영화관을 한개라도 선택 했을때 -->
							<div class="choice-list" id="choiceBrchList"
								style="display: block;">
								<div class="bg">
									<div class="wrap">
										<p class="txt">
											센트럴
											<button type="button" class="del"
												onclick="fn_deleteBrchChoice(&#39;1371&#39;, &#39;10&#39;)"
												brch-no="1371" area-cd="10" spclb-yn="N" theab-kind-cd="10">삭제</button>
										</p>
									</div>
								</div>
								<div class="bg"></div>
								<div class="bg"></div>
							</div>
						</div>
						<!--// view-area -->


					</div>
					<!--// theater-choice : 영화관 선택  -->

					<!-- time-choice : 상영시간표 선택 -->
					<div class="time-choice">
						<div class="tit-area">
							<p class="tit">시간</p>

							<div class="right legend">
								<i class="iconset ico-sun" title="조조"></i> 조조 <i
									class="iconset ico-brunch" title="브런치"></i> 브런치 <i
									class="iconset ico-moon" title="심야"></i> 심야
							</div>
						</div>

						<!-- hour-schedule : 시간 선택  : 00~30 시-->
						<div class="hour-schedule">
							<button type="button" class="btn-prev-time">이전 시간 보기</button>

							<div class="wrap">
								<div class="view"
									style="position: absolute; width: 1015px; transition: none 0s ease 0s; left: -665px;">
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">00</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">01</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">02</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">03</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">04</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">05</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">06</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">07</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">08</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">09</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">10</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">11</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">12</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">13</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">14</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">15</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">16</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">17</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">18</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">19</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">20</button>
									<button type="button" class="hour on" style="opacity: 1;">21</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">22</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">23</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">24</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">25</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">26</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">27</button>
									<button type="button" class="hour" disabled="disabled"
										style="opacity: 0.5">28</button>

								</div>
							</div>

							<button type="button" class="btn-next-time">다음 시간 보기</button>
						</div>
						<!--// hour-schedule : 시간 선택  : 00~30 시-->

						<!-- movie-schedule-area : 시간표 출력 영역-->
						<div class="movie-schedule-area">

							<!-- 영화, 영화관 선택 안했을때 -->
							<!---->
							<div class="no-result" id="playScheduleNonList"
								style="display: none;">
								<i class="iconset ico-movie-time"></i>

								<p class="txt">
									영화와 극장을 선택하시면<br> 상영시간표를 비교하여 볼 수 있습니다.
								</p>
							</div>


							<!-- 영화, 영화관 선택 했을때 -->
							<div class="result">
								<div
									class="scroll m-scroll mCustomScrollbar _mCS_16 mCS_no_scrollbar"
									id="playScheduleList" style="">
									<div id="mCSB_16"
										class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
										style="max-height: none;" tabindex="0">
										<div id="mCSB_16_container"
											class="mCSB_container mCS_no_scrollbar_y"
											style="position: relative; top: 0; left: 0;" dir="ltr">
											<ul>
												<li><button type="button" class="btn on"
														id="2204111371025" play-start-time="2145"
														play-de="20220411" play-seq="6" rpst-movie-no="22004701"
														brch-no="1371" theab-no="05" play-schdl-no="2204111371025"
														rest-seat-cnt="83" ctts-ty-div-cd="MVCT01"
														theab-popup-at="N" theab-popup-no="0">
														<div class="legend"></div>
														<span class="time"><strong title="상영 시작">21:45</strong><em
															title="상영 종료">~23:46</em></span><span class="title"><strong
															title="루이스 웨인: 사랑을 그린 고양이 화가">루이스 웨인: 사랑을 그린 고양이
																화가</strong><em>2D(자막)</em></span>
														<div class="info">
															<span class="theater" title="극장">센트럴<br>더부티크
																105호
															</span><span class="seat"><strong class="now"
																title="잔여 좌석">83</strong><span>/</span><em class="all"
																title="전체 좌석">118</em></span>
														</div>
													</button></li>
											</ul>
										</div>
										<div id="mCSB_16_scrollbar_vertical"
											class="mCSB_scrollTools mCSB_16_scrollbar mCS-light mCSB_scrollTools_vertical">
											<div class="mCSB_draggerContainer">
												<div id="mCSB_16_dragger_vertical" class="mCSB_dragger"
													style="position: absolute; min-height: 30px; display: none; height: 2802px; max-height: 420px; top: 0px;">
													<div class="mCSB_dragger_bar" style="line-height: 30px;"></div>
												</div>
												<div class="mCSB_draggerRail"></div>
											</div>
										</div>
									</div>
								</div>

							</div>
						</div>
						<!--// movie-schedule-area : 시간표 출력 영역-->

					</div>
					<!--// time-choice : 상영시간표 선택 -->
				</div>
				<!--// quick-reserve-area -->
			</div>
			<!--// mege-quick-reserve-inculde : 다른 페이지에서 iframe 으로 설정될 영역 -->

		</div>
		<!--// quick-reserve -->

		<!--// RIA의 경우에만 표시하도록 -->
		<div class="quick-reserve-ad-area" style="">
			<script data-id="Sk8ODqWvTfiYIQGxHdGNHw"
				name="megabox_p/sub/sub@sub_bottom_booking_1100x80?mlink=347"
				src="./persona.js.다운로드" async=""></script>
			<script
				src="./m-ny8Ge9GlYZJI4cgMhnHRaYB3JpsfRgMZ-aSWeaR4SEAM4qWzAZAbZEZkUwWnZPUVNfQ01sOTEtVU9TeHFRAstB2JUHayDnTwPLQdiVB2sg508.js(1).다운로드"></script>
			<div id="Sk8ODqWvTfiYIQGxHdGNHw">
				<iframe src="./sub@sub_bottom_booking_1100x80.html"
					title="빠른예매 하단 배너영역" height="80px" width="1100px" name="mliframe"
					scrolling="no" frameborder="0" topmargin="0" leftmargin="0"
					marginwidth="0" marginheight="0"></iframe>
			</div>
		</div>

	</div>
	<!--// inner-wrap -->

	<!-- <div class="normalStyle"
		style="display: none; position: fixed; top: 0; left: 0; background: #000; opacity: 0.7; text-indent: -9999px; width: 100%; height: 100%; z-index: 100;">닫기</div>
	<div class="alertStyle"
		style="position: fixed; top: 0px; left: 0px; background: rgb(0, 0, 0); opacity: 0; width: 100%; height: 100%; z-index: 5005; display: none;"></div>
	<div id="ui-datepicker-div"
		class="ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all"></div>
	<section class="alert-popup"
		style="position: fixed; padding-top: 45px; background: rgb(255, 255, 255); z-index: 5006; top: 211px; left: 651.5px; width: 600px; opacity: 1; display: none;"
		id="layerId_04363414884115524">
		<div class="wrap">
			<header class="layer-header">
				<h3 class="tit">알림</h3>
			</header>
			<div class="layer-con" style="height: 450px">
				<p class="txt-common">﻿</p>
				<p>
					<font color="black"><strong><font color="red">※접종유무에
								관계없이 10명까지 관람 가능※</font><br>◆ 물, 음료(무알콜)만 취식가능<br>◆ 띄어앉기 운영 </strong><br>
					<br>[극장 이용 안내]<br>1. 마스크 항상 착용<br>2. 상영관 입장 전 발열 체크<br>안전한
						관람환경 조성을 위해 고객 여러분의 많은 협조 부탁드립니다.</font>
				</p>
				<p></p>
				<div class="btn-group">
					<button type="button" class="button lyclose" style="display: none;"></button>
					<button type="button" class="button purple confirm">확인</button>
				</div>
			</div>
			<button type="button" class="btn-layer-close">레이어 닫기</button>
		</div>
	</section> -->
</body>
</html>