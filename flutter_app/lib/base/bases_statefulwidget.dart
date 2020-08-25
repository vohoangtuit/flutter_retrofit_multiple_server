import 'package:flutter/material.dart';
import 'package:flutter_app/build_config/app_config.dart';
import 'package:flutter_app/network/rest_client.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/loadingdialog.dart';

import 'dialog.dart';

typedef Int2VoidFunc = void Function(String);
abstract class BaseStatefulState<T extends StatefulWidget> extends State<T> {
  bool isLoading =false;
  LoadingDialog loadingDialog;
  BaseDialog  dialog;
  bool loaded =false;
 static BaseStatefulState baseStatefulState;
 RestClient restApi;
  AppConfig config;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: isLoading?widgetLoading():Container() ,
        )
      ],
    );
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!loaded) {
      baseStatefulState=this;
      config = AppConfig.of(context);
      restApi =  RestClient(baseStatefulState:baseStatefulState, BASE_URL: config.apiBaseUrl);
      setState(() {
        loaded = true;
      });
    }
  }

  void baseMethod() {
    // Parent method
  }
  showBaseDialog(String title,String description){
    dialog = new BaseDialog(title: title, description: description);
    showDialog(
     // barrierDismissible: false,// touch outside dismiss
      context: context,
      builder: (BuildContext context) => dialog
    );
  }

  void showLoading(bool show)async{
    await  Future.delayed(Duration(milliseconds: 30));
    setState(() async{
      if(show){
        await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
      }else{
        if (loadingDialog != null && loadingDialog.isShowing()) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          loadingDialog = null;
        }
      }
    });

  }

}
