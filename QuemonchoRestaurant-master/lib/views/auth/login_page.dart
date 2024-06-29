import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/custom_btn.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/login_controller.dart';
import 'package:foodly_restaurant/models/login_request.dart';
import 'package:foodly_restaurant/views/auth/registration.dart';
import 'package:foodly_restaurant/views/auth/widgets/email_textfield.dart';
import 'package:foodly_restaurant/views/auth/widgets/password_field.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  String _selectedUserType = 'Client'; // Default selected user type

  final FocusNode _passwordFocusNode = FocusNode();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
   
    super.dispose();
  }

  bool validateAndSave() {
    final form = _loginFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    // List of user types
    List<String> userTypes = ['Client', 'Vendor', 'Driver', 'Admin'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(top: 5.w),
          height: 50.h,
          child: Text(
            "Foodly Restaurant Panel",
            style: appStyle(24, kPrimary, FontWeight.bold),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 30.h,
          ),
          Lottie.asset('assets/anime/delivery.json'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  //email
                  EmailTextField(
                    focusNode: _passwordFocusNode,
                    hintText: "Email",
                    controller: _emailController,
                    prefixIcon: Icon(
                      CupertinoIcons.mail,
                      color: Theme.of(context).dividerColor,
                      size: 20.h,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                  ),

                  SizedBox(
                    height: 25.h,
                  ),

                  PasswordField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                  ),

                  SizedBox(
                    height: 6.h,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: _selectedUserType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedUserType = newValue!;
                            });
                          },
                          items: userTypes.map((String userType) {
                            return DropdownMenuItem<String>(
                              value: userType,
                              child: Text(userType),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const RegistrationPage());
                          },
                          child: Text('Register',
                              style: appStyle(
                                  12, Colors.black, FontWeight.normal)),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 12.h,
                  ),

                  Obx(
                    () => controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: kPrimary,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(kLightWhite),
                          ))
                        : CustomButton(
                            btnHieght: 37.h,
                            btnWidth: 225,
                            color: kPrimary,
                            text: "L O G I N",
                            onTap: () {
                              LoginRequest model = LoginRequest(
                                email: _emailController.text,
                                password: _passwordController.text,
                                userType: _selectedUserType, // Pass selected user type to the model
                              );

                              String authData = loginRequestToJson(model);

                              controller.loginFunc(authData);
                            },
                          ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
