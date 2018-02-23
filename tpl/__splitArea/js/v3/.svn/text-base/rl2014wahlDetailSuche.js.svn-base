<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function() {

    $('#electionSearch .electionSearchInput')
        .autoComplete({
            minChars: 1,
            source: function(term, suggest) {
                term = term.toLowerCase();
                var choices = globalElectionSearchData;
                var matches = [];
                $.each(choices, function(index, value) {
                    if (value.toLowerCase().indexOf(term) >= 0) {
                        matches.push(value);
                    }
                });
                suggest(matches);
            },
            renderItem: function (item, search) {
                search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
                var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
                return '<div class="autocomplete-suggestion" data-val="' + item + '">' + item.replace(re, "<b>$1</b>") + '</div>';
            },
            onSelect: function(e, term, item) {
                var dataVal = $(item).data('val').toLowerCase();
                $.each(globalElectionSearchData, function(index, value) {
                    if (value.toLowerCase() === dataVal) {
                        var url = $('#electionSearch .electionSearchInput').data('entity-url') + index;
                        $('#electionSearch .electionSearchInput').data('url', url);
                    }
                });
            }
        });

    $('.electionSearchForm').on('submit', function(e) {
        e.preventDefault();
        var url = $('#electionSearch .electionSearchInput').data('url');
        var myWindow = window.open(url, '_blank');
    });

});
