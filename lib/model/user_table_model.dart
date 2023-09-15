import 'package:expenser_app/database/app_database.dart';

class UserModel{
  String userEmail;
  String userPassword;
  String userName;
  UserModel({
    required this.userEmail,
    required this.userPassword,
    required this.userName,
  });
factory UserModel.fromMap(Map<String,dynamic> map){
  return UserModel(userEmail:map[AppDatabase().userColumnEmail],
      userPassword:map[AppDatabase().userColumnPassword],
      userName: map[AppDatabase().userColumnName]);
}
Map<String,dynamic>toMap(){
  return
    {AppDatabase().userColumnEmail:userEmail,
      AppDatabase().userColumnPassword:userPassword,
      AppDatabase().userColumnName:userName,
    };
}
}