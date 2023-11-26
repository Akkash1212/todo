import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/todoprovider.dart';

import 'firebase_options.dart';
import 'screens/today_task/today_task_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(1080, 2340),
        builder: (_, child) {
          return MaterialApp(debugShowCheckedModeBanner: false, home: child);
        },
        child: TodayTask(),
      ),
    );
  }
}
