import 'package:flutter/material.dart';
import 'package:mockapp/view/mobile%20view/scan_vehicle_plate.dart';
import '../../res/colors.dart';
import '../../res/components/CustomGradientButton.dart';
import 'image_service.dart';

class FinanceRequestMobile extends StatefulWidget {
  final String? vehicleRegistration;

  const FinanceRequestMobile({super.key, this.vehicleRegistration});

  @override
  State<FinanceRequestMobile> createState() => _FinanceRequestMobileState();
}

class _FinanceRequestMobileState extends State<FinanceRequestMobile> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // print('🚒🚒🚒🚍${widget.vehicleRegistration}');
    if (widget.vehicleRegistration != null) {
      _controller.text = widget.vehicleRegistration!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter VIN or Plate Number',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Please scan or enter the number.',
              style: TextStyle(color: Colors.black54, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.info_outline_rounded,
                        color: kGreyColor,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: 'Enter VRM/VIN Number',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CustomGradientButton(
                  prefixIcon: Icons.document_scanner_outlined,
                  width: 50,
                  onPressed: () async {
                    final imageService = ImageService();
                    final (file, data) = await imageService.pickImage();
                    if (file != null && data != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScanVehiclePlate(
                              imageFile: file,
                              imageData: data,
                            ),
                          ));
                      // Do something with the picked image
                    }
                  },
                  // here it should call pickImage()
                  isActive: true,
                  isScanButton: true,
                )
              ],
            ),
            SizedBox(height: 24),
            CustomGradientButton(
              title: 'Search Vehicle',
              onPressed: () {},
              isActive: false,
            )
          ],
        ),
      ),
    );
  }
}
