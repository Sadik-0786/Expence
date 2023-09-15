import 'package:expenser_app/ui_helper/app_styles.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  AppTextField({super.key,this.inputTypeIsNumber=false,this.isThereBorderColor=false,required this.textFieldHeading,required this.tittleStyle,required this.hintText,required this.widthByMdQuery,required this.controller,this.isThereIcon=false,required this.validation,});
  String textFieldHeading;
  TextStyle tittleStyle;
  String hintText;
  double widthByMdQuery;
  TextEditingController controller;
  bool isThereIcon;
  bool inputTypeIsNumber;
  bool isThereBorderColor;
  String? Function(String?) validation;
 bool isTaped=true;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.textFieldHeading,style:widget.tittleStyle,),
        gap(),
        SizedBox(
          height:85,
          width: MediaQuery.of(context).size.width*widget.widthByMdQuery,
          child: TextFormField(
            keyboardType:widget.inputTypeIsNumber?TextInputType.number:TextInputType.emailAddress,
            obscureText:widget.isThereIcon?widget.isTaped:false,
            validator:widget.validation,
            controller: widget.controller,
            decoration: InputDecoration(
                hintText: widget.hintText,
                suffixIcon: widget.isThereIcon==true?InkWell(onTap:(){
                  setState(() {
                  widget.isTaped=!widget.isTaped;
                });}, child: Icon(widget.isTaped?Icons.visibility_off:Icons.visibility,)):SizedBox(height: MediaQuery.of(context).size.height*0.0,width:MediaQuery.of(context).size.width*0.0 ,),
                prefixIconColor:Colors.black ,
                hintStyle:AppSubHeadings.hintStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color:widget.isThereBorderColor?Colors.grey.shade600:Colors.purple.shade200,width:2),

                ),
              focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color:widget.isThereBorderColor?Colors.black87:Colors.purple,width:2),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color:widget.isThereBorderColor?Colors.grey.shade600:Colors.purple.shade200,width: 1),
              ),
            ),

          ),
        )
      ],
    );
  }
}
gap({double height=10,double?width}){
  return SizedBox(
    height:height ,
    width: width,
  );
}