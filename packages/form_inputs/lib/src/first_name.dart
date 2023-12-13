import 'package:formz/formz.dart';

/// Validation errors for the [FirstName] [FormzInput].
enum FirstNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Name}
/// Form input for a FirstName input.
/// {@endtemplate}
class FirstName extends FormzInput<String, FirstNameValidationError> {
  /// {@macro FirstName}
  const FirstName.pure() : super.pure('');

  /// {@macro FirstName}
  const FirstName.dirty([super.value = '']) : super.dirty();

  // regex for a name
  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z]+$',
  );

  @override
  FirstNameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? null
        : FirstNameValidationError.invalid;
  }
}
