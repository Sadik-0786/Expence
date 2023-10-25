import 'expense_model.dart';

class FilterDateModel{
  String date;
  num amt;
  List<ExpenseModel> arrExpense;

  FilterDateModel({ required this.date,required this.amt,required this.arrExpense});
}