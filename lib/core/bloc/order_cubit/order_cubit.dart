
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.coreRepository) : super(OrderInitial());
  final CoreRepository coreRepository;

  void getOrder() async {

    emit(OrderLoading());
    try {

      // GetNotificationResponse response = await coreRepository.getNotifications(userId!);
      emit(OrderSuccess());
    } catch (e) {
      String message = e.toString().replaceAll('api - ', '');
      emit(OrderError(message));
    }
  }

}
