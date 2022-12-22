import 'package:flutter/material.dart';
import 'package:kirana_store/core/core.dart';

class AddItemDialogBuilder {
  AddItemDialogBuilder(
      this.context,
      );

  final BuildContext context;

  TextEditingController commentController = TextEditingController();

  final List<Map<String, dynamic>> sortingList = [
    {"category": [
      'Grains',
      'Baby Care',
      'Spices',
      'Bakery'
    ],
    }];
  showCategoryDialog(BuildContext context, final void Function(String)? onConfirm) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: AppTheme.appWhite,
      insetPadding: const EdgeInsets.only(top: 120),
      alignment: Alignment.topCenter,
      child: SizedBox(
          width: MediaQuery.of(context).size.width-20,
          child: StatefulBuilder(builder: (context, setState) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: sortingList[0]["category"].length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        sortingList[0]["category"][index],
                        style: TextStyle(
                            color: AppTheme.appBlack,
                            fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                      onTap: () {

                        onConfirm!(sortingList[0]["category"][index]);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }
          )
      ),
    );
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (BuildContext context) => dialog);
  }
}