import 'package:expenser_app/app_constants.dart';
import 'package:expenser_app/app_widgets/app_button.dart';
import 'package:expenser_app/app_widgets/app_form_field.dart';
import 'package:expenser_app/database/app_database.dart';
import 'package:expenser_app/model/user_table_model.dart';
import 'package:expenser_app/ui_helper/app_styles.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late MediaQueryData mq;

  final formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late String check;
  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/image/expenses.png',width:35,height:35,),
            gap(height: 0,width: 5),
            Column(
              children: [
                gap(),
                Text(AppConsts.appName,style:AppHeadings.hading3 ,),
              ],
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottomOpacity: 0,
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return _portrait();
          } else {
            return _landScape();
          }
        },
      ),
    );
  }

  _portrait() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Text(
              'Create an account',
              style: AppHeadings.hading1,
            ),
            gap(),
            Text(
              'Sign up now and unlock exclusive access!',
              style: AppSubHeadings.loginSubHading,
            ),
            gap(),
            Form(
              key: formKey,
              child: Column(
                children: [
                  AppTextField(
                      textFieldHeading: 'Your name',
                      tittleStyle: AppHeadings.hading3,
                      hintText: 'Enter your name',
                      widthByMdQuery: 0.9,
                      controller: _nameController,
                      validation: (String? value) {
                        if (value == null || value == '') {
                          return 'Please enter any name ';
                        }
                      }),
                  gap(height: 5),
                  AppTextField(
                      textFieldHeading: 'Email',
                      tittleStyle: AppHeadings.hading3,
                      hintText: 'your@email.com',
                      widthByMdQuery: 0.9,
                      controller: _emailController,
                      validation: (String? value) {
                        if (value == null||value.isEmpty) {
                          return 'Please enter valid email ';
                        }else if(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                          return null;
                        }
                        return check==null?'invalid email':check;
                      }),
                  gap(height: 5),
                  AppTextField(
                    textFieldHeading: 'Password',
                    tittleStyle: AppHeadings.hading3,
                    hintText: 'Enter your password',
                    widthByMdQuery: 0.9,
                    controller: _passwordController,
                    validation: (String? value) {
                      if (value == '' || value!.length < 8) {
                        return 'Password length should be greater than or equals to 8 ';
                      }
                    },
                    isThereIcon: true,
                  ),
                  gap(height: 5),
                  AppTextField(
                    textFieldHeading: 'Confirm password',
                    tittleStyle: AppHeadings.hading3,
                    hintText: '******************',
                    widthByMdQuery: 0.9,
                    controller: _confirmPasswordController,
                    validation: (String? value) {
                      if (value != _passwordController.text) {
                        return 'Please enter same password ';
                      }
                    },
                    isThereIcon: true,
                  ),
                ],
              ),
            ),
            AppButton(
                widthByMdQuery: 0.9,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                   check= await AppDatabase().addUserAccount(UserModel(userEmail:_emailController.text,
                       userPassword: _passwordController.text, userName:_nameController.text));
                    Navigator.pop(context);
                  }
                },
                buttonName: 'Create Account',
                buttonColor: Colors.purple),
            gap(),
            AppButton(
                widthByMdQuery: 0.9,
                onPressed: () {Navigator.pop(context);},
                buttonName: 'Sign in',
                buttonColor: Colors.black),
            gap(),
            Row(
              children: [
                Icon(Icons.email),
                Text(
                  'Help@${AppConsts.appName}.com',
                  style: AppHeadings.hading3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _landScape() {
    return SingleChildScrollView(
      child: Center(
        child: Column(children: [
          gap(height: 30),
          Text(
            'Create an account',
            style: AppHeadings.hading1,
          ),
          gap(),
          Text(
            'Sign up now and unlock exclusive access!',
            style: AppSubHeadings.loginSubHading,
          ),
          gap(height: 20),
          Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextField(
                        textFieldHeading: 'Your name',
                        tittleStyle: AppHeadings.hading3,
                        hintText: 'Enter your name',
                        widthByMdQuery: 0.4,
                        controller: _nameController,
                        validation: (String? value) {
                          if (value == null || value == '') {
                            return 'Please enter any name ';
                          }
                        }),
                    gap(width: 10),
                    AppTextField(
                        textFieldHeading: 'Email',
                        tittleStyle: AppHeadings.hading3,
                        hintText: 'your@email.com',
                        widthByMdQuery: 0.4,
                        controller: _emailController,
                        validation: (String? value) {
                          if (value == null||value.isEmpty) {
                            return 'Please enter valid email ';
                          }else if(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                            return null;
                          }
                          return 'invalid email';
                        }),
                  ],
                ),
                gap(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextField(
                      textFieldHeading: 'Password',
                      tittleStyle: AppHeadings.hading3,
                      hintText: 'Enter your password',
                      widthByMdQuery: 0.4,
                      controller: _passwordController,
                      validation: (String? value) {
                        if (value == '' || value!.length < 8) {
                          return 'Please enter valid password ';
                        }
                      },
                      isThereIcon: true,
                    ),
                    gap(width: 10),
                    AppTextField(
                      textFieldHeading: 'Confirm password',
                      tittleStyle: AppHeadings.hading3,
                      hintText: '******************',
                      widthByMdQuery: 0.4,
                      controller: _confirmPasswordController,
                      validation: (String? value) {
                        if (value != _passwordController.text) {
                          return 'Please enter valid password ';
                        }
                      },
                      isThereIcon: true,
                    ),
                  ],
                )
              ],
            ),
          ),
          gap(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                  widthByMdQuery: 0.4,
                  onPressed: () async {
                    if (formKey.currentState!.validate()){
                      await AppDatabase().addUserAccount(UserModel(userEmail:_emailController.text, userPassword: _passwordController.text, userName:_nameController.text));
                      Navigator.pop(context);
                    }
                  },
                  buttonName: 'Create Account',
                  buttonColor: Colors.purple),
              gap(width: 10),
              AppButton(
                  widthByMdQuery: 0.4,
                  onPressed: () {Navigator.pop(context);},
                  buttonName: 'Sign in',
                  buttonColor: Colors.black),
            ],
          ),
          gap(height: 30),
          Row(
            children: [
              Icon(Icons.email),
              Text(
                'Help@${AppConsts.appName}.com',
                style: AppHeadings.hading3,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
