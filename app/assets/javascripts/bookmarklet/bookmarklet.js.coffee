#= require ./requires/puppy
#= require ./requires/give_puppies

# GivePuppi.es Bookmarklet
#
# @author Matt Rayner
# @since 0.1-beta
# @version 0.1-beta
#
# Description:
#   This bookmarklet is basically the secret sauce of GivePuppi.es. I'm going to try and summarise what it does here :)
#
#   What happens first?
#     First we try and connect to the GivePuppi.es API,
#     If we can get some puppies then we use those puppies later.
#     If we can't get puppies then we fall back to our local cache (of 10) puppies.
#       We do this so if the API goes down it still works, just it looks a bit repetative.
#     Once we know what puppies we are using we look at all of the <img /> tags on the page
#     We then replace the images with a (hopefully) appropriate and adorable puppy alternative.
#
#   What's a Puppy?
#     In the context of the bookmarklet, a puppy is a small object that describes an image on the server.
#     It contains an ID and an orientations i.e.
#       Puppy 1 is horizontal - therefore, this can be used to replace a horizontal image.
#     Depending on the size of the image we are replacing, we will choose the appropriate image from the server
#     (this helps to save YOUR, and OUR bandwidth). It also means that we can help make sure it never looks too
#     blurry).
#
#   How do you decide what puppy to get?
#     When we look at the images on the web page, we take measurements. With those measurements we can work out whether
#     to replace it will a horizontal, vertical or square image. We also look at the size of the image and choose an
#     appropriate size puppy to replace it with.
((document)->
  console.log window.give_puppies
  if (typeof window.give_puppies == 'undefined')
    console.log 'create new puppies'
    window.give_puppies = new GivePuppies()
  else
    console.log 'use existing'
    window.give_puppies.replace_images()
)(document)