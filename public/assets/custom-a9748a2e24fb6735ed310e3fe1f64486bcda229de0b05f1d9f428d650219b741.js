function fullscreenFix(){var t=$("body").height();$(".content-b").each(function(){$(this).innerHeight()<=t&&$(this).closest(".fullscreen").addClass("not-overflow")})}function backgroundResize(){var t=$(window).height();$(".landing, .action, .contact, .subscribe").each(function(){var a=$(this),o=a.width(),e=a.height(),i=a.attr("data-img-width"),n=a.attr("data-img-height"),s=i/n,l=parseFloat(a.attr("data-diff"));l=l?l:0;var c=0;if(a.hasClass("parallax")&&!$("html").hasClass("touch")){c=t-e}n=e+c+l,i=n*s,o>i&&(i=o,n=i/s),a.data("resized-imgW",i),a.data("resized-imgH",n),a.css("background-size",i+"px "+n+"px")})}function parallaxPosition(){var t=$(window).height(),a=$(window).scrollTop(),o=a+t,e=(a+o)/2;$(".parallax").each(function(){var i=$(this),n=i.height(),s=i.offset().top,l=s+n;if(o>s&&a<l){var c=(i.data("resized-imgW"),i.data("resized-imgH")),r=0,d=-c+t,h=n<t?c-n:c-t;s-=h,l+=h;var u=r+(d-r)*(e-s)/(l-s),f=i.attr("data-oriz-pos");f=f?f:"50%",$(this).css("background-position",f+" "+u+"px")}})}$(function(){$("a[href*=#]:not([href=#])").click(function(){if(location.pathname.replace(/^\//,"")==this.pathname.replace(/^\//,"")||location.hostname==this.hostname){var t=$(this.hash);if(t=t.length?t:$("[name="+this.hash.slice(1)+"]"),t.length)return $("html,body").animate({scrollTop:t.offset().top},1e3),!1}})}),$("body").scrollspy({target:"#navbar-scroll"}),$(".navbar-collapse ul li a").click(function(){$(".navbar-toggle:visible").click()}),$(document).ready(function(){$("#screenshots").owlCarousel({items:4,itemsCustom:[[0,1],[480,2],[768,3],[992,4]]}),$("#owl-testi").owlCarousel({navigation:!1,slideSpeed:300,autoHeight:!0,singleItem:!0})}),$(document).ready(function(){$("#menu").sticky({topSpacing:0})}),jQuery(document).ready(function(t){t(window).load(function(){t("#preloader").fadeOut("slow",function(){t(this).remove()})})}),$(document).ready(function(){$(window).scroll(function(){$(this).scrollTop()>500?$(".scrollToTop").fadeIn():$(".scrollToTop").fadeOut()}),$(".scrollToTop").click(function(){return $("html, body").animate({scrollTop:0},800),!1})}),"ontouchstart"in window&&(document.documentElement.className=document.documentElement.className+" touch"),$("html").hasClass("touch")||$(".parallax").css("background-attachment","fixed"),$(window).resize(fullscreenFix),fullscreenFix(),$(window).resize(backgroundResize),$(window).focus(backgroundResize),backgroundResize(),$("html").hasClass("touch")||($(window).resize(parallaxPosition),$(window).scroll(parallaxPosition),parallaxPosition());