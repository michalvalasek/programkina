$(document).ready(function() {
    $('.remove-event').on('ajax:success', function() {  
        $(this).closest('tr').fadeOut();
    });
});