
;(function() {

    // http://www.chartjs.org/
    // https://laracasts.com/discuss/channels/general-discussion/chartjs-and-half-donuts
    // https://jsfiddle.net/m846s85L/

    "use strict";

    function drawMyChart(ctx) {

        var chartType = ctx.dataset.chartType;
        var chartData = JSON.parse(ctx.dataset.chartData);
        var defaultFontSize = (ctx.dataset.defaultFontSize === 'undefined') ? 14 : ctx.dataset.defaultFontSize;

        // Charts.js kennt unter anderem nur 'bar' bzw. 'pie' als Chart-Type
        // Im spunQ-Template muss ich allerdings unterscheiden zwischen
        // einfachem Bar-Chart mit nur einem Bar und Group-Bar-Chart fuer
        // "alte" und "neue" Werte, die nebeneinander dargestellt werden sollen.

        chartType = ('bar' == chartType || 'barGroup' ==  chartType) ? 'bar' :  chartType;

        // console.log(chartType);
        // console.log(chartData);
        // console.log(chartData.data);
        // console.log(defaultFontSize);

        // ----------------------------------------------

        var datasets = [], options, data;

        for (var n = 0; n < chartData.data.length; n++) {
            datasets.push({
                data: chartData.data[n],
                backgroundColor: chartData.colors[n]
            });
        }

        // ----------------------------------------------

        switch (chartType) {
            case 'bar':
                options = {
                    legend: { display: false }
                }
                break;
            case 'pie':
                options = {
                    legend: { display: false },
                    layout: {
                        padding: {
                            left: 0, right: 0, top: 0, bottom: 11
                        }
                    },
                    rotation: 1 * Math.PI,
                    circumference: 1 * Math.PI
                }
                break;
            default:
                return;
        }

        // ----------------------------------------------

        data = {
            labels: chartData.parteien,
            datasets: datasets
        }

        // ----------------------------------------------

        Chart.defaults.global.defaultFontFamily = "'Open Sans', 'Helvetica Neue', 'Helvetica', 'Arial', sans-serif";
        Chart.defaults.global.defaultFontSize   = (typeof defaultFontSize === 'undefined') ? 14 : defaultFontSize;
        Chart.defaults.global.defaultFontStyle  = 'bold';
        Chart.defaults.global.defaultFontColor  = '#000000';

        // console.log(data);
        // console.log(options);

        var myChart = new Chart(ctx, {
            type: chartType,
            options: options,
            data: data
        });

        // console.log(myChart);
    }

    // ------------------------------------------

    var charts = document.querySelectorAll('.chart');

    // IE11: [object NodeList].foreach() funktioniert nicht

    // charts.forEach(function(ctx, index) {
    //     drawMyChart(ctx);
    // });

    for (var i = 0; i < charts.length; i++) {
        drawMyChart(charts[i]);
    }

})();
