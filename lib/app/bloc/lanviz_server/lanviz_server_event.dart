part of 'lanviz_server_bloc.dart';

abstract class LanvizServerEvent extends Equatable {
  const LanvizServerEvent();

  @override
  List<Object> get props => [];
}

class HostServerClicked extends LanvizServerEvent {}
