
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kirana_store/core/model/cart_data.dart';

import '../../core.dart';

part 'smart_list_state.dart';

class SmartListCubit extends Cubit<SmartState> {
  SmartListCubit(this.coreRepository) : super(SmartStateInitial());
  final CoreRepository coreRepository;
  var cartDataList = <CartData>[].obs;
  // late SharedPreferences storge;
  String cartListString = '';
  // void loadData() async {
  //   emit(SmartStateLoading());
  //   try {
  //     String address= await _getLocation();
  //     emit(SmartStateSuccess(address));
  //   } catch (e) {
  //     String message = e.toString().replaceAll('api - ', '');
  //     emit(SmartStateError(message));
  //   }
  // }


  Future<List<CartData>>  cartData() async {
    String cartListString=  coreRepository.localRepository.getCartList();
    if (cartListString != '') {
      final List<CartData> cartList = CartData.decode(cartListString);
      cartDataList.value = cartList;
      return cartList;
    }else{
      return [];
    }
  }

}