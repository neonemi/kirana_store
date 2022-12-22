
import 'package:flutter/material.dart';

import '../../core.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.coreRepository) : super(NotificationInitial());
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
