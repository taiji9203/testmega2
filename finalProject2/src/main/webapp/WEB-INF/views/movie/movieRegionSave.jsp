<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); String cp = request.getContextPath(); %>


	
<!-- header -->
<jsp:include page="../layout/headerWhite.jsp"></jsp:include>
<!--// header -->


		<div class="container has-lnb">
			<div class="page-util">
				<div class="inner-wrap" id="myLoaction">
					<div class="location">
						<span>Home</span> <a class="no-link">관리자 페이지</a> <a
							class="no-link">지역 저장</a>
					</div>
				</div>
			</div>

			<div class="inner-wrap">



				<script type="text/javascript">
$(function(){
	var url = location.pathname + location.search;
    $("div.lnb-area > nav#lnb a").filter(function(i,o) { return $(o).attr("href") == url;}).last().parent().addClass("on");

	$.get('/on/oh/ohh/MyScnBoard/selectCponMbNoCount.do')
			.done(function (data) {
				if (data.todayPubOthcomCponCnt > 0) {
					var i = $('<span>메가박스/제휴쿠폰 </span><i class="iconset ico-theater-new"></i>');

					$('#discountCoupon')
							.empty()
							.append(i);
				} else {
					// do nothing
				}
			});
});
</script>


				<div class="lnb-area">
					<nav id="lnb">
						<p class="tit">
							<a href="#">영화 관리</a>
						</p>
						<ul>
							<li class=""><a href="/movieSave">영화</a></li>
							<li class=""><a href="/movieTheaterSave">상영관</a></li>
							<li class=""><a href="/movieTotalSave">영화통합</a></li>
						</ul>
					</nav>
				</div>
				<script src="resources/createPage_files/postcode.v2.js.다운로드"></script>

				<script type="text/javascript">
    var interval;
    var m, s;

    $(function() {
        // 주소검색 버튼
        $('#addrBtn').on('click', function(e) {
            e.preventDefault();

            var target = $(this);

            // 다음 주소 API 호출
            daum.postcode.load(function() {
                new daum.Postcode({
                    oncomplete: function(d) {
                    	var extraAddr = "";

                    	if(d.bname !== '' && /[동|로|가]$/g.test(d.bname)){
                            extraAddr += d.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(d.buildingName !== '' && d.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + d.buildingName : d.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }

                        target.prev().html(d.zonecode);
                        target.next().html(d.address+extraAddr);

                        $('[name=zipcd]').val(d.zonecode);
                        $('[name=mbAddr]').val(d.address+extraAddr);
                    }
                }).open();
            });
        });

        // IPIN 인증
        $('#ipinBtn').on('click', function(e) {
            e.preventDefault();

            fn_selfCheck('ipin');
        });

        // 휴대폰 인증
        $('#phoneBtn').on('click', function(e) {
            e.preventDefault();

            fn_selfCheck('phone');
        });

        // 휴대폰번호 변경 클릭
        $('#phoneChgBtn').on('click', function() {
            $('.change-phone-num-area > div input').val('');
            $('.change-phone-num-area > div:first button').text('인증번호 전송');
            $('#timeLimit').html('');
            clearInterval(interval);
        });

        // 인증번호 발송 버튼 클릭
        $('#sendNumberBtn').on('click', function() {
            var target = $('#sendNumberBtn');

            if(target.prev().val().trim() == '')
                return gfn_alertMsgBox('변경할 휴대폰 번호를 입력해 주세요.');

            if (!target.prev().val().isHpPhoneNo())
            	return gfn_alertMsgBox('올바른 휴대폰 번호를 입력해 주세요.');


            if(target.prev().val() == $('[name=phoneNo]').val().replaceAll('-',''))
                return gfn_alertMsgBox('휴대폰 번호가 동일합니다.');

            $.ajaxMegaBox({
                url: '/on/oh/ohg/MbLogin/selectNonMbCertNoSend.rest',
                data: JSON.stringify({
                    nonMbNm: $('.mbNmClass').text(),
                    nonMbByymmdd: $('#mbByymmdd').val(),
                    nonMbTelno: target.prev().val()
                }),
                success: function (d) {
                    target.attr('data-key', d.resultMap.redisKey);

                    $('.change-phone-num-area > div:first button').text('재전송');
                    $('.change-phone-num-area > div:last').show();

                    $('#chgBtn').prev().val('');
                    $('#chkNum').val('');
                    $("#chgBtn").removeClass("disabled");
                    $("#chgBtn").attr("disabled", false);

                    clearInterval(interval);


                    gfn_alertMsgBoxSize('인증번호를 전송했습니다.\n인증번호가 도착하지 않았을 경우 재전송을 눌러 주세요.', 400, 250);

                    m = 3;
                    s = 0;

                    $('#timeLimit').html(m + ':0' + s);
                    interval = setInterval(fn_setTime, 1000);
                }
            });
        });

        // 휴대폰번호 변경 완료 버튼
        $('#chgBtn').on('click', function() {
            var telNo = $('#sendNumberBtn').prev().val();
            var certNo = $('#chkNum').val();

            var mbNo = MegaboxUtil.Form.getFormObjData($(document.forms.mbInfoForm)).mbNo;

            $.ajaxMegaBox({
                url: '/on/oh/ohg/MbLogin/selectNonMbCertNoCnfn.rest',
                data: JSON.stringify({
                    redisKey: $('#sendNumberBtn').data('key'),
                    //certNo: $(this).prev().val(),
                    certNo: certNo,
                    nonMbTelno: telNo,
                    mbNo: parseInt(mbNo)
                }),
                success: function (d) {
                    var data = d.resultMap;

                    if(data.successAt == 'Y') {
                        gfn_alertMsgBoxSize('휴대폰 번호가 변경완료 되었습니다.', 400, 250);	//휴대폰 인증을 완료

                        var no = telNo.substr(0, 3) + '-' + telNo.substr(3, 4) + '-' + telNo.substr(7, 4);

                        $('.changeVal').html(no);
                        $('[name=phoneNo]').val(no);

                        $('#phoneChgBtn').click();

                        $('#phoneChgBtn').attr("style","display: none;");

                    } else {
                        if(data.msg == 'ME019') gfn_alertMsgBox('인증번호가 일치하지 않습니다.\n인증번호를 다시 입력해주세요.'); // 인증번호 틀림
                        else if(data.msg == 'ME040') gfn_alertMsgBox('유효시간이 초과되었습니다.\n인증번호 재전송을 통해서 다시 인증해주세요.'); // 인증번호 유효시간 지남
                        else gfn_alertMsgBox('휴대폰번호 변경에 실패하였습니다.'); // 저장실패
                    }
                }
            });
        });

        // 파일 선택 후 액션
        $('#profileTarget').on('change', function(e) {
            var file = e.target.files[0];
            var filePath = $(this).val();
            var type = file.type;

            if(type.indexOf('image') == -1)
                return gfn_alertMsgBox('이미지 파일만 등록 가능합니다.');

            $.ajax({
                url: '/on/oh/ohh/Mypage/addProfile.do',
                data: new FormData(document.forms.fileForm),
				type: 'POST',
                dataType: 'json',
                processData: false,
                contentType: false,
                success: function(data) {

                	if (data.statCd != 0) {
						if( data.msg != "" ){
							gfn_alertMsgBox(data.msg);
						}else{
							gfn_alertMsgBox('프로필 사진이 등록시 오류가 발생하였습니다.');
						}

						return;
					}

					gfn_alertMsgBox({ msg: '프로필 사진이 등록되었습니다.', callback: fn_reload });
                }
            });
        });

        // 첨부파일 추가
        $('#addProfileImgBtn').on('click', function() {
            $('#profileTarget').click();
        });

        // 첨부파일 삭제
        $('#deleteProfileImgBtn').on('click', function() {
            if(!confirm('프로필 사진을 삭제하시겠습니까?')) return;

            $.ajaxMegaBox({
                 url: '/on/oh/ohh/Mypage/deleteProfile.do',
                 success: function(d) {
                     gfn_alertMsgBox({ msg: '프로필 사진이 삭제되었습니다.', callback: fn_reload });
                  }
            });
        });

        // 취소 버튼
        $('#cancelBtn').on('click', function(e) {
            location.href = '/mypage';
        });

        // 등록 버튼
        $('#updateBtn').on('click', function() {
            var form = $(document.forms.mbInfoForm);
            var validObj = [
                
                { target: '[name=phoneNo]', msg: '휴대폰 번호를 입력 해주세요.' },
                { target: '[name=mbEmail]', msg: '이메일을 입력 해주세요.' }
            ];

            if (!$('input[name="mbEmail"]').val().isEmail()) {
				gfn_alertMsgBox('이메일 형식이 잘못 되었습니다.');
				return false
			}

            if(!MegaboxUtil.Form.validRegForm(validObj))
                return false;

            $('[name=phoneNo]').val($.trim($('.changeVal').text()));

            var data = MegaboxUtil.Form.getFormObjData(form);
            data.kioskByymmddLoginSetAt = $('[name=kioskset]:checked').val();
            data.redisKey = $('#sendNumberBtn').data('key');

            // 스페셜 멤버십 가입 해지 체크
            var removeMbshipCds = '';
            var mbshipLength = $('.userMbshipList .clearfix').length - 1;

            $.each($('.userMbshipList .clearfix'), function(i, v) {
                if($(v).find('input[type=radio]:checked').val() == 'N') {
                    removeMbshipCds += $(v).data('cd');

                    if(i < mbshipLength) removeMbshipCds += ',';
                }
            });

            if(removeMbshipCds.length > 0) data.removeMbshipCds = removeMbshipCds;

            $.ajaxMegaBox({
                 url: '/on/oh/ohh/Mypage/updateUserInfo.do',
                 data: JSON.stringify(data),
                 clickLmtChk: true, //중복클릭 방지 실행
                 success: function(d) {
                    if(d.result == 'notEq') gfn_alertMsgBox('회원정보가 일치 하지않습니다.');
                    else gfn_alertMsgBox({ msg: '회원정보가 수정되었습니다.', callback: fn_mypageHome });
                 },complete: function(xhr){
 					//중복제한 초기화
 					clearLmt();
 				 }
            });
        });
    });

    // 페이지 새로고침
    function fn_reload() {
        location.reload();
    };

    function fn_mypageHome(){
    	location.href="/mypage";
    };

    // 인증번호 3분 타이머
    function fn_setTime() {
        if(m == 0 && s == 0) {
        	gfn_alertMsgBox('유효시간이 초과되었습니다.\n인증번호 재전송을 통해서 다시 인증해주세요.'); // 인증번호 유효시간 지남
            $("#chgBtn").attr("disabled", true);	//인증확인버튼 비활성
			$("#chgBtn").addClass("disabled");		//인증확인버튼 비활성

        	return clearInterval(interval);
        }

        if(s == 0) {
            s = 59;
            m -= 1;
        } else {
            s -= 1;
        }

        s = s < 10 ? '0' + s : s;

        $('#timeLimit').html(m + ':' + s);
    }

    // 본인인증 완료 후 호출
    function fn_MbSelfCertCmpl(d) {

        var newNm = d.newNm;
        var megaCertCi = d.megaCertCi;
        var niceCertCi = d.niceCertCi;

        if (megaCertCi != niceCertCi) {
        	gfn_alertMsgBox('이름 변경 대상정보가 회원님과 일치하지 않습니다.');
        } else if(newNm != undefined && newNm != $('.mbNmClass').text()) {
            $('[name=mbNm]').val(newNm);
            $('.mbNmClass').text(newNm);

            gfn_alertMsgBox('이름이 변경되었습니다.');
        } else {
            gfn_alertMsgBox('이름이 동일합니다.');
        }

        $('.btn-modal-close').click();
    }

  	//메세지 표시
    function fn_MbSelfCertMessage(param){
    	var options       = {};
    	options.msg       = param;
    	options.callback  = fn_submit;
    	options.param     = {confirm:'/main'};
    	options.minWidth  = 400;
    	options.minHeight = 250;
    	gfn_alertMsgBox(options);
    	return;
    }

    // 본인인증
    function fn_selfCheck(type) {
        var form = type == 'ipin' ? $('#ipinFrm') : $('#phoneFrm');
        var param = MegaboxUtil.Form.getInputString(form);
        var url;

        if(type == 'ipin') url = 'https://cert.vno.co.kr/ipin.cb';
        else url = 'https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb';

        window.open('', 'selfCheck', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');

        form.find('[name=param_r1]').val(param);
        form.attr('target', 'selfCheck');
        form.attr('action', url);
        form.submit();
    }

    // 첨부파일 삭제 이벤트
    function fn_bindDelBtnCheck() {
        $('.btn-del').off();
        $('.btn-del').on('click', function() {
            var idx = $(this).parent().index();

            $.ajaxMegaBox({
                url: '/on/coc/FileUpload/deleteFileUpload.do',
                data: JSON.stringify({
                    fileNo: $(this).data('no'),
                    fileSn: $(this).data('sn'),
                    physicFileDelYn: 'Y'
                }),
                success: function (d) {
                    if (Number(d.deleteCnt) > 0) {
                        $('#imgList p').eq(idx).remove();
                    }
                }
            });
        });
    }
</script>

				<div id="myLoactionInfo" style="display: none;">
					<div class="location">
						<span>Home</span> <a href="#">관리자 페이지</a> <a href="#">지역 저장</a>
					</div>
				</div>

				<div id="contents" class="">
					<h2 class="tit">지역 저장</h2>

					<div class="tit-util mt40 mb10">
						<h3 class="tit">기본정보</h3>

					</div>

					<script>
function sendIt(){
	
	var f = document.myForm;
	
	/* str = f.radio_payment.value;
	if(!str){
		alert("결제수단을 선택하세요");
		return;
	}
	
	if(str == "credit") {
		str = f.card_select.value;
		if(str == "00"){
			alert("카드를 선택하세요");
			return;
		}
	}  */
	
	f.action = "/movieSave_ok";
	f.submit();
}
</script>
					<form action="movieUpload" method="post"
						enctype="multipart/form-data" name="myForm">
						<div class="table-wrap mb40">
							<table class="board-form">
								<caption>이름, 생년월일, 휴대폰, 이메일, 비밀번호, 주소 항목을 가진 기본정보 표</caption>
								<colgroup>
									<col style="width: 180px;">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label for="regionNm_value">지역 이름</label></th>
										<td><input type="text" id="regionNm_value"
											name="regionNm_value" class="input-text w500px"></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="btn-group mt40">
							<input type="button" class="button large" value="취소" /> <input
								type="button" class="button purple large" value="등록"
								onclick="sendIt();" />
						</div>
					</form>
				</div>
				<!--// container -->
			</div>
		</div>
		<div class="quick-area" style="display: none;">
			<a href="mypage/userinfo"
				class="btn-go-top" title="top" style="position: fixed;">top</a>
		</div>
	
<!-- footer -->
<jsp:include page="../layout/footerGrey.jsp"></jsp:include>
<!--// footer -->

		<!-- 모바일 때만 출력 -->
		<div class="go-mobile" style="display: none;">
			<a href="mypage/userinfo#"
				data-url="https://m.megabox.co.kr">모바일웹으로 보기 <i
				class="iconset ico-go-mobile"></i></a>
		</div>
	</div>
	<form id="mainForm"></form>

	<div class="normalStyle"
		style="display: none; position: fixed; top: 0; left: 0; background: #000; opacity: 0.7; text-indent: -9999px; width: 100%; height: 100%; z-index: 100;">닫기</div>
	<div class="alertStyle"
		style="display: none; position: fixed; top: 0px; left: 0px; background: #000; opacity: 0.7; width: 100%; height: 100%; z-index: 5005;"></div>
	<div id="fatkun-drop-panel">
		<a id="fatkun-drop-panel-close-btn">×</a>
		<div id="fatkun-drop-panel-inner">
			<div class="fatkun-content">
				<svg class="fatkun-icon" viewBox="0 0 1024 1024" version="1.1"
					xmlns="http://www.w3.org/2000/svg" p-id="5892">
					<path
						d="M494.933333 782.933333c2.133333 2.133333 4.266667 4.266667 8.533334 6.4h8.533333c6.4 0 10.666667-2.133333 14.933333-6.4l2.133334-2.133333 275.2-275.2c8.533333-8.533333 8.533333-21.333333 0-29.866667-8.533333-8.533333-21.333333-8.533333-29.866667 0L533.333333 716.8V128c0-12.8-8.533333-21.333333-21.333333-21.333333s-21.333333 8.533333-21.333333 21.333333v588.8L249.6 475.733333c-8.533333-8.533333-21.333333-8.533333-29.866667 0-8.533333 8.533333-8.533333 21.333333 0 29.866667l275.2 277.333333zM853.333333 874.666667H172.8c-12.8 0-21.333333 8.533333-21.333333 21.333333s8.533333 21.333333 21.333333 21.333333H853.333333c12.8 0 21.333333-8.533333 21.333334-21.333333s-10.666667-21.333333-21.333334-21.333333z"
						p-id="5893"></path></svg>
				<div class="fatkun-title">Drag and Drop</div>
				<div class="fatkun-desc">The image will be downloaded</div>
			</div>
		</div>
	</div>
</body>
</html>