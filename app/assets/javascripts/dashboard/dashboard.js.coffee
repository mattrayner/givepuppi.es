# Dashboard CoffeScript class containing a number of helper actions around the UI of the dashboard
#
# @since 0.1
class UI
  # Show a block of error text at the top of the page for user feedback.
  #
  # @author Matt Rayner
  #
  # @param [String] error_text The error text to display
  this.show_error = (error_text)->
    console.log error_text

  # Hide the error text helper at the top of the page.
  #
  # @author Matt Rayner
  this.hide_error = ->
    console.log "HIDE ERROR TEXT"

  # Show a block or undo helper text and allow the user to reverse their last action.
  #
  # @param [String] helper_text The proceeding helper text before our callback action.
  # @param [String] callback_text The text that will appear on our 'undo' button.
  # @param [Function] callback The callback function we will execute when someone click on the 'undo' button.
  this.show_undo_helper = (helper_text, callback_text, callback)->
    console.log 'helper: '+helper_text+
                '\ncallback: '+callback_text+
                '\nfunc: '+callback+
                '\n\n'+helper_text+'. '+callback_text

  # Slide down a previously hidden item as an 'undo' action.
  #
  # @param [HTMLElement] element The element we are going to call SlideDown on
  this.slide_down = (element)->
    console.log 'slide down'

window.UI = UI