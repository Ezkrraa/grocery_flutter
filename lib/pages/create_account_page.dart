import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_flutter/http/user/account_creation_model.dart';
import 'package:grocery_flutter/http/user/account_creation_result.dart';
import 'package:grocery_flutter/http/user/user_controller.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final controller = UserController();

  isEmptyValidator(value) {
    return value == null || value.isEmpty ? "Please enter a value" : null;
  }

  submitForm() async {
    var result = await UserController.createAccount(
      AccountCreationModel(
        userName: usernameController.text,
        password: passwordController.text,
        email: emailController.text,
      ),
    );
    if (mounted) {
      if (isSuccess(result)) {
        Fluttertoast.showToast(msg: "Created an account successfully");
        Navigator.of(context).pop();
      } else if (result is FailureResult) {
        Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: result.reason,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    keyboardType: TextInputType.text,
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username",
                    ),
                    validator: (value) => isEmptyValidator(value),
                  ),
                ),
              ),
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

              FilledButton(onPressed: submitForm, child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
