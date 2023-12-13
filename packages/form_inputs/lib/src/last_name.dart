import 'package:formz/formz.dart';

/// Validation errors for the [LastName] [FormzInput].
enum LastNameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Name}
/// Form input for a LastName input.
/// {@endtemplate}
class LastName extends FormzInput<String, LastNameValidationError> {
  /// {@macro LastName}
  const LastName.pure() : super.pure('');

  /// {@macro LastName}
  const LastName.dirty([super.value = '']) : super.dirty();

  // regex for a name
  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z]+$',
  );

  @override
  LastNameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? null
        : LastNameValidationError.invalid;
  }
}
