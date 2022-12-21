part of 'smart_list_cubit.dart';

abstract class SmartState extends Equatable {
  const SmartState();
}

class SmartStateInitial extends SmartState {
  @override
  List<Object> get props => [];
}

class SmartStateLoading extends SmartState {
  @override
  List<Object> get props => [];
}

class SmartStateSuccess extends SmartState {
  const SmartStateSuccess(this.address);

  final String address;
  @override
  List<Object> get props => [address];
}


class SmartStateError extends SmartState {
  const SmartStateError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
