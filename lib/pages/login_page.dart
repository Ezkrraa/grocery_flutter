import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_flutter/http/auth/auth_controller.dart';
import 'package:grocery_flutter/http/auth/login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  isEmptyValidator(value) {
    return value == null || value.isEmpty ? "Please enter a value" : null;
  }

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Login page'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 150, horizontal: 20),
        child: Form(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                    validator: (value) => isEmptyValidator(value),
                  ),
                ),
              ),

              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                  child: TextFormField(
                    enableSuggestions: false,
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                    validator: (value) => isEmptyValidator(value),
                  ),
                ),
              ),

              FilledButton(
                onPressed: () async {
                  String? jwt = await AuthController.login(
                    LoginModel(
                      userName: emailController.text,
                      password: passwordController.text,
                    ),
                  );
                  if (!context.mounted) return;
                  if (jwt == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error connecting to server'),
                        duration: Duration(seconds: 10),
                      ),
                    );
                  } else if (jwt.length < 300 || !jwt.startsWith("ey")) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(jwt),
                        duration: Duration(seconds: 10),
                      ),
                    );
                  } else {
                    storage.write(key: 'jwt', value: jwt);
                    Navigator.of(
                      context,
                    ).popAndPushNamed('/home', arguments: jwt);
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/create-account');
                },
                child: Text('Create account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
