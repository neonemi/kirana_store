import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../core/core.dart';
import '../../ui.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late final RegisterCubit _cubit;
  bool checkBoxValue = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) {
        _cubit = RegisterCubit(context.read<CoreRepository>());
        return _cubit;
      },
      child: BlocListener<RegisterCubit,RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if (state is RegisterSuccess) {
            if(state.registerUserResponse.data==null) {
              if (kDebugMode) {
                print("json hello");
              }

               context.showToast(state.registerUserResponse.message.toString());
            }else{
              context.showToast(state.registerUserResponse.message.toString());

            }
          }
          if (state is RegisterError) {
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
                    const SizedBox(height: 10,),
                    Container(
                        alignment: Alignment.center,
                        child:  Text(
                          StringConstant.signUp,
                          style: TextStyle(
                              fontSize: 24,color: AppTheme.appBlack,
                              fontWeight: FontWeight.w600,
                              fontFamily: StringConstant.fontFamily),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Text(StringConstant.fullName,style: TextStyle(fontSize: 14,color: AppTheme.appBlack),textAlign: TextAlign.left,)),
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(fontSize: 16,color: AppTheme.appBlack) ,
                            decoration: InputDecoration(
                                hintText: StringConstant.enterYourName,
                                hintStyle: TextStyle(fontSize: 16,color: AppTheme.appGrey),
                                border: InputBorder.none,
                                counterStyle: const TextStyle(height: double.minPositive,),
                                counterText: ""
                            ),
                            onChanged: (phone) {
                              debugPrint(phone);
                            },
                            maxLength: 200,
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.singleLineFormatter
                            ],
                          ),
                          const Divider(height: 1,color: Colors.grey,)
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Text(StringConstant.email,style: TextStyle(fontSize: 14,color: AppTheme.appBlack),textAlign: TextAlign.left,)),
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(fontSize: 16,color: AppTheme.appBlack) ,
                            decoration: InputDecoration(
                                hintText: StringConstant.enterYourEmail,
                                hintStyle: TextStyle(fontSize: 16,color: AppTheme.appGrey),
                                border: InputBorder.none,
                                counterStyle: const TextStyle(height: double.minPositive,),
                                counterText: ""
                            ),
                            onChanged: (phone) {
                              debugPrint(phone);
                            },
                            maxLength: 200,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.singleLineFormatter
                            ],
                          ),
                          const Divider(height: 1,color: Colors.grey,)
                        ],
                      ),
                    ),

                    Container(
                        margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Text(StringConstant.mobileNo,style: TextStyle(fontSize: 14,color: AppTheme.appBlack),textAlign: TextAlign.left,)),
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 20),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 60,width: 70,
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                Container(
                                    height: 48,width: 70,
                                    alignment: Alignment.center,
                                    child: Text(StringConstant.nineOne,style: TextStyle(fontSize: 16,color: AppTheme.appBlack),)),
                                const Divider(height: 1,color: Colors.grey,)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width-120,
                            child: Column(
                              children: [
                                TextFormField(
                                  style: TextStyle(fontSize: 16,color: AppTheme.appBlack) ,
                                  decoration: InputDecoration(
                                      hintText: StringConstant.phoneNumber,
                                      hintStyle: TextStyle(fontSize: 16,color: AppTheme.appGrey),
                                      border: InputBorder.none,
                                      counterStyle: const TextStyle(height: double.minPositive,),
                                      counterText: ""
                                  ),
                                  onChanged: (phone) {
                                    debugPrint(phone);
                                  },
                                  maxLength: 10,
                                  controller: _phoneController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                                const Divider(height: 1,color: Colors.grey,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                checkBoxValue = !checkBoxValue;
                              });
                            },
                            child: checkBoxValue == true
                                ?  SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(Icons.check_box,color: AppTheme.appYellow,)
                            )
                                :  SizedBox(
                                width: 20,
                                height: 20,
                                child:Icon(Icons.check_box_outline_blank,color: AppTheme.appYellow,)
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(
                                  StringConstant.pleaseAgreeToOur,
                                  style: TextStyle(
                                      color: AppTheme.appBlack),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                         PrivacyScreen(url: Apis.privacyUrl, heading: StringConstant.privacyPolicy,)));

                                    },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      StringConstant.privacyPolicy,
                                      style: TextStyle(
                                          color: AppTheme.appBlack,fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
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
                          onPressed: () => _onTapSendOtp(context),
                          child: const Text(
                            StringConstant.signUp,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringConstant.alreadyHaveAccount,
                            style: TextStyle(
                                fontSize: 16
                                ,color: AppTheme.appBlack
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(width: 5,),
                          GestureDetector(
                            onTap:(){
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                builder: (context) {
                                  return const LoginScreen();
                                },
                              ), (e) => false);
                            },
                            child: Text(
                              StringConstant.signIn,
                              style: TextStyle(
                                  fontSize: 16
                                  ,color: AppTheme.appYellow
                              ),
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

  _onTapSendOtp(BuildContext context){
    _hideKeyboard();
    // TODO : validate mobile number
    debugPrint(
        '_phoneNumberController.text.length ${_phoneController.text.length}');
    if(_nameController.text.isNotEmpty && _nameController.text.length>3){
      if(_emailController.text.isNotEmpty && AppFunctions.isEmailValid(_emailController.text)){
        if (_phoneController.text.isNotEmpty &&
            _phoneController.text.length == 10) {
          if(checkBoxValue==true){
            _cubit.registerUser(
                mobile: _phoneController.text,
                name: _nameController.text,
                email: _emailController.text);
          }else{
            context.showToast(StringConstant.pleaseAgreeToOurPolicy);
          }
        } else {
          context.showToast(StringConstant.enterMobileNumber);
        }
      }else{
        context.showToast(StringConstant.enterYourEmail);
      }
    }else{
      context.showToast(StringConstant.enterYourName);
    }
  }
  // Future<void> launchPrivacyUrl(
  //     {required BuildContext context, required String url}) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     debugPrint('Unable to launch url');
  //     ToastExtension(context).showToast(StringConstant.enableToLaunch);
  //   }
  //
  //   return;
  // }
}
