
li_options =
  step_height:      700
  initial_height:   1600
  step_scroll:      450
  body_main_diff:   236
  anim_speed:       300
  step1_min:        0
  step1_max:        170
  step2_min:        420
  step2_max:        650
  step3_min:        1120
  step3_max:        1330
  step4_min:        1810
  step4_max:        1980

step = 1

glowNext = ->
  $('.next span').delay(1000).fadeOut(700, ->
    $(this).fadeIn(700, ->
      glowNext()
    )
  )

$(document).ready ->

  $body = $('body')
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


  $('.move').click (event) ->

    event.preventDefault()
    step = parseInt $(this).attr('data-step')

    $body.css
      'min-height': ( li_options.initial_height + ( li_options.step_height * (step - 1 ) )  ) + 'px'

    $('html, body').stop(true,true).animate
      scrollTop: ( li_options.step_scroll + ( li_options.step_height * (step - 1 ) ) ) + 'px'
      , (li_options.anim_speed)

    $('#main').stop(true,true).animate
      height: ( (li_options.initial_height + (li_options.step_height * (step - 1 ) )) - li_options.body_main_diff )  + 'px'
      , (li_options.anim_speed)

    $('#ball').stop(true,true).animate
      top: '20px'
      opacity: 1
      , (li_options.anim_speed), ->

        step += 1

        $body.removeClass('step1 step2 step3 step4').addClass('step' + step)
        $('header').css(marginTop: '250px') if step is 2

        $('.step').removeClass('active').hide()
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

  $(window).scroll ->

      scroll = $(this).scrollTop()

      if scroll > li_options.step1_max and $step1.not ':visible'
        $step1.fadeOut li_options.anim_speed
      else
        $step1.fadeIn li_options.anim_speed

      for s in [2..4]
        $da_step = $("#step#{s}")
        if scroll < li_options["step#{s}_min"] or scroll > li_options["step#{s}_max"]

          if $da_step.is ':visible' # outside the zone
            $da_step.fadeOut li_options.anim_speed

        else
          if ( ($da_step.not ':visible') && step >= s) # in the zone
            $da_step.fadeIn li_options.anim_speed
