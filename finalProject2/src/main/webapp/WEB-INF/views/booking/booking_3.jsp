<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>


<style type="text/css">
.fdLayer {
	display: none;
	position: absolute;
	top: 50%;
	left: 50%;
	height: auto;
	background-color: #fff;
	border: 5px solid rgb(0, 66, 101);
	z-index: 10;
}

.fdLayer .fdContainer {
	padding: 3px;
}

.fdLayer .fdBtn {
	width: 100%;
	margin: 10px 0 0;
	padding-top: 10px;
	border-top: 1px solid #DDD;
	text-align: right;
}

a.closeBtn {
	display: inline-block;
	height: 25px;
	padding: 0 14px 0;
	border: 1px solid #304a8a;
	background-color: rgb(0, 32, 61);
	font-size: 13px;
	color: #fff;
	line-height: 25px;
}

a.closeBtn:hover {
	border: 1px solid #091940;
	background-color: #1f326a;
	color: #fff;
}

#mask {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 9;
	background-color: #000;
	display: none;
}
/* LAYER POPUP STYLE END */

/* 할인수단 FONT size 변경처리 (기본15px;)*/
span.txt {
	font-size: 13px;
}
</style>

<script>
	window.dataLayer = window.dataLayer || [];
	function gtag() {
		dataLayer.push(arguments);
	}
	gtag('js', new Date());
	gtag('config', 'UA-30006739-3');
</script>

<script type="text/javascript">
	var reset = ''

	if (reset == 'Y' || location.pathname == '/booking') {
		history.replaceState('', '', location.href);
	}

	var _init = {
		cache : Date.now(),
		path : '/static/pc/js/'
	};

	document.write('<script src="' + _init.path + 'ui.common.js?v='
			+ _init.cache + '"><\/script>' + '<script src="' + _init.path
			+ 'front.js?v=' + _init.cache + '"><\/script>');

	//RedirectException 발생시 메시지 처리

	//링크 구분에 따라 url 이동을 한다.
	function fn_goMoveLink(link_gbn, link_url) {
		alert("준비중 입니다");
		return;
	}
</script>

<!--<script src="/resources/js/jquery-1.12.4.js"></script>
<script src="/resources/js/jquery-ui.1.12.1.js"></script>
<script src="/resources/js/gsaps.js"></script>
<script src="/resources/js/megaboxCom.js"></script>
<script src="/resources/js/mega.prototype.js"></script>
<script src="/resources/js/commons.js"></script>
<script src="/resources/js/bootstrap-custom.js"></script>
<script src="/resources/js/bootstrap-select.js"></script>
<script type="text/javascript" src="/resources/js/netfunnel.js" charset="UTF-8"></script>
<script type="text/javascript" src="/resources/js/netfunnel_skin.js" charset="UTF-8"></script>
<script type="text/javascript" src="/resources/js/netfunnel_frm.js" charset="UTF-8"></script>
<script type="text/javascript" src="/resources/js/swiper.min.js"></script>-->
	
	
<div class="container">

		<div class="inner-wrap">
			<div id="bokdMPayBooking" style="overflow: hidden; height: 1000px;">
				<iframe id="framePayBooking" src="/resources/js/booking/completeSeat.html" title="예매 결제" scrolling="no" frameborder="0" class="reserve-iframe" style="width: 100%; height: 1000px;"></iframe>
				<!--<iframe id="framePayBooking" src="/booking/completeSeat.jsp" title="예매 결제" scrolling="no" frameborder="0" class="reserve-iframe" style="width: 100%; height: 1000px;"></iframe>-->
				<input type="hidden" name="tagName_value" value="${tagName }" />
				<input type="hidden" name="hangle_value" value="${hangle }" />
				<input type="hidden" name="movieNm_value" value="${movieNm }" /> 
				<input type="hidden" name="movieImg_value" value="${movieImg }" />
				<input type="hidden" name="playKindNm_value" value="${playKindNm }" /> 
				<input type="hidden" name="brchNm_value" value="${brchNm }" /> 
				<input type="hidden" name="theater_value" value="${theater }" /> 
				<input type="hidden" name="playDe_value" value="${playDe }" /> 
				<input type="hidden" name="dowNm_value" value="${dowNm }" /> 
				<input type="hidden" name="playTime_value" value="${playTime }" /> 
				<input type="hidden" name="adultCnt_value" value="${adultCnt }" /> 
				<input type="hidden" name="youngCnt_value" value="${youngCnt }" /> 
				<input type="hidden" name="favorCnt_value" value="${favorCnt }" /> 
				<input type="hidden" name="adultPrice_value" value="${adultPrice }" />
				<input type="hidden" name="youngPrice_value" value="${youngPrice }" />
				<input type="hidden" name="favorPrice_value" value="${favorPrice }" /> 
				<input type="hidden" name="totalPrice_value" value="${totalPrice }" />
				<input type="hidden" name="seat1_value" value="${seat1 }" /> 
				<input type="hidden" name="seat2_value" value="${seat2 }" /> 
				<input type="hidden" name="seat3_value" value="${seat3 }" /> 
				<input type="hidden" name="seat4_value" value="${seat4 }" /> 
				<input type="hidden" name="seat5_value" value="${seat5 }" /> 
				<input type="hidden" name="seat6_value" value="${seat6 }" /> 
				<input type="hidden" name="seat7_value" value="${seat7 }" /> 
				<input type="hidden" name="seat8_value" value="${seat8 }" />
			</div>
		</div>

</div>
	
	</div>
</body>
</html>