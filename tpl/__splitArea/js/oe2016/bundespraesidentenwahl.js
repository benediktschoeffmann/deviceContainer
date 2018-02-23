<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function() {

    $('.apaElectionSearch .apaElectionSearchInput')
        .autoComplete({
            minChars: 1,
            source: function(term, suggest) {
                term = term.toLowerCase();
                var choices = globalApaGemeindeListe;
                var matches = [];
                $.each(choices, function(index, value) {
                    if (value.toLowerCase().indexOf(term) >= 0) {
                        matches.push(value);
                    }
                });
                matches.sort();
                suggest(matches);
            },
            renderItem: function (item, search) {
                search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
                var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
                return '<div class="autocomplete-suggestion" data-val="' + item + '">' + item.replace(re, "<b>$1</b>") + '</div>';
            },
            onSelect: function(e, term, item) {
                var dataVal = $(item).data('val').toLowerCase();
                $.each(globalApaGemeindeListe, function(index, value) {
                    if (value.toLowerCase() === dataVal) {
                        var url = $('.apaElectionSearch .apaElectionSearchInput').data('entity-url') + index;
                        $('.apaElectionSearch .apaElectionSearchInput').data('url', url);
                    }
                });
            }
        });

    $('.apaElectionSearchForm').on('submit', function(e) {
        e.preventDefault();
        var value = $('.apaElectionSearch .apaElectionSearchInput').val();
        value = $.trim(value + '');
        if ('' !== value) {
            var url = $('.apaElectionSearch .apaElectionSearchInput').data('url');
            var myWindow = window.open(url, '_blank');
        }
    });

});

