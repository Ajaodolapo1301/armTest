import 'package:arm_test/constants/colorConstants.dart';
import 'package:flutter/material.dart';



import 'navigation/navigator.dart';

class Header extends StatelessWidget {
  final String text;
 final bool register;
  final VoidCallback preferredActionOnBackPressed;

  const Header({
    Key key,
    this.text,
    this.register= false,
    this.preferredActionOnBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
    register ?     Container(
          height: 36,
          // width: 45,
          decoration: BoxDecoration(
              color: kPrimaryLight, borderRadius: BorderRadius.circular(60)),

          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
              color: Colors.white,
            ),
            onPressed: () {
              preferredActionOnBackPressed != null
                  ? preferredActionOnBackPressed()
                  : pop(context);
            },
          ),
        ) :    IconButton(
    icon: Icon(
    Icons.arrow_back_ios_rounded,
    size: 18,
    color: blue,
    ),
    onPressed: () {
    // FocusScopeNode currentFocus = FocusScope.of(context);
    //
    // if (!currentFocus.hasPrimaryFocus) {
    //   currentFocus.unfocus();
    // }
    preferredActionOnBackPressed != null
    ? preferredActionOnBackPressed()
        : pop(context);


    },
    ),
        Spacer(),
        Text(
          text,
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Spacer(),
        Opacity(
          opacity: 0,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
            onPressed: null,
          ),
        ),
      ],
    );
  }
}
