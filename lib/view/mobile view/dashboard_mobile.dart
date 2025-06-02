import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mockapp/model/dashboard_model.dart';
import 'package:mockapp/res/colors.dart';
import 'package:mockapp/res/font_family.dart';
import 'package:mockapp/res/svg_icons.dart';
import 'package:mockapp/utils/format_utils.dart';
import 'package:provider/provider.dart';
import '../../res/default_padding.dart';
import '../../view model/dashboard_viewmodel.dart';

class DashboardMobile extends StatefulWidget {
  const DashboardMobile({super.key});

  @override
  State<DashboardMobile> createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final dashboardProvider = Provider.of<DashboardViewModel>(context);
    final dashboardData = dashboardProvider.dashboard;

    return dashboardProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : dashboardProvider.errorMessage != null
            ? Center(child: Text(dashboardProvider.errorMessage!))
            : dashboardProvider.dashboard == null
                ? Center(
                    child: ElevatedButton(
                      onPressed: dashboardProvider.fetchDashboard,
                      child: const Text('Load Dashboard'),
                    ),
                  )
                : Scaffold(
                    key: _scaffoldKey,
                    backgroundColor: AppColors.backgroundColor,
                    appBar: buildAppBar(
                        title: dashboardData!.appbarTitle,
                        scaffoldKey: _scaffoldKey),
                    drawer: Drawer(),
                    body: buildDashboard(dashboardData),
                  );
  }

  SingleChildScrollView buildDashboard(DashboardModel dashboardData) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...buildCreditLimit(
              approvedLimit: dashboardData.creditLimits.approvedLimit,
              availableLimit: dashboardData.creditLimits.availableLimit,
              utilizedLimit: dashboardData.creditLimits.utilizedLimit,
              title: dashboardData.creditLimits.title,
              approvedLimitLabel: dashboardData.labels.approvedLimit,
              availableLimitLabel: dashboardData.labels.availableLimit,
              utilizedLimitLabel: dashboardData.labels.utilized,
            ),
            SizedBox(
              height: AppPadding.sm,
            ),
            ...dashboardData.floorplans.map(
              (floorplan) => buildFloorPlanUnitsCard(
                approvedLimit: floorplan.permanentLimit,
                availableLimit: floorplan.availableBalance,
                utilizedLimit: floorplan.utilized,
                floorPlanUnits: floorplan.unitCount,
                floorPlanUnitsStatus: floorplan.status,
                floorPlanUnitsLabel: dashboardData.labels.floorplanUnits,
                permanentLimitLabel: dashboardData.labels.permanentLimit,
                availableLimitLabel: dashboardData.labels.availableLimit,
                utilizedLabel: dashboardData.labels.utilized,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildCreditLimit({
    required double approvedLimit,
    required double availableLimit,
    required double utilizedLimit,
    required String title,
    required String approvedLimitLabel,
    required String availableLimitLabel,
    required String utilizedLimitLabel,
  }) {
    return [
      Text(
        title,
        style: TextStyle(
          fontFamily: AppFonts.elzaRoundVariable,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      SizedBox(height: AppPadding.md),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildLimitCard(
              iconColor: AppColors.approvedLimitCircle,
              iconPath: AppIcons.fileIcon,
              value: approvedLimit,
              title: approvedLimitLabel),
          SizedBox(
            width: AppPadding.sm,
          ),
          buildLimitCard(
            iconColor: AppColors.utilizedLimitCircle,
            iconPath: AppIcons.fileTickedIcon,
            value: utilizedLimit,
            title: utilizedLimitLabel,
          ),
        ],
      ),
      SizedBox(
        height: AppPadding.sm,
      ),
      Row(
        children: [
          buildLimitCard(
            iconColor: AppColors.availableLimitCircle,
            iconPath: AppIcons.filePenIcon,
            value: availableLimit,
            title: availableLimitLabel,
          ),
        ],
      ),
    ];
  }

  Padding buildFloorPlanUnitsCard({
    required double approvedLimit,
    required double availableLimit,
    required double utilizedLimit,
    required int floorPlanUnits,
    required String floorPlanUnitsStatus,
    required String floorPlanUnitsLabel,
    required String permanentLimitLabel,
    required String availableLimitLabel,
    required String utilizedLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.md),
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: AppColors.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$floorPlanUnits',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppFonts.elzaRoundVariable,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0x2908B1A2),
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: Text(
                              floorPlanUnitsStatus,
                              style: TextStyle(
                                color: Color(0xFF08B1A2),
                                fontFamily: AppFonts.elzaRoundVariable,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      floorPlanUnitsLabel,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontFamily: AppFonts.elzaRoundVariable,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: AppPadding.xxl,
                    ),
                    SliderPopupGradient(
                      approvedLimit: approvedLimit,
                      availableLimit: availableLimit,
                      utilizedLimit: utilizedLimit,
                      utilizedLimitLabel: utilizedLabel,
                    ),
                    SizedBox(
                      height: AppPadding.sm,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          permanentLimitLabel,
                          style: TextStyle(
                            fontFamily: AppFonts.elzaRoundVariable,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                        Text(
                          availableLimitLabel,
                          style: TextStyle(
                            fontFamily: AppFonts.elzaRoundVariable,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${approvedLimit.toFormattedString()}',
                          style: TextStyle(
                            fontFamily: AppFonts.elzaRoundVariable,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${availableLimit.toFormattedString()}',
                          style: TextStyle(
                            fontFamily: AppFonts.elzaRoundVariable,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar({required title, required scaffoldKey}) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      shadowColor: Colors.black,
      elevation: 1.0,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SizedBox(height: AppSpacing.md),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              child: SvgPicture.asset(
                AppIcons.bellIcon,
                width: 25,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 34,
                  fontFamily: AppFonts.elza,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildLimitCard(
      {required Color iconColor,
      required String iconPath,
      required double value,
      required String title}) {
    return Expanded(
      child: Card(
        color: AppColors.cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.md),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: iconColor,
                child: SvgPicture.asset(
                  iconPath,
                  width: 25,
                ),
              ),
              SizedBox(height: AppPadding.md),
              Text(
                value.toFormattedString(),
                style: TextStyle(
                  fontFamily: AppFonts.elzaRoundVariable,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: AppFonts.elzaRoundVariable,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderPopupGradient extends StatefulWidget {
  final double approvedLimit;
  final double availableLimit;
  final double utilizedLimit;
  final String utilizedLimitLabel;

  const SliderPopupGradient(
      {super.key,
      required this.approvedLimit,
      required this.availableLimit,
      required this.utilizedLimit,
      required this.utilizedLimitLabel});

  @override
  State<SliderPopupGradient> createState() => _SliderPopupGradientState();
}

class _SliderPopupGradientState extends State<SliderPopupGradient> {
  double _value = 0.5;

  final TextStyle popupTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  String get popupText =>
      '${widget.utilizedLimitLabel}: \$${widget.utilizedLimit.toFormattedString()}';

  double _calculatePopupWidth(String text, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return painter.size.width + 24; // Padding inside the container
  }

  double calculateNormalized() =>
      1 - (widget.availableLimit / widget.approvedLimit);

  double _calculateThumbPosition(double sliderWidth) {
    return _value * sliderWidth;
  }

  @override
  void initState() {
    super.initState();
    _value = calculateNormalized();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final sliderWidth = constraints.maxWidth;
          final popupWidth = _calculatePopupWidth(popupText, popupTextStyle);

          final thumbX = _calculateThumbPosition(sliderWidth);
          double popupLeft = thumbX - (popupWidth / 2);

          popupLeft = popupLeft.clamp(0.0, sliderWidth - popupWidth);

          return Stack(
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.none,
            children: [
              // Gradient bar
              Container(
                height: 8,
                width: sliderWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4FC71A), Color(0xFF07A5CB)],
                  ),
                ),
              ),

              // Slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbColor: Colors.green,
                  trackHeight: 0,
                  thumbShape: TriangleThumbShape(
                    thumbRadius: 10,
                    verticalOffset: -4,
                    triangleWidth: 10,
                    triangleHeight: 7,
                  ),
                  inactiveTrackColor: Colors.transparent,
                  activeTrackColor: Colors.transparent,
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: Slider(
                  value: _value, onChanged: (_) {},
                  // onChanged: (val) => setState(() => _value = val),
                ),
              ),

              // Popup
              Positioned(
                left: popupLeft,
                top: -38,
                child: Container(
                  width: popupWidth,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4FC71A), Color(0xFF07A5CB)],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Text(
                      popupText,
                      maxLines: 1,
                      style: popupTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TriangleThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double verticalOffset;

  // Triangle size
  final double triangleWidth;
  final double triangleHeight;

  TriangleThumbShape(
      {this.thumbRadius = 10,
      this.verticalOffset = 0,
      required this.triangleWidth,
      required this.triangleHeight});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size(thumbRadius * 2, thumbRadius * 2); // more accurate touch size

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    // Draw the circle thumb
    final circlePaint = Paint()..color = sliderTheme.thumbColor ?? Colors.blue;
    canvas.drawCircle(center, thumbRadius, circlePaint);

    // Gradient rectangle positioned above the thumb
    final Rect gradientRect = Rect.fromLTWH(
      center.dx - triangleWidth / 2,
      center.dy - thumbRadius - triangleHeight + verticalOffset,
      triangleWidth,
      triangleHeight,
    );

    // Gradient paint with your colors
    final Paint trianglePaint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFF4FC71A), Color(0xFF07A5CB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(gradientRect);

    // Triangle path pointing DOWN but positioned ABOVE the thumb
    final Path path = Path()
      ..moveTo(center.dx, center.dy - thumbRadius + verticalOffset) // tip
      ..lineTo(center.dx - triangleWidth / 2,
          center.dy - thumbRadius - triangleHeight + verticalOffset) // left
      ..lineTo(center.dx + triangleWidth / 2,
          center.dy - thumbRadius - triangleHeight + verticalOffset) // right
      ..close();

    canvas.drawPath(path, trianglePaint);
  }
}
