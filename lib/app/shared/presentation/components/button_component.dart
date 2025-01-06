import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/framework/theme/spacings/spacings.dart';

class ButtonComponent extends StatelessWidget {
  final bool expanded;
  final String text;
  final Color? color;
  final BorderRadius? radius;
  final Border? border;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final bool Function()? validator;
  final double? width;
  final Color? textColor;
  final Color? borderColor;
  final double? verticalPadding;
  final double? horizontalPadding;
  final bool isLoading;

  const ButtonComponent({
    super.key,
    this.expanded = false,
    required this.text,
    this.color,
    required this.onPressed,
    this.padding,
    this.validator,
    this.radius,
    this.border,
    this.width,
    this.textColor,
    this.borderColor,
    this.verticalPadding,
    this.horizontalPadding,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? (expanded ? double.maxFinite : null),
      decoration: BoxDecoration(
        borderRadius: radius,
        border: border,
      ),
      child: ElevatedButton(
        onPressed: (validator == null ? true : validator!()) && (!isLoading)
            ? onPressed
            : null,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            padding ??
                EdgeInsets.symmetric(
                  horizontal: horizontalPadding ?? Spacings.spacing20,
                  vertical: verticalPadding ?? Spacings.spacing20,
                ),
          ),
          elevation: WidgetStateProperty.all(0.0),
          backgroundColor: (validator == null ? true : validator!())
              ? WidgetStateProperty.all(
                  color ?? const Color(0xff9A1A87),
                )
              : WidgetStateProperty.all(
                  const Color(0xff9A1A87).withOpacity(0.5),
                ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
              ),
              borderRadius: radius ?? BorderRadius.circular(Spacings.spacing8),
            ),
          ),
        ),
        child: isLoading
            ? const CupertinoActivityIndicator(
                color: Colors.white,
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: Spacings.spacing14,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}
