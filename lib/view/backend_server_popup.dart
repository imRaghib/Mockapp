import 'package:flutter/material.dart';
import 'package:mockapp/res/components/CustomGradientButton.dart';
import 'package:mockapp/res/components/customOutlineButton.dart';
import 'package:mockapp/res/default_urls.dart';
import '../res/colors.dart';

class BackendServerPopup extends StatelessWidget {
  BackendServerPopup({super.key});

  final TextEditingController _textController =
      TextEditingController(text: DefaultURLs.defaultBackendUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildServerPopup(),
    );
  }

  Card buildServerPopup() {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Text('Configurations'),
          TextField(
            controller: _textController,
            cursorColor: kGreyColor,
            style: TextStyle(color: kGreyColor),
            decoration: InputDecoration(
              labelText: 'Server Url',
              labelStyle: TextStyle(color: kGreyColor),
              enabledBorder: textFieldBorderStyle,
              focusedBorder: textFieldBorderStyle,
              border: textFieldBorderStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomGradientButton(onPressed: () {}),
              CustomOutlineButton(onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}
