import 'package:expenser_app/app_constants.dart';
import 'package:expenser_app/app_widgets/app_button.dart';
import 'package:expenser_app/app_widgets/app_form_field.dart';
import 'package:expenser_app/database/app_database.dart';
import 'package:expenser_app/model/user_table_model.dart';
import 'package:expenser_app/screens/home_page.dart';
import 'package:expenser_app/screens/onbording%20screens/sign_up.dart';
import 'package:expenser_app/screens/onbording%20screens/splace_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui_helper/app_styles.dart';
class LoginPage extends StatefulWidget {
   LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserModel?check;
   final formKey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
       child: SingleChildScrollView(
         child: Center(
            child: Column(
              children: [
                 gap(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/image/expenses.png',width:45,height:40,),
                    gap(height: 0,width: 5),
                    Column(
                      children: [
                        gap(),
                        Text(AppConsts.appName,style:AppHeadings.hading1 ,),
                      ],
                    )
                  ],
                ),
                gap(),
                Text('Login now to manage your Expense',style:AppSubHeadings.loginSubHading,),
                gap(height: 40),
              Form(
                key: formKey,
                  child: Column(
                    children: [
                      AppTextField(textFieldHeading: 'Email id', tittleStyle:AppHeadings.hading3, hintText: 'your@email.com', widthByMdQuery:0.9, controller:emailController, validation:(String?value){
                      }),
                      gap(),
                      AppTextField(textFieldHeading: 'Password', tittleStyle:AppHeadings.hading3, hintText: 'Enter your password', widthByMdQuery:0.9, controller:passwordController, validation:(String?value){},isThereIcon: true,),
                    ],
                  )
              ),
               gap(height: 30),
                AppButton(widthByMdQuery: 0.9,
                    onPressed:() async {
                   check=await AppDatabase().loginUserAccount(emailController.text,passwordController.text);
                  if(check!=null)
                  {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>HomePage(emailId: emailController.text,)));
                    var pref = await SharedPreferences.getInstance();
                    pref.setString(SplashScreenState.LOGIN_ID,emailController.text.toString());
                  }
                  }, buttonName: 'Login ', buttonColor: Colors.purple),
                gap(),
                AppButton(widthByMdQuery: 0.9, onPressed:(){Navigator.push(context,MaterialPageRoute(builder:(context)=>SignUpPage()));}, buttonName: 'create Account', buttonColor: Colors.black),
                gap(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email),
                    Text('Help@${AppConsts.appName}.com',style:AppHeadings.hading3,),
                  ],
                ),
              ],
            ),
          ),
       ),
     ),
    );

  }
}
