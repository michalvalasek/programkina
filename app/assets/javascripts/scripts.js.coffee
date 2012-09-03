# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->  
  $('.run_script_button').on 'click', ->
    if confirm "Skript môže bežať aj niekoľko minút, skutočne ho chcete spustiť?"
      spinner = $("#img-spinner")
      $(this).replaceWith(spinner)
      return true
    return false