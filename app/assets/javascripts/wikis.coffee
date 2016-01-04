# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# $(document).ready(function() {
#     $('#wiki_body').on('keyup', function() {
#       alert('found keyup event!')
#     });
# })


$ ->
  converter = new showdown.Converter()
  $('#wiki_body').on 'keyup', ->
    mdown = $('#wiki_body').val()
    content = converter.makeHtml(mdown)
    $('#wiki_preview').html(content)
