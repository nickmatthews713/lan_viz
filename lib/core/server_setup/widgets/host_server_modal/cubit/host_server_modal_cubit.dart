import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'host_server_modal_state.dart';

class HostServerModalCubit extends Cubit<HostServerModalState> {
  HostServerModalCubit() : super(const HostServerModalState());

  void serverNameChanged(String serverName) {
    final serverNameInput = serverName == '' ? const ServerName.pure() : ServerName.dirty(serverName);
    emit(
      state.copyWith(
        serverName: serverNameInput,
        status: Formz.validate([serverNameInput]),
      ),
    );
  }
}