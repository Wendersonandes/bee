var ready;ready=function(){var e=new Bloodhound({datumTokenizer:Bloodhound.tokenizers.obj.whitespace("caption"),queryTokenizer:Bloodhound.tokenizers.whitespace,remote:{url:"../posts/autocomplete?query=%QUERY",wildcard:"%QUERY"}}),o=new Bloodhound({datumTokenizer:Bloodhound.tokenizers.obj.whitespace("completo"),queryTokenizer:Bloodhound.tokenizers.whitespace,remote:{url:"../posts/autocomplete2?query=%QUERY",wildcard:"%QUERY"}}),a=e.initialize();o.initialize();a.done(function(){console.log("success!")}).fail(function(){console.log("err!")}),$(".typeahead").typeahead({highlight:!0},{name:"engine2",displayKey:"completo",source:o.ttAdapter(),templates:{header:"<h1>Usu\xe1rios</h1>",suggestion:Handlebars.compile('<a href={{url}} class="media list-group-item"><span class="pull-left"><img src={{image}} class= "media-object img-circle img-notification"/></span><span class="media-body"><strong>{{completo}}</strong><small class="text-muted"></small></span></a>')}},{name:"engine",displayKey:"caption",source:e.ttAdapter(),templates:{header:"<h1>Projetos</h1>",suggestion:Handlebars.compile('<a href={{url}} class="media list-group-item"><span class="pull-left"><img src={{image}} class= "media-object img-circle img-notification"/></span><span class="media-body"><strong>{{caption}}</strong><small class="text-muted">{{user}}</small></span></a>')}})},$(document).ready(ready),$(document).on("page:load",ready);