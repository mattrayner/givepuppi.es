# The DomInjector basically injects our API code into a page.
# It works by adding a <script/> tag into the page header. If it is prevented by a CSP (Content Security Policy) then
# it will fire an error.
#
# @author Matt Rayner
# @since 0.1-beta
#
# @attr [String] url The url we want to inject
# @attr [Integer] delay How long we will wait between our checks for failure (in ms)
# @attr [Function] success_callback What function we should call on success
# @attr [Function] fail_callback What function we should call on failure
# @attr [Object] document_head A reference to the first <head/> element found within the page
# @attr [Object] inject_script A reference to the script that we are injecting
# @attr [Function] error_handler A function called when an error is found within our injection
class @DomInjector

  # Create a new PuppyDomInjector object, providing a delay, success callback, fail callback and optional URL
  #
  # @author Matt Rayner
  #
  # @param [Integer] delay How long we should wait between 'ticks'
  # @param [Function] success_callback What function we should execute on success
  # @param [Function] fail_callback What function we should execute on fail
  # @param [String] url The url we are injecting
  constructor: (delay, success_callback, fail_callback, url = null)->
    injector = this

    console.log 'hi'
    @delay = delay
    @success_callback = success_callback
    @fail_callback = fail_callback

    # If a URL is passed, set it. Else use the default.
    @url = (url == null)? 'http://givepuppi.es/api/v1/puppies?callback=this.give_puppies.api_return' : url

    # Check to see if the document head is available
    @document_head_available()
    if !@document_head
      return false # We cannot continue if it is not

    # Create a placeholder script tag to be used later
    @inject_script = document.createElement('script')

    # Create a timeout to wait for our delay to tick
    setTimeout ->
      console.log 'timeout fired'
      blank_function = ->
      error_function = ->
        console.log('GivePuppi.es error: Cannot load resource ' + url)

      # If our callbacks are not set, load default functions
      @success_callback = (typeof success_callback == 'function') ? success_callback : blank_function

      @fail_callback = (typeof fail_callback == 'function') ? fail_callback : error_function


      console.log('inject')
      console.log(@setup_inject_script)
      # Attempt to set up our placeholder script, ready for injection.
      injector.setup_inject_script(@inject_script)
      console.log('injected')

      # If there is an error, we will get a null. If that happens, exit immediately.
      if @inject_script == null
        @fail_callback()
        return false

      # If there have been no errors, attempt to inject our puppy script
      try
        @document_head.appendChild inector.inject_script
      catch e
        injector.error_handler(injector.inject_script)
    , delay

    null

  # Given a script element, set it up ready for injection into the dom.
  #
  # @author Matt Rayner
  #
  # @param [Object] script The script tag that we are going to try and inject.
  # @return [Object] Our fully set up script tag, ready for injection (can be null on error)
  setup_inject_script: (script)->
    if (typeof script != 'object')
      return false

    # Set the type of script we are expecting
    script.type = 'text/javascript'
    # Attempt to do all the loading asynchronously
    script.async = true
    # Set the charset so that the code will execute correctly even if the page's charset is not UTF-8
    script.charset = 'utf-8'

    # Try out hardest to add an event directly to the script
    @add_event script, 'error', ->
      @error_handler(this)

    # As a fallback, we will also add a timer that will fire x number of times and will manually check and call our
    # fail callback if for some reason the above configured events dont fire.
    @timer 15, @delay, ->
      script.id == 'loaded'
    , ->
      if script.id != 'loaded'
        @error_handler(script)

    script.src = @url

  # A helper function to add an event listener to the given object.
  #
  # @author Matt Rayner
  #
  # @param [Object] object The object we are trying to add the events to
  # @param [String] event The event we are listening for
  # @param [Function] callback The function we should execute when the events fire
  # @return [Boolean] Did it work?
  add_event: (object, event, callback)->
    # Make sure all of our params are the right format to proceed
    if (typeof object == 'object') || (typeof event == 'string') || (typeof callback == 'function')
      # Does the object have addEventListener as an option? (most modern browsers
      if object.addEventListener
        object.addEventListener(event, callback, false)
        return true

      # Does the object have attacheEvent as an option? (IE)
      if object.attachEvent
        object.attachEvent("on#{event}", callback)
        return true

    # Either the object could not have an event attached OR the params supplied were not of the right type
    return false

  # Create a timer that iterates a given number of times, ticking each time and then completes with a specific function.
  # This function is a fallback when events cannot be attached to an object for whatever reason.
  #
  # @author Matt Rayner
  #
  # @param [Integer] iterations How many times should we iterate over this?
  # @param [Integer] how long should we wait between ticks? (in ms)
  # @param [Function] tick_function What should we execute on each tick?
  # @param [Function] complete_function What should we execute when/if we get to the end of our iterations?
  timer: (iterations, delay, tick_function, complete_function)->
    # Are there any iterations left?
    if iterations > 1
      # delay the execution of our code...
      setTimeout ->
        # Tick if you can
        tick_function() if (typeof tick_function == 'function')

        # Create another timer with one fewer iterations
        @timer (iterations-1), delay, tick_function, complete_function
      , (typeof delay == 'number') ? delay : 1
    else if (typeof complete_function == 'function') # Providing our complete function is a function
      setTimeout -> # Delay execution
        complete_function() # BOOM
      , (typeof delay == 'number') ? delay : 1

  # Get the current document head, assign it to an attribute and return that bad boy!
  #
  # @author Matt Rayner
  #
  # @return [Object] The first instance of <head/> found within the document. (can be null)
  document_head_available: ->
    @document_head = document.getElementsByTagName('head')[0]

  # This function can be called when we encounter an error at any point within the injection.
  #
  # @param [Object] script The script element that the error happened on
  error_handler: (script)->
    if (typeof script != 'object') && (typeof @inject_script == 'object')
      script = @inject_script
    else
      @fail_callback()
      return false

    # Check if the script has been marked already
    if script.data('error')
      script.data('error', true) # Mark that an error has been found
      script.id = 'failed' # Give it an ID so that we can easily check
      @fail_callback() # Execute our fail callback
