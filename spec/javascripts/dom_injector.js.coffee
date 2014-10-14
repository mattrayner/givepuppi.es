# A class designed to handle DOM injection.
#
# The purpose of this class is to handle injecting <script /> tags into the head of the current page.
# This injection will go out to the givepuppies server and get an updated list of puppies from the server.
#
# @author Matt Rayner
# @since 0.1-beta
class @PuppyDomInjector

  # Initialize our injector, either using the url passed or the base API url.
  #
  # @author Matt Rayner
  # @since 0.1-beta
  #
  # @param [String] url The url we want to inject (can be null)
  # @return
  constructor: (success_callback, error_callback, url = null)->
    # IF there is no URL set, use the API url
    if url == null
      url = 'http://givepuppi.es/api/v1/puppies'

    # If there is no success or error function, create them
    success_callback = (typeof success_callback == 'function') ? success_callback : ->
    error_callback = (typeof error_callback == 'function') ? error_callback : ->
      alert("Whoops! DomInjector couldn't inject for the url: "+url)

    # Create a placeholder for our script tag
    script_placeholder = document.createElement('script')

    # If there is no available document head then return false. This really shouldn't happen.
    unless document_head_available
      return false;

    # Create a delay, allowing us to recreate the script tag.
    setTimeout ->
      # Create a success listener, so that we know if the script has loaded successfully.
      script_placeholder.onload = ->
        script_placeholder.id = 'loaded' # Give it an ID that we can check against.
        success_callback(script_placeholder) # Call the success callback we were passed.
      script_placeholder.type = 'text/javascript' # Give the script tag's  type.
      script_placeholder.async = true # We want to do it asynchronously if that is a possibility.
      script_placeholder.charset = 'utf-8' # Set a charset (this means our code will execute even if the documents charset is not UTF-8.
      @addEvent(script_placeholder, 'error', error_callback) # If an error happens (4**, 5** etc.) then we will call the error callback.

  # Check to see if the document head is available on the page. This shouldn't fail, but you never know!
  #
  # @author Matt Rayner
  # @since 0.1-beta
  #
  # @return [Boolean] Is the document head available?
  document_head_available: ->
    @document_head = document.getElementsByTagName("head")[0]

    return (!document_head != null)

  # Create a timer that loops a specified number of times.
  #
  # This will be used as a manual check, ensuring that the success callback is fired, even if the onload event fails.
  #
  # @author Matt Rayner
  # since 0.1-beta
  #
  # @param [Integer] iterations How many times should the timer fire?
  # @param [Integer] delay How long should the delay be between calls?
  # @param [Function] tick_callback The function we should call every time the timer ticks.
  # @param
  timer: (iterations, delay, tick_callback, end_callback)->
    # Do we have any iterations left?
    if iterations > 1
      setTimeout ->
        # call our timer again, just lower the iteration number
        o.timer (iterations -1), delay, tick_callback, end_callback
      , delay
    else if typeof end_callback == 'function' # If the callback we have is a function
      setTimeout end_callback, 1 # Create a timer to execute it