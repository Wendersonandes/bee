jQuery(function(){$("#infinite-scrolling").size()>0&&$(window).on("scroll",function(){var i;i=$("#infinite-scrolling a.next_page").attr("href"),i&&$(window).scrollTop()>$(document).height()-$(window).height()-240&&($(".pagination").html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..."/>'),$.getScript(i,function(){}))})});