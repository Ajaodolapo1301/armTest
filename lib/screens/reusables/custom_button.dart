import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/sizeConfig/sizeConfig.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool showArrow;
  final Color color;
  final Color textColor;

  const CustomButton({
    Key key,
    @required this.text,
    this.onPressed,
    this.textColor,
    this.type = ButtonType.filled,
    this.showArrow = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.outlined) {
      return SizedBox(
        width: double.maxFinite,
        child: OutlineButton(

          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'BasisGrotesquePro',
              color: textColor,
              fontSize: 16
            ),
          ),
          // borderSide: BorderSide(color: cyan),
          padding: EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          highlightElevation: 0,
        ),
      );
    }else if(type == ButtonType.filled){
      return SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(

          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'BasisGrotesquePro',
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 1.4 * SizeConfig.textMultiplier,
                ),
              ),
              if (showArrow)
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.keyboard_backspace_rounded,
                    ),
                  ),
                ),
            ],
          ),
          style:  ButtonStyle(

            backgroundColor: MaterialStateProperty.all(color ?? gold),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 18),
            ),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ) ,
        ),
      );
    }else{
      return  SizedBox(
        width: double.maxFinite,
        child: InkWell(

          onTap: onPressed,
          child: Container(

            padding: EdgeInsets.symmetric(vertical: 18),

            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xff432B7B), Color(0xff6A4BBC)]),
                borderRadius:BorderRadius.circular(6),
              ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'BasisGrotesquePro',
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 1.4 * SizeConfig.textMultiplier,
                  ),
                ),
                if (showArrow)
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.keyboard_backspace_rounded,
                      ),
                    ),
                  ),
              ],
            ),
          ),

        ),
      );
    }

  }
}

enum ButtonType { outlined, filled, gradient }
