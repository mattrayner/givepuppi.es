(function() {
  this.GivePuppies = (function() {
    GivePuppies.cached_puppies = null;

    function GivePuppies() {
      this.cached_puppies = [new Puppy(1, 'hor'), new Puppy(2, 'hor'), new Puppy(3, 'hor'), new Puppy(4, 'ver'), new Puppy(5, 'ver'), new Puppy(6, 'ver'), new Puppy(7, 'squ'), new Puppy(8, 'squ'), new Puppy(9, 'squ'), new Puppy(10, 'squ')];
      this.contact_api();
    }

    GivePuppies.prototype.contact_api = function() {
      return this.injector = new DomInjector(1000, function() {
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
