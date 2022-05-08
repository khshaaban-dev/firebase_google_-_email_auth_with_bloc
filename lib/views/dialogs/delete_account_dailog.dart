import 'package:flutter/cupertino.dart';
import 'package:tiktok_clone/views/dialogs/generic_dialog.dart';

// delete account dialog
Future<bool> showDeleteAccountDailog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete Account',
    content:
        'Are you Sure you want to delete account ? you can not undo this opration .',
    optionBuilder: () => {
      'Cancel': false,
      'Delete Account': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
