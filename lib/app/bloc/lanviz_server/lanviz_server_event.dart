part of 'lanviz_server_bloc.dart';

abstract class LanvizServerEvent extends Equatable {
  const LanvizServerEvent();

  @override
  List<Object> get props => [];
}

class HostServerClicked extends LanvizServerEvent {
  const HostServerClicked({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;
  final String lastName;

  @override
  List<Object> get props => [firstName, lastName];
}
