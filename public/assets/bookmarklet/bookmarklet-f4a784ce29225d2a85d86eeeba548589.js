(function() {
  this.Puppy = (function() {
    function Puppy(id, orientation) {
      this.id = id;
      this.orientation = orientation;
    }

    Puppy.prototype.image_url = function(size) {
      return "http://givepuppi.es/puppies/" + size + "/" + this.id + ".png";
    };

    return Puppy;

  })();

}).call(this);
(function() {
  this.PuppyDomInjector = (function() {
    function PuppyDomInjector(delay, success_callback, fail_callback, url) {
      var error_handler, _base, _ref;
      if (url == null) {
        url = null;
      }
      this.delay = delay;
      this.success_callback = success_callback;
      this.fail_callback = fail_callback;
      this.url = typeof (_base = url === null) === "function" ? _base({
        'http://givepuppi.es/api/v1/puppies?callback=this.give_puppies.api_return': url
      }) : void 0;
      document_head_available();
      if (!this.document_head) {
        return false;
      }
      this.puppy_script = document.createElement('script');
      error_handler = function() {
        if (!this.puppy_script.data('error')) {
          this.puppy_script.data('error', true);
          this.puppy_script.id = 'failed';
          return this.fail_callback();
        }
      };
      setTimeout(function() {
        var blank_function, e, error_function, _ref, _ref1;
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
        this.puppy_script = setup_puppy_script(this.puppy_script);
        if (this.puppy_script === null) {
          this.fail_callback();
          return false;
        }
        try {
          return this.document_head.appendChild(this.puppy_script);
        } catch (_error) {
          e = _error;
          return error_handler();
        }
      }, (_ref = typeof delay === 'number') != null ? _ref : {
        delay: 1
      });
    }

    PuppyDomInjector.prototype.setup_puppy_script = function(script) {
      if (typeof script !== 'object') {
        return false;
      }
      script.type = 'text/javascript';
      script.async = true;
      script.charset = 'utf-8';
      this.add_event(script, 'error', function() {
        return this.error_handler();
      });
      timer(15, this.delay, function() {
        return script.id === 'loaded';
      }, function() {
        if (script.id !== 'loaded') {
          return this.error_handler();
        }
      });
      script.src = this.url;
      return script;
    };

    PuppyDomInjector.prototype.add_event = function(object, event, callback) {
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

    PuppyDomInjector.prototype.timer = function(iterations, delay, tick_function, complete_function) {
      var _ref, _ref1;
      if (iterations > 1) {
        return setTimeout(function() {
          if (typeof tick_function === 'function') {
            tick_function();
          }
          return timer(iterations - 1, delay, tick_function, complete_function);
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

    PuppyDomInjector.prototype.document_head_available = function() {
      return this.document_head = document.getElementsByTagName('head')[0];
    };

    return PuppyDomInjector;

  })();

}).call(this);
(function() {
  this.GivePuppies = (function() {
    GivePuppies.cached_puppies = null;

    function GivePuppies() {
      this.cached_puppies = [new Puppy(1, 'hor'), new Puppy(2, 'hor'), new Puppy(3, 'hor'), new Puppy(4, 'ver'), new Puppy(5, 'ver'), new Puppy(6, 'ver'), new Puppy(7, 'squ'), new Puppy(8, 'squ'), new Puppy(9, 'squ'), new Puppy(10, 'squ')];
      this.contact_api();
    }

    GivePuppies.prototype.contact_api = function() {
      var injector;
      return injector = new PuppyDomInjector(1000, function() {
        return null;
      }, function() {
        return set_puppies();
      });
    };

    GivePuppies.prototype.set_puppies = function(pups) {
      if (pups === null) {
        this.pups = this.cached_puppies;
      } else {
        this.pups = pups;
      }
      console.log('Set pups:');
      return console.log(this.pups);
    };

    GivePuppies.prototype.pups_for_orientation = function(orientation) {
      return this.pups.filter(function(pup) {
        return pup.orientation === orientation;
      });
    };

    GivePuppies.prototype.orientation_for = function(image) {
      var orientation, proportions;
      proportions = image.clientHeight / image.clientWidth;
      if (proportions < 1) {
        orientation = 'hor';
      } else if (proportions > 1) {
        orientation = 'ver';
      } else if (proportions === 1) {
        orientation = 'squ';
      }
      return orientation;
    };

    return GivePuppies;

  })();

}).call(this);
(function() {
  document.onload = function() {
    if (window.give_puppies === null) {
      return window.give_puppies = new GivePuppies();
    } else {
      return window.give_puppies.replace_images();
    }
  };

}).call(this);
