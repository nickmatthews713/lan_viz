import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'join_server_modal_state.dart';

class JoinServerModalCubit extends Cubit<JoinServerModalState> {
  JoinServerModalCubit() : super(const JoinServerModalState());

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
