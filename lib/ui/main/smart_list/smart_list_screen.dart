import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kirana_store/core/core.dart';
import 'package:kirana_store/core/model/cart_data.dart';

import '../../../core/controller/cart_controller.dart';
import '../../ui.dart';

class SmartListScreen extends StatefulWidget {
  const SmartListScreen({super.key});

  @override
  State<SmartListScreen> createState() => _SmartListScreenState();
}

class _SmartListScreenState extends State<SmartListScreen> {
  late final SmartListCubit _cubit;
  final cartController = Get.find<CartController>();
  int selectedIndex = 0;
  String cartListString = '';
  Future<void> preference() async {
    cartListString = context.read<LocalRepository>().getCartList() ?? '';
    setState(() {
      cartListString;
    });
  }

  @override
  void initState() {
    super.initState();
    // _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SmartListCubit>(create: (context) {
            _cubit = SmartListCubit(context.read<CoreRepository>());
            //_cubit.loadData();
            return _cubit;
          }),

        ],
        child: BlocListener<SmartListCubit, SmartState>(
            listener: (context, state) {
              if (state is SmartStateLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
              if (state is SmartStateSuccess) {}
              if (state is SmartStateError) {
                context.showToast(state.message);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.appWhite,
                centerTitle: true,
                elevation: 0.0,
                iconTheme: IconThemeData(color: AppTheme.appBlack),
                title: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Your Smart List',
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   Text('Smart List')
                  ],
                ),
              ),
            )));
  }

//const Center(child: Text("profile",style: TextStyle(color: Colors.red),));

}
