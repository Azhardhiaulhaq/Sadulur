import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/category_assessment.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';

class StatisticStorePage extends StatefulWidget {
  final UMKMUser user;
  final List<CategoryAssessment> categoryAssessments;
  const StatisticStorePage(
      {super.key, required this.categoryAssessments, required this.user});

  @override
  StatisticStorePageState createState() => StatisticStorePageState();
}

class StatisticStorePageState extends State<StatisticStorePage> {
  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;
  FlGridData get gridData => const FlGridData(show: false);
  List<LineChartBarData> lineChartData = [];
  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: AppColor.darkDatalab.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );
  int getWeekNumberOfDate(DateTime date) {
    // Create a DateTime object for the beginning of the year
    DateTime beginningOfYear = DateTime(date.year, 1, 1);

    // Calculate the difference in days between the given date and the beginning of the year
    int differenceInDays = date.difference(beginningOfYear).inDays;

    // Calculate the week number (assuming the first week starts on January 1st)
    int weekNumber = (differenceInDays ~/ 7) + 1;

    return weekNumber;
  }

  List<LineChartBarData> transformToLineChartBarData(
      List<CategoryAssessment> categoryAssessments) {
    return [
      LineChartBarData(
          isCurved: true,
          curveSmoothness: 0,
          color: AppColor.darkDatalab.withOpacity(0.5),
          barWidth: 2,
          isStrokeCapRound: true,
          aboveBarData: BarAreaData(show: false),
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
          spots: categoryAssessments.map((assessment) {
            logger.d("Get Assessment: ${assessment.createdAt}");
            return FlSpot(getWeekNumberOfDate(assessment.createdAt).toDouble(),
                assessment.businessComm.score.toDouble());
          }).toList()),
      LineChartBarData(
          isCurved: true,
          curveSmoothness: 0,
          color: AppColor.darkGreen.withOpacity(0.5),
          barWidth: 2,
          isStrokeCapRound: true,
          aboveBarData: BarAreaData(show: false),
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
          spots: categoryAssessments
              .map((assessment) => FlSpot(
                  getWeekNumberOfDate(assessment.createdAt).toDouble(),
                  assessment.businessFeas.score.toDouble()))
              .toList()),
      LineChartBarData(
          isCurved: true,
          curveSmoothness: 0,
          color: AppColor.darkOrange.withOpacity(0.5),
          barWidth: 2,
          isStrokeCapRound: true,
          aboveBarData: BarAreaData(show: false),
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
          spots: categoryAssessments
              .map((assessment) => FlSpot(
                  getWeekNumberOfDate(assessment.createdAt).toDouble(),
                  assessment.collaboration.score.toDouble()))
              .toList()),
      LineChartBarData(
          isCurved: true,
          curveSmoothness: 0,
          color: AppColor.darkRed.withOpacity(0.5),
          barWidth: 2,
          isStrokeCapRound: true,
          aboveBarData: BarAreaData(show: false),
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
          spots: categoryAssessments
              .map((assessment) => FlSpot(
                  getWeekNumberOfDate(assessment.createdAt).toDouble(),
                  assessment.decisionMaking.score.toDouble()))
              .toList()),
    ];
  }

  @override
  void initState() {
    super.initState();
    lineChartData = transformToLineChartBarData(widget.categoryAssessments);
    logger.d("chartData : ${lineChartData[0].spots}");
  }

  Widget radarInfographic() {
    return AspectRatio(
        aspectRatio: 1.5,
        child: RadarChart(
          RadarChartData(
            titleTextStyle: const TextStyle(
                color: AppColor.secondaryTextDatalab, fontSize: 14),
            getTitle: (index, angle) {
              final usedAngle =
                  relativeAngleMode ? angle + angleValue : angleValue;
              switch (index) {
                case 0:
                  return RadarChartTitle(
                    text: 'Business Communication',
                    angle: usedAngle,
                  );
                case 2:
                  return RadarChartTitle(
                    text: 'Collaboration',
                    angle: usedAngle,
                  );
                case 3:
                  return RadarChartTitle(
                    text: 'Decision Making',
                    angle: usedAngle,
                  );
                case 1:
                  return RadarChartTitle(
                      text: 'Business Feasability', angle: usedAngle);
                default:
                  return const RadarChartTitle(text: '');
              }
            },
            dataSets: showingDataSets(),
            radarShape: RadarShape.circle,
            radarBackgroundColor: Colors.transparent,
            borderData: FlBorderData(show: true),
            radarBorderData: const BorderSide(color: AppColor.darkDatalab),
            titlePositionPercentageOffset: 0.2,
            tickCount: 2,
            ticksTextStyle: const TextStyle(color: Colors.black, fontSize: 10),
            tickBorderData:
                const BorderSide(color: Colors.black, style: BorderStyle.solid),
            gridBorderData:
                const BorderSide(color: AppColor.backgroundDatalab, width: 1),
          ),
          swapAnimationDuration: const Duration(milliseconds: 400),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
            elevation: 8.0,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Nilai per Kategori",
                      style: CustomTextStyles.normalText(
                          fontSize: 16,
                          color: AppColor.darkDatalab,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    radarInfographic(),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Histori Nilai UMKM",
                      style: CustomTextStyles.normalText(
                          fontSize: 16,
                          color: AppColor.darkDatalab,
                          fontWeight: FontWeight.bold),
                    ),
                    AspectRatio(
                      aspectRatio: 1.23,
                      child: Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const SizedBox(
                                height: 37,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 16, left: 6),
                                  child: _LineChart(data: lineChartData),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 4,
                                    margin: const EdgeInsets.only(right: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      color:
                                          AppColor.darkDatalab.withOpacity(0.5),
                                    ),
                                  ),
                                  const Text("Business Communication"),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 4,
                                    margin: const EdgeInsets.only(right: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      color:
                                          AppColor.darkGreen.withOpacity(0.5),
                                    ),
                                  ),
                                  const Text("Business Feasability"),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 4,
                                    margin: const EdgeInsets.only(right: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      color:
                                          AppColor.darkOrange.withOpacity(0.5),
                                    ),
                                  ),
                                  const Text("Collaboration"),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 4,
                                    margin: const EdgeInsets.only(right: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      color: AppColor.darkRed.withOpacity(0.5),
                                    ),
                                  ),
                                  const Text("Decision Making"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Karakteristik UMKM",
                      style: CustomTextStyles.normalText(
                          fontSize: 16,
                          color: AppColor.darkDatalab,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 3,
                      runSpacing: 4,
                      children: [
                        ...widget.user.assessment.entrepreneurialAssessment
                            .characteristics
                            .map((character) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: AppColor.darkDatalab,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              character,
                              style: CustomTextStyles.tagText1,
                            ),
                          );
                        })
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    )
                  ],
                ))));
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      return RadarDataSet(
        fillColor: rawDataSet.color.withOpacity(0.2),
        borderColor: rawDataSet.color.withOpacity(0.7),
        entryRadius: 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: 'Basic Assessment',
        color: AppColor.darkDatalab,
        values: [
          widget.user.assessment.basicAssessment.businessComm.score.toDouble(),
          widget.user.assessment.basicAssessment.businessFeas.score.toDouble(),
          widget.user.assessment.basicAssessment.collaboration.score.toDouble(),
          widget.user.assessment.basicAssessment.decisionMaking.score
              .toDouble(),
        ],
      ),
    ];
  }
}

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });

  final String title;
  final Color color;
  final List<double> values;
}

class _LineChart extends StatelessWidget {
  final List<LineChartBarData> data;
  const _LineChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 48,
        maxY: 10,
        minY: 0,
      );

  LineTouchData get lineTouchData2 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: AppColor.lightGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => data;

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    TextStyle style =
        CustomTextStyles.normalText(fontSize: 10, color: AppColor.black);
    String text = value.toInt().toString();

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 5,
        reservedSize: 17,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style =
        CustomTextStyles.normalText(fontSize: 10, color: AppColor.black);
    Widget text;
    String month = "";
    if (value.toInt() > 0) {
      DateTime dateTime = DateTime.utc(2024); // Start of the year
      dateTime = dateTime.add(Duration(
          days: (value.toInt() - 1) *
              7)); // Add the appropriate number of days to reach the desired week

      month = DateFormat('MMM').format(dateTime);
    }
    text = Text(month, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 48,
        interval: 4,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData =>
      const FlGridData(show: true, drawVerticalLine: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: AppColor.darkDatalab, width: 2),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: AppColor.darkGreen.withOpacity(0.5),
        barWidth: 2,
        isStrokeCapRound: true,
        aboveBarData: BarAreaData(show: false),
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 3.8 * 3),
          FlSpot(1, 1.9 * 3),
          FlSpot(6, 5 * 3),
          FlSpot(10, 3.3 * 3),
          FlSpot(13, 4.5 * 3),
        ],
      );
}
