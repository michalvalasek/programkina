$(document).ready(function() {
    $('.remove-event').on('ajax:success', function() {  
        $(this).closest('tr').fadeOut();
    });
    $('.add-event').on('ajax:success', function() {  
        $(this).closest('tr').fadeOut();
    });
    $('.remove-section').on('ajax:success', function() {  
        $(this).closest('tr').fadeOut();
    });
});