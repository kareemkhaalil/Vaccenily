import 'dart:ui';

import 'package:dashborad/data/local/constans/appColors.dart';
import 'package:flutter/material.dart';

class GlassmorphismContainer extends StatelessWidget {
  double? width;
  double? height;
  Widget? child;
  BorderRadiusGeometry? borderRadius;
  Matrix4? customTransform;
  GlassmorphismContainer({
    Key? key,
    this.width,
    this.height,
    this.child,
    this.borderRadius,
    this.customTransform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius == null ? BorderRadius.circular(20.0) : borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          transform: customTransform,
          width: width == null ? 300.0 : width,
          height: height == null ? 300.0 : height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1580243117731-a108c2953e2c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
              fit: BoxFit.cover,
              opacity: 0.03,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: -3,
                blurRadius: 50,
              ),
            ],
            gradient: LinearGradient(
              colors: [
                AppColors.secondaryColor.withOpacity(0.2),
                AppColors.primaryColor.withOpacity(0.2),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
