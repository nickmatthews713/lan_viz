part of 'host_server_modal_cubit.dart';

class HostServerModalState extends Equatable {
  const HostServerModalState({
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.status = FormzStatus.pure,
  });

  final FirstName firstName;
  final LastName lastName;
  final FormzStatus status;

  @override
  List<Object> get props => [firstName, lastName, status];

  HostServerModalState copyWith({
    FirstName? firstName,
    LastName? lastName,
    FormzStatus? status,
  }) {
    return HostServerModalState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      status: status ?? this.status,
    );
  }
}
