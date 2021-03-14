import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'footballmatch_result.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BioMetric(),
    );
  }
}


class BioMetric extends StatefulWidget {

  @override
  _BioMetricState createState() => _BioMetricState();
}

class _BioMetricState extends State<BioMetric> {

  int _counter = 0;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometric = false;
  String _authorizedorNot = "Not Authorized";
  List<BiometricType> _availableBiometricType = List<BiometricType>();
  Future<void> _checkBiometric()async{
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e){
      print(e);
    }
    if(!mounted) return;
    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }


  Future<void> _getListOfBiometricTypes()async{
    List<BiometricType> listOfBiometrics ;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e){
      print(e);
    }
    if(!mounted) return;
    setState(() {
      _availableBiometricType = listOfBiometrics  ;
    });
  }

void authenticate()async {
  List<BiometricType> availableBiometrics =
  await _localAuthentication.getAvailableBiometrics();

  if (Platform.isIOS) {
    if (availableBiometrics.contains(BiometricType.face)) {
      // Face ID.
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      // Touch ID.
    }
  }

}


  Future<void> _authorizeNow()async{
    bool isAuthorized = false;
    try {
      isAuthorized =  await _localAuthentication.authenticateWithBiometrics(localizedReason: "please authenticate to complete the process",
        useErrorDialogs:  true,
        stickyAuth: true,
      );
    } on PlatformException catch (e){
      print(e);
    }
    if(!mounted) return;
    setState(() {
      if(isAuthorized){
       Navigator.push(context, MaterialPageRoute(builder: (context)=> Football()));
      }
      else {
        _authorizedorNot = "Not Authorized";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: IconButton(icon: Icon(Icons.face_retouching_natural,size: 50,), onPressed: (){
              _authorizeNow();
              }),
            ),

            SizedBox(
              height: 5,
            ),
            Text('Press the Icon for Face ID Auth')
          ],
        ),
      ),
    );
  }
}
