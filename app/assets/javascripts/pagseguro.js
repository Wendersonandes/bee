$( document ).ready(function() {
  // Inicia o PagSeguro
  if(document.getElementById("carrinho")){
  PagSeguroDirectPayment.setSessionId($("#session_id").val());
 
  // Verifica se existe um cartão preenchido
  card_flag();
  verificacao();
  // Pega o Sender Hash e o Card Token quando o usuário confirma os dados do cartão
  $("#buy-button").click(function() {
    $('#sender_hash').val(PagSeguroDirectPayment.getSenderHash());
 
    var params = {
     cardNumber: $("#card-number").val(),
     cvv: $("#card-cvv").val(),
     expirationMonth: $("#card-month").val(),
     expirationYear: $("#card-year").val(),
     success: function (response) {
       //token gerado, esse deve ser usado na chamada da API do Checkout Transparente
       $('#card_token').val(response['card']['token']);
       $('#payment-datas').hide();
       $('#finish-buy').fadeIn();
     },
     error: function (response) {
       alert('As informações sobre o cartão estão incorretas')
     }
    }
 
    PagSeguroDirectPayment.createCardToken(params);
  });
 
  // Muda do step de finalização para o step de edição do meio de pagamento
  $("#edit-payment").click(function() {
    $('#finish-buy').hide();
    $('#payment-datas').fadeIn();
  });
 
  // Verifica informações sobre o cartão digitado como a bandeira
  //, tamanho do cvv, se possui expiração de é internacional e etc
  $("#card-number").on('input', function() {
    card_flag();
  });
}
});

//--------------------------------------------------- VERIFICACAO DINAMICA -------------------------------------------
function bloqueio(){
  var stringBloq = $('.erro_bloq').attr('class');
  if (stringBloq == 'erro_bloq') {
    $('#buy-button').prop( "disabled", true );
  }else{
    $('#buy-button').prop( "disabled", false );
  };
}

 function verificacao()
{
  
  var stringAtual;
  var inputAtual;
  
  $(document).on('keyup click', 'input:focus', function(){
    var erro = 0;
    inputAtual = $(this).attr('name');
    stringAtual = $(this).val();
    console.log(inputAtual);
    console.log(stringAtual);

    //DADOS PESSOAIS DO COMPRADOR
    if (inputAtual == "name") {
      erro = apenasLetras(stringAtual);
      msgDeErro(erro, 'erro_name', "*Numeros e Caracteres especiais não são permitidos");
    }
    else if (inputAtual == "email") {
      erro = apenasEmail(stringAtual);
      msgDeErro(erro, 'erro_email', "*Formato de email inválido");
    }
    else if (inputAtual == "cpf") {
      erro = apenasNum(stringAtual);
      msgDeErro(erro, 'erro_cpf', "*Utilize apenas numeros");
    }
    else if (inputAtual == "phone_code") {
      erro = apenasNum(stringAtual);
      msgDeErro(erro, 'erro_phone_code', "*Utilize apenas numeros");
    }
    else if (inputAtual == "phone_number") {
      erro = apenasNum(stringAtual);
      msgDeErro(erro, 'erro_phone_number', "*Utilize apenas numeros");
    }
    else if (inputAtual == "birthday") {
      erro = apenasData(stringAtual);
      msgDeErro(erro, 'erro_birthday', "*Formato inválido");
    }
    //ENDERECO DO COMPRADOR
    else if (inputAtual == "street") {
      erro = apenasNumLetra(stringAtual);
      msgDeErro(erro, 'erro_street', "me fode!");
    }
    else if (inputAtual == "number") { //não obrigatorio
      erro = apenasNum(stringAtual);
      msgDeErro(erro, 'erro_number', "*Utilize apenas numeros");
    }
    else if (inputAtual == "complement") { //não obrigatorio
      erro = apenasNumLetra(stringAtual);
      msgDeErro(erro, 'erro_complement', "me fode!");
    }
    else if (inputAtual == "district") {
      erro = apenasLetras(stringAtual);
      msgDeErro(erro, 'erro_district', "*Numeros e Caracteres especiais não são permitidos");
    }
    else if (inputAtual == "city") {
      erro = apenasLetras(stringAtual);
      msgDeErro(erro, 'erro_city', "*Numeros e Caracteres especiais não são permitidos");
    }
    else if (inputAtual == "state") {
      erro = apenasLetras(stringAtual);
      msgDeErro(erro, 'erro_state', "*Numeros e Caracteres especiais não são permitidos");
    }
    else if (inputAtual == "postal_code") {
      erro = apenasNum(stringAtual);
      msgDeErro(erro, 'erro_postal_code', "*Utilize apenas numeros");
    }
    //DADOS DO CARTAO
    else if (inputAtual == "card_name") {
      erro = apenasLetras(stringAtual);
      msgDeErro(erro, 'erro_card_name', "*Numeros e Caracteres especiais não são permitidos");
    }
    else if (inputAtual == "card-number") {
      erro = apenasNum(stringAtual);
      msgDeErro(erro, 'erro_card-number', "*Utilize apenas numeros");
    }

    bloqueio();
  });
  $(document).on('click', '#card-options', function(){
    var parcela;
    var valorParcela;
    var valorTotal;
    ParcelaCartao(parcela, valorParcela, valorTotal);
  });
}

function apenasEmail(stringAtual)
{
  var erro = 0;
  var arroba = stringAtual.indexOf("@");
  var pontoCom = stringAtual.indexOf(".com");
  var pontoOrg = stringAtual.indexOf(".org");
  var pontoNet = stringAtual.indexOf(".net");

  if ((stringAtual.length >0)&&((arroba == -1)||((pontoCom == -1)&&(pontoOrg == -1)&&(pontoNet == -1)))) {
    erro = -1;
  };

  return erro;
}

function apenasData(stringAtual)
{
  var erro = 0;
  if ((stringAtual[0] >= '0')&&(stringAtual[0] <= '9')&&
    (stringAtual[1] >= '0')&&(stringAtual[1] <= '9')&&
    (stringAtual[3] >= '0')&&(stringAtual[3] <= '9')&&
    (stringAtual[4] >= '0')&&(stringAtual[4] <= '9')&&
    (stringAtual[6] >= '0')&&(stringAtual[6] <= '9')&&
    (stringAtual[7] >= '0')&&(stringAtual[7] <= '9')&&
    (stringAtual[8] >= '0')&&(stringAtual[8] <= '9')&&
    (stringAtual[9] >= '0')&&(stringAtual[9] <= '9')&&
    (stringAtual[2] == '/')&&(stringAtual[5] == '/')) {
    //ok
  }else{
    erro = -1;
  };

  return erro;
}

function apenasLetras(stringAtual)
{
  var letra;
  var erro = 0;
  for (var i = 0; i < stringAtual.length; i++) {
    letra = stringAtual[i];
    if (((letra >= 'A')&&(letra <= 'Z'))||((letra >= 'a')&&(letra <= 'z'))||(letra == ' ')) {
      //tudo ok!
    }else{
      erro = erro - 1;
    }; 
  };
  return erro;
}

function apenasNum(stringAtual)
{
  var letra;
  var erro = 0;
  for (var i = 0; i < stringAtual.length; i++) {
    letra = stringAtual[i];
    if ((letra >= '0')&&(letra <= '9')) {
      //tudo ok!
    }else{
      erro = erro - 1;
    }; 
  };
  return erro;
}

function apenasNumLetra(stringAtual)
{
  var letra;
  var erro = 0;
  for (var i = 0; i < stringAtual.length; i++) {
    letra = stringAtual[i];
    if (((letra >= 'A')&&(letra <= 'Z'))||((letra >= 'a')&&(letra <= 'z'))||(letra == ' ')||((letra >= '0')&&(letra <= '9'))) {
      //tudo ok!
    }else{
      erro = erro - 1;
    }; 
  };
  return erro;
}


function msgDeErro(erro, id, texto)
{
  $('#'+id).remove();
  if (erro < 0) {
    $('input:focus').parent().after('<p1 class="erro_bloq" id="'+id+'" style="color:red;">'+texto+'</p1>');
  }
}

function msgDeVazio(erro, campo, id, texto)
{
  $('#'+id).remove();
  if (erro < 0) {
    $(campo).parent().after('<p1 class="erro_bloq" id="'+id+'" style="color:red;">'+texto+'</p1>');
  }
}

function getNumber(subString, stringCompleta)
{
  var local = 0;

  local = stringCompleta.indexOf(subString);
  local = local + subString.length;

  console.log('teste:'+local);
  if (local !== -1) {
    var number = '';
    console.log('LADY2');
    while((((stringCompleta[local] >= '0')&&(stringCompleta[local] <= '9'))||(stringCompleta[local] == '.'))&&(local <= stringCompleta.length)){
      number = number + stringCompleta[local];
      local++;
    }
    console.log('testeN:'+number);
  };
  return number;
}

function ParcelaCartao(parcela, valorParcela, valorTotal)
{
  if ($('#card-options-box').css('display') != 'none') {
    var string = $('#card-options :selected').text();
    console.log('LADY GAGA'+string);
    valorParcela = getNumber("$", string);
    parcela = getNumber("x ", string);
    valorTotal = getNumber(": $", string);

    console.log(parcela, valorParcela);
    $('#parcela').val(valorParcela);
    $('#quantidade').val(parcela);
    console.log($('#quantidade').val(), $('#parcela').val());
  }; 
}


 //--------------------------------------------------------------------------------------------------------------------------------

function card_flag()
{
  PagSeguroDirectPayment.getBrand({
   cardBin: $("#card-number").val(),
   success: function (response) {
     console.log(response);
     //Coloca qual a bandeira ao lado do numero
     $("#card-flag").html(response['brand']['name']);
     $("#card-flag").show();
     //Mostra as opções de parcelamento (passando o preço e a bandeira)
     showPaymentOptions(response['brand']['name'], $("#price").val());
     $("#card-options-box").show();
     //Mostra o campo CVV se o cartão exigir
     if(response['brand']['cvvSize'] > 0){$("#card-cvv-box").show();}
   },
   error: function (response) {
     console.log($("#card-number").val());
     console.log(response);
     $("#card-flag").hide();
     $("#card-cvv-box").hide();
     $("#card-options-box").hide();
   }
  });
}
 
//Função para pegar o token do cartão de crédito que será usado no checkout
function getCardToken(card_number, cvv, month, year){
  console.log(month);
  console.log(year);
  var params = {
    cardNumber: card_number,
    cvv: cvv,
    expirationMonth: month,
    expirationYear: year,
    success: function (response) {
      console.log(response);
    },
    error: function (response) {
      console.log(response);
    }
  }
 
  PagSeguroDirectPayment.createCardToken(params);
}
 
// Função para mostrar opções de pagamento para o usuário
function showPaymentOptions(flag, price)
{
  PagSeguroDirectPayment.getInstallments({
   amount: price,
   brand: flag,
   success: function (response) {
     $("#card-options").html("");
     $.each( response['installments'][flag], function( index, value ){
       $("#card-options")
       .append($("<option></option>")
                  .attr("value",value['quantity'])
                  .text("$"+value['installmentAmount']+" x "+value['quantity']+" - total: $"+value['totalAmount']));
     });
   },
   error: function (response) {
     console.log(response);
   },
   complete: function (response) {
     //tratamento comum para todas chamadas
   }
 });
}