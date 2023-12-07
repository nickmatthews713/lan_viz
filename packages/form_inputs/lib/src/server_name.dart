import 'package:formz/formz.dart';

/// Validation errors for the [ServerName] [FormzInput].
enum ServerNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template serverName}
/// Form input for an serverName input.
/// {@endtemplate}
class ServerName extends FormzInput<String, ServerNameValidationError> {
  /// {@macro ServerName}
  const ServerName.pure() : super.pure('');

  /// {@macro ServerName}
  const ServerName.dirty([super.value = '']) : super.dirty();

  // static final RegExp _serverNameRegExp = RegExp(
  //   r'^[a-zA-Z0-9]+([_-]?[a-zA-Z0-9])*$',
  // );

  // regex for an IP address
  static final RegExp _serverNameRegExp = RegExp(
    r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}$',
  );

  @override
  ServerNameValidationError? validator(String? value) {
    return _serverNameRegExp.hasMatch(value ?? '')
        ? null
        : ServerNameValidationError.invalid;
  }
}
