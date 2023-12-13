import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'host_server_modal_state.dart';

class HostServerModalCubit extends Cubit<HostServerModalState> {
  HostServerModalCubit() : super(const HostServerModalState());

  void firstNameChanged(String firstName) {
    final firstNameInput = firstName == '' ? FirstName.pure() : FirstName.dirty(firstName);
    print("${firstNameInput.value} ${state.lastName.value}");
    emit(
      state.copyWith(
        firstName: firstNameInput,
        status: Formz.validate([firstNameInput, state.lastName]),
      ),
    );
  }

  void lastNameChanged(String lastName) {
    final lastNameInput = lastName == '' ? LastName.pure() : LastName.dirty(lastName);
    print("${state.firstName.value} ${lastNameInput.value}");
    emit(
      state.copyWith(
        lastName: lastNameInput,
        status: Formz.validate([state.firstName, lastNameInput]),
      ),
    );
  }
}
