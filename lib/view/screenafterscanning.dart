import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'title_bar.dart'; // Importing TitleBar widget
import 'custom_bottom_nav_bar.dart'; // custom widget for bottom navigation

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VINViewModel()), // VINViewModel
        ChangeNotifierProvider(create: (_) => NotificationViewModel()), // NotificationViewModel
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VIN/VRM Entry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const VINScreen(),
    );
  }
}

class VINScreen extends StatefulWidget {
  const VINScreen({super.key});

  @override
  State<VINScreen> createState() => _VINScreenState();
}

class _VINScreenState extends State<VINScreen> {
  final TextEditingController _vinController = TextEditingController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onScanPressed() {
    // Handle scan logic here (e.g., open camera)
    // For now, just show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Scan button pressed.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access the VINViewModel using Provider
    final vinViewModel = Provider.of<VINViewModel>(context);

    return Scaffold(
      appBar: const TitleBar(), // TitleBar widget is already imported and used here
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Enter VIN/VRM Number',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _vinController,
              decoration: const InputDecoration(
                labelText: 'VIN/VRM Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onScanPressed, // Trigger scan logic here
              child: const Text('Scan VIN/VRM'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle VIN submission logic
                String vin = _vinController.text;
                if (vin.isNotEmpty) {
                  // Update the ViewModel's VIN value
                  vinViewModel.setVIN(vin); // This updates the ViewModel state
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('VIN/VRM Entered: $vin')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a VIN/VRM number.')),
                  );
                }
              },
              child: const Text('Submit VIN/VRM'),
            ),
            const SizedBox(height: 20),
            Text('Entered VIN: ${vinViewModel.vin}', // Display the entered VIN
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class VINViewModel extends ChangeNotifier {
  String _vin = '';

  String get vin => _vin;

  void setVIN(String vin) {
    _vin = vin;
    notifyListeners(); // Notify listeners to update UI
  }
}
