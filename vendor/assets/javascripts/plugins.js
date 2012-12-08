$.fn.makeNiceCheckboxes = function(options) {

	$(this).each(function(i) {

		var the_name = $(this).attr('name');
		var the_id = $(this).attr('id');
		var the_faux_element = '';
		var the_class = 'off';

		$(this).siblings('label').addClass('checkboxLabel').attr('for', '');

		if($(this).is(':checked')) {
			the_class = 'on'
		}

		the_faux_element = '<div class="checkbox ' + the_class + '"';

		if (typeof the_id !== 'undefined' && the_id !== false && the_id != '') {
			the_faux_element += ' id="faux_' + the_id +'"';
		}

		the_faux_element += '><span><em>' + '</em></span></div>';

		$(this).css({'opacity':0, '-moz-opacity':0, 'width':'0px', 'height':'0px' ,'visibility':'hidden'}).after(the_faux_element);

	});


	$('div.checkbox').css({'cursor':'pointer'});

	$('div.checkbox').click(function() {

		var the_id = $(this).attr('id').replace('faux_','');
		var the_class = '';

		if($(this).hasClass('on')) {
			the_class = 'off';
			$('#' + the_id).attr('checked', false);
		} else {
			the_class = 'on';
			$('#' + the_id).attr('checked', true);
		}

		$(this).removeClass('on off');
		$(this).addClass(the_class);

	});

	$('.checkboxLabel').click(function() {

		var $the_checkbox = $(this).siblings('div.checkbox');
		var the_id = $the_checkbox.attr('id').replace('faux_','');
		var the_class = '';

		if($the_checkbox.hasClass('on')) {
			the_class = 'off';
		$('#' + the_id).attr('checked', false);
		} else {
			the_class = 'on';
			$('#' + the_id).attr('checked', true);
		}

		$the_checkbox.removeClass('on off');
		$the_checkbox.addClass(the_class);

	});
}






$.fn.makeNiceRadios = function() {

	$(this).each(function(i){

		var the_id = $(this).attr('id');

		var the_name = $(this).attr('name');
		var the_faux_element = '';
		var the_class = '';
		$(this).siblings('label').addClass('radioLabel');

		if($(this).is(':checked')) {
			the_class = 'on';
		}

		the_faux_element = '<div class="radio ' + the_name + ' ' + the_class + '"';

		if (typeof the_id !== 'undefined' && the_id !== false && the_id != '') {
			the_faux_element += ' id="faux_' + the_id +'"';
		}

		the_faux_element += '>';

		$(this).css({'opacity':0, '-moz-opacity':0, 'width':'0px', 'visibility':'hidden'}).after(the_faux_element);

	});


	$('div.radio').css({'cursor':'pointer'});

	$('div.radio').click(function() {

		var the_id = $(this).attr('id').replace('faux_','');
		var $the_input = $('#' + the_id);
		var the_name = $the_input.attr('name');
		var the_class = '';

		if(!$(this).hasClass('on')) {
			the_class = 'on';

			$('div.' + the_name).removeClass('on off');
			$(this).addClass(the_class);

			$('input[name='+the_name+']').attr('checked', false);
			$the_input.attr('checked', true);

		}

	});

}



// Kudos to CMS @ Stack Overflow
// http://stackoverflow.com/questions/18082/validate-numbers-in-javascript-isnumeric
function isNumeric(n) {
	return !isNaN(parseInt(n)) && isFinite(n) && (n % 1 == 0);
}


