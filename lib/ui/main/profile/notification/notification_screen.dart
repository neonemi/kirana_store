import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kirana_store/core/core.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationCubit _cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationCubit>(
      create: (context) {
        _cubit = NotificationCubit(context.read<CoreRepository>());

        return _cubit;
      },
      child: BlocListener<NotificationCubit, NotificationState>(
        listener: (context, state) {
          if (state is NotificationLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if (state is NotificationSuccess) {

          }
          if (state is NotificationError) {
            context.showToast(state.message);
          }
        },
        child:
        BlocBuilder<NotificationCubit,NotificationState>(builder: (context, state) {

          return Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.appYellow,
                // centerTitle: true,
                elevation: 0.0,
                iconTheme: IconThemeData(color: AppTheme.appWhite),
                title: Container(
                  height: 50,
                  margin: const EdgeInsets.only(right: 40),
                  alignment: Alignment.center,
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                        color: AppTheme.appWhite,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              body: const SizedBox(
                height: 200,
                width: 200,)

          );
        }),
      ),
    );
    //const Center(child: Text("profile",style: TextStyle(color: Colors.red),));
  }


}
