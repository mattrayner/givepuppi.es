# Create a placeholder for our Puppy, holding the ID and orientation so that we can generate an image URL when we
# need it.
#
# @author Matt Rayner
# @since 0.1-beta
#
# @param [Integer] id The ID of our puppy on the server.
# @param [String] orientation The orientation of our puppy ('hor' || 'ver' || 'squ')
class @Puppy
  constructor: (id, orientation)->
    @id = id
    @orientation = orientation

  # Generate an image url for this puppy given the size.
  #
  # @since 0.1-beta
  #
  # @param [String] size The size of the image we want to get ('thmb' || 'sm' || 'md' || 'lg' || 'xlg')
  # @return [String] The image url for the given puppy and size
  image_url: (size)->
    "http://givepuppi.es/puppies/"+size+"/"+this.id+".png"