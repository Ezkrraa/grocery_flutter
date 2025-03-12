import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_flutter/http/auth/auth_controller.dart';

class LoadRedirectPage extends StatefulWidget {
  const LoadRedirectPage({super.key});

  @override
  State<LoadRedirectPage> createState() => _LoadRedirectPageState();
}

class _LoadRedirectPageState extends State<LoadRedirectPage> {
  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final savedJwt = await storage.read(key: 'jwt');
    if (savedJwt == null) {
      if (mounted) {
        Navigator.of(context).popAndPushNamed('/login');
      }
    } else {
      if (!await AuthController.isValidToken(savedJwt)) {
        storage.delete(key: 'jwt');
        if (mounted) {
          Navigator.of(context).popAndPushNamed('/login');
        }
      } else {
        if (mounted) {
          Navigator.of(context).popAndPushNamed('/home', arguments: savedJwt);
        }
      }
    }
  }
}
