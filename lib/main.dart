import 'package:flutter/material.dart';
import 'package:flutter_first_station/http/http_method.dart';
import 'package:flutter_first_station/pages/home_page.dart';
import 'package:flutter_first_station/routes/route_utils.dart';
import 'package:flutter_first_station/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';


import 'counter/counter_page.dart';

void main() {
  DioInstance.instance().initDio(baseUrl: 'https://www.wanandroid.com');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(child: ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          color: Colors.black,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          navigatorKey: RouteUtils.navigatorKey,
          onGenerateRoute: Routes.generateRoute,
          initialRoute: RoutesPath.tab,
          // home: child,
        );
      },
      // child: const HomePage(),


    ));
  }
}

