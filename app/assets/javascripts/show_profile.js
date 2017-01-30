// a barca pai

$(document).ready(function (){
  if(document.getElementById("perfil")){
    //$('#save').hide();
        var urlMain = window.location.pathname;
        $('#infinite-scrolling').remove();
        $('#my-posts').empty();
          urlMain = urlMain + '/projetos';

          console.log(urlMain);

          $.ajax({
          url: urlMain,
          cache: false,
          success: function(html){
              $('#my-posts').append(html);
            }
          });



    $(document).on('click', '.menuNat', function(){
        var $blabla = $('#infinite-scrolling').html();

        $('#infinite-scrolling').remove();
        var urlMain = window.location.pathname;
        var $currentMenu = $(this).attr('id');
        $('.w3-btn').addClass('w3-white');
        $('.w3-btn').addClass('menuNat');
        $(this).removeClass('w3-white'); //fica escuro
        $(this).removeClass('menuNat'); 
        $('#my-posts').empty();
        $('#my-posts').append('<div class="created"></div>');
        //MENU
        if ($currentMenu === 'Projetos') {
          $('#my-posts').empty();
          urlMain = urlMain + '/projetos';
      
          console.log(urlMain);
          //$('#my-posts').after('<div id="infinite-scrolling"></div>');
          //$('#infinite-scrolling').html($blabla);
          //$('#my-posts').hide();

          $.ajax({
          url: urlMain,
          cache: false,
          success: function(html){
              $('#my-posts').append(html);
            }
          });
        }
        else if ($currentMenu === 'Impressoras') {
          $('#my-posts').empty();
          urlMain = urlMain + '/printers';
      
          console.log(urlMain);
          //$('#my-posts').hide();

          $.ajax({
          url: urlMain,
          cache: false,
          success: function(html){
              $('#my-posts').append(html);
            }
          });
        }
        else if ($currentMenu === 'Destaques') {
          $('#my-posts').empty();
          urlMain = urlMain + '/destaques';
      
          console.log(urlMain);
          //$('#my-posts').hide();

          $.ajax({
          url: urlMain,
          cache: false,
          success: function(html){
              $('#my-posts').append(html);
            }
          });
        }
        else if ($currentMenu === 'Avaliacoes') {
          $('#my-posts').empty();
          urlMain = urlMain + '/avaliacoes';
      
          console.log(urlMain);
          //$('#my-posts').hide();

          $.ajax({
          url: urlMain,
          cache: false,
          success: function(html){
              $('#my-posts').append(html);
            }
          });
        }
        else if ($currentMenu === 'Decoracao') {
          $('#my-posts').empty();
          urlMain = urlMain + '/decoracao';
      
          console.log(urlMain);
          //$('#my-posts').hide();

          $.ajax({
          url: urlMain,
          cache: false,
          success: function(html){
              $('#my-posts').append(html);
            }
          });
        }
        else if ($currentMenu === 'Moda') {
          $('#my-posts').empty();
          urlMain = urlMain + '/moda';
      
          console.log(urlMain);
          //$('#my-posts').hide();

          $.ajax({
          url: urlMain,
          cache: false,
          success: function(html){
              $('#my-posts').append(html);
            }
          });
        }
        else if ($currentMenu === 'Outros') {
          $('#my-posts').empty();
          urlMain = urlMain + '/outros';
      
          console.log(urlMain);
          //$('#my-posts').hide();

          $.ajax({
          url: urlMain,
          cache: false,
          success: function(html){
              $('#my-posts').append(html);
            }
          });
        }
        else if ($currentMenu === 'Todos') {
          $('#my-posts').empty();
          urlMain = urlMain + '/projetos';
      
          console.log(urlMain);
          //$('#my-posts').after('<div id="infinite-scrolling"></div>');
          //$('#infinite-scrolling').html($blabla);
          //$('#my-posts').hide();

          $.ajax({
          url: urlMain,
          cache: false,
          success: function(html){
              $('#my-posts').append(html);
            }
          });
        }
        else if ($currentMenu === 'Engenharia') {
          $('#my-posts').empty();
          urlMain = urlMain + '/engenharia';
      
          console.log(urlMain);
          //$('#my-posts').hide();

          $.ajax({
          url: urlMain,
          cache: false,
          success: function(html){
              $('#my-posts').append(html);
            }
          });
        };
    });
  }
});