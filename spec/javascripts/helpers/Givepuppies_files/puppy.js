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
