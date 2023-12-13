part of 'join_server_modal_cubit.dart';

class JoinServerModalState extends Equatable {
  const JoinServerModalState({
    this.serverName = const IpAddress.pure(),
    this.status = FormzStatus.pure,
  });

  final IpAddress serverName;
  final FormzStatus status;

  @override
  List<Object> get props => [serverName, status];

  JoinServerModalState copyWith({
    IpAddress? serverName,
    FormzStatus? status,
  }) {
    return JoinServerModalState(
      serverName: serverName ?? this.serverName,
      status: status ?? this.status,
    );
  }
}
