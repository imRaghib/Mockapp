import 'package:flutter/material.dart';
import '../colors.dart';
import '../default_padding.dart';

class FooterWidget extends StatelessWidget {
  final String title;
  final String copyrightText;
  final String policyText;
  final String tosText;
  final String versionText;

  const FooterWidget(
      {super.key,
      this.title = 'Hiltermann',
      this.copyrightText = 'Copyright @ 2025.All Rights Reserved',
      this.policyText = 'Privacy Policy',
      this.tosText = 'Terms & Condition',
      this.versionText = 'Version 8.24.1545'});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppPadding.md),
        Divider(
          color: AppColors.dividerColor,
          thickness: 1,
        ),
        SizedBox(height: AppPadding.sm),
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(copyrightText),
        SizedBox(height: AppPadding.md),
        Row(
          children: [
            Text(
              policyText,
              style: TextStyle(
                color: limeGreenColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: AppPadding.sm),
            Text(
              tosText,
              style: TextStyle(
                color: limeGreenColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(versionText),
          ],
        ),
        SizedBox(height: AppPadding.md)
      ],
    );
  }
}
