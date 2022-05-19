import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OcupationChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const OcupationChart(this.seriesList, {required this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory OcupationChart.withSampleData() {
    return OcupationChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }



  // [BarLabelDecorator] will automatically position the label
  // inside the bar if the label will fit. If the label will not fit,
  // it will draw outside of the bar.
  // Labels can always display inside or outside using [LabelPosition].
  //
  // Text style for inside / outside can be controlled independently by setting
  // [insideLabelStyleSpec] and [outsideLabelStyleSpec].
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      List.from(seriesList),
      animate: animate,
      // Set a bar label decorator.
      // Example configuring different styles for inside/outside:
      //       barRendererDecorator: new charts.BarLabelDecorator(
      //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
      //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),

      // Configure the axis spec to show percentage values.
      //primaryMeasureAxis: charts.NumericAxisSpec(),
      //barRendererDecorator: charts.BarLabelDecorator<String>(),
      behaviors: [
        charts.ChartTitle(AppLocalizations.of(context).occupationChart, //TODO (Peilin) ready for test
            subTitle: '%' + AppLocalizations.of(context).occupancy, //TODO (Peilin) ready for test
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            // Set a larger inner padding than the default (10) to avoid
            // rendering the text too close to the top measure axis tick label.
            // The top tick label may extend upwards into the top margin region
            // if it is located at the top of the draw area.
            innerPadding: 18),
        charts.ChartTitle(AppLocalizations.of(context).hours, //TODO (Peilin) ready for test
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
            charts.OutsideJustification.middleDrawArea,
        ),
      ],
      domainAxis: const charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
        // Tick and Label styling here.
          labelStyle: charts.TextStyleSpec(
              fontSize: 9, // size in Pts.
              color: charts.MaterialPalette.black),

          // Change the line colors to match text color.
          lineStyle: charts.LineStyleSpec(
              color: charts.MaterialPalette.black)),

      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(   //to see the 0-100 scale
        tickProviderSpec:
        charts.BasicNumericTickProviderSpec(zeroBound: false),
        viewport: charts.NumericExtents(0.0, 100.0),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('2014', 5.0000),
      OrdinalSales('2015', 2.5),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
    ];

    return [
      charts.Series<OrdinalSales, String>(
          id: 'Sales',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (OrdinalSales sales, _) =>
          '\$${sales.sales.toString()}')
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final double sales;

  OrdinalSales(this.year, this.sales);
}