import 'package:bloc/bloc.dart';
import 'package:expenser_app/model/expense_model.dart';
import 'package:meta/meta.dart';
import '../database/app_database.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  AppDatabase dbRef;
  ExpenseBloc({required this.dbRef}) : super(ExpenseInitial()) {
    emit(ExpenseLoadingState());
    on<AddExpenseEvent>((event, emit) async{
     var check= await dbRef.addExpense(event.newExpense);
     if(check){
       var data= await dbRef.getAllExpense();
       emit(ExpenseLoadedState(arrExpense: data));
     }else{
       emit(ExpenseErrorState(errorMsg: 'Error 404'));
     }
    });
    on<FetchAllExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());
      var data= await dbRef.getAllExpense();
      emit(ExpenseLoadedState(arrExpense: data));
    });
    on<DeletExpenseEvent>((event, emit) async {
      var check= await dbRef.deletExpense(event.index);
      if(check){
        var data= await dbRef.getAllExpense();
        emit(ExpenseLoadedState(arrExpense: data));
      }else{
        emit(ExpenseErrorState(errorMsg: 'Error 404'));
      }
    }
    );
  }
}
