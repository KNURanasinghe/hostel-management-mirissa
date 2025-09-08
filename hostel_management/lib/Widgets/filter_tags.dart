import 'package:flutter/material.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';

class FilterTags extends StatelessWidget {
  final bool isNotBlack;
  const FilterTags({super.key, this.isNotBlack = true});

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
              border: Border.all(
                color: isNotBlack ? Colors.black : Colors.white,
              ),

              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/calender.png',
                    height: 13,
                    width: 13,
                    color: isNotBlack ? Colors.black : Colors.white,
                  ),
                  SizedBox(width: 5),

                  InterTextWidget(
                    text: '12 Aug - 15 Aug',
                    fontSize: 12,
                    color: isNotBlack ? Colors.black : Colors.white,
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
              border: Border.all(
                color: isNotBlack ? Colors.black : Colors.white,
              ),

              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/user-round.png',
                    height: 13,
                    width: 13,
                    color: isNotBlack ? Colors.black : Colors.white,
                  ),
                  SizedBox(width: 5),

                  InterTextWidget(
                    text: '1',
                    fontSize: 12,
                    color: isNotBlack ? Colors.black : Colors.white,
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
