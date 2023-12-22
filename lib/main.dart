import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv2/view/screens/splash_screen/splash_screen.dart';
import 'package:todoappv2/view/screens/statistics/statistics_screen.dart';
import 'package:todoappv2/view_model/bloc/auth/auth_cubit.dart';
import 'package:todoappv2/view_model/bloc/bloc_observer/bloc_observer.dart';
import 'package:todoappv2/view_model/bloc/todo/todo_cubit.dart';
import 'package:todoappv2/view_model/data/local/shared_preference.dart';
import 'package:todoappv2/view_model/data/network/dio_helper.dart';


Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalData.init();
  LocalData.clearData();
  DioHelper.init();
  runApp(const MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>TodoCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a blue toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const TodoSplashScreen()
      ),
    );
  }
}