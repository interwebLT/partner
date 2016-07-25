# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link) # look bellow for implementations
  false # always stops the action since code runs asynchronously

$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')


$.rails.showConfirmDialog = (link) ->
  message = link.attr 'data-confirm'
  html = """
         <div class="modal" id="confirmationDialog">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
             <div class="modal-body">
               <h4>#{message}</h4>
             </div>
             <div class="modal-footer">
               <a data-dismiss="modal" class="btn btn-default">No</a>
               <a data-dismiss="modal" class="btn btn-primary confirm">Yes</a>
             </div>
            </div>
          </div>
         </div>
         """
  $(html).modal()
  $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)


