import 'package:dashborad/data/local/constans/appColors.dart';
import 'package:dashborad/presentation/wedgits/glassmorphism_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAuthTextForm extends StatelessWidget {
  TextInputType? keyboardType;
  TextEditingController? controller;
  bool isPassword = false;
  Widget? sufIcon;
  Widget? preIcon;
  double? width;
  CustomAuthTextForm(
      {this.keyboardType,
      this.controller,
      this.isPassword = false,
      this.sufIcon,
      this.preIcon,
      this.width,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GlassmorphismContainer(
      width: width == null ? screenSize.width * 0.4 : width,
      height: screenSize.height * 0.1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.05,
        ),
        child: TextFormField(
          cursorRadius: Radius.circular(10),
          style: TextStyle(
            color: AppColors.backgroundColor,
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontSize: 35,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            suffixIcon: sufIcon,
            prefixIcon: preIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          keyboardType: keyboardType,
          controller: controller,
          obscureText: isPassword,
        ),
      ),
    );
  }
}
