import 'package:formz/formz.dart';

/// Validation errors for the [IpAddress] [FormzInput].
enum IpAddressValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template serverName}
/// Form input for an IpAddress input.
/// {@endtemplate}
class IpAddress extends FormzInput<String, IpAddressValidationError> {
  /// {@macro ServerName}
  const IpAddress.pure() : super.pure('');

  /// {@macro ServerName}
  const IpAddress.dirty([super.value = '']) : super.dirty();

  // regex for an IP address
  static final RegExp _ipAddressRegExp = RegExp(
    r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}$',
  );

  @override
  IpAddressValidationError? validator(String? value) {
    return _ipAddressRegExp.hasMatch(value ?? '')
        ? null
        : IpAddressValidationError.invalid;
  }
}
