(function() {
  window.onload = function() {
    console.log(window.give_puppies);
    if (typeof window.give_puppies === 'undefined') {
      console.log('create new puppies');
      return window.give_puppies = new GivePuppies();
    } else {
      console.log('use existing');
      return window.give_puppies.replace_images();
    }
  };

}).call(this);
