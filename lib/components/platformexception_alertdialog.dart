import 'package:TimeTracker/components/platform_alertdialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({@required this.title, @required this.exception})
      : super(title: title, content: _message(exception), confirmText: 'OK');

  final String title;
  final Exception exception;

  static String _message(PlatformException exception) {
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    ///  * `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
    'ERROR_WRONG_PASSWORD': ' The user has entered a wrong password. ',
    'PERMISSION_DENIED': ' The user has insufficient permissions. ',

    ///  * `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address, or if the user has been deleted.
    ///  * `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
    ///  * `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
    ///  * `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Email & Password accounts are not enabled.
    ///  * `ERROR_WEAK_PASSWORD` - If the password is not strong enough.
    ///  * `ERROR_INVALID_EMAIL` - If the email address is malformed.
    ///  * `ERROR_EMAIL_ALREADY_IN_USE` - If the email is already in use by a different account.
  };
}
