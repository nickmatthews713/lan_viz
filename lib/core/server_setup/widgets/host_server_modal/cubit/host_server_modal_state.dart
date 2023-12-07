part of 'host_server_modal_cubit.dart';

class HostServerModalState extends Equatable {
  const HostServerModalState({
    this.serverName = const ServerName.pure(),
    this.status = FormzStatus.pure,
  });

  final ServerName serverName;
  final FormzStatus status;

  @override
  List<Object> get props => [serverName, status];

  HostServerModalState copyWith({
    ServerName? serverName,
    FormzStatus? status,
  }) {
    return HostServerModalState(
      serverName: serverName ?? this.serverName,
      status: status ?? this.status,
    );
  }
}
