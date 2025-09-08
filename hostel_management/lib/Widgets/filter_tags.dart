import 'package:flutter/material.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';

class FilterTags extends StatelessWidget {
  const FilterTags({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      height: size.height * 0.055,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.055,
            width: size.width * 0.3,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),

              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/calender.png', height: 13, width: 13),
                  SizedBox(width: 5),

                  InterTextWidget(
                    text: '12 Aug - 15 Aug',
                    fontSize: 12,
                    color: Color(0xFF000000),
                    fontWeight: FontWeightConst.medium,
                    letterSpacing: 0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Container(
            height: size.height * 0.055,
            width: size.width * 0.1,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),

              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/user-round.png', height: 13, width: 13),
                  SizedBox(width: 5),

                  InterTextWidget(
                    text: '1',
                    fontSize: 12,
                    color: Color(0xFF000000),
                    fontWeight: FontWeightConst.medium,
                    letterSpacing: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
