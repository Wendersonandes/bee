var ready;
ready = function() {
  var engine = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("caption"),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    //prefetch: '../posts/autocompletepre',
    remote: {
      url: '../posts/autocomplete?query=%QUERY',
      wildcard: '%QUERY'
    }
  });
    var engine2 = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("completo"),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    //prefetch: '../posts/autocompletepre2',
    remote: {
      url: '../posts/autocomplete2?query=%QUERY',
      wildcard: '%QUERY'
    }
  });
 
  var promise = engine.initialize();
  var promise2 = engine2.initialize();
 
  promise
  .done(function() { console.log('success!'); })
  .fail(function() { console.log('err!'); });
 
  $('.typeahead').typeahead({
    highlight: true
  },
  {
    name: 'engine2',
    displayKey: 'completo',
    source: engine2.ttAdapter(),
    templates: {
      header: '<h3 style="margin:5px;">Usuários</h3>',
      suggestion: Handlebars.compile('\
        <a href={{url}} class="media list-group-item">\
          <span class="pull-left" style="border: 0px solid black;">\
          <img src={{image}} class= "media-object img-circle img-notification"/>\
          </span>\
          <span class="media-body" style="text-align:left;padding-top:11px;vertical-align: middle;border: 0px solid black;text-transform:capitalize;margin:0px;">\
          <strong>{{completo}}</strong>\
          <small class="text-muted"></small>\
          </span>\
        </a>')
    }
  },
  {
    name: 'engine',
    displayKey: 'caption',
    source: engine.ttAdapter(),
    templates: {
      header: '<h3 style="margin:5px;">Projetos</h3>',
      suggestion: Handlebars.compile('<a href={{url}} class="media list-group-item">\
        <span class="pull-left">\
        <img src={{image}} class= "media-object img-circle img-notification"/>\
        </span>\
        <span class="media-body" style="text-align:left;padding-top:11px;vertical-align: middle;border: 0px solid black;text-transform:capitalize;margin:0px;">\
        <strong>{{caption}}</strong>\
        <small class="text-muted">{{user}}</small>\
        </span>\
        </a>')
    }
    }
  );
}
 
$(document).ready(ready);
$(document).on('page:load', ready);