//= require jquery.ui.datepicker
//= require jquery.ui.slider
//= require jquery-ui-timepicker-addon
//= require datetimepicker.localization

jQuery ->
    datetimepicker_config = {
        dateFormat: "dd.mm.yy",
        timeFormat: "hh:mm",
        stepHour: 1,
        stepMinute: 15,
        firstDay: 1,
        hourGrid: 6,
        minuteGrid: 15
    }

    $.datepicker.setDefaults($.datepicker_localization)
    $.timepicker.setDefaults($.timepicker_localization)

    $('.datetime_picker').datetimepicker(datetimepicker_config)

    $('form').on 'click', '.remove_fields', (event) ->
        $(this).prev('input[type=hidden').val('1')
        $(this).closest('div.projection-date').hide()
        event.preventDefault()

    $('form').on 'click', '.add_fields', (event) ->
        time = new Date().getTime()
        regexp = new RegExp($(this).data('id'), 'g')
        $(this).before($(this).data('fields').replace(regexp, time))
        $('.datetime_picker').datetimepicker(datetimepicker_config)
        event.preventDefault()