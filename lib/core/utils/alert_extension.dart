import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:vendorapp/core/core.dart';

extension AlertExtension on BuildContext {

  showSuccessAlert({
    required String message,
    String? title,
    final void Function()? onConfirm,
    String? confirmTextButton,
    String? cancelTextButton,
    required double height,
    required double width
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                padding: const EdgeInsets.all(8),
                  child: Text('Alert',style: TextStyle(color: AppTheme.appBlack,fontWeight: FontWeight.w600,fontSize: 18),textAlign: TextAlign.left,)),
              if(message.isNotEmpty)Container(
                  padding: const EdgeInsets.all(8),child: Text(message)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => SmartDialog.dismiss(),
                    child: Text(cancelTextButton ??'Cancel',style: TextStyle(color: AppTheme.appBlack),textAlign: TextAlign.left,),
                  ),
                  ElevatedButton(
                    //Colors.green,
                    onPressed: () {
                      onConfirm?.call();
                      SmartDialog.dismiss();
                    },
                    child: Text(confirmTextButton ??'Ok',style: TextStyle(color: AppTheme.appBlack),textAlign: TextAlign.left,),
                  ),
                ],
              )
        ]),
      );
    });
  }
  hideSuccessAlert(){
    SmartDialog.dismiss(status: SmartStatus.dialog);
  }
  showCameraAlert({
    required String title,
    final void Function()? onCamera,
    final void Function()? onGallery,
    String? cancelTextButton,
    required double height,
    required double width
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(title,style: TextStyle(color: AppTheme.appBlack,fontWeight: FontWeight.w600,fontSize: 18),textAlign: TextAlign.left,)),
              GestureDetector(
               onTap: (){
                     onCamera?.call();
                     SmartDialog.dismiss();
               },
               child: Container(
                    padding: const EdgeInsets.all(8),child:  Text('Camera',style: TextStyle(color: AppTheme.appBlack,fontSize: 14))),
             ),
              Divider(color: AppTheme.appGrey,),
              GestureDetector(
                onTap: (){
                  onGallery?.call();
                  SmartDialog.dismiss();
                },
                child: Container(
                    padding: const EdgeInsets.all(8),child:  Text('Gallery',style: TextStyle(color: AppTheme.appBlack,fontSize: 14))),
              ),
              Divider(color: AppTheme.appGrey,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => SmartDialog.dismiss(),
                    child: Text(cancelTextButton ??'Cancel',style: TextStyle(color: AppTheme.appBlack,fontWeight: FontWeight.w600),textAlign: TextAlign.left,),
                  ),
                ],
              )
            ]),
      );
    });
  }
  showSmartLoadingDialog() {
    SmartDialog.show(builder: (context) {
      return Container(
        height: 80,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:const CircularProgressIndicator(),
      );
    });
  }
  hideSmartLoadingDialog(){
    SmartDialog.dismiss(status: SmartStatus.dialog);
  }

  showTimeOutAlert({
    final void Function()? onConfirm,
    String? confirmTextButton,
    String? cancelTextButton,
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: 180,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            children:[
              Text('Time Out',style: TextStyle(color: AppTheme.appBlack),textAlign: TextAlign.left,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    //Colors.orange,
                    onPressed: () {
                      onConfirm?.call();
                      SmartDialog.dismiss();
                    },
                    child: Text(confirmTextButton ??'Ok',style: TextStyle(color: AppTheme.appBlack),textAlign: TextAlign.left,),
                  ),
                ],
              )
            ]),
      );
    });
  }

  showOtpConfirm({
    final void Function()? onConfirm,
    String? confirmTextButton,
    String? cancelTextButton,
    required String message,
    required String title,
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: 160,
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width-100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            children:[
              Container(alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width-100,
                  child: Text(title,style: TextStyle(color: AppTheme.appBlack,fontSize: 22),textAlign: TextAlign.left,)),
             const SizedBox(height: 10,),
              Text(message,style: TextStyle(color: AppTheme.appBlack,fontSize: 16),textAlign: TextAlign.left,),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    //Colors.orange,
                    onPressed: () {
                      onConfirm?.call();
                      SmartDialog.dismiss();
                    },
                    child: Text(confirmTextButton ??'Ok',style: TextStyle(color: AppTheme.appBlack),),
                  ),
                ],
              )
            ]),
      );
    });
  }

  showBottomSheet({
    bool isScrollControlled = true,
    Color backgroundColor = Colors.transparent,
    bool enableDrag = false,
    required WidgetBuilder builder,
  }) {
    showModalBottomSheet<void>(
      context: this,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      enableDrag: enableDrag,
      builder: builder,
    );
  }

  showRequestError({
    final void Function()? onConfirm,
    String? confirmTextButton,
    String? cancelTextButton,
    required String message,
  }) {
    SmartDialog.show(builder: (context) {
      return Container(
        height: 180,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child:Column(
            children:[
              Text(message),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    //Colors.orange,
                    onPressed: () {
                      onConfirm?.call();
                      SmartDialog.dismiss();
                    },
                    child: Text(confirmTextButton ??'Ok'),
                  ),
                ],
              )
            ]),
      );
    });
  }
}