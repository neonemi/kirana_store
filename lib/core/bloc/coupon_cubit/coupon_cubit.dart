
import 'package:flutter/material.dart';

import '../../core.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit(this.coreRepository) : super(CouponInitial());
  final CoreRepository coreRepository;

  // void logout() async {
  //   emit(NotificationLoading());
  //   try {
  //     coreRepository.localRepository.clearDatabase();
  //     emit(NotificationSuccess());
  //   } catch (e) {
  //     String message = e.toString().replaceAll('api - ', '');
  //     emit(NotificationError(message));
  //   }
  // }

}
