#= require ./dom_injector

# Our GivePuppies object, used to manipulate our pups array.
#
# @author Matt Rayner
# @since 0.1-beta
#
# @param [Array] cached_puppies An array of fallback puppies to be used if there is an issue with the API
# @param [Array] pups An array of the active puppies within the object - this will either be from the API or from our cache
class @GivePuppies

  # Store an array of cached puppies which we will fall back on if there is no access to the api
  @cached_puppies = null

  # Initialize our pups array, saving it into memory so that we can manipulate it.
  #
  # @author Matt Rayner
  constructor: ->
    # Store our cached puppies array
    @cached_puppies = [new Puppy(1, 'hor'),
                       new Puppy(2, 'hor'),
                       new Puppy(3, 'hor'),
                       new Puppy(4, 'ver'),
                       new Puppy(5, 'ver'),
                       new Puppy(6, 'ver'),
                       new Puppy(7, 'squ'),
                       new Puppy(8, 'squ'),
                       new Puppy(9, 'squ'),
                       new Puppy(10, 'squ')]

    @contact_api()

  # Attempt to inject the API script tag call into the head of the current page.
  contact_api: ->
    give_pups = this

    @injector = new DomInjector 1000, ->
      null
    ,->
      give_pups.set_puppies()

  set_puppies: (pups)->
    if pups == null
      @pups = @cached_puppies
    else
      @pups = pups

    console.log 'Set pups:'
    console.log @pups

  # Get an array of puppies for a given orientation.
  #
  # @author Matt Rayner
  #
  # @param [String] orientation The orientation we are looking for ('hor' || 'ver' || 'squ')
  pups_for_orientation: (orientation)->
    return @pups.filter (pup)->
      return pup.orientation == orientation

  # Get the orientation fo the given image
  #
  # @author Matt Rayner
  #
  # @param [HTMLElement] image The image we are getting the orientation for
  # @return [String] The orientation of the image ('hor' || 'ver' || 'squ)
  orientation_for: (image)->
    proportions = image.clientHeight/image.clientWidth

    if proportions < 1
      orientation = 'hor'
    else if proportions > 1
      orientation = 'ver'
    else if proportions == 1
      orientation = 'squ'

    orientation