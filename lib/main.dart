import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:base_templet/core/constants/colors.dart';
import 'package:base_templet/core/firebase/firbase_notifications.dart';
import 'package:base_templet/core/handle_controller/handle_cubit.dart';
import 'package:base_templet/core/router/app_router.dart';
import 'package:base_templet/core/utils/bloc_observer.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    Firebase.initializeApp(),
    dotenv.load(fileName: "assets/config/.env"),
  ]);
  await NotificationInitial().registerOnFirebase();
  //
  final botToastBuilder = BotToastInit();
  Bloc.observer = MyGlobalObserver();
  runApp(EasyLocalization(
      supportedLocales: const [Locale("ar"), Locale("en")],
      path: "assets/translation",
      child: MainApp(botToastBuilder: botToastBuilder)));
}

class MainApp extends StatelessWidget {
  final TransitionBuilder? botToastBuilder;
  const MainApp({super.key, this.botToastBuilder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HandleCubit>(
      create: (context) => HandleCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.goRouter,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        theme: ThemeData(
          fontFamily: 'Cairo',
          primaryColor: AppColors.primaryColor,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(
                  secondary: AppColors.primaryColor,
                  primary: AppColors.primaryColor)
              .copyWith(background: Colors.white),
        ),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: botToastBuilder!(
              context,
              GestureDetector(
                  onTap: ()
                      //
                      {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: BlocListener<HandleCubit, HandleState>(
                      listenWhen: (previous, current) => previous != current,
                      listener: (context, state) {
                        if (state is ErrorState) {
                          final snackBar = SnackBar(
                            elevation: 0,
                            duration: const Duration(seconds: 3),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: "error".tr(),
                              message: state.message,
                              contentType: ContentType.failure,
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                        //
                        else if (state is SuccessState) {
                          final snackBar = SnackBar(
                            duration: const Duration(seconds: 3),
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: "operation_success".tr(),
                              message: state.message,
                              contentType: ContentType.success,
                              color: Colors.green[300],
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                      },
                      child: child)),
            ),
          );
        },
      ),
    );
  }
}
