import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kirana_store/core/core.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  HelpScreenState createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  bool manageOrder = true;
  bool returnRefund = true;
  bool transaction = true;
  bool other = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appYellow,
          iconTheme: IconThemeData(color: AppTheme.appWhite),
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.only(right: 40),
            height: 50,
            alignment: Alignment.center,
            child: Text(
              StringConstant.help,
              style: TextStyle(
                  color: AppTheme.appWhite,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontFamily: StringConstant.fontFamily),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: ListView(
            children: [
              Image.asset(
                AppIconKeys.helpImage,
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                StringConstant.helpCentre,
                style: TextStyle(
                    color: AppTheme.appBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                StringConstant.pleaseGetInTouchNote,
                style: TextStyle(color: AppTheme.appBlack, fontSize: 10),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                StringConstant.welcomeToHelpCentre,
                style: TextStyle(color: AppTheme.appBlack, fontSize: 14),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                StringConstant.youCanCallUs,
                style: TextStyle(
                    color: AppTheme.appBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Text(
                StringConstant.nineToSeven,
                style: TextStyle(color: AppTheme.appBlack, fontSize: 10),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_hospital_outlined,
                    color: AppTheme.appGrey,
                  ),
                  Text(
                    StringConstant.helpMobileNumber,
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    color: AppTheme.appGrey,
                  ),
                  Text(
                    StringConstant.kareliLocation,
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                StringConstant.customerService,
                style: TextStyle(
                    color: AppTheme.appBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    manageOrder = !manageOrder;
                    other = true;
                    returnRefund = true;
                    transaction = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringConstant.manageOrders,
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify,
                    ),
                    Visibility(
                      visible: manageOrder,
                      replacement: const Icon(Icons.keyboard_arrow_up_outlined),
                      child: const Icon(Icons.keyboard_arrow_down_outlined),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: !manageOrder,
                  child: Text(
                    StringConstant.allOfYourOrdersHaveBeen,
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 12,
                        fontFamily: 'Montserrat'),
                    textAlign: TextAlign.justify,
                  )),
              Visibility(
                visible: !manageOrder,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    returnRefund = !returnRefund;
                    other = true;
                    manageOrder = true;
                    transaction = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringConstant.returnsRefund,
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify,
                    ),
                    Visibility(
                      visible: returnRefund,
                      replacement: const Icon(Icons.keyboard_arrow_up_outlined),
                      child: const Icon(Icons.keyboard_arrow_down_outlined),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: !returnRefund,
                  child: Text(
                    StringConstant.onceAOrder,
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 12,
                        fontFamily: StringConstant.fontFamily),
                    textAlign: TextAlign.justify,
                  )),
              Visibility(
                visible: !returnRefund,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    transaction = !transaction;
                    other = true;
                    manageOrder = true;
                    returnRefund = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringConstant.transaction,
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify,
                    ),
                    Visibility(
                      visible: transaction,
                      replacement: const Icon(Icons.keyboard_arrow_up_outlined),
                      child: const Icon(Icons.keyboard_arrow_down_outlined),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: !transaction,
                  child: Text(
                    StringConstant.youNeedToPayOnline,
                     style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 12,
                        fontFamily: 'Montserrat'),
                    textAlign: TextAlign.justify,
                  )),
              Visibility(
                visible: !transaction,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    other = !other;
                    transaction = true;
                    manageOrder = true;
                    returnRefund = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringConstant.other,
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify,
                    ),
                    Visibility(
                      visible: other,
                      replacement: const Icon(Icons.keyboard_arrow_up_outlined),
                      child: const Icon(Icons.keyboard_arrow_down_outlined),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: !other,
                  child: Text(
                    StringConstant.contactOnTheHelpline,
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 12,
                        fontFamily: 'Montserrat'),
                    textAlign: TextAlign.justify,
                  )),
              Visibility(
                visible: !other,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
            ],
          ),
        ));
  }
}
