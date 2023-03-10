import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../core/core.dart';
import '../../ui.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpVerifyScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();
  late final OtpCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpCubit>(
      create: (context) {
        _cubit = OtpCubit(context.read<CoreRepository>());
        return _cubit;
      },
      child: BlocListener<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if (state is OtpVerifyOTPSuccess) {
            if (state.otpResponse.data == null) {
              if (kDebugMode) {
                print("json hello");
              }
              // context.showOtpConfirm(message: state.otpResponse.message.toString(),onConfirm: (){
              //
              // }, title: 'Alert');
              context.showToast(state.otpResponse.message.toString());
            } else {
              context.showToast(state.otpResponse.message.toString());
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return const HomeContainer();
                },
              ), (e) => false);
            }
          }
          if (state is OtpVerifyOTPError) {
            context.showToast(state.message);
          }
        },
        child: Scaffold(
          appBar:  PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: AppBar(
              toolbarHeight: 0,
              backgroundColor: AppTheme.appYellow,
              elevation: 0.0,
            ),
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () {
                // Hide keyboard if touched outside of text field
                _hideKeyboard();
              },
              behavior: HitTestBehavior.translucent,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: AppTheme.appYellow,
                      height: MediaQuery.of(context).size.height * 1 / 3,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child:  AppLogo(),),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          StringConstant.enterVerificationCode,
                          style: TextStyle(
                              fontSize: 18,
                              color: AppTheme.appBlack,
                              fontWeight: FontWeight.w600,
                              fontFamily: StringConstant.fontFamily),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          '${StringConstant.weHaveSendOtp} ${widget.phoneNumber}',
                          style:
                              TextStyle(fontSize: 16, color: AppTheme.appBlack),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                      margin: const EdgeInsets.only(left: 120, right: 120),
                      height: 70,
                      width: 120,
                      alignment: Alignment.center,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 16, color: AppTheme.appBlack),
                        decoration: InputDecoration(
                            hintText: '',
                            hintStyle: TextStyle(
                                fontSize: 16, color: AppTheme.appGrey),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            counterStyle: const TextStyle(
                              height: double.minPositive,
                            ),
                            counterText: ""),
                        onChanged: (phone) {
                          debugPrint(phone);
                        },
                        maxLength: 6,
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppTheme.appYellow,
                            elevation: 3,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            fixedSize: const Size(170, 52),
                            //////// HERE
                          ),
                          onPressed: () => _onTapVerifyOtp(context),
                          child: const Text(
                           StringConstant.continueButton,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TweenAnimationBuilder<Duration>(
                        duration: const Duration(minutes: 1),
                        tween: Tween(
                            begin: const Duration(minutes: 1),
                            end: Duration.zero),
                        onEnd: () {
                          if (kDebugMode) {
                            print('Timer ended');
                          }
                        },
                        builder: (BuildContext context, Duration value,
                            Widget? child) {
                          String strDigits(int n) =>
                              n.toString().padLeft(2, '0');
                          final minutes =
                              strDigits(value.inMinutes.remainder(60));
                          final seconds =
                              strDigits(value.inSeconds.remainder(60));
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text('$minutes:$seconds',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppTheme.appBlack, fontSize: 16)));
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringConstant.didNotReceiveCode,
                            style: TextStyle(
                                fontSize: 16, color: AppTheme.appBlack),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: (){
                              _onTapResend(context);
                            },
                            child: Text(
                              StringConstant.resendNow,
                              style:
                                  TextStyle(fontSize: 16, color: AppTheme.appYellow),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  _onTapVerifyOtp(BuildContext context) {
    _hideKeyboard();
    // TODO : validate mobile number
    debugPrint('_otpController.text.length ${_otpController.text.length}');
    if (_otpController.text.isNotEmpty && _otpController.text.length == 6) {
      _cubit.verifyOTP(
          phoneNumber: widget.phoneNumber, otp: _otpController.text);
    } else {
      context.showToast(StringConstant.enterOtp);
    }
  }
  _onTapResend(BuildContext context) {
    _hideKeyboard();
    _cubit.resendOTP(
        phoneNumber: widget.phoneNumber);

  }
}
