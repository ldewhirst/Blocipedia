# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  converter = new showdown.Converter()
  $('#wiki_body').on 'keyup', ->
    markdown = $('#wiki_body').val()
    content = converter.makeHtml(markdown)
    $('#wiki_preview').html(content)
