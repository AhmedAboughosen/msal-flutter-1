import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:msal_flutter/msal_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _output = 'NONE';

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  Future<void> _acquireToken() async{
    String res;
    try{
      res = await PublicClientApplication.acquireToken("https://login.microsoftonline.com/tfp/msalfluttertest.onmicrosoft.com/B2C_1_sisu", "5913dfb1-7576-451c-a7ea-a7c5a3f8682a", ["https://msalfluttertest.onmicrosoft.com/msalbackend/user_impersonation"]);
    } on PlatformException {
      res = "Error getting token";
    }

    setState(() {
      _output = res;
    });
  }

  Future<void> _acquireTokenSilently() async {
    String res;
    try
    {
      res = await PublicClientApplication.acquireTokenSilent("https://login.microsoftonline.com/tfp/msalfluttertest.onmicrosoft.com/B2C_1_sisu","5913dfb1-7576-451c-a7ea-a7c5a3f8682a", ["https://msalfluttertest.onmicrosoft.com/msalbackend/user_impersonation"]);
    } on PlatformException{
      res = "Error getting token silently!";
    }
    setState(() {
      _output = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton( onPressed: _acquireToken, 
                child: Text('AcquireToken()'),),
              RaisedButton( onPressed: _acquireTokenSilently,
                child: Text('AcquireTokenSilently()')),
              Text( _output)
            ],
          ),
        ),
      ),
    );
  }
}