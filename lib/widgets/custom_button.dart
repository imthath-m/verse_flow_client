import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: backgroundColor ?? AppConstants.primaryColor,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingLarge,
                  vertical: AppConstants.paddingMedium,
                ),
              ),
              child: _buildButtonContent(theme),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? AppConstants.primaryColor,
                foregroundColor: textColor ?? AppConstants.surfaceColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingLarge,
                  vertical: AppConstants.paddingMedium,
                ),
              ),
              child: _buildButtonContent(theme),
            ),
    );
  }

  Widget _buildButtonContent(ThemeData theme) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isOutlined 
                ? (backgroundColor ?? AppConstants.primaryColor)
                : (textColor ?? AppConstants.surfaceColor),
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppConstants.iconSizeMedium,
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          Text(
            text,
            style: AppConstants.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: isOutlined 
                  ? (backgroundColor ?? AppConstants.primaryColor)
                  : (textColor ?? AppConstants.surfaceColor),
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: AppConstants.bodyMedium.copyWith(
        fontWeight: FontWeight.w600,
        color: isOutlined 
            ? (backgroundColor ?? AppConstants.primaryColor)
            : (textColor ?? AppConstants.surfaceColor),
      ),
    );
  }
}
