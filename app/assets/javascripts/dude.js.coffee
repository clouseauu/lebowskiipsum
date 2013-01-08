
li_options =
  step_height:      700
  initial_height:   1600
  step_scroll:      450
  body_main_diff:   236
  anim_speed:       300

step = 1

$(document).ready ->

  glowNext = ->

    $('.next span').delay(1000).fadeOut(700, ->
      $(this).fadeIn(700, ->
        glowNext()
      )
    )

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
  glowNext()

  $body.removeClass('step2 step3 step4').addClass 'step1'


  $('.p-radio label').each ->
      $faux = $(this).siblings 'div.radio'
      $(this).appendTo($faux).wrap '<span />'


  $('#roll').click (event) ->

    event.preventDefault()

    $body.css
      'min-height': li_options.initial_height + 'px'

    $('html, body').stop(true,true).animate
      scrollTop: li_options.step_scroll + 'px'
      , (li_options.anim_speed)

    $main.stop(true,true).animate
      height: (li_options.initial_height - li_options.body_main_diff)  + 'px'
      , (li_options.anim_speed)

    $ball.stop(true,true).animate
      top: '20px'
      , (li_options.anim_speed), ->

        step = 2

        $body.removeClass('step1 step3 step4').addClass 'step2'
        $('header').css
          marginTop: '250px'

        $step.removeClass('active').hide()
        $('#step' + step).fadeIn(li_options.anim_speed, ->
          $(this).addClass 'active'
        )


  $('#step2 .next').click (event) ->

    event.preventDefault()

    $body.css
      'min-height' : (li_options.initial_height + li_options.step_height) + 'px'

    $('html, body').stop(true,true).animate
      scrollTop: (li_options.step_height + li_options.step_scroll) + 'px'
      , (li_options.anim_speed)

    $main.stop(true,true).animate
      height: ((li_options.initial_height + li_options.step_height) - li_options.body_main_diff)  + 'px'
      , (li_options.anim_speed)

    # dummy animate
    $ball.stop(true,true).animate
      opacity :1
      , (li_options.anim_speed), ->

        step = 3

        $body.removeClass('step1 step2 step4').addClass 'step3'
        $step.removeClass('active').hide()

        $('#step' + step).fadeIn(li_options.anim_speed, ->
          $(this).addClass 'active'
        )


  $('#step3 .next').click (event) ->

    event.preventDefault()

    $body.css
      'min-height' : (li_options.initial_height + (li_options.step_height*2)) + 'px'

    $('html, body').stop(true,true).animate
      scrollTop: (li_options.step_scroll + (li_options.step_height*2)) + 'px'
      , (li_options.anim_speed)

    $main.stop(true,true).animate
      height: ((li_options.initial_height + (li_options.step_height*2)) - li_options.body_main_diff)  + 'px'
      , (li_options.anim_speed)

    # dummy animate
    $ball.stop(true,true).animate
      opacity :1
      , (li_options.anim_speed), ->

        step = 4

        $body.removeClass('step1 step2 step3').addClass 'step4'
        $step.removeClass('active').hide()

        $('#step' + step).fadeIn(li_options.anim_speed, ->
          $(this).addClass 'active'
        )


  $('form').submit ->

    unless isNumeric( $('#paragraphs').val() )
      alert 'Hold on there, cowboy! Enter a valid number first'
      return false

    if parseInt( $('#paragraphs').val() ) > 500
      alert 'Whoa, man! this won\'t fill your doctoral thesis! 500 paragraphs should be enough.'
      return false



  step1Min = 0
  step1Max = 170

  step2Min = 420
  step2Max = 650

  step3Min = 1120
  step3Max = 1330

  step4Min = 1810
  step4Max = 1980


  $(window).scroll ->

      scroll = $(this).scrollTop()

      if scroll > step1Max and $step1.not ':visible'
        $step1.fadeOut li_options.anim_speed
      else
        $step1.fadeIn li_options.anim_speed


      # step2
      if scroll < step2Min or scroll > step2Max

        # outside the zone
        if $step2.is ':visible'
          $step2.fadeOut li_options.anim_speed

      else if step >= 2
        # in the zone
        if $step2.not ':visible'
          $step2.fadeIn li_options.anim_speed

      # step3
      if scroll < step3Min or scroll > step3Max

        # outside the zone
        if $step3.is ':visible'
          $step3.fadeOut li_options.anim_speed

      else if step >= 3
        # in the zone
        if $step3.not ':visible'
          $step3.fadeIn li_options.anim_speed

      # step4
      if scroll < step4Min or scroll > step4Max

        # outside the zone
        if $step4.is ':visible'
          $step4.fadeOut li_options.anim_speed

      else if step >= 4
        # in the zone
        if $step4.not ':visible'
          $step4.fadeIn li_options.anim_speed

