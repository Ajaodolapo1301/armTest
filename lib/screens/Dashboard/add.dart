import 'dart:io';

import 'package:arm_test/Services/database.dart';
import 'package:arm_test/constants/colorConstants.dart';
import 'package:arm_test/model/postModel.dart';
import 'package:arm_test/screens/Dashboard/homeList.dart';
import 'package:arm_test/screens/reusables/custom_button.dart';
import 'package:arm_test/sizeConfig/commonUtils.dart';
import 'package:arm_test/sizeConfig/navigation/navigator.dart';
import 'package:arm_test/sizeConfig/sizeConfig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Add extends StatefulWidget {
  final Post post;
  const Add({Key key, this.post}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController idfileController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  User user;
  TextEditingController title = TextEditingController();

  TextEditingController desc = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File idFile;
  var imageUrl;

  ProgressDialog pd;
  void showLoadingDialog(context) async {
    pd = await CommonUtils.showProgressDialog(
        context, "Processing...Please wait!");
  }

  getCurrent() async {
    user = auth.currentUser;
    print(user);
  }



  // getCurrent()async{
  //   final user = await auth.currentUser();
  //   if(user != null){
  //     loggedInUser = user;
  //   }
  //   print(loggedInUser.email);
  //

  //
  //
  //
  //
  // }

  @override
  void initState() {
    super.initState();

    getCurrent();
    if(widget.post != null){
      print(widget.post.image);
      idfileController.text = widget.post.image;
      title.text = widget.post.title;
      desc.text = widget.post.desc;
    }
  }
  @override
  Widget build(BuildContext context) {
    getCurrent();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(

          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            pop(context);
          },
        ),
        actions: [
        widget.post != null ? IconButton(icon: Icon(Icons.delete, color: blue,), onPressed: (){
              Delete(context);
          }) : SizedBox()
        ],
        title: Text(
          " ${widget.post == null ? "Add Personal Notes " : "Edit Personal Notes"}",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 1.3 * SizeConfig.textMultiplier,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: title,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Title is required";
                            }
                            return null;
                          },
                          style: TextStyle(color: kPrimaryColor),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(kPaddingM),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: borderBlue.withOpacity(0.35)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color:  borderBlue.withOpacity(0.35),
                              ),
                            ),
                            hintText: "Title",
                            hintStyle: TextStyle(
                              fontSize: 1.8 * SizeConfig.textMultiplier,
//                        color:  Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                            fillColor: lightBlue,
                            filled: true,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.8 * SizeConfig.textMultiplier,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Image",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 1.3 * SizeConfig.textMultiplier,
                  ),
                  InkWell(
                    onTap: () async {

                      idFile = await getFile();
                      setState(() {
                        idfileController.text = basename(idFile.path);
                      });
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(

                            onTap: () async {

                              idFile = await getFile();
                              setState(() {
                                idfileController.text = basename(idFile?.path);
                              });
                            },
                            controller: idfileController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "image is required";
                              }

                              return null;
                            },
                            style: TextStyle(color: kPrimaryColor),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(kPaddingM),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: borderBlue.withOpacity(0.35)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color:  borderBlue.withOpacity(0.35),
                                ),
                              ),
                              hintText: "Image",
                              hintStyle: TextStyle(
                                fontSize: 1.8 * SizeConfig.textMultiplier,
//                        color:  Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: lightBlue,
                              filled: true,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.8 * SizeConfig.textMultiplier,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 1.3 * SizeConfig.textMultiplier,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: desc,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Desc is required";
                            }

                            return null;
                          },
                          style: TextStyle(color: kPrimaryColor),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(kPaddingM),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: borderBlue.withOpacity(0.35)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color:  borderBlue.withOpacity(0.35),
                              ),
                            ),
                            alignLabelWithHint: true,
                            hintText: "Description",
                            hintStyle: TextStyle(
                              fontSize: 1.8 * SizeConfig.textMultiplier,
//                        color:  Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                            fillColor: lightBlue,
                            filled: true,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          maxLength: 100,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.8 * SizeConfig.textMultiplier,
              ),

              CustomButton(

                color: cyan,
                type: ButtonType.filled,
                textColor: Colors.white,
                text: widget.post != null ? "Edit Post".toUpperCase() :  "Add Post".toUpperCase(),
                onPressed: () async {
                  if(formKey.currentState.validate()){
                    widget.post != null  ?
                    Edit(context) :
                    uploadImage(context);
                  }
                },
              ),
            ],
          ),
        )
      ),
    );
  }



  Delete(context){
    showLoadingDialog(context);
    Database.deleteItem(docId: widget.post.id);
    CommonUtils.showAlertDialog(context: context, text: "Delete Succesfully", onClose: (){
    pop(context);
    pop(context);
    pop(context);
    });

  }


  Edit(context){
    showLoadingDialog(context);


    Database.updateItem(
      title: title.text,
        description: desc.text,
        docId: widget.post.id,
        sender: user.email,
        imageUrl: imageUrl ?? widget.post.image

    );
    // pop(context);

    CommonUtils.showAlertDialog(context: context, text: "Edited Succesfully", onClose: (){
      pop(context);
      pop(context);
      pop(context);
    });
  }



  uploadImage(context) async {
    showLoadingDialog(context);
    final _firebaseStorage = FirebaseStorage.instance;
      if (idFile != null){
        //Upload to Firebase
        var snapshot = await _firebaseStorage.ref()
            .child('images/imageName')
            .putFile(idFile);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });

        print(imageUrl);
        Database.addItem(
          title: title.text,
          sender: user.email,
          description: desc.text,
          imageUrl: imageUrl
        );

        pop(context);
    CommonUtils.showAlertDialog(context: context, text: "Added succesfully", onClose: (){
pop(context);
pop(context);
    });
      } else {
        print('No Image Path Received');
      }
    }
  }


