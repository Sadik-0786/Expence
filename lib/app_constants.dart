import 'package:expenser_app/image_const.dart';

class AppConsts{
  static const String appName='Expanser';
  static const List<Map<String,dynamic>> appTransactions=[
    {
      'day':'Today',
      'totalAmt':'15',
      'transactions':[
        {
         'tittle':'Pets',
         'subTittle':'Treat' ,
          'trailing':'\$3.35',
          'subTrailing':'2.35€',
        },
        {
          'tittle':"Snacks",
          'subTittle':"8:54AM",
          'trailing':'\$3.35',
          'subTrailing':'1.50€',
        },
        {
          'tittle':'Coffee',
          'subTittle':'8:37AM',
          'trailing':'\$2.56',
          'subTrailing':'1.99€',
        }
      ]

    },
    {
      'day':'Yesterday',
      'totalAmt':'30',
      'transactions':[
        {
          'tittle':'Books',
          'subTittle':'8:37AM' ,
          'trailing':'\$14.55',
          'subTrailing':'10.55€',
        },
        {
          'tittle':'Canteen',
          'subTittle':'Lunch',
          'trailing':'\$15.00',
          'subTrailing':'13.00€',
        },
        {
          'tittle':'Coffee',
          'subTittle':'7:30AM',
          'trailing':'\$2.56',
          'subTrailing':'1.99€',
        }
      ]

    }

  ];
  static const List<Map<String,dynamic>> expenseCat=[
    {'id':'1','name':'Bike Repair','img':ImageConst.bikeRepairImg},
    {'id':'2','name':'Car Repair','img':ImageConst.carRepairImg},
    {'id':'3','name':'Books','img':ImageConst.booksImg},
    {'id':'4','name':'Coffee','img':ImageConst.coffeeOrTeaImg},
    {'id':'5','name':'Shopping','img':ImageConst.shoppingImg},
    {'id':'6','name':'Groceries','img':ImageConst.groceriesImg},
    {'id':'7','name':'Taxi','img':ImageConst.taxiImg},
    {'id':'8','name':'Travel','img':ImageConst.travelImg},
    {'id':'9','name':'Boy Acc','img':ImageConst.menAccessoriesImg},
    {'id':'10','name':'Girl Acc','img':ImageConst.womenAccessoriesImg},
    {'id':'11','name':'Pet','img':ImageConst.petImg},
    {'id':'12','name':'Petrol','img':ImageConst.petrolImg},
    {'id':'13','name':'Mobile Acc','img':ImageConst.mobileAccessoriesImg},
    {'id':'14','name':'Borrow','img':ImageConst.borrowMoneyImg},
    {'id':'15','name':'LendMoney','img':ImageConst.lendMoneyImg},
    {'id':'16','name':'Snakes','img':ImageConst.snacksImg},
    {'id':'17','name':'Fast Food','img':ImageConst.fastFoodImg},
    {'id':'18','name':'Gift','img':ImageConst.giftImg},
    {'id':'19','name':'Electronics','img':ImageConst.electronicsImg},
    {'id':'20','name':'Recharge','img':ImageConst.mobileRechargeImg},
  ];
}