"use strict";function setOfCachedUrls(e){return e.keys().then(function(e){return e.map(function(e){return e.url})}).then(function(e){return new Set(e)})}var precacheConfig=[["/XRepair/BackEnd/public/template/webapp/app/index.html","6b55b0647702b1bf6e0c5ee56a4626f4"],["/XRepair/BackEnd/public/template/webapp/app/static/js/0.6d8ce997.chunk.js","ec873c5db3f2e29478bdc1b74f7ea135"],["/XRepair/BackEnd/public/template/webapp/app/static/js/0.6d8ce997.chunk.js.gz","3a11d4e2fca0f361f1b09b89266267c1"],["/XRepair/BackEnd/public/template/webapp/app/static/js/1.70ad75dd.chunk.js","74e9b9473085905039dc1cdcd6d674f8"],["/XRepair/BackEnd/public/template/webapp/app/static/js/1.70ad75dd.chunk.js.gz","035e249fd9cbb4d47bc2e04ff24d93b5"],["/XRepair/BackEnd/public/template/webapp/app/static/js/2.625284fb.chunk.js","6902705be3147fa50416168c493c1187"],["/XRepair/BackEnd/public/template/webapp/app/static/js/2.625284fb.chunk.js.gz","e4b42aadb988a6482c87cbeac8e73b34"],["/XRepair/BackEnd/public/template/webapp/app/static/js/3.ad630aa1.chunk.js","e0b4bff42591722a538db85b31b4f8e2"],["/XRepair/BackEnd/public/template/webapp/app/static/js/3.ad630aa1.chunk.js.gz","14f3d1e74fb9fd990238f9d97601404a"],["/XRepair/BackEnd/public/template/webapp/app/static/js/4.b0f082c2.chunk.js","47c742e9c647f32114f0a5bb99de1615"],["/XRepair/BackEnd/public/template/webapp/app/static/js/main.js","12914b157b46569674ce4d22078d720f"],["/XRepair/BackEnd/public/template/webapp/app/vendor.bundle.js","659c27c5d11d38883e7bd3ec6a828ee5"],["/XRepair/BackEnd/public/template/webapp/app/vendor.bundle.js.gz","91f0168be0be7eeb17047fefb4440def"],["/XRepair/BackEnd/public/template/webapp/app/vendor_f0b2c06fcc3f95d9b4a8.js","79022e270deccfbb8f87f19143a3bf94"]],cacheName="sw-precache-v3-sw-precache-webpack-plugin-"+(self.registration?self.registration.scope:""),ignoreUrlParametersMatching=[/^utm_/],addDirectoryIndex=function(e,t){var a=new URL(e);return"/"===a.pathname.slice(-1)&&(a.pathname+=t),a.toString()},cleanResponse=function(e){return e.redirected?("body"in e?Promise.resolve(e.body):e.blob()).then(function(t){return new Response(t,{headers:e.headers,status:e.status,statusText:e.statusText})}):Promise.resolve(e)},createCacheKey=function(e,t,a,n){var r=new URL(e);return n&&r.pathname.match(n)||(r.search+=(r.search?"&":"")+encodeURIComponent(t)+"="+encodeURIComponent(a)),r.toString()},isPathWhitelisted=function(e,t){if(0===e.length)return!0;var a=new URL(t).pathname;return e.some(function(e){return a.match(e)})},stripIgnoredUrlParameters=function(e,t){var a=new URL(e);return a.hash="",a.search=a.search.slice(1).split("&").map(function(e){return e.split("=")}).filter(function(e){return t.every(function(t){return!t.test(e[0])})}).map(function(e){return e.join("=")}).join("&"),a.toString()},hashParamName="_sw-precache",urlsToCacheKeys=new Map(precacheConfig.map(function(e){var t=e[0],a=e[1],n=new URL(t,self.location),r=createCacheKey(n,hashParamName,a,/\.\w{8}\./);return[n.toString(),r]}));self.addEventListener("install",function(e){e.waitUntil(caches.open(cacheName).then(function(e){return setOfCachedUrls(e).then(function(t){return Promise.all(Array.from(urlsToCacheKeys.values()).map(function(a){if(!t.has(a)){var n=new Request(a,{credentials:"same-origin"});return fetch(n).then(function(t){if(!t.ok)throw new Error("Request for "+a+" returned a response with status "+t.status);return cleanResponse(t).then(function(t){return e.put(a,t)})})}}))})}).then(function(){return self.skipWaiting()}))}),self.addEventListener("activate",function(e){var t=new Set(urlsToCacheKeys.values());e.waitUntil(caches.open(cacheName).then(function(e){return e.keys().then(function(a){return Promise.all(a.map(function(a){if(!t.has(a.url))return e.delete(a)}))})}).then(function(){return self.clients.claim()}))}),self.addEventListener("fetch",function(e){if("GET"===e.request.method){var t,a=stripIgnoredUrlParameters(e.request.url,ignoreUrlParametersMatching);(t=urlsToCacheKeys.has(a))||(a=addDirectoryIndex(a,"index.html"),t=urlsToCacheKeys.has(a));var n="/XRepair/BackEnd/public/template/webapp/app/index.html";!t&&"navigate"===e.request.mode&&isPathWhitelisted(["^(?!\\/__).*"],e.request.url)&&(a=new URL(n,self.location).toString(),t=urlsToCacheKeys.has(a)),t&&e.respondWith(caches.open(cacheName).then(function(e){return e.match(urlsToCacheKeys.get(a)).then(function(e){if(e)return e;throw Error("The cached response that was expected is missing.")})}).catch(function(t){return console.warn('Couldn\'t serve response for "%s" from cache: %O',e.request.url,t),fetch(e.request)}))}});