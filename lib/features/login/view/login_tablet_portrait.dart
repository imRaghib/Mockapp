//Tablet portrait layout

import 'package:flutter/material.dart';
import 'package:mockapp/features/login/view/widgets/constants.dart';
import 'package:mockapp/features/login/view/widgets/login_form.dart';
import 'package:mockapp/features/login/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

const subtenantList = ['', ''];

class LoginTabletPortrait extends StatefulWidget {
  const LoginTabletPortrait({super.key});

  @override
  State<LoginTabletPortrait> createState() => _LoginTabletPortraitState();
}

class _LoginTabletPortraitState extends State<LoginTabletPortrait> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final inputColor = Color(0xFF82899B);
    final borderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: inputColor),
    );

    String? selectedOption;

    // final viewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UsernameField(
                controller: _usernameController,
                onChanged: (_) {}, // viewModel.setUsername,
              ),
              const SizedBox(height: 16),
              PasswordField(
                controller: _passwordController,
                onChanged: (_) {}, //viewModel.setPassword,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
              const SizedBox(height: 16),
              // SubtenantDropdown(
              //   value: "", //viewModel.subtenant,
              //   onChanged: (_) {}, //viewModel.setSubtenant,
              //   items: const ['HML', 'ABC', 'XYZ'],
              // ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle valid form submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Form is valid!")),
                    );
                  }
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
      // body: Column(
      //
      //   children: [
      //     buildTopImage(size),
      //     Expanded(
      //       child: Padding(
      //         padding: const EdgeInsets.all(0),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Column(
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(top: 30),
      //                   child: buildWelcomeText(text: 'Welcome Back'),
      //                 ),
      //                 const Text(
      //                   'Enter your email and password to access your account',
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(fontSize: 14, color: Colors.black54),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.symmetric(
      //                     vertical: 16,
      //                     horizontal: 200,
      //                   ),
      //                   child: Column(
      //                     children: [
      //                       Padding(
      //                         padding: EdgeInsets.symmetric(vertical: 16),
      //                         child: TextField(
      //                           cursorColor: inputColor,
      //                           style: TextStyle(color: inputColor),
      //                           decoration: InputDecoration(
      //                             labelText: 'Enter Username',
      //                             labelStyle: TextStyle(color: inputColor),
      //                             enabledBorder: borderStyle,
      //                             focusedBorder: borderStyle,
      //                             border: borderStyle,
      //                           ),
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: EdgeInsets.only(top: 16),
      //                         child: TextField(
      //                           cursorColor: inputColor,
      //                           style: TextStyle(color: inputColor),
      //                           decoration: InputDecoration(
      //                             labelText: 'Enter Password',
      //                             labelStyle: TextStyle(color: inputColor),
      //                             enabledBorder: borderStyle,
      //                             focusedBorder: borderStyle,
      //                             border: borderStyle,
      //                             suffixIcon: Icon(
      //                               Icons.remove_red_eye,
      //                               color: inputColor,
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.end,
      //                         children: [
      //                           Padding(
      //                             padding: const EdgeInsets.only(top: 14.0),
      //                             child: Text(
      //                               'Forgot Password?',
      //                               textAlign: TextAlign.right,
      //                               style: TextStyle(
      //                                 color: limeGreenColor,
      //                                 fontSize: 14,
      //                                 fontWeight: FontWeight.bold,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(top: 24),
      //                         child: DropdownButtonFormField<String>(
      //                           value: selectedOption,
      //                           onChanged: (value) {
      //                             selectedOption = value;
      //                             // Call setState() if this is in a StatefulWidget
      //                           },
      //                           items:
      //                               subtenantList
      //                                   .map(
      //                                     (option) => DropdownMenuItem(
      //                                       value: option,
      //                                       child: Text(
      //                                         option,
      //                                         style: TextStyle(
      //                                           color: inputColor,
      //                                         ),
      //                                       ),
      //                                     ),
      //                                   )
      //                                   .toList(),
      //                           decoration: InputDecoration(
      //                             labelText: 'Subtenant',
      //                             labelStyle: TextStyle(color: inputColor),
      //                             enabledBorder: borderStyle,
      //                             focusedBorder: borderStyle,
      //                             border: borderStyle,
      //                           ),
      //                           icon: Icon(
      //                             Icons.arrow_drop_down,
      //                             color: inputColor,
      //                           ),
      //                           style: TextStyle(color: inputColor),
      //                           dropdownColor: Colors.white,
      //                           hint: Text(
      //                             'Please select',
      //                             style: TextStyle(color: Colors.black),
      //                           ),
      //                         ),
      //                       ),
      //                       buildFaceId(),
      //                     ],
      //                   ),
      //                 ),
      //                 CustomGradientButton(
      //                   text: 'Login',
      //                   onPressed: () {
      //                     // Your login logic
      //                   },
      //                 ),
      //
      //                 // buildButton(context: context, buttonName: 'Login'),
      //               ],
      //             ),
      //
      //             // Footer
      //             Column(
      //               children: [
      //                 const Divider(thickness: 1),
      //                 Padding(
      //                   padding: const EdgeInsets.symmetric(
      //                     horizontal: 16,
      //                     vertical: 12,
      //                   ),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: const [
      //                       Text(
      //                         'Hiltermann\nCopyright © 2025 All Rights Reserved',
      //                         style: TextStyle(fontSize: 12),
      //                       ),
      //                       Column(
      //                         crossAxisAlignment: CrossAxisAlignment.end,
      //                         children: [
      //                           Text(
      //                             'Privacy Policy   •   Terms & Conditions',
      //                             style: TextStyle(
      //                               fontSize: 12,
      //                               color: Colors.teal,
      //                             ),
      //                           ),
      //                           SizedBox(height: 4),
      //                           Text(
      //                             'Version 2.84.1545',
      //                             style: TextStyle(
      //                               fontSize: 10,
      //                               color: Colors.grey,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Stack buildTopImage(Size size) {
    return Stack(
      children: [
        Image.asset(
          'lib/assets/images/hiltermann_login_screen_portrait.png',
          width: size.width,
          height: 250,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Your partner for',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'leasing and financing',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: Padding(
  //       padding: const EdgeInsets.only(bottom: 30),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Image.asset(
  //             'lib/assets/images/hiltermann_login_screen_portrait.png',
  //           ),
  //           buildFooter(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
