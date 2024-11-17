import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as google_fonts;
import 'package:sizer/sizer.dart';
import 'constants.dart';

class CustomTheme {
  var baseTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: kPrimaryColor,
    primaryColor: kPrimaryColor,
    appBarTheme: AppBarTheme(
      //height for both phone and tablet
      toolbarHeight: SizerUtil.deviceType == DeviceType.tablet ? 9.h : 7.h,
      backgroundColor: kPrimaryColor,
      titleTextStyle: google_fonts.GoogleFonts.poppins(
        fontSize: SizerUtil.deviceType == DeviceType.tablet ? 12.sp : 13.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.0,
      ),
      iconTheme: IconThemeData(
        color: kOtherColor,
        size: SizerUtil.deviceType == DeviceType.tablet ? 17.sp : 18.sp,
      ),
      elevation: 0,
    ),
    //input decoration theme for all our the app
    inputDecorationTheme: InputDecorationTheme(
      //label style for formField
      labelStyle: TextStyle(
          fontSize: 11.sp, color: kTextLightColor, fontWeight: FontWeight.w400),
      //hint style
      hintStyle: TextStyle(fontSize: 16.0, color: kTextBlackColor, height: 0.5),
      //we are using underline input border
      //not outline
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kTextLightColor, width: 0.7),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: kTextLightColor),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kTextLightColor),
      ),
      // on focus  change color
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: kPrimaryColor,
        ),
      ),
      //color changes when user enters wrong information,
      //we will use validators for this process
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kErrorBorderColor, width: 1.2),
      ),
      //same on focus error color
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: kErrorBorderColor,
          width: 1.2,
        ),
      ),
    ),
    textTheme: google_fonts.GoogleFonts.poppinsTextTheme().copyWith(
      //custom text for bodyText1
      headlineSmall: google_fonts.GoogleFonts.chewy(
        color: kTextWhiteColor,
        //condition if device is tablet or a phone
        fontSize: SizerUtil.deviceType == DeviceType.tablet ? 45.sp : 40.sp,
      ),
    ),
  );
}