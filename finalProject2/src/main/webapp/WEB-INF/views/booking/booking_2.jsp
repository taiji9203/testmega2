<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	

<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

	
<form id="bokdMForm">
	<input type="hidden" name="returnURL" value="info">
</form>

<div class="container" style="padding-bottom: 240px;">

	<div class="page-util" style="">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span> <a href="/booking_1" title="예매 페이지로 이동">예매</a> <a href="/booking_1" title="빠른예매 페이지로 이동">빠른예매</a> <a> ${mtnDto.movie }</a>
			</div>
		</div>
	</div>

	<div id="contents">
		<div class="inner-wrap">
			<div id="bokdMSeat" style="overflow: hidden; height: 1000px;">
				<iframe id="frameBokdMSeat" src="/resources/js/booking/selectPcntSeatChoi.jsp" title="관람인원선택 프레임" scrolling="no" frameborder="0" class="reserve-iframe" style="width: 100%; height: 1000px;"></iframe>
				<input type="hidden" name="tagName_value" value="${mtnDto.tagName }" />
				<input type="hidden" name="hangle_value" value="${mtnDto.hangle }" />
				<input type="hidden" name="movieNm_value" value="${mtnDto.movie }" /> 
				<input type="hidden" name="movieImg_value" value="${mtnDto.movieImg }" /> 
				<input type="hidden" name="playKindNm_value" value="${mtnDto.playKind }" /> 
				<input type="hidden" name="brchNm_value" value="${mtnDto.regionDetail }" /> 
				<input type="hidden" name="theater_value" value="${mtnDto.theater }" /> 
				<input type="hidden" name="playDe_value" value="${mtnDto.strDate }" /> 
				<input type="hidden" name="dowNm_value" value="(${mtnDto.dayOfWeek })" /> 
				<input type="hidden" name="playTime_value" value="${mtnDto.startHour }:${mtnDto.startMinute }~	${mtnDto.endHour }:${mtnDto.endMinute }" /> 
			</div>
		</div>
	</div>
</div>
		
<!-- footer -->
<jsp:include page="../layout/footer.jsp"></jsp:include>
<!-- //footer -->
</div>

</body>
</html>