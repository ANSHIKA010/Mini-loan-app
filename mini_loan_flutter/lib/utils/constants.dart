import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

//API urls
// const String baseUrlAuth = "https://172.22.63.213:8000/api/users";
// const String baseUrlLoans = 'https://172.22.63.213:8000/api/loans';
const String baseUrlAuth = "https://mini-loan-app-cjl5.onrender.com/api/users";
const String baseUrlLoans = 'https://mini-loan-app-cjl5.onrender.com/api/loans';

//colors
const Color kPrimaryColor = Color(0xFF345FB4);
const Color kSecondaryColor = Color(0xFF6789CA);
const Color kTextBlackColor = Color(0xFF313131);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kContainerColor = Color(0xFF777777);
const Color kOtherColor = Color(0xFFF4F6F7);
const Color kTextLightColor = Color(0xFFA5A5A5);
const Color kErrorBorderColor = Color(0xFFE74C3C);

//default value
const kDefaultPadding = 20.0;

const sizedBox = SizedBox(
  height: kDefaultPadding,
);
const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);
// Snippet for border radius based on device size
final kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(Device.screenType == ScreenType.tablet ? 40 : 20),
  topRight:
  Radius.circular(Device.screenType == ScreenType.tablet ? 40 : 20),
);

final kBottomBorderRadius = BorderRadius.only(
  bottomRight: Radius.circular(Device.screenType == ScreenType.tablet ? 40 : 20),
  bottomLeft:
  Radius.circular(Device.screenType == ScreenType.tablet? 40 : 20),
);

final kInputTextStyle = GoogleFonts.poppins(
    color: kTextBlackColor,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500
);

//validation for email
const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';