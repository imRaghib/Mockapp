import 'package:flutter/material.dart';
import '../colors.dart';

class CustomGradientButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPressed;
  final double height;
  final double? width;
  final bool isActive;
  final bool isScanButton;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color foregroundColor;

  const CustomGradientButton({
    super.key,
    this.title,
    required this.onPressed,
    this.height = 50,
    this.width,
    this.isActive = true,
    this.isScanButton = false,
    this.prefixIcon,
    this.suffixIcon,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onPressed : null,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: isActive ? buttonGradient : disableButtonGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) Icon(prefixIcon, color: foregroundColor),
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (suffixIcon != null) Icon(suffixIcon, color: foregroundColor),
          ],
        ),
      ),
    );
  }
}
