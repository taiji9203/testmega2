<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>
	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->

<!--<div id="bodyContent"> -->
        
<script type="text/javascript">
$(function(){
	/* 앵커 이동 이벤트 */
	$("#mbshipBenefit").on("click","a", function(){
		$('html, body').animate({scrollTop : $($(this).attr("data-target")).offset().top - 150}, 400);
	});
});


</script>
		<!-- container -->
		<div class="container">
			<div class="page-util">
				<div class="inner-wrap">
					<div class="location">
						<span>Home</span>
						<a href="/benefit/membership" title="혜택 메인 페이지로 이동">혜택</a>
						<a href="/benefit/membership" title="멤버십 안내 페이지로 이동">메가박스 멤버십</a>
						<a href="/benefit/membership" title="멤버십 안내 페이지로 이동">멤버십 안내</a>
					</div>

				<!-- 공유하기 -->
					



<div class="sns-share">
	<a href="/benefit/membership#" class="btn btn-common-share" title="공유하기">
		
			
			
				
					공유하기 <!-- 공유하기 -->  <i class="iconset ico-share-toggle"></i>
				
			
		
	</a>

	<div class="btn-sns-share-wrap">
		<div class="cont-area">
			<div class="btn-sns-share-group">
				<!-- <button type="button" title="카카오톡 공유하기" class="btn btnSns kakao">카카오톡 </button> 카카오톡 -->
				<button type="button" title="페이스북 공유하기" class="btn btnSns face">페이스북 <!-- 페이스북 --></button>
				<button type="button" title="밴드 공유하기" class="btn btnSns band">밴드 <!-- 밴드 --></button>
				<button type="button" title="트위터 공유하기" class="btn btnSns twitter">트위터 <!-- 트위터 --></button>
				<button type="button" title="링크 공유하기" class="btn btnSns link">링크공유 <!-- 링크공유 --></button>
			</div>
		</div>
	</div>
</div>
				</div>
			</div>

			<!-- contents -->
			<div id="contents">
				<div class="inner-wrap">

					<h2 class="tit">메가박스 멤버십</h2>

					<div class="tab-list">
						<ul>
							<li class="on"><a href="/benefit/membership" title="멤버십 안내 탭으로 이동">멤버십 안내</a></li>
							<li><a href="/benefits/vipLounge" title="VIP LOUNGE 탭으로 이동">VIP LOUNGE</a></li>
						</ul>
					</div>

					<div class="box-slash mt40">
						<p class="tit-pr">MEGABOX MEMBERSHIP</p>

						<p>
							메가박스 멤버십 회원에게만 제공되는 다양한 혜택
						</p>
					</div>

					<h3 class="tit mt70">메가박스 멤버십 혜택</h3>

					<!-- benefit-membership -->
					<div class="benefit-membership" id="mbshipBenefit">
						<div class="box bg-point-save">
							<p class="tit">포인트 적립</p>

							<p class="txt">
								영화 티켓, 매점 상품 구매 시 등급에 따라<br>
								5 ~ 10% 포인트를 적립할 수 있어요
							</p>

							<div class="btn">
								<a href="javascript:void(0)" class="button purple" data-target="#pointSave" title="포인트 적립 상세보기">자세히 보기</a>
							</div>
						</div>

						<div class="box bg-point-present">
							<p class="tit">포인트 선물</p>

							<p class="txt">
								사랑하는 가족, 친구에게 포인트를 선물하세요<br>
								포인트 선물은 신포인트만 가능해요<br>
								<span>* 상세 내용은 모바일앱에서 확인해 주세요!</span>
							</p>
<!-- PC는 포인트 선물 기능 없어져서 상세 버튼 삭제 -->
<!-- 							<div class="btn"> -->
<!-- 								<a href="" class="button purple">자세히 보기</a> -->
<!-- 							</div> -->
						</div>

						<div class="box bg-point-use">
							<p class="tit">포인트 사용</p>

							<p class="txt">
								보유한 포인트로 원하는 영화 보고<br>
								팝콘도 구매하세요
							</p>

							<div class="btn">
								<a href="javascript:void(0)" class="button purple" data-target="#pointUse" title="포인트 사용 상세보기">자세히 보기</a>
							</div>
						</div>

						<div class="box bg-point-birthday">
							<p class="tit">생일 축하 쿠폰</p>

							<p class="txt">
								회원이라면 누구나 생일 축하 쿠폰을 드려요
							</p>

							<div class="btn">
								<a href="javascript:void(0)" class="button purple" data-target="#birthDayCp" title="생일 축하 쿠폰 상세보기">자세히 보기</a>
							</div>
						</div>

						<div class="box bg-point-vip">
							<p class="tit">VIP LOUNGE</p>

							<p class="txt">
								VIP 회원이라면<br>
								더 많은 추가 혜택을 받을 수 있어요
							</p>

							<div class="btn">
								<a href="/benefits/vipLounge" class="button purple" data-target="#vipLounge" title="VIP LOUNGE 상세보기">VIP LOUNGE11</a>
							</div>
						</div>

						<div class="box bg-point-special">
							<p class="tit">스페셜 멤버십</p>

							<p class="txt">
								메가박스 멤버십 혜택에<br>
								스페셜 멤버십 추가혜택도 받을 수 있어요
							</p>

							<div class="btn">
								<a href="/curation/specialcontent" class="button purple" title="스페셜 멤버십 상세보기">스페셜멤버십 안내</a>
							</div>
						</div>
					</div>
					<!--// benefit-membership -->

					<h3 class="tit mt70" id="pointSave">포인트 적립</h3>

					<h4 class="tit">포인트 기본 적립</h4>

					<ul class="dot-list">
						<li>영화 티켓 구매 시 유료 결제 금액의 <em class="font-gblue">5~10%</em> 적립
							<ul class="dash-list font-gray">
								<li>일반회원 : 5% 적립</li>
								<li>VIP회원 : 10% 적립 (단, VIP 선정 기준은 5%만 반영)</li>
							</ul>
						</li>
						<li>매점 유료 결제 금액의 <em class="font-gblue">2%</em> 적립</li>
						<li>결제가 완료된 후 적립 예정 포인트로 적립되며 <em class="font-gblue">영화의 경우 상영일 익일, 매점의 경우 구매일 익일</em> 사용 가능한 포인트(가용 포인트) 로 전환됩니다.</li>
						<li>회원이 로그인 후 온라인 서비스를 이용 하거나 현장 매표소, 키오스크에서 멤버십 카드 제시 또는 회원임을 확인 할 수 있는 정보를 제공하여야 포인트가 적립됩니다.</li>
						<li>메가박스 및 제휴사 할인, 포인트 결제 등을 통해 할인 받은 금액을 제외한 실제 고객님께서 현금, 신용카드 등으로 유료 결제한 금액 기준으로 적립됩니다.</li>
						<li>일부 영화, 상품, 극장, 결제 수단의 경우 적립이 되지 않거나 별도의 적립률이 적용될 수 있으며 상세 내용은 해당 상품, 극장 등에 별도 공지합니다.</li>
						<li>VIP 선정 시 기준이 되는 포인트입니다.</li>
						<li>포인트 적립은 티켓에 노출된 영화 시작 시간 이전까지만 가능하며, 영화 상영 및 매점 상품 구매 이후 사후 적립은 불가능합니다.</li>
					</ul>

					<h4 class="tit mt30">포인트 적립 제외 극장</h4>
					<ul class="dot-list">
						<li>일부 극장의 경우 매점 구매 시 포인트 적립이 불가합니다.
							<ul class="dash-list font-gray">
								<li>매점 적립 제외 극장: 경산하양, 경주, 공주, 김천, 남양주, 남원, 남춘천, 북대구(칠곡), 속초, 순천, 아트나인, 안산중앙, 원주, 인천논현, 제천, 진천, 첨단, 청주사창, 충주, 파주금촌</li>
							</ul>
						</li>
						<li>더 부티크 프라이빗 관람 시 포인트 적립이 불가합니다.</li>
					</ul>

					<h4 class="tit mt30">기타 적립 안내</h4>
					<ul class="dot-list">
						<li>단체 영화 관람 및 매점 구매를 통해 가격 할인을 받은 경우 포인트는 적립되지 않습니다.</li>
						<li>메가박스에서 발행된 관람권은 영화 가격과 무관하게 관람권이 판매된 가격 기준으로 포인트가 적립됩니다.</li>
						<li>모바일 쿠폰(기프티콘, 쇼 등)으로 결제된 티켓은 포인트 적립이 제외됩니다.</li>
						<li>위탁예매사(인터파크, YES24 등)을 통한 티켓 예매 시 회원정보가 동일할 경우 포인트가 적립됩니다.</li>
					</ul>

					<h3 class="tit mt70" id="pointUse">포인트 사용</h3>

					<h4 class="tit">포인트 사용</h4>

					<ul class="dot-list">
						<li>
							적립된 포인트는 사용 가능한 보유포인트 내에서 <span class="font-gblue">영화, 포토카드</span> 상품 구매 시
							<span class="font-gblue">상품 정가 전액을 기준</span>으로 포인트를 차감하여 사용 가능하며,
							매점 상품 구매 시 <span class="font-gblue">1,000포인트 이상 부터 10P단위로</span> 포인트를 차감하여 사용 가능합니다.<br>
							(일부 상품 포인트 사용 제외 될 수 있으며 자세한 사항은 하기 내용 확인 바랍니다.)
						</li>
					</ul>

					<div class="table-wrap mt10">
						<table class="data-table a-c">
							<caption>회원상품, 구분, 구포인트, 신포인트 항목을 가진 포인트 사용 표</caption>
							<colgroup>
								<col style="width:140px;">
								<col style="width:140px;">

								<col>
							</colgroup>
							<thead>
								<tr>
									<th scope="col">회원상품</th>
									<th scope="col">구분</th>
									<th scope="col">포인트 사용 기준</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td rowspan="2">영화</td>
									<td>사용 가능 요일</td>
									<td>월~일(요일 무관)</td>
								</tr>
								<tr>
									<td>차감 포인트</td>
									<td>티켓 정가 100% 필요</td>
								</tr>
								<tr>
									<td rowspan="2">매점</td>
									<td>사용 가능 상품</td>
									<td>매점 판매 상품(일부 상품 제외)</td>
								</tr>
								<tr>
									<td>차감<br>포인트</td>
									<td>보유 포인트 내, 최소 1,000 포인트 부터 10 포인트 단위 사용 가능 (키오스크, 모바일오더)<br>
										※ 현장 직원 결제 시 500 포인트 단위 사용 가능
									</td>
								</tr>
								<tr>
									<td>포토카드</td>
									<td>차감 포인트</td>
									<td>장당 1,000 포인트</td>
								</tr>
								<tr>
									<td>온라인 스토어</td>
									<td>차감<br>포인트</td>
									<td>상품별 차감 기준 상이 / 일부 상품 제외</td>
								</tr>
							</tbody>
						</table>
					</div>

					<ul class="dot-list mt10">
						<li>영화 티켓 구매 시
							<ul class="dash-list font-gray">
								<li>포인트는 티켓가 전액 차감되며 현금 또는 신용카드 등 다른 결제 수단과 합산하여 사용할 수 없습니다.</li>
								<li>예 : 13,000원 티켓 구매 시, 13,000 포인트 필요 (전액 차감)</li>
								<li>할인 쿠폰, 제휴 할인, 제휴포인트 결제 등 할인 적용 시 멤버십 포인트 사용 불가 합니다.(중복 사용 불가)</li>
							</ul>
						</li>
						<li>매점 상품 구매시
							<ul class="dash-list font-gray">
								<li>최소 1,000 포인트 부터 10포인트 단위 (키오스크, 모바일오더) 또는 500포인트 단위 (현장 직원 결제 시)로 사용 가능합니다.</li>
								<li>포인트 사용 후 남은 금액에 대하여 현금 또는 신용카드 등으로 결제 가능합니다.</li>
								<li>매점 할인 쿠폰 적용 후 멤버십 포인트 사용 가능합니다.(일부 상품 제외)</li>
								<li>모바일 상품권, 스토어 교환권 등 이용 시 멤버십 포인트 사용 불가 합니다.</li>
							</ul>
						</li>
						<li>오프라인에서 포인트 사용 시, 멤버십 카드 또는 메가박스 앱을 반드시 제시해야하며, 개인별로 설정된 포인트 비밀 번호 인증이 필요 합니다.</li>
						<li>특별콘텐트 (오페라, 팝콘클래식, 기획전, GV, 라이브중계 등) 및 일부 영화는 포인트 사용 관람이 불가합니다.</li>
						<li>매점 상품 중 프로모션 상품, 특가 상품 및 일부 품목은 포인트 사용이 제한될 수 있으며, 극장에 따라 사용 가능 상품이 상이할 수 있습니다.</li>
						<li>“더 부티크 프라이빗” 관람 시 포인트 사용이 불가합니다.</li>
					</ul>

					<h4 class="tit mt30">포인트 사용 제외 극장</h4>

					<ul class="dot-list">
						<li>일부 극장의 경우 매점에서 포인트 사용이 불가합니다.
							<ul class="dash-list font-gray">
								<li>사용 제외 극장 : 경산하양, 경주, 공주, 김천, 남양주, 남원, 남춘천, 북대구(칠곡), 속초, 순천, 아트나인, 안산중앙, 원주, 인천논현, 제천, 진천, 첨단, 청주사창, 충주, 파주금촌</li>
							</ul>
						</li>
					</ul>

					<h3 class="tit mt70">유효기간 및 소멸</h3>

					<h4 class="tit">포인트 유효기간</h4>

					<ul class="dot-list">
						<li>기본 적립 포인트 : 적립일로부터 24개월이 지난 해당월 말일  (티켓 및 매점 유료 구매 시)</li>
						<li>선물 받은 포인트 : 선물 받은 날로부터 3개월이 지난 해당월 말일</li>
						<li>이벤트 적립 포인트 : 이벤트 마다 유효기간이 상이(개별 확인 필요)</li>
					</ul>

					<h4 class="tit mt30">포인트 소멸</h4>

					<ul class="dot-list">
						<li>유효기간이 경과된 포인트는 매월 말일 영업 종료 후 포인트가 자동 소멸되며 포인트 사용 취소시 복구되지 않습니다</li>
						<li>소멸 기준은 잔여 가용 포인트 중 유효기간이 가장 짧은 포인트부터 소멸되며, 소멸된 포인트는 복구되지 않습니다.</li>
						<li>
							보유 포인트의 소멸 예정일이 도래할 경우, 포인트 소멸과 관련된 내용을 최소 15일 전에 문자 또는 이메일 등으로 고지합니다.<br>
							또한, 홈페이지 및 모바일 웹/앱 로그인 시 소멸 예정 포인트를 확인하실 수 있습니다.
						</li>
					</ul>

					<h3 class="tit mt70" id="birthDayCp">생일 축하 쿠폰</h3>

					<h4 class="tit">생일 축하 쿠폰 증정!</h4>

					<ul class="dot-list">
						<li>생일 쿠폰은 메가박스 회원에게만 제공됩니다.</li>
						<li>생일 쿠폰은 1년에 1회 지급되며, 한 번 발급되면 추가 발급되지 않습니다.</li>
						<li>
							생일 쿠폰은 회원정보에 등록된 생일을 기준으로 발급됩니다.
							<ul class="dash-list font-gray">
								<li>생일 2주전 쿠폰이 발행되며, 유효기간은 발행일로부터 4주입니다. (예 : 3월 16일 생일인 경우 3월 2일 발급, 3월 30일까지 사용 가능)</li>
							</ul>
						</li>
						<li>발행된 쿠폰은 로그인 후 ‘나의 메가박스 &gt; 쿠폰’에서 확인 가능합니다.</li>
						<li>쿠폰 발급일 기준, 정상 회원에게만 제공됩니다. (쿠폰 발급일 이후 가입, 휴면 회원 상태 고객 등 제외)</li>
						<li>쿠폰 내용, 지급 일정, 사용 방법 등은 내부 사정에 따라 변경될 수 있습니다.</li>
					</ul>

					<h3 class="tit mt70">멤버십 카드</h3>

					<ul class="dot-list">
						<li>극장 이용 시 멤버십 카드를 꼭 제시해주세요!</li>
					</ul>

					<div class="box-benefit-membership-card mt05">
						<img src="/resources/benefits/img-card-mobile.png" alt="모바일 카드">
					</div>

					<ul class="dot-list mt05">
						<li>메가박스 회원가입 시 모바일 카드가 자동 발급됩니다.</li>
						<li>플라스틱 카드 수령을 원하시는 분은 메가박스 현장 매표소에서 받으실 수 있습니다.</li>
						<li>플라스틱 카드를 수령하신 경우 홈페이지 ‘나의 메가박스 &gt; 멤버십 포인트 &gt; 멤버십 카드관리’에서 등록 후 이용하실 수 있습니다.</li>
					</ul>
				</div>
			</div>
			<!--// contents -->
		</div>
		<!--// container -->
<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="/benefit/membership" class="focus">레이어로 포커스 이동 됨</a>
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
	<a href="/benefits/memberShip" class="btn-go-top" title="top">top</a>
</div>

<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="/benefits/memberShip#" data-url="#">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>