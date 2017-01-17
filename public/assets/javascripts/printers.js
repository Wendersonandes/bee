jQuery(function() {
  var states;
  states = $('#printer_modelo').html();
  console.log(states);
  return $('#printer_marca').change(function() {
    var country, escaped_country, options;
    country = $('#printer_marca :selected').text();
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
    options = $(states).filter("optgroup[label=" + escaped_country + "]").html();
    console.log(options);
    if (options) {
      $('#printer_modelo').html(options);
      return $('#printer_modelo').parent().show();
    } else {
      $('#printer_modelo').empty();
      return $('#printer_modelo').parent().hide();
    }
  });
});