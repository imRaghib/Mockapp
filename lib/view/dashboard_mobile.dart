import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mockapp/res/colors.dart';
import 'package:mockapp/res/svg_icons.dart';
import 'package:mockapp/utils/format_utlis.dart';
import 'dashboard_tablet_landscape.dart';

class DashboardMobile extends StatelessWidget {
  final double _approvedLimit = 1000000;
  final double _availableLimit = 31465.70;
  final double _utilizedLimit = 968543.30;

  const DashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Credit Limit Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
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
                height: 16,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
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
              SizedBox(height: 20),
              Text(
                value.toFormattedString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                title,
                style: TextStyle(
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
