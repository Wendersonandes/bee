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
      header: '<h1>Usuários</h1>',
      suggestion: Handlebars.compile('<a href={{url}} class="media list-group-item"><span class="pull-left"><img src={{image}} class= "media-object img-circle img-notification"/></span><span class="media-body"><strong>{{completo}}</strong><small class="text-muted"></small></span></a>')
    }
  },
  {
    name: 'engine',
    displayKey: 'caption',
    source: engine.ttAdapter(),
    templates: {
      header: '<h1>Projetos</h1>',
      suggestion: Handlebars.compile('<a href={{url}} class="media list-group-item"><span class="pull-left"><img src={{image}} class= "media-object img-circle img-notification"/></span><span class="media-body"><strong>{{caption}}</strong><small class="text-muted">{{user}}</small></span></a>')
    }
    }
  );
}
 
$(document).ready(ready);
$(document).on('page:load', ready);