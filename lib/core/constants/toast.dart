import 'package:base_templet/core/constants/colors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'styles.dart';

myToast(m) {
  BotToast.showText(
    text: '$m',
    contentColor: AppColors.primaryColor,
    align: Alignment.center,
    textStyle: AppStyles.style16w500White,
  );
}
