if(typeof NetFunnel == "object"){
	NetFunnel.SkinUtil.add('megabox',{
		prepareCallback:function(){
			//var progress_print = document.getElementById("Progress_Print");
			//progress_print.innerHTML="0 % (0/0) - 0 sec";
			//넷퍼넬 페이지별 적용시 닫기 버튼 제거
			if( NetFunnel.TS_TARGET == "page" ){
				$("#NetFunnel_Skin_Top .layer-header span").css("display","none");
			}
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			//var progress_print = document.getElementById("Progress_Print");
			//var prog=totwait - nwait;
			//progress_print.innerHTML=percent+" % ("+prog+"/"+totwait+") - "+timeleft+" sec";
			var tempWidth = document.getElementById("NetFunnel_Loading_Popup_Progressbar_CUSTOM").style.width.replace("px","");
			var tempTarget = document.getElementById("NetFunnelCustomProgressbar");
            var i = tempWidth - Math.round((NetFunnel.gLastData.nwait / NetFunnel.gTotWait) * tempWidth);

            //tempTarget.style.width = i + "px";
            tempTarget.style.width = percent + "%";
            console.log(NetFunnel.gLastData.nwait +"/"+ NetFunnel.gTotWait + " : "+percent);

		},

		htmlStr:'<div id="NetFunnel_Skin_Top" style="width: 560px; background-color: #fff; padding: 29px 0px; border:1px solid #eee; box-sizing:border-box;"> \
						<div class="wrap" style="width:100%;">\
						<header class="layer-header" style=-"margin-bottom:20px;">\
							<h3 class="tit">[PC]접속대기안내</h3>\
							<span onclick="NetFunnel.countdown_stop();" style="position: absolute; right:10px; top:15px; width:18px; height:18px;background:url(/static/pc/images/common/btn/btn-layer-close.png) no-repeat 0 0"></span>\
						</header>\
						<div class="layer-con" style="margin:20px 0 0 -1px;">\
							<div class="connect-waiting">\
								 \
								<div class="counting">\
									<i class="iconset ico-connect-waiting"></i>\
									<div class="count">\
										<p class="tit">대기인원</p>\
										<p class="txt">\
											<em id="NetFunnel_Loading_Popup_Count">230</em>\
											<span>명</span>\
										</p>\
									</div>\
								</div>\
								<div class="box-gray">\
									<p class="txt">\
										페이지 사용량이 많아 접속이 지연되고 있습니다.<br />\
										잠시만 기다려 주세요.\
									</p>\
									<div id="NetFunnel_Loading_Popup_Progressbar_CUSTOM" class="graph-bar">\
										<!-- 접근성 : em 안의 숫자도 실시간으로 바꿔줘야 합니다. -->\
										<div id="NetFunnelCustomProgressbar" class="bar" style="width:100%">\
											<span><em>33.333</em> &#37;</span>\
										</div>\
									</div>\
								</div>\
								<p class="info">\
									※ 새로고침 또는 뒤로가기를 하시면 대기 시간이 다시 부여됩니다.\
								</p>\
							</div>\
						</div>\
					</div>\
				</div>'

	},'normal');

	NetFunnel.SkinUtil.add('megaboxMobile',{
		prepareCallback:function(){
			//var progress_print = document.getElementById("Progress_Print");
			//progress_print.innerHTML="0 % (0/0) - 0 sec";
			//넷퍼넬 페이지별 적용시 닫기 버튼 제거
			if( NetFunnel.TS_TARGET == "page" ){
				$("#NetFunnel_Skin_Top .iconset.ico-p-close").css("display", "none");
			}

			//앱 로딩바 제거
			if((typeof AppHandler) == undefined){
				AppHandler.Common.stopLoadingBar();
			}
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			//var progress_print = document.getElementById("Progress_Print");
			//var prog=totwait - nwait;
			//progress_print.innerHTML=percent+" % ("+prog+"/"+totwait+") - "+timeleft+" sec";
			var tempWidth = document.getElementById("NetFunnel_Loading_Popup_Progressbar_CUSTOM").style.width.replace("px","");
			var tempTarget = document.getElementById("NetFunnelCustomProgressbar");
            var i = tempWidth - Math.round((NetFunnel.gLastData.nwait / NetFunnel.gTotWait) * tempWidth);

            tempTarget.style.width = percent + "%";
            console.log(NetFunnel.gLastData.nwait +"/"+ NetFunnel.gTotWait);

            if( $(".event-detail-cont").length > 0 ){
            	$("#NetFunnel_Skin_Top").parent().addClass("net-wrap");
            }
		},

		htmlStr:'<div id="NetFunnel_Skin_Top" style="width:320px; height:310px;"> \
						<div class="wrap delay" style="width:100%;">\
						<header class="title-area">\
							<p class="tit">접속대기안내</p>\
							<span onclick="NetFunnel.countdown_stop();controlAction.off();" title="닫기" class="btn-close"><i class="iconset ico-p-close"></i></span>\
						</header>\
						<div class="layer-cont">\
							<div class="delay-wrap">\
								<p class="tit">대기인원</p>\
								<p class="peaple"><span class="font-roboto" id="NetFunnel_Loading_Popup_Count">230</span><em>명</em></p>\
								<div class="delay-bar" id="NetFunnel_Loading_Popup_Progressbar_CUSTOM"><span id="NetFunnelCustomProgressbar" class="bar" style="width:100%;"></span></div>\
							</div>\
							<ul class="star-list">\
								<li>페이지 사용량이 많아 접속이 지연되고 있습니다.<br>잠시 기다려 주세요.</li>\
								<li>새로고침 또는 뒤로가기를 하시면 대기 시간이 다시 부여됩니다.</li>\
							</ul>\
						</div>\
					</div>\
				</div>'

	},'normal');
}