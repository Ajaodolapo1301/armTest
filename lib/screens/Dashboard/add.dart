


import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/screens/reusables/custom_button.dart';
import 'package:arm_test/sizeConfig/sizeConfig.dart';
import 'package:flutter/material.dart';


class Add extends StatefulWidget {
  const Add({Key key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Text("Title"),
          Container(

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Address is required";
                    }

                    if (value.length < 10) {
                      return "Enter full address";
                    }

                    return null;
                  },
                  style: TextStyle(
                      color:  kPrimaryColor),

                  decoration:
                  InputDecoration(
                    contentPadding: const EdgeInsets.all(kPaddingM),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    labelText: "Title",
                    labelStyle: TextStyle(
                      fontSize: 1.8 * SizeConfig.textMultiplier ,
//                        color:  Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),

                    fillColor: Colors.transparent,
                    filled: true,
                  ),

                )
              ],
            ),
          ),
          Text("Description"),
          Container(

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Address is required";
                    }

                    if (value.length < 10) {
                      return "Enter full address";
                    }

                    return null;
                  },
                  style: TextStyle(
                      color:  kPrimaryColor),

                  decoration:
                  InputDecoration(
                    contentPadding: const EdgeInsets.all(kPaddingM),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    alignLabelWithHint: true,
                    labelText: "Description",
                    labelStyle: TextStyle(
                      fontSize: 1.8 * SizeConfig.textMultiplier ,
//                        color:  Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),

                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                  keyboardType:
                  TextInputType
                      .multiline,
                  maxLines: 5,
                  maxLength: 100,
                )
              ],
            ),
          ),

          CustomButton(
            textColor: Colors.black,
            text: "Add item".toUpperCase(),
            onPressed: () async {

            },
          ),
        ],
      ),
    );
  }
}
