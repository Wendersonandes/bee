$(document).ready(function(){if(document.getElementById("perfil")){var s=window.location.pathname;$("#infinite-scrolling").remove(),$("#my-posts").empty(),s+="/projetos",console.log(s),$.ajax({url:s,cache:!1,success:function(s){$("#my-posts").append(s)}}),$(document).on("click",".menuNat",function(){$("#infinite-scrolling").html();$("#infinite-scrolling").remove();var s=window.location.pathname,o=$(this).attr("id");$(".w3-btn").addClass("w3-white"),$(".w3-btn").addClass("menuNat"),$(this).removeClass("w3-white"),$(this).removeClass("menuNat"),$("#my-posts").empty(),$("#my-posts").append('<div class="created"></div>'),"Projetos"===o?($("#my-posts").empty(),s+="/projetos",console.log(s),$.ajax({url:s,cache:!1,success:function(s){$("#my-posts").append(s)}})):"Impressoras"===o?($("#my-posts").empty(),s+="/printers",console.log(s),$.ajax({url:s,cache:!1,success:function(s){$("#my-posts").append(s)}})):"Destaques"===o?($("#my-posts").empty(),s+="/destaques",console.log(s),$.ajax({url:s,cache:!1,success:function(s){$("#my-posts").append(s)}})):"Avaliacoes"===o?($("#my-posts").empty(),s+="/avaliacoes",console.log(s),$.ajax({url:s,cache:!1,success:function(s){$("#my-posts").append(s)}})):"Decoracao"===o?($("#my-posts").empty(),s+="/decoracao",console.log(s),$.ajax({url:s,cache:!1,success:function(s){$("#my-posts").append(s)}})):"Moda"===o?($("#my-posts").empty(),s+="/moda",console.log(s),$.ajax({url:s,cache:!1,success:function(s){$("#my-posts").append(s)}})):"Outros"===o?($("#my-posts").empty(),s+="/outros",console.log(s),$.ajax({url:s,cache:!1,success:function(s){$("#my-posts").append(s)}})):"Todos"===o?($("#my-posts").empty(),s+="/projetos",console.log(s),$.ajax({url:s,cache:!1,success:function(s){$("#my-posts").append(s)}})):"Engenharia"===o&&($("#my-posts").empty(),s+="/engenharia",console.log(s),$.ajax({url:s,cache:!1,success:function(s){$("#my-posts").append(s)}}))})}});