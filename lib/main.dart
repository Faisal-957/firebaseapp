import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:widgets_practicing/curdopp/read.dart';

import 'package:widgets_practicing/firebase_options.dart';
import 'package:widgets_practicing/noteapp/noteviewmodel.dart';
import 'package:widgets_practicing/student_data.dart/student_viewmodel.dart';
import 'package:widgets_practicing/student_data.dart/studentdetails.dart';
import 'package:widgets_practicing/curdopp/creat.dart';
import 'package:widgets_practicing/todo.dart/todo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotepadViewmodel()),

        ChangeNotifierProvider(create: (context) => StudentViewsModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Readscreen(),
        );
      },
    );
  }
}
