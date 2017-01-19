/*!
 * typeahead.js 0.11.1
 * https://github.com/twitter/typeahead.js
 * Copyright 2013-2015 Twitter, Inc. and other contributors; Licensed MIT
 */
!function(t,e){"function"==typeof define&&define.amd?define("bloodhound",["jquery"],function(n){return t.Bloodhound=e(n)}):"object"==typeof exports?module.exports=e(require("jquery")):t.Bloodhound=e(jQuery)}(this,function(t){var e=function(){"use strict";return{isMsie:function(){return/(msie|trident)/i.test(navigator.userAgent)?navigator.userAgent.match(/(msie |rv:)(\d+(.\d+)?)/i)[2]:!1},isBlankString:function(t){return!t||/^\s*$/.test(t)},escapeRegExChars:function(t){return t.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g,"\\$&")},isString:function(t){return"string"==typeof t},isNumber:function(t){return"number"==typeof t},isArray:t.isArray,isFunction:t.isFunction,isObject:t.isPlainObject,isUndefined:function(t){return"undefined"==typeof t},isElement:function(t){return!(!t||1!==t.nodeType)},isJQuery:function(e){return e instanceof t},toStr:function(t){return e.isUndefined(t)||null===t?"":t+""},bind:t.proxy,each:function(e,n){function i(t,e){return n(e,t)}t.each(e,i)},map:t.map,filter:t.grep,every:function(e,n){var i=!0;return e?(t.each(e,function(t,r){return(i=n.call(null,r,t,e))?void 0:!1}),!!i):i},some:function(e,n){var i=!1;return e?(t.each(e,function(t,r){return(i=n.call(null,r,t,e))?!1:void 0}),!!i):i},mixin:t.extend,identity:function(t){return t},clone:function(e){return t.extend(!0,{},e)},getIdGenerator:function(){var t=0;return function(){return t++}},templatify:function(e){function n(){return String(e)}return t.isFunction(e)?e:n},defer:function(t){setTimeout(t,0)},debounce:function(t,e,n){var i,r;return function(){var s,o,u=this,a=arguments;return s=function(){i=null,n||(r=t.apply(u,a))},o=n&&!i,clearTimeout(i),i=setTimeout(s,e),o&&(r=t.apply(u,a)),r}},throttle:function(t,e){var n,i,r,s,o,u;return o=0,u=function(){o=new Date,r=null,s=t.apply(n,i)},function(){var a=new Date,c=e-(a-o);return n=this,i=arguments,0>=c?(clearTimeout(r),r=null,o=a,s=t.apply(n,i)):r||(r=setTimeout(u,c)),s}},stringify:function(t){return e.isString(t)?t:JSON.stringify(t)},noop:function(){}}}(),n="0.11.1",i=function(){"use strict";function t(t){return t=e.toStr(t),t?t.split(/\s+/):[]}function n(t){return t=e.toStr(t),t?t.split(/\W+/):[]}function i(t){return function(n){return n=e.isArray(n)?n:[].slice.call(arguments,0),function(i){var r=[];return e.each(n,function(n){r=r.concat(t(e.toStr(i[n])))}),r}}}return{nonword:n,whitespace:t,obj:{nonword:i(n),whitespace:i(t)}}}(),r=function(){"use strict";function n(n){this.maxSize=e.isNumber(n)?n:100,this.reset(),this.maxSize<=0&&(this.set=this.get=t.noop)}function i(){this.head=this.tail=null}function r(t,e){this.key=t,this.val=e,this.prev=this.next=null}return e.mixin(n.prototype,{set:function(t,e){var n,i=this.list.tail;this.size>=this.maxSize&&(this.list.remove(i),delete this.hash[i.key],this.size--),(n=this.hash[t])?(n.val=e,this.list.moveToFront(n)):(n=new r(t,e),this.list.add(n),this.hash[t]=n,this.size++)},get:function(t){var e=this.hash[t];return e?(this.list.moveToFront(e),e.val):void 0},reset:function(){this.size=0,this.hash={},this.list=new i}}),e.mixin(i.prototype,{add:function(t){this.head&&(t.next=this.head,this.head.prev=t),this.head=t,this.tail=this.tail||t},remove:function(t){t.prev?t.prev.next=t.next:this.head=t.next,t.next?t.next.prev=t.prev:this.tail=t.prev},moveToFront:function(t){this.remove(t),this.add(t)}}),n}(),s=function(){"use strict";function n(t,n){this.prefix=["__",t,"__"].join(""),this.ttlKey="__ttl__",this.keyMatcher=new RegExp("^"+e.escapeRegExChars(this.prefix)),this.ls=n||u,!this.ls&&this._noop()}function i(){return(new Date).getTime()}function r(t){return JSON.stringify(e.isUndefined(t)?null:t)}function s(e){return t.parseJSON(e)}function o(t){var e,n,i=[],r=u.length;for(e=0;r>e;e++)(n=u.key(e)).match(t)&&i.push(n.replace(t,""));return i}var u;try{u=window.localStorage,u.setItem("~~~","!"),u.removeItem("~~~")}catch(a){u=null}return e.mixin(n.prototype,{_prefix:function(t){return this.prefix+t},_ttlKey:function(t){return this._prefix(t)+this.ttlKey},_noop:function(){this.get=this.set=this.remove=this.clear=this.isExpired=e.noop},_safeSet:function(t,e){try{this.ls.setItem(t,e)}catch(n){"QuotaExceededError"===n.name&&(this.clear(),this._noop())}},get:function(t){return this.isExpired(t)&&this.remove(t),s(this.ls.getItem(this._prefix(t)))},set:function(t,n,s){return e.isNumber(s)?this._safeSet(this._ttlKey(t),r(i()+s)):this.ls.removeItem(this._ttlKey(t)),this._safeSet(this._prefix(t),r(n))},remove:function(t){return this.ls.removeItem(this._ttlKey(t)),this.ls.removeItem(this._prefix(t)),this},clear:function(){var t,e=o(this.keyMatcher);for(t=e.length;t--;)this.remove(e[t]);return this},isExpired:function(t){var n=s(this.ls.getItem(this._ttlKey(t)));return e.isNumber(n)&&i()>n?!0:!1}}),n}(),o=function(){"use strict";function n(t){t=t||{},this.cancelled=!1,this.lastReq=null,this._send=t.transport,this._get=t.limiter?t.limiter(this._get):this._get,this._cache=t.cache===!1?new r(0):u}var i=0,s={},o=6,u=new r(10);return n.setMaxPendingRequests=function(t){o=t},n.resetCache=function(){u.reset()},e.mixin(n.prototype,{_fingerprint:function(e){return e=e||{},e.url+e.type+t.param(e.data||{})},_get:function(t,e){function n(t){e(null,t),h._cache.set(a,t)}function r(){e(!0)}function u(){i--,delete s[a],h.onDeckRequestArgs&&(h._get.apply(h,h.onDeckRequestArgs),h.onDeckRequestArgs=null)}var a,c,h=this;a=this._fingerprint(t),this.cancelled||a!==this.lastReq||((c=s[a])?c.done(n).fail(r):o>i?(i++,s[a]=this._send(t).done(n).fail(r).always(u)):this.onDeckRequestArgs=[].slice.call(arguments,0))},get:function(n,i){var r,s;i=i||t.noop,n=e.isString(n)?{url:n}:n||{},s=this._fingerprint(n),this.cancelled=!1,this.lastReq=s,(r=this._cache.get(s))?i(null,r):this._get(n,i)},cancel:function(){this.cancelled=!0}}),n}(),u=window.SearchIndex=function(){"use strict";function n(n){n=n||{},n.datumTokenizer&&n.queryTokenizer||t.error("datumTokenizer and queryTokenizer are both required"),this.identify=n.identify||e.stringify,this.datumTokenizer=n.datumTokenizer,this.queryTokenizer=n.queryTokenizer,this.reset()}function i(t){return t=e.filter(t,function(t){return!!t}),t=e.map(t,function(t){return t.toLowerCase()})}function r(){var t={};return t[a]=[],t[u]={},t}function s(t){for(var e={},n=[],i=0,r=t.length;r>i;i++)e[t[i]]||(e[t[i]]=!0,n.push(t[i]));return n}function o(t,e){var n=0,i=0,r=[];t=t.sort(),e=e.sort();for(var s=t.length,o=e.length;s>n&&o>i;)t[n]<e[i]?n++:t[n]>e[i]?i++:(r.push(t[n]),n++,i++);return r}var u="c",a="i";return e.mixin(n.prototype,{bootstrap:function(t){this.datums=t.datums,this.trie=t.trie},add:function(t){var n=this;t=e.isArray(t)?t:[t],e.each(t,function(t){var s,o;n.datums[s=n.identify(t)]=t,o=i(n.datumTokenizer(t)),e.each(o,function(t){var e,i,o;for(e=n.trie,i=t.split("");o=i.shift();)e=e[u][o]||(e[u][o]=r()),e[a].push(s)})})},get:function(t){var n=this;return e.map(t,function(t){return n.datums[t]})},search:function(t){var n,r,c=this;return n=i(this.queryTokenizer(t)),e.each(n,function(t){var e,n,i,s;if(r&&0===r.length)return!1;for(e=c.trie,n=t.split("");e&&(i=n.shift());)e=e[u][i];return e&&0===n.length?(s=e[a].slice(0),void(r=r?o(r,s):s)):(r=[],!1)}),r?e.map(s(r),function(t){return c.datums[t]}):[]},all:function(){var t=[];for(var e in this.datums)t.push(this.datums[e]);return t},reset:function(){this.datums={},this.trie=r()},serialize:function(){return{datums:this.datums,trie:this.trie}}}),n}(),a=function(){"use strict";function t(t){this.url=t.url,this.ttl=t.ttl,this.cache=t.cache,this.prepare=t.prepare,this.transform=t.transform,this.transport=t.transport,this.thumbprint=t.thumbprint,this.storage=new s(t.cacheKey)}var n;return n={data:"data",protocol:"protocol",thumbprint:"thumbprint"},e.mixin(t.prototype,{_settings:function(){return{url:this.url,type:"GET",dataType:"json"}},store:function(t){this.cache&&(this.storage.set(n.data,t,this.ttl),this.storage.set(n.protocol,location.protocol,this.ttl),this.storage.set(n.thumbprint,this.thumbprint,this.ttl))},fromCache:function(){var t,e={};return this.cache?(e.data=this.storage.get(n.data),e.protocol=this.storage.get(n.protocol),e.thumbprint=this.storage.get(n.thumbprint),t=e.thumbprint!==this.thumbprint||e.protocol!==location.protocol,e.data&&!t?e.data:null):null},fromNetwork:function(t){function e(){t(!0)}function n(e){t(null,r.transform(e))}var i,r=this;t&&(i=this.prepare(this._settings()),this.transport(i).fail(e).done(n))},clear:function(){return this.storage.clear(),this}}),t}(),c=function(){"use strict";function t(t){this.url=t.url,this.prepare=t.prepare,this.transform=t.transform,this.transport=new o({cache:t.cache,limiter:t.limiter,transport:t.transport})}return e.mixin(t.prototype,{_settings:function(){return{url:this.url,type:"GET",dataType:"json"}},get:function(t,e){function n(t,n){e(t?[]:r.transform(n))}var i,r=this;if(e)return t=t||"",i=this.prepare(t,this._settings()),this.transport.get(i,n)},cancelLastRequest:function(){this.transport.cancel()}}),t}(),h=function(){"use strict";function i(i){var r;return i?(r={url:null,ttl:864e5,cache:!0,cacheKey:null,thumbprint:"",prepare:e.identity,transform:e.identity,transport:null},i=e.isString(i)?{url:i}:i,i=e.mixin(r,i),!i.url&&t.error("prefetch requires url to be set"),i.transform=i.filter||i.transform,i.cacheKey=i.cacheKey||i.url,i.thumbprint=n+i.thumbprint,i.transport=i.transport?u(i.transport):t.ajax,i):null}function r(n){var i;if(n)return i={url:null,cache:!0,prepare:null,replace:null,wildcard:null,limiter:null,rateLimitBy:"debounce",rateLimitWait:300,transform:e.identity,transport:null},n=e.isString(n)?{url:n}:n,n=e.mixin(i,n),!n.url&&t.error("remote requires url to be set"),n.transform=n.filter||n.transform,n.prepare=s(n),n.limiter=o(n),n.transport=n.transport?u(n.transport):t.ajax,delete n.replace,delete n.wildcard,delete n.rateLimitBy,delete n.rateLimitWait,n}function s(t){function e(t,e){return e.url=s(e.url,t),e}function n(t,e){return e.url=e.url.replace(o,encodeURIComponent(t)),e}function i(t,e){return e}var r,s,o;return r=t.prepare,s=t.replace,o=t.wildcard,r?r:r=s?e:t.wildcard?n:i}function o(t){function n(t){return function(n){return e.debounce(n,t)}}function i(t){return function(n){return e.throttle(n,t)}}var r,s,o;return r=t.limiter,s=t.rateLimitBy,o=t.rateLimitWait,r||(r=/^throttle$/i.test(s)?i(o):n(o)),r}function u(n){return function(i){function r(t){e.defer(function(){o.resolve(t)})}function s(t){e.defer(function(){o.reject(t)})}var o=t.Deferred();return n(i,r,s),o}}return function(n){var s,o;return s={initialize:!0,identify:e.stringify,datumTokenizer:null,queryTokenizer:null,sufficient:5,sorter:null,local:[],prefetch:null,remote:null},n=e.mixin(s,n||{}),!n.datumTokenizer&&t.error("datumTokenizer is required"),!n.queryTokenizer&&t.error("queryTokenizer is required"),o=n.sorter,n.sorter=o?function(t){return t.sort(o)}:e.identity,n.local=e.isFunction(n.local)?n.local():n.local,n.prefetch=i(n.prefetch),n.remote=r(n.remote),n}}(),l=function(){"use strict";function n(t){t=h(t),this.sorter=t.sorter,this.identify=t.identify,this.sufficient=t.sufficient,this.local=t.local,this.remote=t.remote?new c(t.remote):null,this.prefetch=t.prefetch?new a(t.prefetch):null,this.index=new u({identify:this.identify,datumTokenizer:t.datumTokenizer,queryTokenizer:t.queryTokenizer}),t.initialize!==!1&&this.initialize()}var r;return r=window&&window.Bloodhound,n.noConflict=function(){return window&&(window.Bloodhound=r),n},n.tokenizers=i,e.mixin(n.prototype,{__ttAdapter:function(){function t(t,e,i){return n.search(t,e,i)}function e(t,e){return n.search(t,e)}var n=this;return this.remote?t:e},_loadPrefetch:function(){function e(t,e){return t?n.reject():(r.add(e),r.prefetch.store(r.index.serialize()),void n.resolve())}var n,i,r=this;return n=t.Deferred(),this.prefetch?(i=this.prefetch.fromCache())?(this.index.bootstrap(i),n.resolve()):this.prefetch.fromNetwork(e):n.resolve(),n.promise()},_initialize:function(){function t(){e.add(e.local)}var e=this;return this.clear(),(this.initPromise=this._loadPrefetch()).done(t),this.initPromise},initialize:function(t){return!this.initPromise||t?this._initialize():this.initPromise},add:function(t){return this.index.add(t),this},get:function(t){return t=e.isArray(t)?t:[].slice.call(arguments),this.index.get(t)},search:function(t,n,i){function r(t){var n=[];e.each(t,function(t){!e.some(s,function(e){return o.identify(t)===o.identify(e)})&&n.push(t)}),i&&i(n)}var s,o=this;return s=this.sorter(this.index.search(t)),n(this.remote?s.slice():s),this.remote&&s.length<this.sufficient?this.remote.get(t,r):this.remote&&this.remote.cancelLastRequest(),this},all:function(){return this.index.all()},clear:function(){return this.index.reset(),this},clearPrefetchCache:function(){return this.prefetch&&this.prefetch.clear(),this},clearRemoteCache:function(){return o.resetCache(),this},ttAdapter:function(){return this.__ttAdapter()}}),n}();return l}),function(t,e){"function"==typeof define&&define.amd?define("typeahead.js",["jquery"],function(t){return e(t)}):"object"==typeof exports?module.exports=e(require("jquery")):e(jQuery)}(this,function(t){var e=function(){"use strict";return{isMsie:function(){return/(msie|trident)/i.test(navigator.userAgent)?navigator.userAgent.match(/(msie |rv:)(\d+(.\d+)?)/i)[2]:!1},isBlankString:function(t){return!t||/^\s*$/.test(t)},escapeRegExChars:function(t){return t.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g,"\\$&")},isString:function(t){return"string"==typeof t},isNumber:function(t){return"number"==typeof t},isArray:t.isArray,isFunction:t.isFunction,isObject:t.isPlainObject,isUndefined:function(t){return"undefined"==typeof t},isElement:function(t){return!(!t||1!==t.nodeType)},isJQuery:function(e){return e instanceof t},toStr:function(t){return e.isUndefined(t)||null===t?"":t+""},bind:t.proxy,each:function(e,n){function i(t,e){return n(e,t)}t.each(e,i)},map:t.map,filter:t.grep,every:function(e,n){var i=!0;return e?(t.each(e,function(t,r){return(i=n.call(null,r,t,e))?void 0:!1}),!!i):i},some:function(e,n){var i=!1;return e?(t.each(e,function(t,r){return(i=n.call(null,r,t,e))?!1:void 0}),!!i):i},mixin:t.extend,identity:function(t){return t},clone:function(e){return t.extend(!0,{},e)},getIdGenerator:function(){var t=0;return function(){return t++}},templatify:function(e){function n(){return String(e)}return t.isFunction(e)?e:n},defer:function(t){setTimeout(t,0)},debounce:function(t,e,n){var i,r;return function(){var s,o,u=this,a=arguments;return s=function(){i=null,n||(r=t.apply(u,a))},o=n&&!i,clearTimeout(i),i=setTimeout(s,e),o&&(r=t.apply(u,a)),r}},throttle:function(t,e){var n,i,r,s,o,u;return o=0,u=function(){o=new Date,r=null,s=t.apply(n,i)},function(){var a=new Date,c=e-(a-o);return n=this,i=arguments,0>=c?(clearTimeout(r),r=null,o=a,s=t.apply(n,i)):r||(r=setTimeout(u,c)),s}},stringify:function(t){return e.isString(t)?t:JSON.stringify(t)},noop:function(){}}}(),n=function(){"use strict";function t(t){var o,u;return u=e.mixin({},s,t),o={css:r(),classes:u,html:n(u),selectors:i(u)},{css:o.css,html:o.html,classes:o.classes,selectors:o.selectors,mixin:function(t){e.mixin(t,o)}}}function n(t){return{wrapper:'<span class="'+t.wrapper+'"></span>',menu:'<div class="'+t.menu+'"></div>'}}function i(t){var n={};return e.each(t,function(t,e){n[e]="."+t}),n}function r(){var t={wrapper:{position:"relative",display:"inline-block"},hint:{position:"absolute",top:"0",left:"0",borderColor:"transparent",boxShadow:"none",opacity:"1"},input:{position:"relative",verticalAlign:"top",backgroundColor:"transparent"},inputWithNoHint:{position:"relative",verticalAlign:"top"},menu:{position:"absolute",top:"100%",left:"0",zIndex:"100",display:"none"},ltr:{left:"0",right:"auto"},rtl:{left:"auto",right:" 0"}};return e.isMsie()&&e.mixin(t.input,{backgroundImage:"url(data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)"}),t}var s={wrapper:"twitter-typeahead",input:"tt-input",hint:"tt-hint",menu:"tt-menu",dataset:"tt-dataset",suggestion:"tt-suggestion",selectable:"tt-selectable",empty:"tt-empty",open:"tt-open",cursor:"tt-cursor",highlight:"tt-highlight"};return t}(),i=function(){"use strict";function n(e){e&&e.el||t.error("EventBus initialized without el"),this.$el=t(e.el)}var i,r;return i="typeahead:",r={render:"rendered",cursorchange:"cursorchanged",select:"selected",autocomplete:"autocompleted"},e.mixin(n.prototype,{_trigger:function(e,n){var r;return r=t.Event(i+e),(n=n||[]).unshift(r),this.$el.trigger.apply(this.$el,n),r},before:function(t){var e,n;return e=[].slice.call(arguments,1),n=this._trigger("before"+t,e),n.isDefaultPrevented()},trigger:function(t){var e;this._trigger(t,[].slice.call(arguments,1)),(e=r[t])&&this._trigger(e,[].slice.call(arguments,1))}}),n}(),r=function(){"use strict";function t(t,e,n,i){var r;if(!n)return this;for(e=e.split(a),n=i?u(n,i):n,this._callbacks=this._callbacks||{};r=e.shift();)this._callbacks[r]=this._callbacks[r]||{sync:[],async:[]},this._callbacks[r][t].push(n);return this}function e(e,n,i){return t.call(this,"async",e,n,i)}function n(e,n,i){return t.call(this,"sync",e,n,i)}function i(t){var e;if(!this._callbacks)return this;for(t=t.split(a);e=t.shift();)delete this._callbacks[e];return this}function r(t){var e,n,i,r,o;if(!this._callbacks)return this;for(t=t.split(a),i=[].slice.call(arguments,1);(e=t.shift())&&(n=this._callbacks[e]);)r=s(n.sync,this,[e].concat(i)),o=s(n.async,this,[e].concat(i)),r()&&c(o);return this}function s(t,e,n){function i(){for(var i,r=0,s=t.length;!i&&s>r;r+=1)i=t[r].apply(e,n)===!1;return!i}return i}function o(){var t;return t=window.setImmediate?function(t){setImmediate(function(){t()})}:function(t){setTimeout(function(){t()},0)}}function u(t,e){return t.bind?t.bind(e):function(){t.apply(e,[].slice.call(arguments,0))}}var a=/\s+/,c=o();return{onSync:n,onAsync:e,off:i,trigger:r}}(),s=function(t){"use strict";function n(t,n,i){for(var r,s=[],o=0,u=t.length;u>o;o++)s.push(e.escapeRegExChars(t[o]));return r=i?"\\b("+s.join("|")+")\\b":"("+s.join("|")+")",n?new RegExp(r):new RegExp(r,"i")}var i={node:null,pattern:null,tagName:"strong",className:null,wordsOnly:!1,caseSensitive:!1};return function(r){function s(e){var n,i,s;return(n=u.exec(e.data))&&(s=t.createElement(r.tagName),r.className&&(s.className=r.className),i=e.splitText(n.index),i.splitText(n[0].length),s.appendChild(i.cloneNode(!0)),e.parentNode.replaceChild(s,i)),!!n}function o(t,e){for(var n,i=3,r=0;r<t.childNodes.length;r++)n=t.childNodes[r],n.nodeType===i?r+=e(n)?1:0:o(n,e)}var u;r=e.mixin({},i,r),r.node&&r.pattern&&(r.pattern=e.isArray(r.pattern)?r.pattern:[r.pattern],u=n(r.pattern,r.caseSensitive,r.wordsOnly),o(r.node,s))}}(window.document),o=function(){"use strict";function n(n,r){n=n||{},n.input||t.error("input is missing"),r.mixin(this),this.$hint=t(n.hint),this.$input=t(n.input),this.query=this.$input.val(),this.queryWhenFocused=this.hasFocus()?this.query:null,this.$overflowHelper=i(this.$input),this._checkLanguageDirection(),0===this.$hint.length&&(this.setHint=this.getHint=this.clearHint=this.clearHintIfInvalid=e.noop)}function i(e){return t('<pre aria-hidden="true"></pre>').css({position:"absolute",visibility:"hidden",whiteSpace:"pre",fontFamily:e.css("font-family"),fontSize:e.css("font-size"),fontStyle:e.css("font-style"),fontVariant:e.css("font-variant"),fontWeight:e.css("font-weight"),wordSpacing:e.css("word-spacing"),letterSpacing:e.css("letter-spacing"),textIndent:e.css("text-indent"),textRendering:e.css("text-rendering"),textTransform:e.css("text-transform")}).insertAfter(e)}function s(t,e){return n.normalizeQuery(t)===n.normalizeQuery(e)}function o(t){return t.altKey||t.ctrlKey||t.metaKey||t.shiftKey}var u;return u={9:"tab",27:"esc",37:"left",39:"right",13:"enter",38:"up",40:"down"},n.normalizeQuery=function(t){return e.toStr(t).replace(/^\s*/g,"").replace(/\s{2,}/g," ")},e.mixin(n.prototype,r,{_onBlur:function(){this.resetInputValue(),this.trigger("blurred")},_onFocus:function(){this.queryWhenFocused=this.query,this.trigger("focused")},_onKeydown:function(t){var e=u[t.which||t.keyCode];this._managePreventDefault(e,t),e&&this._shouldTrigger(e,t)&&this.trigger(e+"Keyed",t)},_onInput:function(){this._setQuery(this.getInputValue()),this.clearHintIfInvalid(),this._checkLanguageDirection()},_managePreventDefault:function(t,e){var n;switch(t){case"up":case"down":n=!o(e);break;default:n=!1}n&&e.preventDefault()},_shouldTrigger:function(t,e){var n;switch(t){case"tab":n=!o(e);break;default:n=!0}return n},_checkLanguageDirection:function(){var t=(this.$input.css("direction")||"ltr").toLowerCase();this.dir!==t&&(this.dir=t,this.$hint.attr("dir",t),this.trigger("langDirChanged",t))},_setQuery:function(t,e){var n,i;n=s(t,this.query),i=n?this.query.length!==t.length:!1,this.query=t,e||n?!e&&i&&this.trigger("whitespaceChanged",this.query):this.trigger("queryChanged",this.query)},bind:function(){var t,n,i,r,s=this;return t=e.bind(this._onBlur,this),n=e.bind(this._onFocus,this),i=e.bind(this._onKeydown,this),r=e.bind(this._onInput,this),this.$input.on("blur.tt",t).on("focus.tt",n).on("keydown.tt",i),!e.isMsie()||e.isMsie()>9?this.$input.on("input.tt",r):this.$input.on("keydown.tt keypress.tt cut.tt paste.tt",function(t){u[t.which||t.keyCode]||e.defer(e.bind(s._onInput,s,t))}),this},focus:function(){this.$input.focus()},blur:function(){this.$input.blur()},getLangDir:function(){return this.dir},getQuery:function(){return this.query||""},setQuery:function(t,e){this.setInputValue(t),this._setQuery(t,e)},hasQueryChangedSinceLastFocus:function(){return this.query!==this.queryWhenFocused},getInputValue:function(){return this.$input.val()},setInputValue:function(t){this.$input.val(t),this.clearHintIfInvalid(),this._checkLanguageDirection()},resetInputValue:function(){this.setInputValue(this.query)},getHint:function(){return this.$hint.val()},setHint:function(t){this.$hint.val(t)},clearHint:function(){this.setHint("")},clearHintIfInvalid:function(){var t,e,n,i;t=this.getInputValue(),e=this.getHint(),n=t!==e&&0===e.indexOf(t),i=""!==t&&n&&!this.hasOverflow(),!i&&this.clearHint()},hasFocus:function(){return this.$input.is(":focus")},hasOverflow:function(){var t=this.$input.width()-2;return this.$overflowHelper.text(this.getInputValue()),this.$overflowHelper.width()>=t},isCursorAtEnd:function(){var t,n,i;return t=this.$input.val().length,n=this.$input[0].selectionStart,e.isNumber(n)?n===t:document.selection?(i=document.selection.createRange(),i.moveStart("character",-t),t===i.text.length):!0},destroy:function(){this.$hint.off(".tt"),this.$input.off(".tt"),this.$overflowHelper.remove(),this.$hint=this.$input=this.$overflowHelper=t("<div>")}}),n}(),u=function(){"use strict";function n(n,r){n=n||{},n.templates=n.templates||{},n.templates.notFound=n.templates.notFound||n.templates.empty,n.source||t.error("missing source"),n.node||t.error("missing node"),n.name&&!u(n.name)&&t.error("invalid dataset name: "+n.name),r.mixin(this),this.highlight=!!n.highlight,this.name=n.name||c(),this.limit=n.limit||5,this.displayFn=i(n.display||n.displayKey),this.templates=o(n.templates,this.displayFn),this.source=n.source.__ttAdapter?n.source.__ttAdapter():n.source,this.async=e.isUndefined(n.async)?this.source.length>2:!!n.async,this._resetLastSuggestion(),this.$el=t(n.node).addClass(this.classes.dataset).addClass(this.classes.dataset+"-"+this.name)}function i(t){function n(e){return e[t]}return t=t||e.stringify,e.isFunction(t)?t:n}function o(n,i){function r(e){return t("<div>").text(i(e))}return{notFound:n.notFound&&e.templatify(n.notFound),pending:n.pending&&e.templatify(n.pending),header:n.header&&e.templatify(n.header),footer:n.footer&&e.templatify(n.footer),suggestion:n.suggestion||r}}function u(t){return/^[_a-zA-Z0-9-]+$/.test(t)}var a,c;return a={val:"tt-selectable-display",obj:"tt-selectable-object"},c=e.getIdGenerator(),n.extractData=function(e){var n=t(e);return n.data(a.obj)?{val:n.data(a.val)||"",obj:n.data(a.obj)||null}:null},e.mixin(n.prototype,r,{_overwrite:function(t,e){e=e||[],e.length?this._renderSuggestions(t,e):this.async&&this.templates.pending?this._renderPending(t):!this.async&&this.templates.notFound?this._renderNotFound(t):this._empty(),this.trigger("rendered",this.name,e,!1)},_append:function(t,e){e=e||[],e.length&&this.$lastSuggestion.length?this._appendSuggestions(t,e):e.length?this._renderSuggestions(t,e):!this.$lastSuggestion.length&&this.templates.notFound&&this._renderNotFound(t),this.trigger("rendered",this.name,e,!0)},_renderSuggestions:function(t,e){var n;n=this._getSuggestionsFragment(t,e),this.$lastSuggestion=n.children().last(),this.$el.html(n).prepend(this._getHeader(t,e)).append(this._getFooter(t,e))},_appendSuggestions:function(t,e){var n,i;n=this._getSuggestionsFragment(t,e),i=n.children().last(),this.$lastSuggestion.after(n),this.$lastSuggestion=i},_renderPending:function(t){var e=this.templates.pending;this._resetLastSuggestion(),e&&this.$el.html(e({query:t,dataset:this.name}))},_renderNotFound:function(t){var e=this.templates.notFound;this._resetLastSuggestion(),e&&this.$el.html(e({query:t,dataset:this.name}))},_empty:function(){this.$el.empty(),this._resetLastSuggestion()},_getSuggestionsFragment:function(n,i){var r,o=this;return r=document.createDocumentFragment(),e.each(i,function(e){var i,s;s=o._injectQuery(n,e),i=t(o.templates.suggestion(s)).data(a.obj,e).data(a.val,o.displayFn(e)).addClass(o.classes.suggestion+" "+o.classes.selectable),r.appendChild(i[0])}),this.highlight&&s({className:this.classes.highlight,node:r,pattern:n}),t(r)},_getFooter:function(t,e){return this.templates.footer?this.templates.footer({query:t,suggestions:e,dataset:this.name}):null},_getHeader:function(t,e){return this.templates.header?this.templates.header({query:t,suggestions:e,dataset:this.name}):null},_resetLastSuggestion:function(){this.$lastSuggestion=t()},_injectQuery:function(t,n){return e.isObject(n)?e.mixin({_query:t},n):n},update:function(e){function n(t){o||(o=!0,t=(t||[]).slice(0,r.limit),u=t.length,r._overwrite(e,t),u<r.limit&&r.async&&r.trigger("asyncRequested",e))}function i(n){n=n||[],!s&&u<r.limit&&(r.cancel=t.noop,u+=n.length,r._append(e,n.slice(0,r.limit-u)),r.async&&r.trigger("asyncReceived",e))}var r=this,s=!1,o=!1,u=0;this.cancel(),this.cancel=function(){s=!0,r.cancel=t.noop,r.async&&r.trigger("asyncCanceled",e)},this.source(e,n,i),!o&&n([])},cancel:t.noop,clear:function(){this._empty(),this.cancel(),this.trigger("cleared")},isEmpty:function(){return this.$el.is(":empty")},destroy:function(){this.$el=t("<div>")}}),n}(),a=function(){"use strict";function n(n,i){function r(e){var n=s.$node.find(e.node).first();return e.node=n.length?n:t("<div>").appendTo(s.$node),new u(e,i)}var s=this;n=n||{},n.node||t.error("node is required"),i.mixin(this),this.$node=t(n.node),this.query=null,this.datasets=e.map(n.datasets,r)}return e.mixin(n.prototype,r,{_onSelectableClick:function(e){this.trigger("selectableClicked",t(e.currentTarget))},_onRendered:function(t,e,n,i){this.$node.toggleClass(this.classes.empty,this._allDatasetsEmpty()),this.trigger("datasetRendered",e,n,i)},_onCleared:function(){this.$node.toggleClass(this.classes.empty,this._allDatasetsEmpty()),this.trigger("datasetCleared")},_propagate:function(){this.trigger.apply(this,arguments)},_allDatasetsEmpty:function(){function t(t){return t.isEmpty()}return e.every(this.datasets,t)},_getSelectables:function(){return this.$node.find(this.selectors.selectable)},_removeCursor:function(){var t=this.getActiveSelectable();t&&t.removeClass(this.classes.cursor)},_ensureVisible:function(t){var e,n,i,r;e=t.position().top,n=e+t.outerHeight(!0),i=this.$node.scrollTop(),r=this.$node.height()+parseInt(this.$node.css("paddingTop"),10)+parseInt(this.$node.css("paddingBottom"),10),0>e?this.$node.scrollTop(i+e):n>r&&this.$node.scrollTop(i+(n-r))},bind:function(){var t,n=this;return t=e.bind(this._onSelectableClick,this),this.$node.on("click.tt",this.selectors.selectable,t),e.each(this.datasets,function(t){t.onSync("asyncRequested",n._propagate,n).onSync("asyncCanceled",n._propagate,n).onSync("asyncReceived",n._propagate,n).onSync("rendered",n._onRendered,n).onSync("cleared",n._onCleared,n)}),this},isOpen:function(){return this.$node.hasClass(this.classes.open)},open:function(){this.$node.addClass(this.classes.open)},close:function(){this.$node.removeClass(this.classes.open),this._removeCursor()},setLanguageDirection:function(t){this.$node.attr("dir",t)},selectableRelativeToCursor:function(t){var e,n,i,r;return n=this.getActiveSelectable(),e=this._getSelectables(),i=n?e.index(n):-1,r=i+t,r=(r+1)%(e.length+1)-1,r=-1>r?e.length-1:r,-1===r?null:e.eq(r)},setCursor:function(t){this._removeCursor(),(t=t&&t.first())&&(t.addClass(this.classes.cursor),this._ensureVisible(t))},getSelectableData:function(t){return t&&t.length?u.extractData(t):null},getActiveSelectable:function(){var t=this._getSelectables().filter(this.selectors.cursor).first();return t.length?t:null},getTopSelectable:function(){var t=this._getSelectables().first();return t.length?t:null},update:function(t){function n(e){e.update(t)}var i=t!==this.query;return i&&(this.query=t,e.each(this.datasets,n)),i},empty:function(){function t(t){t.clear()}e.each(this.datasets,t),this.query=null,this.$node.addClass(this.classes.empty)},destroy:function(){function n(t){t.destroy()}this.$node.off(".tt"),this.$node=t("<div>"),e.each(this.datasets,n)}}),n}(),c=function(){"use strict";function t(){a.apply(this,[].slice.call(arguments,0))}var n=a.prototype;return e.mixin(t.prototype,a.prototype,{open:function(){return!this._allDatasetsEmpty()&&this._show(),n.open.apply(this,[].slice.call(arguments,0))},close:function(){return this._hide(),n.close.apply(this,[].slice.call(arguments,0))},_onRendered:function(){return this._allDatasetsEmpty()?this._hide():this.isOpen()&&this._show(),n._onRendered.apply(this,[].slice.call(arguments,0))},_onCleared:function(){return this._allDatasetsEmpty()?this._hide():this.isOpen()&&this._show(),n._onCleared.apply(this,[].slice.call(arguments,0))},setLanguageDirection:function(t){return this.$node.css("ltr"===t?this.css.ltr:this.css.rtl),n.setLanguageDirection.apply(this,[].slice.call(arguments,0))},_hide:function(){this.$node.hide()},_show:function(){this.$node.css("display","block")}}),t}(),h=function(){"use strict";function n(n,r){var s,o,u,a,c,h,l,f,d,p,g;n=n||{},n.input||t.error("missing input"),n.menu||t.error("missing menu"),n.eventBus||t.error("missing event bus"),r.mixin(this),this.eventBus=n.eventBus,this.minLength=e.isNumber(n.minLength)?n.minLength:1,this.input=n.input,this.menu=n.menu,this.enabled=!0,this.active=!1,this.input.hasFocus()&&this.activate(),this.dir=this.input.getLangDir(),this._hacks(),this.menu.bind().onSync("selectableClicked",this._onSelectableClicked,this).onSync("asyncRequested",this._onAsyncRequested,this).onSync("asyncCanceled",this._onAsyncCanceled,this).onSync("asyncReceived",this._onAsyncReceived,this).onSync("datasetRendered",this._onDatasetRendered,this).onSync("datasetCleared",this._onDatasetCleared,this),s=i(this,"activate","open","_onFocused"),o=i(this,"deactivate","_onBlurred"),u=i(this,"isActive","isOpen","_onEnterKeyed"),a=i(this,"isActive","isOpen","_onTabKeyed"),c=i(this,"isActive","_onEscKeyed"),h=i(this,"isActive","open","_onUpKeyed"),l=i(this,"isActive","open","_onDownKeyed"),f=i(this,"isActive","isOpen","_onLeftKeyed"),d=i(this,"isActive","isOpen","_onRightKeyed"),p=i(this,"_openIfActive","_onQueryChanged"),g=i(this,"_openIfActive","_onWhitespaceChanged"),this.input.bind().onSync("focused",s,this).onSync("blurred",o,this).onSync("enterKeyed",u,this).onSync("tabKeyed",a,this).onSync("escKeyed",c,this).onSync("upKeyed",h,this).onSync("downKeyed",l,this).onSync("leftKeyed",f,this).onSync("rightKeyed",d,this).onSync("queryChanged",p,this).onSync("whitespaceChanged",g,this).onSync("langDirChanged",this._onLangDirChanged,this)}function i(t){var n=[].slice.call(arguments,1);return function(){var i=[].slice.call(arguments);e.each(n,function(e){return t[e].apply(t,i)})}}return e.mixin(n.prototype,{_hacks:function(){var n,i;n=this.input.$input||t("<div>"),i=this.menu.$node||t("<div>"),n.on("blur.tt",function(t){var r,s,o;r=document.activeElement,s=i.is(r),o=i.has(r).length>0,e.isMsie()&&(s||o)&&(t.preventDefault(),t.stopImmediatePropagation(),e.defer(function(){n.focus()}))}),i.on("mousedown.tt",function(t){t.preventDefault()})},_onSelectableClicked:function(t,e){this.select(e)},_onDatasetCleared:function(){this._updateHint()},_onDatasetRendered:function(t,e,n,i){this._updateHint(),this.eventBus.trigger("render",n,i,e)},_onAsyncRequested:function(t,e,n){this.eventBus.trigger("asyncrequest",n,e)},_onAsyncCanceled:function(t,e,n){this.eventBus.trigger("asynccancel",n,e)},_onAsyncReceived:function(t,e,n){this.eventBus.trigger("asyncreceive",n,e)},_onFocused:function(){this._minLengthMet()&&this.menu.update(this.input.getQuery());
},_onBlurred:function(){this.input.hasQueryChangedSinceLastFocus()&&this.eventBus.trigger("change",this.input.getQuery())},_onEnterKeyed:function(t,e){var n;(n=this.menu.getActiveSelectable())&&this.select(n)&&e.preventDefault()},_onTabKeyed:function(t,e){var n;(n=this.menu.getActiveSelectable())?this.select(n)&&e.preventDefault():(n=this.menu.getTopSelectable())&&this.autocomplete(n)&&e.preventDefault()},_onEscKeyed:function(){this.close()},_onUpKeyed:function(){this.moveCursor(-1)},_onDownKeyed:function(){this.moveCursor(1)},_onLeftKeyed:function(){"rtl"===this.dir&&this.input.isCursorAtEnd()&&this.autocomplete(this.menu.getTopSelectable())},_onRightKeyed:function(){"ltr"===this.dir&&this.input.isCursorAtEnd()&&this.autocomplete(this.menu.getTopSelectable())},_onQueryChanged:function(t,e){this._minLengthMet(e)?this.menu.update(e):this.menu.empty()},_onWhitespaceChanged:function(){this._updateHint()},_onLangDirChanged:function(t,e){this.dir!==e&&(this.dir=e,this.menu.setLanguageDirection(e))},_openIfActive:function(){this.isActive()&&this.open()},_minLengthMet:function(t){return t=e.isString(t)?t:this.input.getQuery()||"",t.length>=this.minLength},_updateHint:function(){var t,n,i,r,s,u,a;t=this.menu.getTopSelectable(),n=this.menu.getSelectableData(t),i=this.input.getInputValue(),!n||e.isBlankString(i)||this.input.hasOverflow()?this.input.clearHint():(r=o.normalizeQuery(i),s=e.escapeRegExChars(r),u=new RegExp("^(?:"+s+")(.+$)","i"),a=u.exec(n.val),a&&this.input.setHint(i+a[1]))},isEnabled:function(){return this.enabled},enable:function(){this.enabled=!0},disable:function(){this.enabled=!1},isActive:function(){return this.active},activate:function(){return this.isActive()?!0:!this.isEnabled()||this.eventBus.before("active")?!1:(this.active=!0,this.eventBus.trigger("active"),!0)},deactivate:function(){return this.isActive()?this.eventBus.before("idle")?!1:(this.active=!1,this.close(),this.eventBus.trigger("idle"),!0):!0},isOpen:function(){return this.menu.isOpen()},open:function(){return this.isOpen()||this.eventBus.before("open")||(this.menu.open(),this._updateHint(),this.eventBus.trigger("open")),this.isOpen()},close:function(){return this.isOpen()&&!this.eventBus.before("close")&&(this.menu.close(),this.input.clearHint(),this.input.resetInputValue(),this.eventBus.trigger("close")),!this.isOpen()},setVal:function(t){this.input.setQuery(e.toStr(t))},getVal:function(){return this.input.getQuery()},select:function(t){var e=this.menu.getSelectableData(t);return e&&!this.eventBus.before("select",e.obj)?(this.input.setQuery(e.val,!0),this.eventBus.trigger("select",e.obj),this.close(),!0):!1},autocomplete:function(t){var e,n,i;return e=this.input.getQuery(),n=this.menu.getSelectableData(t),i=n&&e!==n.val,i&&!this.eventBus.before("autocomplete",n.obj)?(this.input.setQuery(n.val),this.eventBus.trigger("autocomplete",n.obj),!0):!1},moveCursor:function(t){var e,n,i,r,s;return e=this.input.getQuery(),n=this.menu.selectableRelativeToCursor(t),i=this.menu.getSelectableData(n),r=i?i.obj:null,s=this._minLengthMet()&&this.menu.update(e),s||this.eventBus.before("cursorchange",r)?!1:(this.menu.setCursor(n),i?this.input.setInputValue(i.val):(this.input.resetInputValue(),this._updateHint()),this.eventBus.trigger("cursorchange",r),!0)},destroy:function(){this.input.destroy(),this.menu.destroy()}}),n}();!function(){"use strict";function r(e,n){e.each(function(){var e,i=t(this);(e=i.data(g.typeahead))&&n(e,i)})}function s(t,e){return t.clone().addClass(e.classes.hint).removeData().css(e.css.hint).css(l(t)).prop("readonly",!0).removeAttr("id name placeholder required").attr({autocomplete:"off",spellcheck:"false",tabindex:-1})}function u(t,e){t.data(g.attrs,{dir:t.attr("dir"),autocomplete:t.attr("autocomplete"),spellcheck:t.attr("spellcheck"),style:t.attr("style")}),t.addClass(e.classes.input).attr({autocomplete:"off",spellcheck:!1});try{!t.attr("dir")&&t.attr("dir","auto")}catch(n){}return t}function l(t){return{backgroundAttachment:t.css("background-attachment"),backgroundClip:t.css("background-clip"),backgroundColor:t.css("background-color"),backgroundImage:t.css("background-image"),backgroundOrigin:t.css("background-origin"),backgroundPosition:t.css("background-position"),backgroundRepeat:t.css("background-repeat"),backgroundSize:t.css("background-size")}}function f(t){var n,i;n=t.data(g.www),i=t.parent().filter(n.selectors.wrapper),e.each(t.data(g.attrs),function(n,i){e.isUndefined(n)?t.removeAttr(i):t.attr(i,n)}),t.removeData(g.typeahead).removeData(g.www).removeData(g.attr).removeClass(n.classes.input),i.length&&(t.detach().insertAfter(i),i.remove())}function d(n){var i,r;return i=e.isJQuery(n)||e.isElement(n),r=i?t(n).first():[],r.length?r:null}var p,g,m;p=t.fn.typeahead,g={www:"tt-www",attrs:"tt-attrs",typeahead:"tt-typeahead"},m={initialize:function(r,l){function f(){var n,f,m,y,v,_,b,w,S,x,A;e.each(l,function(t){t.highlight=!!r.highlight}),n=t(this),f=t(p.html.wrapper),m=d(r.hint),y=d(r.menu),v=r.hint!==!1&&!m,_=r.menu!==!1&&!y,v&&(m=s(n,p)),_&&(y=t(p.html.menu).css(p.css.menu)),m&&m.val(""),n=u(n,p),(v||_)&&(f.css(p.css.wrapper),n.css(v?p.css.input:p.css.inputWithNoHint),n.wrap(f).parent().prepend(v?m:null).append(_?y:null)),A=_?c:a,b=new i({el:n}),w=new o({hint:m,input:n},p),S=new A({node:y,datasets:l},p),x=new h({input:w,menu:S,eventBus:b,minLength:r.minLength},p),n.data(g.www,p),n.data(g.typeahead,x)}var p;return l=e.isArray(l)?l:[].slice.call(arguments,1),r=r||{},p=n(r.classNames),this.each(f)},isEnabled:function(){var t;return r(this.first(),function(e){t=e.isEnabled()}),t},enable:function(){return r(this,function(t){t.enable()}),this},disable:function(){return r(this,function(t){t.disable()}),this},isActive:function(){var t;return r(this.first(),function(e){t=e.isActive()}),t},activate:function(){return r(this,function(t){t.activate()}),this},deactivate:function(){return r(this,function(t){t.deactivate()}),this},isOpen:function(){var t;return r(this.first(),function(e){t=e.isOpen()}),t},open:function(){return r(this,function(t){t.open()}),this},close:function(){return r(this,function(t){t.close()}),this},select:function(e){var n=!1,i=t(e);return r(this.first(),function(t){n=t.select(i)}),n},autocomplete:function(e){var n=!1,i=t(e);return r(this.first(),function(t){n=t.autocomplete(i)}),n},moveCursor:function(t){var e=!1;return r(this.first(),function(n){e=n.moveCursor(t)}),e},val:function(t){var e;return arguments.length?(r(this,function(e){e.setVal(t)}),this):(r(this.first(),function(t){e=t.getVal()}),e)},destroy:function(){return r(this,function(t,e){f(e),t.destroy()}),this}},t.fn.typeahead=function(t){return m[t]?m[t].apply(this,[].slice.call(arguments,1)):m.initialize.apply(this,arguments)},t.fn.typeahead.noConflict=function(){return t.fn.typeahead=p,this}}()});