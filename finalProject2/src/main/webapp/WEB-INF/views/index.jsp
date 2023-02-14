<%@ page contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>

<!-- header -->
<jsp:include page="layout/headerBlack.jsp"></jsp:include>
<!--// header -->


	
<!--<div id="bodyContent"> -->
<link rel="stylesheet" href="/resources/css/main.css" media="all">
<!-- 2019-04-03 swipe 기능 추가 -->
<script src="/resources/js/swiper.min.js"></script>

<div class="container main-container">

	<!-- contents -->
	<div id="contents">

		<!-- main-page -->
		<div class="main-page">			

			<!-- section main-movie : 영화 -->
			<div id="main_section01" class="section main-movie on">
				<div class="bg">
					<div class="bg-pattern"></div>
					<img src="/resources/main/Vs3oMclXZiQuP5Hdz7txFvXhS2N4M7Lq_380.jpg" alt="titanic_bodostill_01.jpg" onerror="#">
					</div>

				<!-- cont-area  -->
				<div class="cont-area">

					<!-- tab-sorting -->
					<div class="tab-sorting">
						<button type="button" class="on" sort="boxoRankList" name="btnSort">박스오피스</button>
						
					</div>
					<!-- tab-sorting -->

					<a href="/movie/movie" class="more-movie" title="더 많은 영화보기">
						더 많은 영화보기 <i class="iconset ico-more-corss gray"></i>
					</a>

					<!-- main-movie-list -->
					<div class="main-movie-list">
						<ol class="list">
							<!-- 3개의 list를  loop 한다-->
							<!-- 박스오피스 시작 -->
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankList" class="first">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													<p><img src="/resources/main/mov_top_tag_db.png" alt="dolby"></p>
													<p><img src="/resources/main/mov_top_tag_mx.png" alt="mx"></p>
													</div>
												<p class="rank">1<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/ym0dktzCLlIcYSlKLVW6y39GYa1Vg04l_420.jpg" alt="타이타닉" class="poster" onerror="/booking_1">
							                      	<div class="wrap" style="display: none; opacity: 1;">
													<div class="summary">
														"내 인생의 가장 큰 행운은 당신을 만난 거야"<br><br>우연한 기회로 티켓을 구해 타이타닉호에 올라탄 자유로운 영혼을 가진 화가 ‘잭’(레오나르도 디카프리오)은<br>막강한 재력의 약혼자와 함께 1등실에 승선한 ‘로즈’(케이트 윈슬렛)에게 한눈에 반한다.<br>진실한 사랑을 꿈꾸던 ‘로즈’ 또한 생애 처음 황홀한 감정에 휩싸이고, 둘은 운명 같은 사랑에 빠지는데…<br><br>가장 차가운 곳에서 피어난 뜨거운 사랑!<br>영원히 가라앉지 않는 세기의 사랑이 펼쳐진다!</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number">9.7<span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="23004000">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														1.7k
														</button>
                                                <div class="case">
                                                    <!-- 개봉 예매가능 기본-->
                                                            <a href="/booking_1" class="button gblue" title="영화 예매하기">예매</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankList" class="">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													<p><img src="/resources/main/mov_top_tag_mx.png" alt="mx"></p>
													</div>
												<p class="rank">2<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/whzCk46ejtIoWU1eavvF9lJ8rC2Wbvf7_420.jpg" alt="더 퍼스트 슬램덩크" class="poster" onerror="#">
							                      	<div class="wrap" style="display: none; opacity: 1;">
													<div class="summary">
														전국 제패를 꿈꾸는 북산고 농구부 5인방의 꿈과 열정, 멈추지 않는 도전을 그린 영화</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number">9.5<span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="22103500">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														2.6k
														</button>
                                                <div class="case">
                                                    <!-- 개봉 예매가능 기본-->
                                                            <a href="/booking_1" class="button gblue" title="영화 예매하기">예매</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankList" class="">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													<p><img src="/resources/main/mov_top_tag_db.png" alt="dolby"></p>
													<p><img src="/resources/main/mov_top_tag_mx.png" alt="mx"></p>
													</div>
												<p class="rank">3<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/Ke5WV8r17wpYvSjebocicB2pQ0YVhN2U_420.jpg" alt="앤트맨과 와스프: 퀀텀매니아" class="poster" onerror="#">
							                      	<div class="wrap" style="display: none; opacity: 1;">
													<div class="summary">
														슈퍼히어로 파트너인 '스캇 랭'(폴 러드)과 '호프 반 다인'(에반젤린 릴리),<br>호프의 부모 '재닛 반 다인'(미셸 파이퍼)과 '행크 핌'(마이클 더글라스),<br>그리고 스캇의 딸 '캐시 랭'(캐서린 뉴튼)까지<br>미지의 ‘양자 영역’ 세계 속에 빠져버린 ‘앤트맨 패밀리’.<br><br>그 곳에서 새로운 존재들과 무한한 우주를 다스리는 정복자 '캉'을 만나며,<br>그 누구도 예상 못 한 모든 것의 한계를 뛰어넘는 모험을 시작하게 되는데…<br><br>2023년 첫 번째 마블 블록버스터<br>2월, 무한한 우주의 정복자가 깨어난다!</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number">0<span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="22088100">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														1.5k
														</button>
                                                <div class="case">
                                                    <!-- 개봉 예매가능 기본-->
                                                            <a href="/booking_1" class="button gblue" title="영화 예매하기">예매</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankList" class="">
											<a href="javascript:gfn_moveDetail(&#39;22029100&#39;)" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													<p><img src="/resources/main/mov_top_tag_db.png" alt="dolby"></p>
													<p><img src="/resources/main/mov_top_tag_mx.png" alt="mx"></p>
													</div>
												<p class="rank">4<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/9vUySe7DNMro6tdYRPEbjzF2ebr48MwE_420.jpg" alt="아바타: 물의 길" class="poster" onerror="#">
							                      	<div class="wrap" style="display: none; opacity: 1;">
													<div class="summary">
														&lt;아바타: 물의 길&gt;은 판도라 행성에서<br>'제이크 설리'와 '네이티리'가 이룬 가족이 겪게 되는 무자비한 위협과<br>살아남기 위해 떠나야 하는 긴 여정과 전투,<br>그리고 견뎌내야 할 상처에 대한 이야기를 그렸다.<br><br>월드와이드 역대 흥행 순위 1위를 기록한 전편 &lt;아바타&gt;에 이어<br>제임스 카메론 감독이 13년만에 선보이는 영화로,<br>샘 워싱턴, 조 샐다나, 시고니 위버, 스티븐 랭, 케이트 윈슬렛이 출연하고<br>존 랜도가 프로듀싱을 맡았다.</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number">9.4<span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="22029100">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														6.7k
														</button>
                                                <div class="case">
                                                    <!-- 개봉 예매가능 기본-->
                                                            <a href="/booking_1" class="button gblue" title="영화 예매하기">예매</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 박스오피스 종료 -->
								<!-- 박스오피스 시작 -->
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankStillList" style="display:none;" class="first">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													</div>
												<p class="rank">1<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/bg-noimage-main.png" alt="" class="poster" onerror="#">
							                      	<div class="wrap">
													<div class="summary">
														</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number"><span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="23004000">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														</button>
                                                <div class="case">
                                                    <a href="#" class="button gblue" title="상영예정">상영예정</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankStillList" style="display:none;" class="">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													</div>
												<p class="rank">2<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/bg-noimage-main.png" alt="" class="poster" onerror="#">
							                      	<div class="wrap">
													<div class="summary">
														</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number"><span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="23004000">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														</button>
                                                <div class="case">
                                                    <a href="#" class="button gblue" title="상영예정">상영예정</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankStillList" style="display:none;" class="">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													</div>
												<p class="rank">3<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/bg-noimage-main.png" alt="" class="poster" onerror="#">
							                      	<div class="wrap">
													<div class="summary">
														</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number"><span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="23004000">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														</button>
                                                <div class="case">
                                                    <a href="#" class="button gblue" title="상영예정">상영예정</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankStillList" style="display:none;" class="">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													</div>
												<p class="rank">4<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/bg-noimage-main.png" alt="" class="poster" onerror="#">
							                      	<div class="wrap">
													<div class="summary">
														</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number"><span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="23004000">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														</button>
                                                <div class="case">
                                                    <a href="#" class="button gblue" title="상영예정">상영예정</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankStillList" style="display:none;" class="">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													</div>
												<p class="rank">5<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/bg-noimage-main.png" alt="" class="poster" onerror="#">
							                      	<div class="wrap">
													<div class="summary">
														</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number"><span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="23004000">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														</button>
                                                <div class="case">
                                                    <a href="#" class="button gblue" title="상영예정">상영예정</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankStillList" style="display:none;" class="">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													</div>
												<p class="rank">6<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/bg-noimage-main.png" alt="" class="poster" onerror="#">
							                      	<div class="wrap">
													<div class="summary">
														</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number"><span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="23004000">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														</button>
                                                <div class="case">
                                                    <a href="#" class="button gblue" title="상영예정">상영예정</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankStillList" style="display:none;" class="">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													</div>
												<p class="rank">7<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/bg-noimage-main.png" alt="" class="poster" onerror="#">
							                      	<div class="wrap">
													<div class="summary">
														</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number"><span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="23004000">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														</button>
                                                <div class="case">
                                                    <a href="#" class="button gblue" title="상영예정">상영예정</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankStillList" style="display:none;" class="">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													</div>
												<p class="rank">8<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/bg-noimage-main.png" alt="" class="poster" onerror="#">
							                      	<div class="wrap">
													<div class="summary">
														</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number"><span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="23004000">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														</button>
                                                <div class="case">
                                                    <a href="#" class="button gblue" title="상영예정">상영예정</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankStillList" style="display:none;" class="">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													</div>
												<p class="rank">9<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/bg-noimage-main.png" alt="" class="poster" onerror="#">
							                      	<div class="wrap">
													<div class="summary">
														</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number"><span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="23004000">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														</button>
                                                <div class="case">
                                                    <a href="#" class="button gblue" title="상영예정">상영예정</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->

										<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
										<li name="li_boxoRankStillList" style="display:none;" class="">
											<a href="/movie/movie" class="movie-list-info" title="영화상세 보기">
												<div class="screen-type2">
													</div>
												<p class="rank">10<span class="ir">위</span></p>
												<!-- to 개발 : alt 값에 영화 제목 출력 -->
										      	<img src="/resources/main/bg-noimage-main.png" alt="" class="poster" onerror="#">
							                      	<div class="wrap">
													<div class="summary">
														</div>
													<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
													<div class="score">
														<div class="preview">
															<p class="tit">관람평</p>
															<p class="number"><span class="ir">점</span></p>
														</div>
													</div>
												</div>
											</a>
											<div class="btn-util">
                                                <button type="button" class="button btn-like" rpst-movie-no="23004000">
													<i title="보고싶어 설정 안함" class="iconset ico-heart-toggle-gray"></i>
														</button>
                                                <div class="case">
                                                    <a href="#" class="button gblue" title="상영예정">상영예정</a>
                                                        </div>
                                                </div>
										</li>
									<!-- 박스오피스 종료 -->
								</ol>
					</div>
					<!--// main-movie-list -->

					<div class="search-link">
						<div class="cell">
							<div class="search">
								<input type="text" placeholder="영화명을 입력해 주세요" title="영화 검색" class="input-text" id="movieName">
								<button type="button" class="btn" id="btnSearch"><i class="iconset ico-search-w"></i> 검색</button>
							</div>
						</div>

						<div class="cell"><a href="/booking/timeTable" title="상영시간표 보기"><i class="iconset ico-schedule-main"></i> 상영시간표</a></div>
						<div class="cell"><a href="/movie/moviePost" title="박스오피스 보기"><i class="iconset ico-boxoffice-main"></i> 박스오피스</a></div>
						<div class="cell"><a href="/booking_1" title="빠른예매 보기"><i class="iconset ico-quick-reserve-main"></i> 빠른예매</a></div>
					</div>
					<!-- 2019-02-22 추가 : 마우스 아이콘 영역 추가 -->
					<div class="moving-mouse">
						<!--  <i class="iconset ico-mouse"></i> -->
						<img class="iconset" alt="" src="/resources/main/ico-mouse.png" style="top: 2px;">
					</div>
					<!--// 2019-02-22 추가 : 마우스 아이콘 영역 추가 -->
				</div>
				<!--// cont-area  -->
			</div>
			<!--// section main-movie : 영화 -->

			<!-- section main-benefit : 혜택 -->
			<div id="main_section02" class="section main-benefit">
				<!-- wrap -->
				<div class="wrap">
					<!-- 혜택 시작 -->
					<div class="tit-util">
							<h2 class="tit">혜택</h2>
							<a href="javascript:void(0)" onclick="/benefits/memberShip" class="btn-more-cross purple" title="혜택 더보기">더보기</a>
						</div>
						<!--
							왼쪽 글씨 이미지 사이즈 300 * 230, 오른쪽 이미지 635 * 325
						 -->
						<div class="slider main-condition">
							<div class="slider-view" style="width: 1100px;">
								<div class="cell" style="display: none; position: absolute; float: none;">
									<div class="position">
										<div class="txt" style="top: 100px; opacity: 0;"><a href="/event/event" target="_self" title=""><img src="/resources/main/RoSPqWxTV7SenfdFsbmYN3cjsbpKDG36.png" alt="" onerror="#"></a></div>
										<div class="bg" style="left: 450px; opacity: 0;"><a href="/event/event" target="_self" title=""><img src="/resources/main/DunVB3YUwC4UBmENnAnpEey1BPTTNhnl.png" alt="" onerror="#"></a></div>
									</div>
								</div>
								<div class="cell" style="display: none; position: absolute; float: none;">
									<div class="position">
										<div class="txt" style="top: 100px; opacity: 0;"><a href="/event/event" target="_self" title=""><img src="/resources/main/cX1iNcPQqzdreCYknmwAAelXYLkxslOY.png" alt="" onerror="#"></a></div>
										<div class="bg" style="left: 450px; opacity: 0;"><a href="/event/event" target="_self" title=""><img src="/resources/main/r4emhYXDyecioi2uqfDPUSbpqqEVFHj1.png" alt="" onerror="#"></a></div>
									</div>
								</div>
								<div class="cell" style="display: none; position: absolute; float: none;">
									<div class="position">
										<div class="txt" style="top: 100px; opacity: 0;"><a href="/event/event" target="_self" title=""><img src="/resources/main/sbGEL3IbYXqdKYL3fd7bJrYZe2pdFdLx.jpg" alt="" onerror="#"></a></div>
										<div class="bg" style="left: 450px; opacity: 0;"><a href="/event/event" target="_self" title=""><img src="/resources/main/9UXpWhERe6bmzKmYKFTAerzoZ6cQT5G8.jpg" alt="" onerror="#"></a></div>
									</div>
								</div>
								<div class="cell" style="display: none; position: absolute; float: none;">
									<div class="position">
										<div class="txt" style="top: 100px; opacity: 0;"><a href="/event/eventPromotion" target="_self" title="할인쿠폰 받기"><img src="/resources/main/oF7Qwu6GNyz5oVwHfWxtLv1Tc0zbRtrO.jpg" alt="" onerror="#"></a></div>
										<div class="bg" style="left: 450px; opacity: 0;"><a href="/event/eventPromotion" target="_self" title="할인쿠폰 받기"><img src="/resources/main/CMDINzKvXAivmNE9VnmAjXMHbhKrKDJC.png" alt="" onerror="#"></a></div>
									</div>
								</div>
								<div class="cell" style="display: none; position: absolute; float: none;">
									<div class="position">
										<div class="txt" style="top: 100px; opacity: 0;"><a href="#" target="_blank" title="더쎈카드 APP 다운받기"><img src="/resources/main/oh9EH1IP3sjaesilIfPvFmt4Sn0g6wmc.png" alt="" onerror="#"></a></div>
										<div class="bg" style="left: 450px; opacity: 0;"><a href="#" target="_blank" title="더쎈카드 APP 다운받기"><img src="/resources/main/7nk6O2B3HdWxTY2lPu76ybx7BhFvQ8c0.png" alt="" onerror="#"></a></div>
									</div>
								</div>
								<div class="cell" style="display: block; position: absolute; float: none;">
									<div class="position">
										<div class="txt" style="top: 0px; opacity: 1;"><a href="/event/event" target="_self" title=""><img src="/resources/main/f7RPSplY1eWEFFhKNBDJK4JIXKv9NBZK.jpg" alt="" onerror="#"></a></div>
										<div class="bg" style="left: 300px; opacity: 1;"><a href="/event/event" target="_self" title=""><img src="/resources/main/fZ8glF2ggujTRrF5vtRuE1iE2UjjV1oF.jpg" alt="" onerror="#"></a></div>
									</div>
								</div>
								</div>
							<div class="slider-control">

								<div class="page"><span class="" style="width:16.666666666666664%"></span><span class="" style="width:16.666666666666664%"></span><span class="" style="width:16.666666666666664%"></span><span class="" style="width:16.666666666666664%"></span><span class="" style="width:16.666666666666664%"></span><span class="on" style="width:16.666666666666664%"></span></div>

								<div class="util">
									<button type="button" class="btn-prev" style="opacity: 1;">이전 이벤트 보기</button>
									<button type="button" class="btn-next" style="opacity: 0.5;" disabled="true">다음 이벤트 보기</button>

									<button type="button" class="btn-pause on">일시정지</button>
									<button type="button" class="btn-play">자동재생</button>
								</div>

								<div class="page-count">6 / 6</div>

							</div>
						</div>


						<div class="brn-ad" style="height:204px;">
							<div class="banner">
								<div class="size">
										<a href="#" data-no="12392" data-netfunnel="N" class="eventBtn" title="더쎈카드 APP 다운받기">
											<img src="/resources/event/iFpskcjm9wzchFEmLxHd9nmyUrEPdwTq.png" alt="[메가박스X더쎈카드] 할인카드 조회하고 혜택받자!" onerror="#">
										</a>
									</div>
									<div class="size small">
										<a href="#" data-no="11739" data-netfunnel="N" class="eventBtn" title="">
											<img src="/resources/event/Xrp5Tofqsk1VhCZhJKfyuUjmtO9nVbVi.jpg" alt="[광주은행X메가박스] 메가박스 카드 런칭기념 이벤트" onerror="#">
										</a>
									</div>
								</div>							
							</div>
							<!-- 광고영역 -->
							<div class="ad-img">
								<!-- <img src="../../../static/pc/images/main/@img-main-ad.png" alt="블루멤버스 포인트로" /> -->
								<script data-id="M_rwl-o8QV2xFMa0Oy93qQ" name="/resources/popup/main_middle_event_415x530" src="/resources/js/persona.js" async="">
								</script>
								<script src="/resources/js/leVzVmI9mJHrotGMGQAk3u3f1U1EH0RC2PaUuQzpzIaEAM4qWzAZAbZ2ZUE2R2ViZlRGcWgtblFmeDZlb2RBAstB2PmHppu1nQPLQdj5h6abtZ0.js"></script>
								<div id="M_rwl-o8QV2xFMa0Oy93qQ"><iframe src="/resources/popup/main_middle_event_415x530.html" title="메인 혜택 우측배너영역" height="530px" width="415px" name="mliframe" scrolling="no" frameborder="0" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0"></iframe></div>
							</div>
							<!-- 광고영역 -->
					<!-- 혜택 종료 -->

					<div class="menu-link">
						<div class="cell vip"><a href="/benefits/vipLounge" title="VIP LOUNGE 페이지로 이동">VIP LOUNGE</a></div>
						<div class="cell membership"><a href="/benefits/memberShip" title="멤버십 페이지로 이동">멤버십</a></div>
						<div class="cell card"><a href="/benefits/disCount" title="할인카드안내 페이지로 이동">할인카드안내</a></div>
						<div class="cell event"><a href="/event/event" title="이벤트 페이지로 이동">이벤트</a></div>
						<div class="cell store"><a href="/store" title="스토어 페이지로 이동">스토어</a></div>
					</div>

					<!-- grand-open -->
					<!--// grand-open -->
				</div>
				<!--// wrap -->
			</div>
			<!--// section main-benefit : 혜택 -->

			<div id="main_section03" class="section main-curation">
				<!-- wrap -->
				<div class="wrap">
					<div class="tit-util">
						<h2 class="tit">큐레이션</h2>

						<div class="right">
							<a href="/movie/curation" title="큐레이션 더보기">
								큐레이션 더보기 <i class="iconset ico-more-corss gray"></i>
							</a>
						</div>
					</div>

					<!-- curation-area -->
					<div class="curation-area">
						<!-- curr-img -->
								<div class="curr-img">
									<p class="bage classic">메가박스 클래식소사이어티</p>
										<div class="img">
										<a href="#" title="영화상세 보기">
											<img src="/resources/main/xAw5101zkwxSk1pwnyjyE5TONTRX0vM1_420.jpg" alt="[ROH 발레] 달콤 쌉사름한 초콜릿" onerror="#">
											</a>
									</div>

									<div class="btn-group justify">
										<div class="left">
											<a href="#" class="button" title="영화상세 보기">상세정보</a>
										</div>
										<div class="right">
											<a href="/booking_1" class="button gblue" title="영화 예매하기">예매</a>
												</div>
									</div>

									<div class="info classic">
										<p class="txt">#<span>클래식소사이어티</span></p>
											<p class="tit">[ROH 발레] 달콤 쌉사름한 초콜릿</p>
										<p class="summary">
											유명 현대 멕시칸 소설인 ‘마술적 리얼리즘’이 로열 발레로 위대한 재탄생<br><br>[상영 정보]<br>ㆍ상영지점 : <br>서울 = 상암월드컵경기장 / 성수 / 센트럴 / 코엑스 / 더 부티크 목동현대백화점<br>경기/인천 = 분당 / 부천스타필드시티 / 안성스타필드 / 영통 / 일산벨라시타 / 킨텍스 / 하남스타필드<br>대전/충청 = 대전신세계 아트앤사이언스 / 세종나성<br>부산/대구/경상 = 대구이시아 / 마산 / 부산대 / 울산 / 양산라피에스타 / 포항<br>ㆍ상영일정 : 2023년 2월 13일(월) ~ 2023년 3월 5일(일) 매주 월요일 / 일요일 상영<br>ㆍ러닝타임 : 147분 (인터미션 없음)<br><br>[제작진 정보] <br>음악 / 조비 탈보트<br>안무 / 크리스토퍼 휠든<br>원작 / 로라 에스퀴벨<br>지휘 / 알론드라 데 라 파라<br>※ 로열발레단과 아메리칸발레시어터 공동제작<br><br>[출연진 정보] <br>티타 / 프란체스카 헤이워드(Francesca Hayward)<br>마마 엘레나 / 라우라 모레라(Laura Morera)<br>로사우라 / 마야라 마그리(Mayara Magri)<br>헤르트루디스 / 메간 그레이스 힌키스(Meaghan Grace Hinkis)<br>페드로 / 마르셀리노 삼베(Marcelino Sambé)<br>존 브라운 / 매튜 볼(Mattew Ball)<br>나차 / 크리스티나 아레스티스(Christina Arestis)<br>후안 알레한드레스 / 세자르 코랄레스(Cesar Corrales)<br>돈 파스칼 / 개리 애비스(Gary Avis)<br>첸차 / 이사벨라 가스파리니(Isabella Gasparini)<br><br>[작품 소개]<br>유명 현대 멕시칸 소설인 ‘마술적 리얼리즘’이 로열 발레로 위대한 재탄생<br><br>발레는 로라 에스퀴블의 소설에 영감을 받았는데,  <br>놀랍고도 극적인 방법으로 중심이 되는 캐릭터의 감정이  <br>그녀를 둘러싼 모두가 영향을 받도록 조종하는 것을 통해  <br>쏟아져 나오는 매혹적인 가문 대하소설이다.   <br><br>아메리칸 발레 시어터와의 공동 제작으로  <br>조비 탤봇이 새롭게 작업한 음악에 멕시코인 지휘자 <br>알롱드라 드 라 파라는 음악적 자문가로도 활동하였고,  <br>휠든은 에스퀴블과 가까이 일하면서 재미있고 마음을 사로잡는<br>새 발레 작품으로 층층이 쌓인 이야기를 새롭게 구성했다.<br><br><br><br>[시놉시스] <br>티타는 멕시코의 한 목장에서 가족과 함께 사는 소녀이다.  <br>그녀는 근처에 사는 소년 페드로와 사랑에 빠지지만  <br>그들이 결혼하고 싶어할 때 가문의 전례가 그것을 막는데...  <br>티타는 어머니를 돌보기 위해 미혼으로 남아 있어야 한다.  <br><br>요리에 대한 티타의 열정은 자신이 준비한 음식을 통해  <br>자신의 감정이 다른 사람에게 전해지고,  <br>인생의 사건에 따라 기분이 바뀌면서  <br>그녀를 둘러싼 모든 사람들의 결과는 더욱 놀라워진다.<br></p>
									</div>
								</div>
								<!--// curr-img -->

								<!--// list-area -->
								<div class="list">
							 	<ul>
									<li>
										<a href="#" title="영화상세 보기">
										<p class="bage film">필름소사이어티</p>
											<div class="img"><img src="/resources/main/M2u6jNAAz96xptBsFnk1x3azxuMP0GHt_230.jpg" alt="애프터썬" onerror="#"></div>

											<p class="tit">애프터썬</p>

											<p class="summary">
												아빠와 20여 년 전 갔던 튀르키예 여행.
												둘만의 기억이 담긴 오래된 캠코더를 꺼내자
												그해 여름이 물결처럼 출렁이기 시작한다.</p>
										</a>
									</li>
									<li>
										<a href="#" title="영화상세 보기">
										<p class="bage film">필름소사이어티</p>
											<div class="img"><img src="/resources/main/FIjRakrajy6UjCwHMkB6dRGQvT7jdcu1_230.jpg" alt="[사건 읽는 영화관] 의뢰인 : 시체 없는 살인사건의 공판" onerror="#"></div>

											<p class="tit">[사건 읽는 영화관] 의뢰인 : 시체 없는 살인사건의 공판</p>

											<p class="summary">
												사건 읽는 영화관, 그 첫 번째 강연
												사건의뢰 범죄 전문가들에게 듣는 “범죄 수사와 범죄 심리 분석” 이야기

												[사건 ep.01] 의뢰인 : 시체 없는 살인사건의 공판

												[강연 정보]
												- 강연일시 : 23년 02월 19일(일) 오전 11시
												  예매오픈 : 23년 01년 30일(월) 오후 5시
												- 강연자 : 홍유진 박사
												- 강연장소 : 메가박스 신촌지점
												- 강연시간 : 110분 
												- 범죄해설 영화 : 의뢰인

												※ 강연자의 사정으로 강연 순서가 변경되었습니다. 
												2월 예정이었던 김복준 교수의 [대한민국 강력사건 : 연쇄살인사건]은 4월에 찾아 뵙겠습니다.

												* 본 프로그램은 영화 속 범죄들을 다루는 강연으로 청소년은 관람이 불가합니다. 
												* 영화를 상영하거나 영화 내용을 해설하는 프로그램이 아니므로 예매 전 유의 부탁드립니다. 
												* 강연 3일전 ~ 1일전 취소 및 환불 시 수수료가 10% 발생되며, 당일 취소는 불가 합니다.
												** 관람 고객 전원에게 상영관 입장 전 굿즈(수사 키트)와 사건개요 핸드아웃을 제공합니다. 

												[강연 주제]
												정황 증거 만으로 살인 인정이 가능할까?
												사법 판단자들의 의사결정은 어떻게 이루어지는가 - 인간의 판단에 오류를 일으키는 요인들 

												[시놉시스]
												피로 물든 침대, 사라진 시체, 그리고 살인 혐의.. 재판이 끝나기 전까진 누구도 믿을 수 없다!
												시체 없는 살인사건, 그러나 명백한 정황으로 붙잡힌 용의자는 피살자의 남편. 
												여기에 투입된 변호사와 검사의 치열한 공방과 배심원을 놓고 벌이는 그들의 최후 반론. 
												어떤 결말도 예상할 수 없는 치열한 법정 대결, 이제 당신을 배심원으로 초대한다!
												</p>
										</a>
									</li>
									<li>
										<a href="#" title="영화상세 보기">
										<p class="bage classic">클래식소사이어티</p>
											<div class="img"><img src="/resources/main/xo1VEjALK6IBcdM9VnsHH8MMRYBm3cCT_230.jpg" alt="[베로나 오페라 페스티벌] 투란도트" onerror="#"></div>

											<p class="tit">[베로나 오페라 페스티벌] 투란도트</p>

											<p class="summary">
												100th 베로나 오페라 페스티벌 기념, 화제의 오페라 몰아보기
												고대 로마 원형극장에서 열리는 이탈리아의 가장 유서 깊은 축제, 베로나 오페라 페스티벌

												[상영정보]
												- 공연 명칭 : 베로나 오페라 페스티벌 – 투란도트 (오페라 공연으로 한글자막 제공)
												- 상영 일시 : 2023년  1월 31일(화) ~ 2월 18일(토) / 매주 화요일, 토요일
												- 공연 시간 : 약 138분 / 인터미션 없음

												[시놉시스]
												중국 베이징 황제의 딸 투란도트는 자신에게 구혼하러 온 왕자들에게 세가지 수수께끼를 내어 맞추면 결혼하겠지만 하나라도 풀지 못할 시 참수시키겠다는 포고문을 내건다. 이런 끔찍한 조건에도 불구하고 아름다운 투란도트에게 목숨을 걸고 청혼하는 왕자의 수는 늘어만 간다. 우연히 길을 지나던 칼라프 왕자는 그녀에게 반해 수수께끼에 도전하기로 마음먹는다.

												[작품소개]
												아레나 디 베로나에서 가장 사랑받는 푸치니의 마지막 오페라 &lt;투란도트&gt;가 찾아온다. 동화에서 가져온 소재, 신비로운 중국 음악의 선율로 그의 다른 작품들과는 차별화되어 푸치니에게 특별한 작품이며 갑작스러운 죽음으로 미완된 작품이기도 하다. 3막 1장 이후에는 작곡가 프랑코 알파노가 완성하였다. 이번 공연은 거장 영화감독 프란코 제피렐리가 베로나를 위해 만든 연출을 재현하였으며 그 무대 위에 최고의 소프라노 안나 네트렙코가 중국 공주 투란도트 역으로, 그의 배우자인 테너 유시프 에이바조프가 왕자 칼라프 역으로 오른다. 

												[베로나 오페라 페스티벌 기획전 소개]
												세계에서 가장 큰 야외 오페라 극장에서 매년 여름 열리는 아레나 오페라 페스티벌은 베르디 탄생 100주년을 기념해 1913년 시작되었다. 2천 년 전 지어진 야외 원형 극장에서 이 페스티벌은 이탈리아에서 가장 유서 깊은 축제로 자리잡았다. 현존하는 고대 원형 극장 중 가장 잘 보존된 아레나 디 베로나는 여름 밤 야외 오페라를 즐길 수 있을 뿐만 아니라, 모든 좌석에 음향이 완벽하게 전달되어 세계 오페라 애호가들의 성지로 불린다. 2023년 100번째 시즌을 맞는 페스티벌을 기념하여, 이 페스티벌에서 공연된 최신 걸작 3편을 엄선하여 기획전을 진행한다. 

												[제작]
												작곡 : 자코모 푸치니 Giacomo Puccini
												연주 : 아레나 디 베로나 오케스트라 Fondazione Arena di Verona Orchestra
												지휘 : 마르코 아르밀리아토 Marco Armiliato 
												무대연출 : 프란코 제피렐리 Franco Zeffirelli

												[출연]
												투란도트 : 안나 네트렙코 Anna Netrebko 
												황제 : 카를로 보시 Carlo Bosi 
												티무르 : 페루치오 푸르라네토 Ferruccio Furlanetto
												칼라프 : 유시프 에이바조프 Yusif Eyvazov
												류 : 마리아 테레사 레바 Maria Teresa Leva

												[주요 아리아]
												-류의 아리아 “들어보세요, 왕자님”
												-투란도트의 아리아 “이 궁전 안에서”
												-칼라프의 아리아 “아무도 잠들지 말라”
												-류의 아리아 “얼음장 같은 공주님의 마음도"
												</p>
										</a>
									</li>
									<li>
										<a href="#" title="영화상세 보기">
										<p class="bage classic">클래식소사이어티</p>
											<div class="img"><img src="/resources/main/6axAuOaqs6C9kE60Hj6SvvEqIM4jDxEO_230.jpg" alt="[베로나 오페라 페스티벌 앙코르] 카르멘" onerror="#"></div>

											<p class="tit">[베로나 오페라 페스티벌 앙코르] 카르멘</p>

											<p class="summary">
												100th 베로나 오페라 페스티벌 기념, 화제의 오페라 몰아보기
												고대 로마 원형극장에서 열리는 이탈리아의 가장 유서 깊은 축제, 베로나 오페라 페스티벌

												[상영정보]
												- 공연 명칭 : 베로나 오페라 페스티벌 – 카르멘 (앙코르, 오페라 공연으로 한글자막 제공)
												- 상영 일시 : 2023년  2월 21일(화) ~ 3월 18일(토) / 매주 화요일, 토요일
												- 공연 시간 : 약 173분 / 인터미션 없음

												[시놉시스]
												스페인의 세비야에서 위병근무를 서고 있는 하사관 돈 호세는 고향마을에 병든 어머니와 약혼녀를 둔 순진한 청년이다. 그러던 중 담배 공장에서 일하던 집시여인 카르멘이 동료와 싸워 감옥으로 가게 되고 호세가 그녀를 호송하는 임무를 맡게 된다. 카르멘의 유혹에 넘어간 호세는 고의로 그녀를 도망치게 하고 결국 집시 밀수꾼 패에 합류하며 쫓기는 신세가 된다. 이후 호세는 그녀의 마음이 투우사 에스카미요에게 있다는 것을 알게 되고, 자신의 사랑이 무참히 짓밟혀졌다는 사실에 격분한 나머지 카르멘을 칼로 찌른 후 그녀의 주검을 끌어안고 절규한다.

												[작품소개]
												“습기와 우울을 날려버리는 강렬한 태양의 오페라”로 니체의 극찬을 받은 &lt;카르멘&gt;은 조르주 비제의 대표작이자 마지막 작품이다. 19세기 스페인을 배경으로 집시 여인 카르멘과 청년 돈 호세에게 일어난 비극을 그리며, 치정과 탐욕의 서사 아래에는 당시 천대받던 집시의 삶이 사실적으로 드러난다. 이로 인해 초연 당시에는 비난받았지만, 구속보다 자유로운 죽음을 택한 카르멘은 결국 대중들의 마음을 사로잡았고 세계 각국에서 큰 인기를 끌었다. 이번 페스티벌에서는 이탈리아 출신의 거장 영화감독 프란코 제피렐리가 1995년 연출한 무대를 재현하였으며, 깊고 짙은 저음의 메조소프라노 엘리나 가랑차가 카르멘역을 맡아 기대를 모으고 있다.

												[베로나 오페라 페스티벌 기획전 소개]
												세계에서 가장 큰 야외 오페라 극장에서 매년 여름 열리는 아레나 오페라 페스티벌은 베르디 탄생 100주년을 기념해 1913년 시작되었다. 2천 년 전 지어진 야외 원형 극장에서 이 페스티벌은 이탈리아에서 가장 유서 깊은 축제로 자리잡았다. 현존하는 고대 원형 극장 중 가장 잘 보존된 아레나 디 베로나는 여름 밤 야외 오페라를 즐길 수 있을 뿐만 아니라, 모든 좌석에 음향이 완벽하게 전달되어 세계 오페라 애호가들의 성지로 불린다. 2023년 100번째 시즌을 맞는 페스티벌을 기념하여, 이 페스티벌에서 공연된 최신 걸작 3편을 엄선하여 기획전을 진행한다. 

												[제작]
												작곡: 조르주 비제 Georges Bizet
												원작: 프로스페르 메리메 Prosper Mérimée
												연주: 아레나 디 베로나 오케스트라 Fondazione Arena di Verona Orchestra
												지휘: 마르코 아르밀리아토 Marco Armiliato
												무대연출: 프란코 제피렐리 Franco Zeffirelli

												[출연]
												카르멘 Carmen, 엘리나 가랑차 Elina Garanča
												돈 호세 Don Jose, 브라이언 자그데 Brian Jagde
												에스카미요 Escamillo, 클라우디오 스쿠라 Claudio Sgura
												미카엘라 Micaela, 마리아 테레사 레바 Maria Teresa Leva
												프라스키타 Frasquita, 다니엘라 카피엘로 Daniela Cappiello
												메르세데스 Mercedes, 소피아 코베리제 Sofia Koberidze
												주니가 Zuniga, 가브리엘레 사고나 Gabriele Sagona
												모랄레스 Morales, 비아조 피주티 Biagio Pizzuti

												[주요 아리아]
												-카르멘의 하바네라 “사랑은 들새와 같아”
												-호세의 아리아 “당신이 던져 준 이 꽃은”
												-투우사의 합창 “투우사들의 행진”
												-카르멘과 호세의 피날레 2중창 “당신이오? 나요!”
												</p>
										</a>
									</li>
									</ul>

								</div>
								<!--// list-area -->

					</div>
					<!--// curation-area -->
				</div>
			</div>
			<!--// section main-curation : 큐레이션 -->

			<!-- section main-info : 메가박스 안내 -->
			<div id="main_section04" class="section main-info">

				<h2 class="tit">메가박스 안내</h2>

				<div class="swiper-container info-special swiper-container-initialized swiper-container-horizontal">
						<div class="swiper-wrapper">
							<div class="swiper-slide special-cell swiper-slide-active" style="width: 170px; margin-right: 16px;">
											<a href="#" title="DOLBY CINEMA 페이지로 이동" class="bg-dolby">DOLBY CINEMA</a>
										</div>
									<div class="swiper-slide special-cell swiper-slide-next" style="width: 170px; margin-right: 16px;">
										<a href="#" title="THE BOUTIQUE PRIVATE 페이지로 이동" class="bg-private">THE BOUTIQUE PRIVATE</a>
									</div>
								<div class="swiper-slide special-cell" style="width: 170px; margin-right: 16px;">
											<a href="#" title="THE BOUTIQUE 페이지로 이동" class="bg-boutique">THE BOUTIQUE</a>
										</div>
									<div class="swiper-slide special-cell" style="width: 170px; margin-right: 16px;">
											<a href="#" title="MX 페이지로 이동" class="bg-mx">MX</a>
										</div>
									<div class="swiper-slide special-cell" style="width: 170px; margin-right: 16px;">
											<a href="#" title="COMFORT 페이지로 이동" class="bg-comfort">COMFORT</a>
										</div>
									<div class="swiper-slide special-cell" style="width: 170px; margin-right: 16px;">
											<a href="#" title="PUPPY CINEMA 페이지로 이동" class="bg-puppy new">PUPPY CINEMA</a>
										</div>
									<div class="swiper-slide special-cell" style="width: 170px; margin-right: 16px;">
											<a href="#" title="MEGABOX KIDS 페이지로 이동" class="bg-kids">MEGABOX KIDS</a>
										</div>
									</div>
				<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>

				<div class="special-control">
					<button type="button" class="special-prev swiper-button-disabled" tabindex="0" role="button" aria-label="Previous slide" aria-disabled="true"></button>
					<button type="button" class="special-next" tabindex="0" role="button" aria-label="Next slide" aria-disabled="false"></button>
				</div>
				<!-- info-notice -->
				<div class="info-notice">
						<div class="wrap">
							<p class="tit">메가박스</p>
							<p class="link">
								<a href="/movie/list" title="공지사항 상세보기">
									<strong>
										[라이브뷰잉]
									</strong>
									 [라이브뷰잉] 아이돌리쉬 세븐 ZOOL LIVE LEGACY “APOZ”</a>
							</p>

							<p class="date">2023.02.09</p>

							<p class="more">
								<a href="/movie/list" title="전체공지 더보기">더보기 <i class="iconset ico-arr-right-gray"></i></a>
							</p>
						</div>
					</div>
				<!--// info-notice -->

				<!-- info-link -->
				<div class="info-link">
					<div class="table">
						<div class="cell">
							<a href="#" title="고객센터 페이지로 이동">
								<i class="iconset ico-main-customer"></i>
								<span>고객센터</span>
							</a>
						</div>

						<div class="cell">
							<a href="#" title="자주 묻는 질문 페이지로 이동">
								<i class="iconset ico-main-faq"></i>
								<span>자주 묻는 질문</span>
							</a>
						</div>

						<div class="cell">
							<a href="#" title="1:1 문의 페이지로 이동">
								<i class="iconset ico-main-qna"></i>
								<span>1:1 문의</span>
							</a>
						</div>

						<div class="cell">
							<a href="#" title="단체/대관문의 페이지로 이동">
								<i class="iconset ico-main-group"></i>
								<span>단체/대관문의</span>
							</a>
						</div>

						<div class="cell">
							<a href="#" title="분실물 문의/접수 페이지로 이동">
								<i class="iconset ico-main-lost"></i>
								<span>분실물 문의/접수</span>
							</a>
						</div>

						<div class="cell">
							<a href="/booking/privateBooking" title="더 부티크 프라이빗 대관예매 페이지로 이동">
								<i class="iconset ico-main-boutique"></i>
								<span>더 부티크 프라이빗<br>대관예매</span>
							</a>
						</div>
					</div>
				</div>
				<!--// info-link -->
			</div>
			<!--// section main-info : 메가박스 안내 -->

			
		</div>
	</div>
	<!--// contents -->

    </div>
<!--// container -->

<!-- 		</div> -->
        



<section id="saw_movie_regi" class="modal-layer"><a href="/" class="focus">레이어로 포커스 이동 됨</a>
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



<!-- footer -->
	<jsp:include page="layout/footer.jsp"></jsp:include>
    <!-- //footer -->

<!-- 모바일 때만 출력 -->
<div class="go-mobile" style="display: none;">
	<a href="#" data-url="/">모바일웹으로 보기 <i class="iconset ico-go-mobile"></i></a>
</div>
    </div>
    <form id="mainForm">
    </form>

<div class="normalStyle" style="display:none;position:fixed;top:0;left:0;background:#000;opacity:0.7;text-indent:-9999px;width:100%;height:100%;z-index:100;">닫기</div><div class="alertStyle" style="display:none;position:fixed;top:0px;left:0px;background:#000;opacity:0.7;width:100%;height:100%;z-index:5005;"></div></body></html>