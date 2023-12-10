import 'package:base_templet/core/api/exceptions.dart';
import 'package:base_templet/core/constants/colors.dart';
import 'package:base_templet/core/constants/styles.dart';
import 'package:base_templet/core/dependency_injection/injection_container.dart';
import 'package:base_templet/core/handle_controller/handle_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin BaseHandleApi {
  final ctx = injection<GlobalKey<NavigatorState>>().currentContext!;
  handleError(exception) {
    if (exception is FetchDataException) {
      ctx
          .read<HandleCubit>()
          .errorOperation(exception.message ?? "Something Wrong");
    }
    //
    else if (exception is InvalidInputException) {
      ctx
          .read<HandleCubit>()
          .errorOperation(exception.message ?? "Something Wrong");
    }
    //
    else if (exception is UnauthorisedException) {
      sessionExpiredDialog(exception);
    }
    //
    else if (exception is ApiNotRespondingException) {
      ctx
          .read<HandleCubit>()
          .errorOperation(exception.message ?? "Something Wrong");
    }
  }

  sessionExpiredDialog(AppException exception) {
    showDialog(
      barrierDismissible: false,
      context: injection<GlobalKey<NavigatorState>>().currentContext!,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            title: Text("error".tr()),
            content: Text(
              "error_unauth".tr(),
              style:
                  AppStyles.style18w400White.copyWith(color: Colors.grey[850]),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  injection<SharedPreferences>().clear();
                  //TODO Go to Auth Page
                },
                child: Text(
                  "Sign In",
                  style: AppStyles.style18w700Black
                      .copyWith(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
