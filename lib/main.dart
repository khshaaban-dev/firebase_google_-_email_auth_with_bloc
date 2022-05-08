import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/data/repostories/auth_repostory.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/logic/blocs/auth/auth_bloc.dart';
import 'package:tiktok_clone/views/app_routes.dart';
import 'package:tiktok_clone/views/dialogs/show_auth_error.dart';
import 'package:tiktok_clone/views/loading/loading_screen.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/views/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  BlocOverrides.runZoned(
    () => runApp(const App()),
    blocObserver: AppBlocObserver(),
  );
}

/// Custom [BlocObserver] that observes all bloc and cubit state changes.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_) {
        return RepositoryProvider(
          create: (context) => AuthRepostory(),
          child: BlocProvider(
            create: (context) => AuthBloc(
              authRepostory: RepositoryProvider.of<AuthRepostory>(context),
            )..add(
                IntitlizeEvent(),
              ),
            child: MaterialApp(
              onGenerateRoute: onGenerateRoute,
              debugShowCheckedModeBanner: false,
              title: 'TikTok clone',
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: backgraoundColor,
              ),
              home: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoadingState) {
                    LoadingScreen.instance().show(
                      context: context,
                      text: 'Loading...',
                    );
                  } else {
                    LoadingScreen.instance().hide();
                  }
                  if (state is AuthErrorState) {
                    showAuthErrorDailog(
                      authError: state.authError,
                      context: context,
                    );
                  }
                },
                builder: (context, authState) {
                  if (authState is AuthanticatedState) {
                    return const HomeScreen();
                  } else if (authState is IsInSignUpScreenState) {
                    return SignUpScreen();
                  } else {
                    return LoginScreen();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
