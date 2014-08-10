# Puppy CoffeeScript class to help us deal with some of the front-end tasks that having puppies requires.
#
# @since 0.1
#
# @todo Some kind of 'you just did X, click here to undo'
class Puppy
  # Deal with toggling disabled on a puppy (within a table row)
  #
  # @author Matt Rayner
  #
  # @param [HTMLElement] identifier Where did we click to execute this?
  this.toggle_disabled_on_row = (identifier)->
    console.log "in here"
    console.log identifier

    # Listen for an AJAX error
    $(identifier).on 'ajax:error', (e, data, status, xhr) ->
      console.log "ajax error"
      # Revert to showing the row
      $(identifier).closest('tr').slideDown();

      # Display some error text
      UI.show_error 'SOME ERROR TEXT GOES HERE'

    # Add an on click listener
    $(identifier).on 'click', (e)->
      console.log "click"

      row = $(this).closest 'tr'

      $(row).slideUp();

      UI.show_undo_helper 'SOME UNDO HELPER TEXT GOES HERE', 'UNDO DISABLE', ->
        UI.slide_down(row)

window.Puppy = Puppy

jQuery ->
  # Listen for a click on toggle_disabled
  $('tr a.toggle-disabled[data-remote=\'true\']').each ->
    console.log "called"
    Puppy.toggle_disabled_on_row(this)