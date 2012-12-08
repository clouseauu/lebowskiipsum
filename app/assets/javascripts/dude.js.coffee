# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


step_height     = 700
initial_height  = 1600
step_scroll     = 450
body_main_diff  = 236
anim_speed      = 300
step1           = 1


$(document).ready ->

  $body = $('body')
  $main = $('#main')
  $ball = $('#ball')
  $step = $('.step')

  $step1 = $('#step1')
  $step2 = $('#step2')
  $step3 = $('#step3')
  $step4 = $('#step4')

  $('input[type=radio]').makeNiceRadios()
  $('input[type=checkbox]').makeNiceCheckboxes()
  $('.checkbox', $step3).wrap '<div class="ws" />'

  $('.next').append('<span></span>')
  # glowNext

  $body.removeClass('step2 step3 step4').addClass 'step1'


  $('.p-radio label').each ->
      $faux = $(this).siblings 'div.radio'
      $(this).appendTo($faux).wrap '<span />'


  $('#roll').click (event) ->

    event.preventDefault()

    $body.css
      'min-height': initial_height + 'px'

    $('html, body').stop(true,true).animate
      scroll_top: step_scroll + 'px'
      , anim_speed

    $main.stop(true,true).animate
      height: (initial_height - body_main_diff)  + 'px'
      , anim_speed

    $ball.stop(true,true).animate
      top: '20px'
      , anim_speed, ->

        step = 2

        $body.removeClass('step1 step3 step4').addClass 'step2'
        $('header').css
          marginTop: '250px'

        $step.removeClass('active').hide()
        $('#step' + step).fadeIn(anim_speed, ->
          $(this).addClass 'active'
        )


  $('#step2 .next').click (event) ->

    event.preventDefault()

    $body.css
      'min-height' : (initial_height + step_height) + 'px'

    $('html, body').stop(true,true).animate
      scrollTop: (step_height + step_scroll) + 'px'
      , anim_speed

    $main.stop(true,true).animate
      height: ((initial_height + step_height) - body_main_diff)  + 'px'
      , anim_speed

    # dummy animate
    $ball.stop(true,true).animate
      opacity :1
      , anim_speed, ->

        step = 3

        $body.removeClass('step1 step2 step4').addClass 'step3'
        $step.removeClass('active').hide()

        $('#step' + step).fadeIn(anim_speed, ->
          $(this).addClass 'active'
        )


  $('#step3 .next').click (event) ->

    event.preventDefault()

    $body.css
      'min-height' : (initial_height + (step_height*2)) + 'px'

    $('html, body').stop(true,true).animate
      scrollTop: (step_scroll + (step_height*2)) + 'px'
      , anim_speed

    $main.stop(true,true).animate
      height: ((initial_height + (step_height*2)) - body_main_diff)  + 'px'
      , anim_speed

    # dummy animate
    $ball.stop(true,true).animate
      opacity :1
      , anim_speed, ->

        step = 4

        $body.removeClass('step1 step2 step3').addClass 'step4'
        $step.removeClass('active').hide()

        $('#step' + step).fadeIn(anim_speed, ->
          $(this).addClass 'active'
        )

