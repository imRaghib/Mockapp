import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importing the provider package
import 'package:file_picker/file_picker.dart';
import 'custom_bottom_nav_bar.dart';
import 'title_bar.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        // Add other providers when needed
      ],
      child: const AutoFinanceApp(),
    ),
  );
}

class AutoFinanceApp extends StatelessWidget {
  const AutoFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Finance Request',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const AutoFinanceRequestScreen(),
    );
  }
}

class AutoFinanceRequestScreen extends StatefulWidget {
  const AutoFinanceRequestScreen({super.key});

  @override
  State<AutoFinanceRequestScreen> createState() => _AutoFinanceRequestScreenState();
}

class _AutoFinanceRequestScreenState extends State<AutoFinanceRequestScreen> {
  //Used to control and read input from a TextField where the user types mileage.
  final TextEditingController mileageController = TextEditingController();
  //Stores the name of the uploaded file (initially empty).
  String uploadedFile = '';
  double valuationAmount = 25348.0;

  void _calculate() {
    //converting the user's input from the mileage text field into a double.
    final mileage = double.tryParse(mileageController.text) ?? 0.0;// if not then sample as 0.0
    //calculated as 2% of the mileage.
    final depreciation = mileage * 0.02;
    //Uses .clamp() to ensure the result doesn’t go below €5000 or above €25348.
    double result = (25348.0 - depreciation).clamp(5000, 25348);
    //updates the valuationAmount state with the new calculated value.
    setState(() => valuationAmount = result);
  }

  Future<void> _uploadFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null && result.files.single.name.isNotEmpty) {
      setState(() => uploadedFile = result.files.single.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loanAmount = valuationAmount;

    return Scaffold(
      appBar: const TitleBar(), // Use the TitleBar widget here
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1,), // From custom_bottom_nav_bar.dart
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Summary Cards
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildVehicleSummaryCard()),
                const SizedBox(width: 16),
                Expanded(child: _buildRequestSummaryCard(loanAmount)),
              ],
            ),
            const SizedBox(height: 20),

            // Upload Section
            _buildUploadSection(),
            const SizedBox(height: 20),

            // Submit Button
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Request submitted!')),
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text('Submit Request', selectionColor: Colors.teal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleSummaryCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Hardcoded data for now
          children: const [
            Text('Vehicle Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 18),
            InfoRow(label: 'Registration Number', value: 'k570bl'),
            InfoRow(label: 'VIN No.', value: '1HGCM82633A004352'),
            InfoRow(label: 'Asset Sub Type', value: 'Car'),
            InfoRow(label: 'Condition', value: 'Registered'),
            InfoRow(label: 'Reg Date', value: '28-12-2020'),
            InfoRow(label: 'Asset Make', value: 'Polestar'),
            InfoRow(label: 'Model Description', value: '2.78kWh Dual Motor Intro'),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestSummaryCard(double loanAmount) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Request Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: mileageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Mileage',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: _calculate, child: const Text('Calculate')),
              ],
            ),
            const SizedBox(height: 20),
            _amountRow('Valuation Amount', valuationAmount),
            _amountRow('Loan Amount', loanAmount),
          ],
        ),
      ),
    );
  }

  Widget _amountRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('$label:', style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 10),
          Text('€ ${amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildUploadSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: _uploadFile,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          width: double.infinity,
          child: Column(
            children: [
              const Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.teal),
              const SizedBox(height: 10),
              Text(uploadedFile.isEmpty ? 'Upload your files (max 5MB)' : 'Selected: $uploadedFile'),
              const SizedBox(height: 6),
              const Text('Tap to browse', style: TextStyle(color: Colors.teal, decoration: TextDecoration.underline)),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(label, style: const TextStyle(color: Colors.grey))),
          Expanded(flex: 5, child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
