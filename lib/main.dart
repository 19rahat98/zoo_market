import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoo_market/di/di_locator.dart' as di_locator;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoo_market/common/services/simple_bloc_observer.dart';
import 'package:zoo_market/feature/global_auth/presentation/cubit/global_auth_cubit.dart';
import 'package:zoo_market/feature/sign_in/presentation/bloc/authentication/blocs.dart';
import 'package:zoo_market/feature/sign_in/presentation/bloc/signIn_with_phone_number/signIn_with_phone_number_bloc.dart';
import 'package:zoo_market/feature/sign_in/presentation/ui/sign_in_screen.dart';
import 'package:zoo_market/feature/spash_page/presentation/ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// firebase core
  await Firebase.initializeApp();

  /// установка ориентации
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = SimpleBlocObserver();
  await di_locator.initLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalAuthCubit>(
          create: (context) => GlobalAuthCubit()..getUserData(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<SignInWithPhoneNumberBloc>(
          create: (context) => SignInWithPhoneNumberBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Zoo Market',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
