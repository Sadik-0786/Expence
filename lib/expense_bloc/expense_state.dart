part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}
class ExpenseLoadingState extends ExpenseState {}
class ExpenseLoadedState extends ExpenseState {
  List<ExpenseModel> arrExpense;
  ExpenseLoadedState({required this.arrExpense});
}
class ExpenseErrorState extends ExpenseState {
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});
}

