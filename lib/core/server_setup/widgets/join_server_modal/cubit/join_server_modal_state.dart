part of 'join_server_modal_cubit.dart';

class JoinServerModalState extends Equatable {
  const JoinServerModalState({
    this.serverName = const ServerName.pure(),
    this.status = FormzStatus.pure,
  });

  final ServerName serverName;
  final FormzStatus status;

  @override
  List<Object> get props => [serverName, status];

  JoinServerModalState copyWith({
    ServerName? serverName,
    FormzStatus? status,
  }) {
    return JoinServerModalState(
      serverName: serverName ?? this.serverName,
      status: status ?? this.status,
    );
  }
}
