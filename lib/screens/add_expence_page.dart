import 'package:expenser_app/app_constants.dart';
import 'package:expenser_app/app_widgets/app_button.dart';
import 'package:expenser_app/app_widgets/app_form_field.dart';
import 'package:expenser_app/expense_bloc/expense_bloc.dart';
import 'package:expenser_app/model/expense_model.dart';
import 'package:expenser_app/ui_helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpense extends StatefulWidget {
  AddExpense({super.key, required this.userEmail});

  TextEditingController amtController = TextEditingController();
  TextEditingController tittleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  var selectCat = -1;
  List<String> arrTransactionType = ['Debit', 'Credit'];
  String selectedTransactionType = 'Debit';
  String userEmail;
  final formKey = GlobalKey<FormState>();

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Expense',
            style: AppHeadings.hading3,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 35,
            color: Colors.grey.shade400,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: widget.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextField(
                        textFieldHeading: 'Amount',
                        tittleStyle: AppHeadings.hading4,
                        hintText: 'Enter Your Amount',
                        widthByMdQuery: MediaQuery.of(context).size.width,
                        controller: widget.amtController,
                        validation: (String? value) {
                          if (value == '' || value == null) {
                            return 'Please enter valid value ';
                          }
                        },
                        isThereBorderColor: true,
                        inputTypeIsNumber: true,
                      ),
                      AppTextField(
                        textFieldHeading: 'Tittle',
                        tittleStyle: AppHeadings.hading4,
                        hintText: 'Enter Your Tittle',
                        widthByMdQuery: MediaQuery.of(context).size.width,
                        controller: widget.tittleController,
                        validation: (String? value) {
                          if (value == '' || value == null) {
                            return 'Please enter valid value ';
                          }
                        },
                        isThereBorderColor: true,
                      ),
                      AppTextField(
                        textFieldHeading: 'Description',
                        tittleStyle: AppHeadings.hading4,
                        hintText: 'Enter Your Description',
                        widthByMdQuery: MediaQuery.of(context).size.width,
                        controller: widget.descController,
                        validation: (String? value) {
                          if (value == '' || value == null) {
                            return 'Please enter valid value ';
                          }
                        },
                        isThereBorderColor: true,
                      ),
                    ],
                  )),
              gap(height: 25),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50))),
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: SizedBox(
                                      height: 400,
                                      child: GridView.builder(
                                          itemCount:
                                              AppConsts.expenseCat.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  widget.selectCat = index;
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Image.asset(
                                                    AppConsts.expenseCat[index]
                                                        ['img'],
                                                    width: 40,
                                                  ),
                                                  gap(),
                                                  Text(
                                                    AppConsts.expenseCat[index]
                                                        ['name'],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors
                                                            .grey.shade400,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  );
                                });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: widget.selectCat >= 0
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.yellow,
                                        child: Center(
                                            child: Image.asset(
                                                AppConsts.expenseCat[
                                                    widget.selectCat]['img']))),
                                    gap(height: 0, width: 5),
                                    Text(
                                      AppConsts.expenseCat[widget.selectCat]
                                          ['name'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  ],
                                )
                              : const Text(
                                  'Choose Category',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                        )),
                  ),
                  gap(width: 10),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: DropdownButton(
                            underline: Container(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            dropdownColor: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            iconEnabledColor: Colors.white,
                            value: widget.selectedTransactionType,
                            items: widget.arrTransactionType
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                widget.selectedTransactionType = value!;
                              });
                            }),
                      ),
                    ),
                  )
                ],
              ),
              gap(height: 25),
              AppButton(
                  widthByMdQuery: MediaQuery.of(context).size.width,
                  onPressed: () {
                    if (widget.formKey.currentState!.validate()) {
                      context.read<ExpenseBloc>().add(
                            AddExpenseEvent(
                                newExpense: ExpenseModel(
                                    userEmail: widget.userEmail,
                                    expenseTittle:
                                        widget.tittleController.text.toString(),
                                    expenseDesc:
                                        widget.descController.text.toString(),
                                    expenseAmt:
                                        double.parse(widget.amtController.text),
                                    expenseBal: 0,
                                    expenseCatId: int.parse(AppConsts
                                        .expenseCat[widget.selectCat]['id']),
                                    expenseType:
                                        widget.selectedTransactionType ==
                                                'Debit'
                                            ? 0
                                            : 1,
                                    date: DateTime.now().toString())),
                          );
                      Navigator.pop(context);
                    }
                  },
                  buttonName: 'Add Expense',
                  buttonColor: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
