import 'dart:io';
import 'package:flutter/material.dart';

import '../../res/components/CustomGradientButton.dart';
import '../../res/components/customOutlineButton.dart';
import '../../view/mobile view/finance_request_mobile.dart';

class SearchVehicle extends StatefulWidget {
  final File? imageFile;
  final String? vehicleRegistration;

  const SearchVehicle(
      {super.key, required this.imageFile, required this.vehicleRegistration});

  @override
  State<SearchVehicle> createState() => _SearchVehicleState();
}

class _SearchVehicleState extends State<SearchVehicle> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // print('🚒🚒🚒🚍${widget.vehicleRegistration}');
    _controller.text = widget.vehicleRegistration!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Scan Code',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: Column(
        children: [
          widget.imageFile != null
              ? Expanded(
                  child: Image.file(widget.imageFile!, fit: BoxFit.cover))
              : const Center(child: Text("No image selected")),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 50, top: 20),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Enter VRM/VIN Number',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomOutlineButton(
                      title: 'Retake',
                      prefixIcon: Icons.refresh,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CustomGradientButton(
                        width: 160,
                        title: 'Search',
                        suffixIcon: Icons.arrow_right_alt_sharp,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FinanceRequestMobile(
                                  vehicleRegistration:
                                      widget.vehicleRegistration,
                                ),
                              ));
                        }),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
