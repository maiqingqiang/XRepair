(function () {
  var _$1 = this;

  function _4(e, n, t) {
    e.exports = t(1)(31);
  }

  function _5(e, n) {
    e.exports = vendor_f0b2c06fcc3f95d9b4a8;
  }

  function _6(e, n, t) {
    e.exports = t(1)(353);
  }

  function _7(e, n, t) {
    e.exports = t(1)(112);
  }

  function _8(e, n, t) {
    e.exports = t(1)(183);
  }

  function _9(e, n, t) {
    e.exports = t(1)(198);
  }

  function _a(e, n, t) {
    e.exports = t(1)(114);
  }

  function _b(e, n, t) {
    e.exports = t(1)(4);
  }

  function _c(e, n, t) {
    e.exports = t(1)(113);
  }

  function _d(e, n, t) {
    t(23), e.exports = t(28);
  }

  function _e(e, n, t) {
    "use strict";

    "undefined" === typeof _$1.Promise && (t(24).enable(), _$1.window.Promise = t(26)), t(27), _$1.Object.assign = t(20);
  }

  function _f(e, n, t) {
    "use strict";

    _$1.Object.defineProperty(n, "__esModule", {
      value: !0
    });

    var i = t(0),
        r = t.n(i),
        o = t(18),
        a = t.n(o),
        c = t(29),
        l = t(19),
        u = t(17),
        s = (t.n(u), t(60)),
        f = t(63),
        p = t(65),
        d = t.n(p);
    d.a.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded", r.a.Component.prototype.axios = d.a;
    var b = "localhost" === _$1.window.location.host ? "/XRepair/BackEnd/public/webapp/app/index" : "";
    a.a.render(r.a.createElement(u.Provider, s, r.a.createElement(l.a, {
      basename: b
    }, r.a.createElement("div", null, r.a.createElement(l.d, null, f.a.map(function (e, n) {
      return r.a.createElement(l.c, {
        key: n,
        path: e.path,
        exact: e.exact,
        render: e.render
      });
    }))))), _$1.document.getElementById("root")), _$1.Object(c.a)();
  }

  function _g(e, n, t) {
    "use strict";

    function i() {
      if ("serviceWorker" in navigator) {
        if (new URL("/XRepair/BackEnd/public/template/webapp/app", _$1.window.location).origin !== _$1.window.location.origin) return;

        _$1.window.addEventListener("load", function () {
          var e = "/XRepair/BackEnd/public/template/webapp/app/service-worker.js";
          a ? o(e) : r(e);
        });
      }
    }

    function r(e) {
      navigator.serviceWorker.register(e).then(function (e) {
        e.onupdatefound = function () {
          var n = e.installing;

          n.onstatechange = function () {
            "installed" === n.state && (navigator.serviceWorker.controller ? _$1.console.log("New content is available; please refresh.") : _$1.console.log("Content is cached for offline use."));
          };
        };
      }).catch(function (e) {
        _$1.console.error("Error during service worker registration:", e);
      });
    }

    function o(e) {
      fetch(e).then(function (n) {
        404 === n.status || -1 === n.headers.get("content-type").indexOf("javascript") ? navigator.serviceWorker.ready.then(function (e) {
          e.unregister().then(function () {
            _$1.window.location.reload();
          });
        }) : r(e);
      }).catch(function () {
        _$1.console.log("No internet connection found. App is running in offline mode.");
      });
    }

    n.a = i;

    var a = _$1.Boolean("localhost" === _$1.window.location.hostname || "[::1]" === _$1.window.location.hostname || _$1.window.location.hostname.match(/^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$/));
  }

  function _h(e, n, t) {
    e.exports = t(1)(12);
  }

  function _i(e, n, t) {
    e.exports = t(1)(1);
  }

  function _j(e, n, t) {
    e.exports = t(1)(110);
  }

  function _k(e, n, t) {
    e.exports = t(1)(403);
  }

  function _l(e, n, t) {
    "use strict";

    _$1.Object.defineProperty(n, "__esModule", {
      value: !0
    });

    var i = t(61),
        r = t(62);
    t.d(n, "uiStore", function () {
      return i.a;
    }), t.d(n, "userStore", function () {
      return r.a;
    });
  }

  function _m(e, n, t) {
    "use strict";

    function i(e, n, t, i) {
      t && _$1.Object.defineProperty(e, n, {
        enumerable: t.enumerable,
        configurable: t.configurable,
        writable: t.writable,
        value: t.initializer ? t.initializer.call(i) : void 0
      });
    }

    function r(e, n) {
      if (!(e instanceof n)) throw new _$1.TypeError("Cannot call a class as a function");
    }

    var o,
        a,
        c = t(15),
        l = (o = function e() {
      r(this, e), i(this, "selectedTab", a, this);
    }, a = function (e, n, t, i, r) {
      var o = {};
      return _$1.Object.keys(i).forEach(function (e) {
        o[e] = i[e];
      }), o.enumerable = !!o.enumerable, o.configurable = !!o.configurable, ("value" in o || o.initializer) && (o.writable = !0), o = t.slice().reverse().reduce(function (t, i) {
        return i(e, n, t) || t;
      }, o), r && void 0 !== o.initializer && (o.value = o.initializer ? o.initializer.call(r) : void 0, o.initializer = void 0), void 0 === o.initializer && (_$1.Object.defineProperty(e, n, o), o = null), o;
    }(o.prototype, "selectedTab", [c.observable], {
      enumerable: !0,
      initializer: function () {
        return "homeTab";
      }
    }), o),
        u = new l();
    n.a = u;
  }

  function _n(e, n, t) {
    "use strict";

    function i(e, n, t, i) {
      t && _$1.Object.defineProperty(e, n, {
        enumerable: t.enumerable,
        configurable: t.configurable,
        writable: t.writable,
        value: t.initializer ? t.initializer.call(i) : void 0
      });
    }

    function r(e, n) {
      if (!(e instanceof n)) throw new _$1.TypeError("Cannot call a class as a function");
    }

    function o(e, n, t, i, r) {
      var o = {};
      return _$1.Object.keys(i).forEach(function (e) {
        o[e] = i[e];
      }), o.enumerable = !!o.enumerable, o.configurable = !!o.configurable, ("value" in o || o.initializer) && (o.writable = !0), o = t.slice().reverse().reduce(function (t, i) {
        return i(e, n, t) || t;
      }, o), r && void 0 !== o.initializer && (o.value = o.initializer ? o.initializer.call(r) : void 0, o.initializer = void 0), void 0 === o.initializer && (_$1.Object.defineProperty(e, n, o), o = null), o;
    }

    var a,
        c,
        l,
        u = t(15),
        s = (a = function e() {
      r(this, e), i(this, "token", c, this), i(this, "isLogin", l, this);
    }, c = o(a.prototype, "token", [u.observable], {
      enumerable: !0,
      initializer: function () {
        return "123";
      }
    }), l = o(a.prototype, "isLogin", [u.observable], {
      enumerable: !0,
      initializer: function () {
        return !1;
      }
    }), a),
        f = new s();
    n.a = f;
  }

  function _o(e, n, t) {
    "use strict";

    function i(e) {
      if (_$1.Array.isArray(e)) {
        for (var n = 0, t = _$1.Array(e.length); n < e.length; n++) t[n] = e[n];

        return t;
      }

      return _$1.Array.from(e);
    }

    var r = t(0),
        o = t.n(r),
        a = t(16),
        c = t.n(a),
        l = t(64),
        u = _$1.Object.assign || function (e) {
      for (var n = 1; n < arguments.length; n++) {
        var t = arguments[n];

        for (var i in t) _$1.Object.prototype.hasOwnProperty.call(t, i) && (e[i] = t[i]);
      }

      return e;
    },
        s = [];

    s = [].concat(i(s), i(l.a));
    var f = [{
      path: "/",
      exact: !0,
      render: function (e) {
        return o.a.createElement(c.a, u({}, e, {
          component: t.e(2).then(t.bind(null, 67))
        }));
      }
    }, {
      path: "/login",
      exact: !0,
      render: function (e) {
        return o.a.createElement(c.a, u({}, e, {
          component: t.e(0).then(t.bind(null, 68))
        }));
      }
    }, {
      path: "/register",
      exact: !0,
      render: function (e) {
        return o.a.createElement(c.a, u({}, e, {
          component: t.e(0).then(t.bind(null, 69))
        }));
      }
    }, {
      path: "/about",
      exact: !0,
      render: function (e) {
        return o.a.createElement(c.a, u({}, e, {
          component: t.e(0).then(t.bind(null, 70))
        }));
      }
    }, {
      path: "/repair_list",
      exact: !0,
      render: function (e) {
        return o.a.createElement(c.a, u({}, e, {
          component: t.e(3).then(t.bind(null, 71))
        }));
      }
    }, {
      render: function (e) {
        return o.a.createElement(c.a, u({}, e, {
          component: t.e(4).then(t.bind(null, 72))
        }));
      }
    }];
    s = [].concat(i(s), f), n.a = s;
  }

  function _p(e, n, t) {
    "use strict";

    var i = t(0),
        r = t.n(i),
        o = t(16),
        a = t.n(o),
        c = _$1.Object.assign || function (e) {
      for (var n = 1; n < arguments.length; n++) {
        var t = arguments[n];

        for (var i in t) _$1.Object.prototype.hasOwnProperty.call(t, i) && (e[i] = t[i]);
      }

      return e;
    };

    n.a = [{
      path: "/general/index",
      exact: !0,
      render: function (e) {
        return r.a.createElement(a.a, c({}, e, {
          component: t.e(1).then(t.bind(null, 66))
        }));
      }
    }];
  }

  function _q(e, n, t) {
    e.exports = t(1)(164);
  }

  var _0 = this;

  var _1 = _0.webpackJsonp;

  if (_0.webpackJsonp !== _1) {
    throw new Error("Prepack model invariant violation: " + _0.webpackJsonp);
  }

  var _$0 = _1([5], [_4, _5,,, _6,,,,,,,,,,, _7, _8, _9, _a,, _b, _c, _d, _e,,,,, _f, _g,,, _h, _i, _j,,,,,,,,,,,,, _k,,,,,,,,,,,,, _l, _m, _n, _o, _p, _q], [22]);
}).call(this);