(function()
{function k(a){var b=window;
   try{b.addEventListener?b.addEventListener("message",a,!1):b.attachEvent("onmessage",a)}
   catch(c){}}
 
 function r(a,b){var c=document.createElement("script");c.setAttribute("src",a);b&&(c.onload=b);h.parentNode.insertBefore(c,h)}
 function t(a,b){var c;null===b?c=a:c=a+":"+b;try{window.top.postMessage("cast.imp.joins.com:SET:"+c,"*")}catch(d){}}
 function u(a,b){function c(a){d&&clearTimeout(d);
   if(f){try{window.addEventListener?window.removeEventListener("message",f):window.detachEvent("onmessage",f)}
		 catch(e){}f=null}b(a)}
				 var d=null,f=null,f=function(b){if(f){var e=23;
			   		if("string"==typeof b.data&&"cast.imp.joins.com:VAL:"==b.data.substring(0,e)){var e=b.data.substring(e),d=e.indexOf(":");0>d?(b=e,e=null):(b=e.substring(0,d),e=e.substring(d+1));a==b&&c(e)}}};k(f);d=setTimeout(function(){c(null)},1E3);
				 try{window.top.postMessage("cast.imp.joins.com:GET:"+a,"*")}
				 catch(v){c(null)}}
function l(a,b,c,d,f){if(!m&&(m=!0,!d)){a={persona:{token:a,now:c,url:f,origin:!1},placeholder:h,insert_script:r,set:t,get:u,rid:"TaNn603DTlaXJLrljry49A",vid:b,vt:c,click:"//cast.imp.joins.com/click/nmoefdxpCIealrCBV8iwjfoJ9L5eESf80v4QOvHnGQKFpXNpbmNly0HY-Yemm7Wdo3JpZLZUYU5uNjAzRFRsYVhKTHJsanJ5NDlBo2NpZLYzVng4eWJHclQyS2EzSTJUam5IVGpRo3VpZLZ2ZUE2R2ViZlRGcWgtblFmeDZlb2RBpXJ0aW1ly0HY-ZLYYaJg/",site:"k6H7P7Rh1vh2x_thUl8aIwVJZFJTSB5OyZaNh1JqRomUCQIGBw",pref:"47B8ZO52vY_cZAaDJaiMmXfpLGGpadwB1SZ1sNXJe7eECQECAQYBBwE",query:""};window["3Vx8ybGrT2Ka3I2TjnHTjQ.cast.imp.joins.com"]=a;
	try{var g=[function($){ var container_id = $.placeholder.id;
	   var param="?_cid="+$.placeholder.id+"&_uid="+$.persona.token+"&_ref="+encodeURIComponent($.persona.url); if(container_id == ""){space = document.body;}
		   else{space = document.getElementById(container_id);}
			   var ifrmrndr = document.createElement("iframe");ifrmrndr.setAttribute("src", "//ad.imp.joins.com/html/megabox_p/main/main@main_top_1100x80_1100x600"+param);ifrmrndr.setAttribute("title", "메인 상단 배너영역");ifrmrndr.setAttribute("height", "80px");ifrmrndr.setAttribute("width", "100%");ifrmrndr.setAttribute("id", "3Vx8ybGrT2Ka3I2TjnHTjQ");ifrmrndr.setAttribute("name", "3Vx8ybGrT2Ka3I2TjnHTjQ");ifrmrndr.setAttribute("scrolling", "no");ifrmrndr.setAttribute("frameborder", "0");ifrmrndr.setAttribute("topmargin", "0");ifrmrndr.setAttribute("leftmargin", "0");ifrmrndr.setAttribute("marginwidth", "0");ifrmrndr.setAttribute("marginheight", "0");space.appendChild(ifrmrndr);}];
				for(b=0;b<g.length;b++)
				   try{g[b](a)}
						catch(e){}}
							catch(e){}}}
 function g(a){l("leVzVmI9mJHrotGMGQAk3u3f1U1EH0RC2PaUuQzpzIaEAM4qWzAZAbZ2ZUE2R2ViZlRGcWgtblFmeDZlb2RBAstB2PmHppu1nQPLQdj5h6abtZ0","",1676036961526,!1,a)}
 function n(){if(0<p)--p,q=setTimeout(n,1E3),window.top.postMessage("cast.imp.joins.com:REQ:leVzVmI9mJHrotGMGQAk3u3f1U1EH0RC2PaUuQzpzIaEAM4qWzAZAbZ2ZUE2R2ViZlRGcWgtblFmeDZlb2RBAstB2PmHppu1nQPLQdj5h6abtZ0","*");
	  else{var a=window,b=!1;
		   try{for(;a.parent.document!==a.document;)if(a.parent.document)a=a.parent;
			   else{b=!0;
				break}}
				   catch(d){b=!0}
				   if(b)
					   try{try{var c=window.top.location.href;
							   if(c)g(c);
							   else throw 0;}
						   catch(d){g("")}}
				   catch(d){g("")}
				   else g(a.location.href)}}
 var p=parseInt("3",10),h=document.getElementById("3Vx8ybGrT2Ka3I2TjnHTjQ"),m=!1,q;k(function(a){var b=23;
																								 if("string"==typeof a.data&&"cast.imp.joins.com:RES:"==a.data.substring(0,b)&&(a=a.data.substring(b).split(":",5),5==a.length)){clearTimeout(q);var b=parseInt(a[2],10),c="true"==a[3];isNaN(b)||l(a[0],a[1],
b,c,decodeURIComponent(a[4]))}});n()})();