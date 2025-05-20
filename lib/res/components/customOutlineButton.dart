import 'package:flutter/material.dart';
import 'package:mockapp/res/colors.dart';

class CustomOutlineButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPressed;
  final double borderRadius;
  final double width;
  final double height;
  final TextStyle? textStyle;
  final Color backgroundColor;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double borderWidth;

  const CustomOutlineButton({
    super.key,
    this.title,
    required this.onPressed,
    this.width = 160,
    this.height = 48,
    this.textStyle,
    this.borderRadius = 12,
    this.backgroundColor = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    final Color contentColor = buttonGradient.first;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: buttonGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius - borderWidth),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null) ...[
                Icon(prefixIcon, color: contentColor),
                const SizedBox(width: 6),
              ],
              if (title != null)
                Text(
                  title!,
                  style: textStyle ??
                      TextStyle(
                        color: contentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              if (suffixIcon != null) ...[
                const SizedBox(width: 6),
                Icon(suffixIcon, color: contentColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
