part of 'coupon_cubit.dart';

abstract class CouponState extends Equatable {
  const CouponState();
}

class CouponInitial extends CouponState {
  @override
  List<Object> get props => [];
}

class CouponLoading extends CouponState {
  @override
  List<Object> get props => [];
}

class CouponSuccess extends CouponState {
  @override
  List<Object> get props => [];
}


class CouponError extends CouponState {
  const CouponError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
