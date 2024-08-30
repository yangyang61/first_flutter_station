import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/pages/auth_vm.dart';
import 'package:flutter_first_station/routes/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPageState();
  }

}

class _RegisterPageState extends State<RegisterPage>{

  AuthViewModal authViewModal = AuthViewModal();
  TextEditingController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
   return ChangeNotifierProvider<AuthViewModal>(create: (context){
     return authViewModal;
   },
   child: Scaffold(
     body:
     Container(
       width: double.infinity,
       decoration: const BoxDecoration(color: Colors.green),
       padding: EdgeInsets.only(left: 16.w,right: 16.w),
       child: Consumer<AuthViewModal>(
         builder: (context,vm,child){
           return Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               _commonTextField(label: '请输入账号',onChanged: (value){
                 vm.registerInfo.username = value;
               }),
               SizedBox(height: 20.h,),
               _commonTextField(label: '请输入密码',obscureText:true, onChanged: (value){
                 vm.registerInfo.password = value;
               }),
               SizedBox(height: 20.h,),
               _commonTextField(label: '请再次输入密码',obscureText:true,onChanged: (value){
                 vm.registerInfo.repassword = value;
               }),
               SizedBox(height: 50.h,),
               GestureDetector(
                 onTap: (){
                   authViewModal.register().then((value) {
                     if(value == true){
                       showToast('注册成功');
                       RouteUtils.pop(context);
                     }
                   });
                 },
                 child: Container(
                   height: 40.h,
                   width: double.infinity,
                   alignment: Alignment.center,
                   decoration: BoxDecoration(border: Border.all(width: 1.r,color: Colors.white),borderRadius: BorderRadius.all(Radius.circular(20.r))),
                   child: const Text('点我注册'),
                 ),
               ),

             ],
           );
         },
       ),
     ),
   ),);
  }

  Widget _commonTextField({String? label,TextEditingController? controller,ValueChanged<String>? onChanged,bool? obscureText}) {
   return TextField(
     obscureText: obscureText ?? false ,
      controller: controller,
      onChanged: onChanged,
      cursorColor: Colors.white,
      decoration: InputDecoration(
      labelText:  label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white,width: 0.5.r),
      ),
      focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white,width: 1.r)
      )
      ),
   );
  }
}