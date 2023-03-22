import 'package:dashborad/data/local/constans/appImages.dart';
import 'package:dashborad/presentation/wedgits/glassmorphism_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomScaffold extends StatelessWidget {
  Widget? child;
  Widget? customBody;
  Widget? drawer;
  Key? customKey;

  CustomScaffold({
    this.customBody,
    this.customKey,
    this.drawer,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: key,
      drawer: drawer,
      body: customBody == null
          ? Container(
              height: screenSize.height,
              width: screenSize.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.backGround),
                  fit: BoxFit.cover,
                ),
              ),
              child: child,
            )
          : customBody,
    );
  }
}
