import 'package:flutter/material.dart';
import '../registerPages/registerPage.dart';
import '../registerPages/forgetPass.dart';
import '../registerPages/idcardPage.dart';
import '../registerPages/thirdPage.dart';
import '../mainPages/mainpage.dart';
import 'package:myspecialoperations/registerPages/comRegisterGlryPage.dart';
import 'package:myspecialoperations/registerPages/comRegisterPage.dart';

final routes={
    '/registerFirst':(context)=>RegisterFirstPage(),
    '/forgetPass':(context)=>ForgetPassPage(),
    '/idcardPage':(context)=>IdCardCameraPage(),
    '/thirdPage':(context)=>ThirdPage(),
    '/mainpage':(context)=>Mainpage(),
    '/comRegisterPage':(context)=>comRegisterPage(),
    '/comRegisterGlryPage':(context)=>comRegisterGlryPage()
  };

var onGenerateRoute=(RouteSettings settings){
        final String name=settings.name;
        final Function pageContentBuilder = routes[name];
        if(pageContentBuilder!=null){
          if(settings.arguments!=null){
            final Route route=MaterialPageRoute(
              builder: (context)=>
              pageContentBuilder(context,arguments:settings.arguments));
              return route;
          }else{
            final Route route =MaterialPageRoute(
              builder: (context)=>
                pageContentBuilder(context));
                return route;
          }
        }
      };