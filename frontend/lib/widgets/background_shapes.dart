import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BackgroundShapes extends StatelessWidget {
  const BackgroundShapes({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.purpleDark, AppColors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // Abstract circles
        Positioned(
          top: -60,
          left: -40,
          child: _blurCircle(180, AppColors.pink.withOpacity(0.4)),
        ),
        Positioned(
          bottom: -80,
          right: -30,
          child: _blurCircle(200, AppColors.light.withOpacity(0.3)),
        ),
      ],
    );
  }

  Widget _blurCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        blurRadius: 80,
      ),
    );
  }
}
