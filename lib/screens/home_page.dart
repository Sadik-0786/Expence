import 'package:expenser_app/app_constants.dart';
import 'package:expenser_app/expense_bloc/expense_bloc.dart';
import 'package:expenser_app/model/filter_date_model.dart';
import 'package:expenser_app/screens/add_expence_page.dart';
import 'package:expenser_app/ui_helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/expense_model.dart';
class HomePage extends StatefulWidget {

  const HomePage({super.key,this.emailId});
 final String?emailId;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data= AppConsts.appTransactions;
  List<FilterDateModel> arrFilteredDateExpense=[];
@override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchAllExpenseEvent());
  }
  String dateTimeToday(){
    DateTime dateNow = DateTime.now();
    String formattedDate = "${dateNow.year}${dateNow.month
        .toString()
        .length < 2 ? '-0${dateNow.month}' : '-${dateNow.month}'}${dateNow.day
        .toString()
        .length < 2 ? '-0${dateNow.day}' : '-${dateNow.day}'}";
    return formattedDate;
  }
  String dateTimeYesterday(){
    DateTime dateNow = DateTime.now().subtract(const Duration(days: 1));
    String formattedDate = "${dateNow.year}${dateNow.month
        .toString()
        .length < 2 ? '-0${dateNow.month}' : '-${dateNow.month}'}${dateNow.day
        .toString()
        .length < 2 ? '-0${dateNow.day}' : '-${dateNow.day}'}";
    return formattedDate;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:15 ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddExpense(userEmail:widget.emailId!)));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black,
                      ),
                      child: const Center(child: Icon(Icons.add,color: Colors.white,size:30 ,)),
                    ),
                  )
                ],
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Spend this week',style:AppSubHeadings.appSubHeading,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\$',style:  TextStyle(color: Colors.grey.shade400,fontSize: 35),),
                        const Text('295',style: TextStyle(color: Colors.black,fontSize: 55),),
                        const Text('.95',style:  TextStyle(color: Colors.black,fontSize: 35),)
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                    child:BlocBuilder<ExpenseBloc,ExpenseState>(
                      builder: (_,state){
                        if(state is ExpenseLoadingState)
                          {
                            return const Center(child: CircularProgressIndicator(),);
                          }
                        else if(state is ExpenseErrorState){
                          return Center(child: Text(state.errorMsg));
                        }
                        else if(state is ExpenseLoadedState){
                          var arrData=state.arrExpense;
                          filteringExpensesByDate(arrData.reversed.toList());
                         return arrFilteredDateExpense.isNotEmpty?ListView.builder(
                           itemCount: arrFilteredDateExpense.length,
                           itemBuilder: (context, index){
                           return Column(
                             children: [
                               ListTile(
                                 leading: const CircleAvatar(backgroundColor: Colors.transparent,),
                                 title: Text(arrFilteredDateExpense[index].date==dateTimeToday()?'Today':arrFilteredDateExpense[index].date==dateTimeYesterday()?'Yesterday':arrFilteredDateExpense[index].date,style: AppSubHeadings.appSubHeading,),
                                 trailing: Text('${arrFilteredDateExpense[index].amt}\$',style: AppSubHeadings.appSubHeading),
                               ),
                              const Divider(thickness: 1.5,indent: 34),
                              ListView.builder(
                                shrinkWrap: true,
                               physics: const NeverScrollableScrollPhysics(),
                              itemCount:arrFilteredDateExpense[index].arrExpense.length,
                                  itemBuilder: (_,subIndex){
                                var eachTrans=arrFilteredDateExpense[index].arrExpense[subIndex];
                                var imgPath= AppConsts.expenseCat.firstWhere((element) => element['id']==eachTrans.expenseCatId.toString())['img'];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(imgPath),
                                  ),
                                  title: Text(eachTrans.expenseTittle,style: AppHeadings.hading3,),
                                  subtitle: Text(eachTrans.expenseDesc,style: AppSubHeadings.appSubHeading1,),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${eachTrans.expenseAmt}\$',style:AppHeadings.hading4),
                                      InkWell(
                                        onTap: (){
                                        BlocProvider.of<ExpenseBloc>(context).add(DeletExpenseEvent(index:arrFilteredDateExpense[index].arrExpense[subIndex].expenseId!));
                                        },
                                        child:  Icon(Icons.delete,color: Colors.redAccent.shade200,),
                                      )
                                    ],
                                  ),
                                );

                              }
                              ),
                               const Divider(thickness: 1.5,indent: 34),
                             ],
                           );
                         },) : const Text('No Expense Added'
                             ' Yet!');
                        }
                        else{
                          return Container();
                        }
                      },
                    )
              )
            ],
          ),
        ),
      ),
    );
  }
  void filteringExpensesByDate(List<ExpenseModel>data){
  arrFilteredDateExpense.clear();
  //step 1 : getUniqueDate
    List<String> arrUniqueDate=[];
    for(ExpenseModel eachTrans in data) {
      var date = DateTime.parse(eachTrans.date);
      var eachDate = "${date.year}${date.month
          .toString()
          .length < 2 ? '-0${date.month}' : '-${date.month}'}${date.day
          .toString()
          .length < 2 ? '-0${date.day}' : '-${date.day}'}";
      if (!arrUniqueDate.contains(eachDate)) {
        arrUniqueDate.add(eachDate);
      }
    }
      //step 2 : arrange data according to unique date
      for(String date in arrUniqueDate){
          List<ExpenseModel> transInEachDate=[];
          num amt=0;
          for(ExpenseModel eachTrans in data){
            DateTime dateFromTrans=DateTime.parse(eachTrans.date);
            String eachTransDate="${dateFromTrans.year}${dateFromTrans.month.toString().length<2?'-0${dateFromTrans.month}':'-${dateFromTrans.month}'}${dateFromTrans.day.toString().length<2?'-0${dateFromTrans.day}':'-${dateFromTrans.day}'}";
            if(date==eachTransDate){
              transInEachDate.add(eachTrans);
              if(eachTrans.expenseType==0){
                amt-=eachTrans.expenseAmt;
              }else{
                amt+=eachTrans.expenseAmt;
              }
            }//end if
          }//end second loop
          arrFilteredDateExpense.add(FilterDateModel(date: date, amt:amt.toString(), arrExpense:transInEachDate ));
        }//end first loop
      //just for checking
    }
}
