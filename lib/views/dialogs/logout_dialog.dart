import 'package:flutter/cupertino.dart';
import 'package:tiktok_clone/views/dialogs/generic_dialog.dart';

// Log out  dialog
Future<bool> showLogoutDailog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log out',
    content: 'Are you Sure you want to log out ?',
    optionBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
