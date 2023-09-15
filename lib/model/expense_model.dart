import 'package:expenser_app/database/app_database.dart';

class ExpenseModel {

  int ?expenseId;
  String userEmail;
  String expenseTittle;
  String expenseDesc;
  double expenseAmt;
  double expenseBal;
  int expenseCatId;
  int expenseType;
  String date;

  ExpenseModel({ this.expenseId,
    required this.userEmail,
    required this.expenseTittle,
    required this.expenseDesc,
    required this.expenseAmt,
    required this.expenseBal,
    required this.expenseCatId,
    required this.expenseType,
    required this.date
  });
  factory ExpenseModel.fromMap(Map<String,dynamic> map){
    return ExpenseModel(
        expenseId: map[AppDatabase().expenseColumnID],
        userEmail:map[AppDatabase().userColumnEmail],
        expenseTittle: map[AppDatabase().expenseColumnTittle],
        expenseDesc:map[AppDatabase().expenseColumnDesc],
        expenseAmt: map[AppDatabase().expenseColumnAmt],
        expenseBal:map[AppDatabase().expenseColumnBal],
        expenseCatId:map[AppDatabase().expenseColumnCatID],
        expenseType:map[AppDatabase().expenseColumnType],
        date: map[AppDatabase().expenseColumnDate],
    );
  }
  Map<String,dynamic> toMap(){
    return{
      AppDatabase().expenseColumnID:expenseId,
      AppDatabase().userColumnEmail:userEmail,
      AppDatabase().expenseColumnTittle:expenseTittle,
      AppDatabase().expenseColumnDesc:expenseDesc,
      AppDatabase().expenseColumnAmt:expenseAmt,
      AppDatabase().expenseColumnBal:expenseBal,
      AppDatabase().expenseColumnCatID:expenseCatId,
      AppDatabase().expenseColumnType:expenseType,
      AppDatabase().expenseColumnDate:date,
    };
  }
}