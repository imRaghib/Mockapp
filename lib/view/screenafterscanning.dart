import 'package:flutter/material.dart';
import 'custom_bottom_nav_bar.dart'; // Make sure this file exists in the same directory or adjust path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VIN/VRM Entry',
      debugShowCheckedModeBanner: false,
      home: const VinVrmEntryScreen(),
    );
  }
}

class VinVrmEntryScreen extends StatelessWidget {
  const VinVrmEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController vinController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFEAF1FC),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.circle, size: 30, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        'HILTERMANN',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        ' mDealer',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        '09-12-2025 03:11 PM',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.notifications_none),
                      SizedBox(width: 12),
                      CircleAvatar(radius: 16, backgroundColor: Colors.grey),
                    ],
                  )
                ],
              ),
            ),

            // Center Box
            Expanded(
              child: Center(
                child: Container(
                  width: 500,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Enter VIN/VRM Number",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Please enter VRM (Vehicle Registration Mark) or\n"
                            "VIN (Vehicle Identification Number) you can scan with\nscan option.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: vinController,
                              decoration: InputDecoration(
                                hintText: 'VIN / Plate Number',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2FB978), Color(0xFF01B4E4)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                              onPressed: () async {
                                // Placeholder for scanner logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Scan button pressed")),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: const Color(0xFF01B4E4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            final vin = vinController.text.trim();
                            if (vin.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Please enter a VIN/VRM")),
                              );
                            } else {
                              // Replace with actual search logic or ViewModel call
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Searching for: $vin")),
                              );
                            }
                          },
                          child: const Text(
                            'Search Vehicle',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
