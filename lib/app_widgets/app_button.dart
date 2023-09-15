import 'package:expenser_app/ui_helper/app_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
   AppButton({super.key,required this.widthByMdQuery,required this.onPressed,required this.buttonName,required this.buttonColor,this.buttonStyle=AppHeadings.hading2});
  double widthByMdQuery;
  VoidCallback onPressed;
  String buttonName;
  Color buttonColor;
  TextStyle buttonStyle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
        width: MediaQuery.of(context).size.width*widthByMdQuery,
        child: ElevatedButton
          (onPressed:onPressed ,
            child:Center(child: Text(buttonName,style: buttonStyle,),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
        ),
        ));
  }
}
