//
// import 'package:flutter/material.dart';
// import 'package:haggle/screen/signup.dart';
// import 'package:hive/hive.dart';
// import 'package:lyster_app/Model/genderModel.dart';
// import 'package:lyster_app/Model/user.dart';
// import 'package:lyster_app/api/authApi.dart';
//
//
// class LoginState extends AbstractLoginViewModel with ChangeNotifier {
//   User _user;
//   Box box;
//
//   User get user => _user;
//   set user(User value) {
//     _user = value;
//     notifyListeners();
//   }
//
//   LoginState(User value) {
//     box = Hive.box("user");
//     if (value != null) {
//       user = value;
//     }
//   }
//
//
//
//
//
//
//
//
//   @override
//   Future<Map<String, dynamic>> getAuthUser({token}) async {
//     Map<String, dynamic> result = Map();
//     try {
//       result = await Auth().getUserDetail(token: token);
//
//       print("result get user$result");
//       if (result['error'] == null) {
//         result['error'] = true;
//         result['message'] = 'An Error occured, please try again';
//       } else if (result['error'] == true) {
//         result['error'] = true;
//         result['message'] = result["message"];
//       }
//     } catch (error) {
//       print(error.toString());
//       result['error'] = true;
//       result['message'] = result["message"];
//     }
//
//     if (result['error'] == false) {
//       User user1 = result['user'];
//
//      user.is_user_owing = user1.is_user_owing;
//      // user.profilepic = user1.profilepic;
//       user = user;
//       notifyListeners();
//     }
//     print(result);
//     return result;
//   }
//
//   @override
//   Future<Map<String, dynamic>> login({email, password}) async {
//     Map<String, dynamic> result = Map();
//     try {
//       result = await Auth().login(email: email, password: password);
//       print("result $result");
//       if (result["error"] == null) {
//         result["error"] = true;
//         result['message'] = "An error occured, Please try again";
//       }
//     } catch (error) {
//       result['error'] = true;
//       result['message'] = error.toString();
//     }
//
//     if (result['error'] == false) {
//       box.put('user', result['user']);
//       user = result['user'];
//     }
//
//
// a
//
//     return result;
//   }
//
//   @override
//   Future<Map<String, dynamic>> registerStep1({firstName, lastName, phoneNumber, password, email,state, lga, gender, address,image  })async {
//     Map<String, dynamic> result = Map();
//
//     try {
//       result = await Auth().registerStep1(
//           phoneNumber: phoneNumber,
//           firstName: firstName,
//           lastName: lastName,
//           lga: lga,
//           gender: gender,
//
//           password: password,
//           email: email,
//           state: state,
//         address: address,
//
//         image: image
//
//       );
//
//       if (result["error"] == null) {
//         result["error"] = true;
//         result['message'] = result["message"];
//       }
//     } catch (error) {
//       print(error.toString());
//       result['error'] = true;
//       result['message'] = error.toString();
//     }
//
//     if (result['error'] == false) {
//
//     }
//
//
//     return result;
//
//   }
//
//   @override
//   Future<Map<String, dynamic>> getGender() async{
//     Map<String, dynamic> result = Map();
//
//
//     try{
//       result = await Auth().getGender();
//       if(result["error"] == null) {
//         result['error'] = true;
//         result['message'] = 'An Error occured, please  check your internet connection and try again';
//       }else{
//         if(result['error'] == false){
//           gender = result['gender'];
//         }
//       }
//     }catch(e){
//       print(e.toString());
//     }
//     return result;
//   }
//
//   @override
//   Future<Map<String,dynamic >> confirmEmail({ otp, user_id}) async{
//     Map<String, dynamic> result = Map();
//
//
//     try{
//       result = await Auth().confirmEmail( otp: otp, user_id: user_id);
//       if(result["error"] == null) {
//         result['error'] = true;
//         result['message'] = 'An Error occured, please  check your internet connection and try again';
//       }else{
//         if(result['error'] == false){
//           box.put('user', result['user']);
//           user = result['user'];
//         }
//       }
//     }catch(e){
//       print(e.toString());
//     }
//     return result;
//   }
//
//   @override
//   Future<Map<String,dynamic >> confirmPhone({token, user_id, otp}) async{
//     Map<String, dynamic> result = Map();
//
//
//     try{
//       result = await Auth().confirmPhone(token: token, otp: otp, user_id: user_id);
//       if(result["error"] == null) {
//         result['error'] = true;
//         result['message'] = 'An Error occured, please  check your internet connection and try again';
//       }else{
//         if(result['error'] == false){
//           result["message"] = result["message"];
//         }
//       }
//     }catch(e){
//
//     }
//     return result;
//   }
//
//   @override
//   Future<Map<String,dynamic >> verifyBVN({bvn, AuthToken}) async{
//     Map<String, dynamic> result = Map();
//
//
//     try{
//       result = await Auth().verifyBVN(bvn: bvn, AuthToken: AuthToken);
//       if(result["error"] == null) {
//         result['error'] = true;
//         result['message'] = 'An Error occured, please  check your internet connection and try again';
//       }else{
//         if(result['error'] == false){
//           result["message"] = result["message"];
//         }
//       }
//     }catch(e){
//
//     }
//     return result;
//   }
//
//   @override
//   Future<Map<String, dynamic>> verifyBVNMatch({bvn, firstName, lastname, account_number, bank_code, token}) async{
//     Map<String, dynamic> result = Map();
//
//
//     try{
//       result = await Auth().verifyBVNMatch(bvn: bvn, firstName: firstName, account_number: account_number, bank_code: bank_code,lastname: lastname, token:token );
//       if(result["error"] == null) {
//         result['error'] = true;
//         result['message'] = 'An Error occured, please  check your internet connection and try again';
//       }else{
//         if(result['error'] == false){
//           result["message"] = result["message"];
//         }
//       }
//     }catch(e){
//
//     }
//     return result;
//   }
//
//
//
//
//
//
//
//
//
//
// }
//
// abstract class AbstractLoginViewModel {
//
//
//   Future<Map<String, dynamic>> login({email, password});
//
//
//   Future<Map<String, dynamic>> getAuthUser({token});
//
//   Future<Map<String, dynamic>> confirmEmail({ user_id, otp});
//   Future<Map<String, dynamic>> confirmPhone({token, user_id, otp});
//
//
//   Future<Map<String, dynamic>> getGender();
//   Future<Map<String, dynamic>> registerStep1(
//       {firstName,
//         lastName,
//         phoneNumber,
//         password,
//         email,
//         address,
//         lga,
//         gender,
//         state,
//         image,
//       });
//   Future<Map<String, dynamic>> verifyBVN({bvn, AuthToken});
//
//   Future<Map<String, dynamic>> verifyBVNMatch({bvn,firstName, lastname, account_number, bank_code,token,});
// }