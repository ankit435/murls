import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:murls/providers/graph_item.dart';
import 'package:provider/provider.dart';

class LineChartSample2 extends StatefulWidget {
  final String? urlid;
  const LineChartSample2({Key? key, this.urlid}) : super(key: key);
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  var _isLoading = false;
  bool showAvg = false;

  void initState() {
    final urlid = widget.urlid == null ? '' : widget.urlid;
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Graph_value>(context, listen: false)
          .fetchAndSetGraph(urlid!);
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final graphData = Provider.of<Graph_value>(context);

    return Stack(
      children: <Widget>[
        AspectRatio(
            aspectRatio: 1.70,
            child: graphData.items.length <= 6
                ? new Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Minimum 7 days clicks required to generate graph",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          color: Color(0xFF2D2F41),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 18.0, left: 12.0, top: 24, bottom: 12),
                          child: LineChart(
                            showAvg
                                ? LineChartData(
                                    lineTouchData:
                                        LineTouchData(enabled: false),
                                    gridData: FlGridData(
                                      show: true,
                                      drawHorizontalLine: true,
                                      getDrawingVerticalLine: (value) {
                                        return FlLine(
                                          color: const Color(0xff37434d),
                                          strokeWidth: 1,
                                        );
                                      },
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                          color: const Color(0xff37434d),
                                          strokeWidth: 1,
                                        );
                                      },
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      bottomTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 22,
                                        getTextStyles: (context, value) =>
                                            const TextStyle(
                                                color: Color(0xff68737d),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                        getTitles: (value) {
                                          switch (value.toInt()) {
                                            case 0:
                                              return 'SUN';
                                            case 1:
                                              return 'MON';
                                            case 2:
                                              return 'TUE';
                                            case 3:
                                              return 'WED';
                                            case 4:
                                              return 'THU';
                                            case 5:
                                              return 'FRI';
                                            case 6:
                                              return 'SAT';
                                          }
                                          return '';
                                        },
                                        margin: 8,
                                        interval: 1,
                                      ),
                                      leftTitles: SideTitles(
                                        showTitles: true,
                                        getTextStyles: (context, value) =>
                                            const TextStyle(
                                          color: Color(0xff67727d),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        getTitles: (value) {
                                          switch (value.toInt()) {
                                            case 1:
                                              return '100';
                                            case 3:
                                              return '500';
                                            case 5:
                                              return '1k';
                                          }
                                          return '';
                                        },
                                        reservedSize: 32,
                                        interval: 1,
                                        margin: 12,
                                      ),
                                      topTitles: SideTitles(showTitles: false),
                                      rightTitles:
                                          SideTitles(showTitles: false),
                                    ),
                                    borderData: FlBorderData(
                                        show: true,
                                        border: Border.all(
                                            color: const Color(0xff37434d),
                                            width: 1)),
                                    minX: 0,
                                    maxX: 6,
                                    minY: 0,
                                    maxY: 6,
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: [
                                          FlSpot(
                                              0,
                                              graphData.items[0].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[0].count
                                                          .toDouble() /
                                                      100),
                                          FlSpot(
                                              1,
                                              graphData.items[1].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[1].count
                                                          .toDouble() /
                                                      100),
                                          FlSpot(
                                              2,
                                              graphData.items[2].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[2].count
                                                          .toDouble() /
                                                      100),
                                          FlSpot(
                                              3,
                                              graphData.items[3].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[3].count
                                                          .toDouble() /
                                                      100),
                                          FlSpot(
                                              4,
                                              graphData.items[4].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[4].count
                                                          .toDouble() /
                                                      100),
                                          FlSpot(
                                              5,
                                              graphData.items[5].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[5].count
                                                          .toDouble() /
                                                      100),
                                          FlSpot(
                                              6,
                                              graphData.items[6].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[6].count
                                                          .toDouble() /
                                                      100),
                                        ],
                                        isCurved: true,
                                        colors: [
                                          ColorTween(
                                                  begin: gradientColors[0],
                                                  end: gradientColors[1])
                                              .lerp(0.2)!,
                                          ColorTween(
                                                  begin: gradientColors[0],
                                                  end: gradientColors[1])
                                              .lerp(0.2)!,
                                        ],
                                        barWidth: 5,
                                        isStrokeCapRound: true,
                                        dotData: FlDotData(
                                          show: false,
                                        ),
                                        belowBarData:
                                            BarAreaData(show: true, colors: [
                                          ColorTween(
                                                  begin: gradientColors[0],
                                                  end: gradientColors[1])
                                              .lerp(0.2)!
                                              .withOpacity(0.1),
                                          ColorTween(
                                                  begin: gradientColors[0],
                                                  end: gradientColors[1])
                                              .lerp(0.2)!
                                              .withOpacity(0.1),
                                        ]),
                                      ),
                                    ],
                                  )
                                : LineChartData(
                                    gridData: FlGridData(
                                      show: true,
                                      drawVerticalLine: true,
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                          color: const Color(0xff37434d),
                                          strokeWidth: 1,
                                        );
                                      },
                                      getDrawingVerticalLine: (value) {
                                        return FlLine(
                                          color: const Color(0xff37434d),
                                          strokeWidth: 1,
                                        );
                                      },
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles:
                                          SideTitles(showTitles: false),
                                      topTitles: SideTitles(showTitles: false),
                                      bottomTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 22,
                                        interval: 1,
                                        getTextStyles: (context, value) =>
                                            const TextStyle(
                                                color: Color(0xff68737d),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                        getTitles: (value) {
                                          switch (value.toInt()) {
                                            case 0:
                                              return 'SUN';
                                            case 1:
                                              return 'MON';
                                            case 2:
                                              return 'TUE';
                                            case 3:
                                              return 'WED';
                                            case 4:
                                              return 'THU';
                                            case 5:
                                              return 'FRI';
                                            case 6:
                                              return 'SAT';
                                          }
                                          return '';
                                        },
                                        margin: 8,
                                      ),
                                      leftTitles: SideTitles(
                                        showTitles: true,
                                        interval: 1,
                                        getTextStyles: (context, value) =>
                                            const TextStyle(
                                          color: Color(0xff67727d),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        getTitles: (value) {
                                          switch (value.toInt()) {
                                            case 1:
                                              return '10';
                                            case 3:
                                              return '50';
                                            case 5:
                                              return '100';
                                          }
                                          return '';
                                        },
                                        reservedSize: 32,
                                        margin: 12,
                                      ),
                                    ),
                                    borderData: FlBorderData(
                                        show: true,
                                        border: Border.all(
                                            color: const Color(0xff37434d),
                                            width: 1)),
                                    minX: 0,
                                    maxX: 6,
                                    minY: 0,
                                    maxY: 6,
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: [
                                          FlSpot(
                                              0,
                                              graphData.items[0].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[0].count
                                                          .toDouble() /
                                                      10),
                                          FlSpot(
                                              1,
                                              graphData.items[1].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[1].count
                                                          .toDouble() /
                                                      10),
                                          FlSpot(
                                              2,
                                              graphData.items[2].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[2].count
                                                          .toDouble() /
                                                      10),
                                          FlSpot(
                                              3,
                                              graphData.items[3].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[3].count
                                                          .toDouble() /
                                                      10),
                                          FlSpot(
                                              4,
                                              graphData.items[4].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[4].count
                                                          .toDouble() /
                                                      10),
                                          FlSpot(
                                              5,
                                              graphData.items[5].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[5].count
                                                          .toDouble() /
                                                      10),
                                          FlSpot(
                                              6,
                                              graphData.items[6].count
                                                          .toDouble() ==
                                                      null
                                                  ? 0
                                                  : graphData.items[6].count
                                                          .toDouble() /
                                                      10),
                                        ],
                                        isCurved: true,
                                        colors: gradientColors,
                                        barWidth: 5,
                                        isStrokeCapRound: true,
                                        dotData: FlDotData(
                                          show: false,
                                        ),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          colors: gradientColors
                                              .map((color) =>
                                                  color.withOpacity(0.3))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      )),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                  fontSize: 12,
                  color:
                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // LineChartData mainData() {
  //   return;
  // }

  // LineChartData avgData() {
  //   return;
  // }
}
