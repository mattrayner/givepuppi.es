(function() {
  this.DomInjector = (function() {
    function DomInjector(delay, success_callback, fail_callback, url) {
      var error_handler, _base, _ref;
      if (url == null) {
        url = null;
      }
      console.log('hi');
      this.delay = delay;
      this.success_callback = success_callback;
      this.fail_callback = fail_callback;
      this.url = typeof (_base = url === null) === "function" ? _base({
        'http://givepuppi.es/api/v1/puppies?callback=this.give_puppies.api_return': url
      }) : void 0;
      this.document_head_available();
      if (!this.document_head) {
        return false;
      }
      this.inject_script = document.createElement('script');
      error_handler = function() {
        if (!this.inject_script.data('error')) {
          this.inject_script.data('error', true);
          this.inject_script.id = 'failed';
          return this.fail_callback();
        }
      };
      setTimeout(function() {
        var blank_function, e, error_function, _ref, _ref1;
        console.log('timeout fired');
        blank_function = function() {};
        error_function = function() {
          return console.log('GivePuppi.es error: Cannot load resource ' + url);
        };
        this.success_callback = (_ref = typeof success_callback === 'function') != null ? _ref : {
          success_callback: blank_function
        };
        this.fail_callback = (_ref1 = typeof fail_callback === 'function') != null ? _ref1 : {
          fail_callback: error_function
        };
        console.log('inject');
        console.log(this.setup_inject_script);
        console.log(setup_inject_script);
        this.setup_inject_script(this.inject_script);
        console.log('injected');
        if (this.inject_script === null) {
          this.fail_callback();
          return false;
        }
        try {
          return this.document_head.appendChild(this.inject_script);
        } catch (_error) {
          e = _error;
          return error_handler();
        }
      }, (_ref = typeof delay === 'number') != null ? _ref : {
        delay: 1
      });
    }

    DomInjector.prototype.setup_inject_script = function(script) {
      if (typeof script !== 'object') {
        return false;
      }
      script.type = 'text/javascript';
      script.async = true;
      script.charset = 'utf-8';
      this.add_event(script, 'error', function() {
        return this.error_handler();
      });
      this.timer(15, this.delay, function() {
        return script.id === 'loaded';
      }, function() {
        if (script.id !== 'loaded') {
          return this.error_handler();
        }
      });
      return script.src = this.url;
    };

    DomInjector.prototype.add_event = function(object, event, callback) {
      if ((typeof object === 'object') || (typeof event === 'string') || (typeof callback === 'function')) {
        if (object.addEventListener) {
          object.addEventListener(event, callback, false);
          return true;
        }
        if (object.attachEvent) {
          object.attachEvent("on" + event, callback);
          return true;
        }
      }
      return false;
    };

    DomInjector.prototype.timer = function(iterations, delay, tick_function, complete_function) {
      var _ref, _ref1;
      if (iterations > 1) {
        return setTimeout(function() {
          if (typeof tick_function === 'function') {
            tick_function();
          }
          return this.timer(iterations - 1, delay, tick_function, complete_function);
        }, (_ref = typeof delay === 'number') != null ? _ref : {
          delay: 1
        });
      } else if (typeof complete_function === 'function') {
        return setTimeout(function() {
          return complete_function();
        }, (_ref1 = typeof delay === 'number') != null ? _ref1 : {
          delay: 1
        });
      }
    };

    DomInjector.prototype.document_head_available = function() {
      return this.document_head = document.getElementsByTagName('head')[0];
    };

    return DomInjector;

  })();

}).call(this);
