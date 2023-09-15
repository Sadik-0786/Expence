import 'package:expenser_app/database/app_database.dart';
import 'package:expenser_app/expense_bloc/expense_bloc.dart';
import 'package:expenser_app/screens/onbording%20screens/splace_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp( BlocProvider(create: (context)=>ExpenseBloc(
      dbRef: AppDatabase()),child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense',
        theme: ThemeData(
          fontFamily:'Poppins',
        ),
      home:SplashScreen(),
    );
  }
}