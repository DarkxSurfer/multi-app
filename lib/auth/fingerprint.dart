import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:multi_app/Home/home_screen.dart';

class FingerPrint extends StatefulWidget {
  const FingerPrint({super.key});

  @override
  State<FingerPrint> createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {
  late final LocalAuthentication myAuthentication;
  bool authState = false;

  @override
  void initState() {
    super.initState();

    myAuthentication = LocalAuthentication();
    myAuthentication.isDeviceSupported().then((bool myAuth) => setState(() {
          authState = myAuth;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Bio Metric'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: authenticate,
                child: const Text('Authenticate')),
          ],
        ),
      ),
    );
  }

  Future<void> authenticate() async {
    try {
      bool isAuthenticate = await myAuthentication.authenticate(
          localizedReason: 'local authentication',
          options: const AuthenticationOptions(
              stickyAuth: true, FingerPrintOnly: true));

      if (isAuthenticate) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }

      print('authenticated status is $isAuthenticate');
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) {
      return;
    }
  }
}
