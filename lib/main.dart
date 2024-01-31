import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/helper/loading/loading_screen.dart';
import 'package:todo_app/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:todo_app/presentation/home_screen/home_screen.dart';
import 'package:todo_app/presentation/loading_view/loading_view.dart';
import 'package:todo_app/presentation/login_or_signup_screen/login_or_signup_screen.dart';
import 'package:todo_app/presentation/login_screen/login_screen.dart';
import 'package:todo_app/presentation/signup_screen/signup_screen.dart';
import 'package:todo_app/presentation/verify_email_screen.dart/verifyEmailScreen.dart';
import 'package:todo_app/services/auth/bloc/auth_bloc.dart';
import 'package:todo_app/services/auth/bloc/auth_event.dart';
import 'package:todo_app/services/auth/bloc/auth_state.dart';
import 'package:todo_app/services/auth/firebase_auth_provider.dart';
import 'package:todo_app/theme/theme_helper.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  ThemeHelper().changeTheme('primary');
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return HomeScreen();
        } else if (state is AuthStateLoggedOut) {
          return LoginOrSignupScreen();
        } else if (state is AuthStateLogin) {
          return LoginScreen();
        } else if (state is AuthStateRegistering) {
          return SignupScreen();
        } else if (state is AuthStateForgotPassword) {
          return ForgotPasswordScreen();
        } else if (state is AuthStateNeedVerification) {
          return VerifyEmailScreen();
        } else {
          return LoadingView();
        }
      },
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText,
          );
        } else {
          LoadingScreen().hide();
        }
      },
    );
  }
}
