import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kirana_store/core/core.dart';

import '../../../ui.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  AddItemScreenState createState() => AddItemScreenState();
}

class AddItemScreenState extends State<AddItemScreen> {
  late final SmartListCubit _cubit;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<SmartListCubit>(create: (context) {
            _cubit = SmartListCubit(context.read<CoreRepository>());
            // _cubit=SmartListCubit(context.read<CoreRepository>())..getSearchProduct(text: '5gmYcjfO9q');
            return _cubit;
          }),
        ],
        child: BlocListener<SmartListCubit, SmartState>(
            listener: (context, state) {
              print(state);
              if (state is SearchLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
            },
            child: Scaffold(
                backgroundColor: AppTheme.appWhite,
                appBar: AppBar(
                  backgroundColor: AppTheme.appWhite,
                  iconTheme: IconThemeData(color: AppTheme.appWhite),
                  leading: GestureDetector(
                    onTap: (){
                      _navigationPop(context);
                    },
                    child: Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: AppTheme.appYellow, shape: BoxShape.circle),
                        child: const Center(
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                  ),
                  centerTitle: true,
                  elevation: 0.0,
                  title: Container(
                    margin: const EdgeInsets.only(right: 40),
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      StringConstant.addItem,
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontFamily: StringConstant.fontFamily),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                body: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Stack(
                    children: [
                      Container(
                          height: 90,
                          // color: AppTheme.appYellow,
                          child: searchBar(context,
                              MediaQuery.of(context).size.width * 0.07)),
                      Container(
                        margin: const EdgeInsets.only(top: 90),
                      )
                    ],
                  ),
                ))));
  }

  Widget searchBar(BuildContext context, double bodyMargin) {
    var searchController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: bodyMargin, vertical: 22),
      child: TextFormField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        textDirection: TextDirection.ltr,
        keyboardType: TextInputType.none,
        style: TextStyle(color: AppTheme.appBlack),
        cursorColor: AppTheme.appWhite,
        cursorHeight: 0.0,
        cursorWidth: 0.0,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            fillColor: AppTheme.appWhite,
            filled: true,
            hintText: StringConstant.searchHintAddItem,
            hintStyle: TextStyle(color: AppTheme.appGrey),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appGrey)),
            disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appGrey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appGrey)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appGrey)),
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appGrey)),
            suffixIcon: RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppTheme.appGrey,
                ))),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ],
        onTap: (){
          list();
        },
        // onChanged: (value) {
        //   debugPrint(value);
        //
        // },
        // onFieldSubmitted: (String value) {
        //   _cubit.getSearchProduct(text: value);
        //   setState(() {
        //     searchController.text = value;
        //   });
        // },
      ),
    );
  }

  void _navigationPop(BuildContext context) {
    Navigator.of(context).pop();
  }
  void list(){
    AddItemDialogBuilder(context).showCategoryDialog(context, (String value) {
      print(value);
      // setState((){
      //   visibleBestSeller=false;
      // });
      //_cubit.getFoodProduct(getSubCategory.data![0].id.toString(), value, "");

    });
  }
}
