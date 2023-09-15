import 'package:expenser_app/model/expense_model.dart';
import 'package:expenser_app/model/user_table_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{
  String userTableName='user_table';
  String userColumnEmail='user_email';
  String userColumnPassword='user_password';
  String userColumnName='user_name';
  //variables for expense table
  String expenseTableName='expense_table';
 // String userColumnEmail='user_email';  // foreign key
  String expenseColumnID='expense_id';
  String expenseColumnTittle='expense_tittle';
  String expenseColumnDesc='expense_desc';
  String expenseColumnAmt='expense_Amt';
  String expenseColumnType='expense_type';// 0 for debit & 1 for credit
  String expenseColumnBal='expense_bal';
  String expenseColumnCatID='expense_cat_id';
  String expenseColumnDate='expense_date';

  Future<Database> openDB() async {
    var mDirectory= await getApplicationDocumentsDirectory();
    await mDirectory.create(recursive: true);
    var dbPath='$mDirectory/AppDB.db';
    return await openDatabase(dbPath,version: 1,onCreate: (db,version){
      var createExpanseTableQuery="create table $expenseTableName ( $expenseColumnID integer primary key autoincrement, $userColumnEmail text, $expenseColumnTittle text, $expenseColumnDesc text, $expenseColumnAmt real, $expenseColumnBal real, $expenseColumnType integer, $expenseColumnCatID integer, $expenseColumnDate text)";
      db.execute(createExpanseTableQuery);
       db.execute( "CREATE TABLE $userTableName ( $userColumnEmail TEXT PRIMARY KEY , $userColumnPassword TEXT,$userColumnName TEXT)");
    });
  }

  Future<String> addUserAccount(UserModel user) async {
    var dbRef= await openDB();
    if(await checkExistingUserAccount(user.userEmail)){
      return'account not created due to existing email';
    }else{
      await dbRef.insert(userTableName,user.toMap());
      return 'account created';
    }
  }
  Future<bool> checkExistingUserAccount(String email) async {
    var dbRef= await openDB();
    var check=await dbRef.query(userTableName,where:'$userColumnEmail=?',whereArgs: [email]);
    return check.isNotEmpty;
  }
  Future<UserModel?> loginUserAccount(String email,String password) async {
    var dbRef= await openDB();
    var check=await dbRef.query(userTableName,where:'$userColumnEmail=? and $userColumnPassword=?',whereArgs: [email,password],);
    return check.isNotEmpty ? UserModel.fromMap(check[0]) : null;
  }

//functions for expense table
 Future<bool>addExpense(ExpenseModel newExpense) async{
    var dbRef= await openDB();
   var check = await dbRef.insert(expenseTableName,newExpense.toMap());
   return check>0;
 }
 Future<List<ExpenseModel>> getAllExpense() async{
    var dbRef= await openDB();
   List<Map<String,dynamic>> expenses = await dbRef.query(expenseTableName);
   List<ExpenseModel> arrExpenses=[];
   for(Map<String,dynamic> eachExpense in expenses)
     {
       var eachModel=ExpenseModel.fromMap(eachExpense);
       arrExpenses.add(eachModel);
     }
   return arrExpenses;
 }
  Future<bool>deletExpense(int id) async{
    var dbRef= await openDB();
    var check = await dbRef.delete(expenseTableName,where:'$expenseColumnID = ?',whereArgs: ['$id']);
    return check>0;
  }
}