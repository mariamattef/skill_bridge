import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utilities/color_utilis.dart';

class OnBoardItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const OnBoardItemWidget(
      {required this.title,
      required this.image,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtility.gbScaffold,
      padding:  EdgeInsets.symmetric(horizontal: 40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            image,
          ),
           SizedBox(
            height: 40.h,
          ),
          Text(
            title,
            style:  TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
          ),
           SizedBox(
            height: 15.h,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style:  TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16.sp,
              color: ColorUtility.gray,
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 0.h,
          )
        ],
      ),
    );
  }
}
