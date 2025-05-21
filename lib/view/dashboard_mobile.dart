import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:intl/intl.dart' as intl;
import 'package:mockapp/res/colors.dart';
import 'package:mockapp/res/font_family.dart';
import 'package:mockapp/res/svg_icons.dart';
import 'package:mockapp/utils/format_utlis.dart';
import '../res/default_padding.dart';
import 'dashboard_tablet_landscape.dart';

class DashboardMobile extends StatefulWidget {
  final double minLimit;
  final double maxLimit;

  const DashboardMobile({this.minLimit = 200, this.maxLimit = 300});

  @override
  State<DashboardMobile> createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  final double _approvedLimit = 1000000;

  final double _availableLimit = 31465.70;

  final double _utilizedLimit = 968543.30;

  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    // Start the slider value at minLimit or any value between min and max
    _sliderValue =
        widget.minLimit; // or (widget.minLimit + widget.maxLimit) / 2;
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        toolbarHeight: 70,
        shadowColor: Colors.black,
        elevation: 1.0,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(height: AppSpacing.md),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  AppIcons.bellIcon,
                  width: 25,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Dashboard',
                style: TextStyle(
                    fontSize: 34,
                    fontFamily: AppFonts.elza,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Credit Limit Details',
                style: TextStyle(
                  fontFamily: AppFonts.elzaRoundVariable,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildLimitCard(
                      iconColor: AppColors.approvedLimitCircle,
                      iconPath: AppIcons.fileIcon,
                      value: _approvedLimit,
                      title: 'Approved Limit'),
                  SizedBox(
                    width: 16,
                  ),
                  buildLimitCard(
                      iconColor: AppColors.utilizedLimitCircle,
                      iconPath: AppIcons.fileTickedIcon,
                      value: _utilizedLimit,
                      title: 'Utilized Limit'),
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
                      value: _availableLimit,
                      title: 'Available Limit'),
                ],
              ),
              SizedBox(
                height: AppPadding.sm,
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      color: AppColors.cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '23',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: AppFonts.elzaRoundVariable,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x2908B1A2),
                                    borderRadius: BorderRadius.circular(
                                        12), // Rounded corners
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    child: Text(
                                      'Registered',
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
                              'Floorplan Units',
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontFamily: AppFonts.elzaRoundVariable,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 8,
                                activeTrackColor: Colors.transparent,
                                inactiveTrackColor: Colors.transparent,
                                thumbColor: Colors.white,
                                overlayColor: Colors.white.withOpacity(0.2),
                                trackShape: GradientRectSliderTrackShape(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF4FC71A),
                                      Color(0xFF07A5CB)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                              child: Slider(
                                min: widget.minLimit,
                                max: widget.maxLimit,
                                value: _sliderValue.clamp(
                                    widget.minLimit, widget.maxLimit),
                                onChanged: (val) {},
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Permanent Limit',
                                  style: TextStyle(
                                    fontFamily: AppFonts.elzaRoundVariable,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                Text(
                                  'Available Balance',
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
                                  '\$${_approvedLimit.toFormattedString()}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.elzaRoundVariable,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$${_availableLimit.toFormattedString()}',
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
            ],
          ),
        ),
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

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  final LinearGradient gradient;

  GradientRectSliderTrackShape({required this.gradient});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
    Offset? secondaryOffset,
  }) {
    if (sliderTheme.trackHeight == 0) {
      return;
    }
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final paint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..style = PaintingStyle.fill;

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, Radius.circular(trackRect.height / 2)),
      paint,
    );
  }
}
