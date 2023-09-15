part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent {}
class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExpense;
  AddExpenseEvent({required this.newExpense});
}
class FetchAllExpenseEvent extends ExpenseEvent{}
class DeletExpenseEvent extends ExpenseEvent {
  int index;
  DeletExpenseEvent({required this.index});
}