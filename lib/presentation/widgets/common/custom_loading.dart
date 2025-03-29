import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:country_details/core/theme/app_theme.dart';

class CustomLoading extends StatelessWidget {
  final double size;
  final Color? color;

  const CustomLoading({
    super.key,
    this.size = 40.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: color ?? AppTheme.accentColor,
        size: size,
      ),
    );
  }
} 