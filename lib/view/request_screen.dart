import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Importing my custom widgets
import 'title_bar.dart';
import 'custom_bottom_nav_bar.dart';
//first comment was my first code but had the issue of the submit button
/*
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NotificationViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stocklist App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const StockListScreen(),
      routes: {
        '/request-details': (_) => const RequestDetailsScreen(),
      },
    );
  }
}

// Mock data for stock list
final List<Map<String, String>> stockData = [
  {
    'loanRef': '9670000008',
    'condition': 'Registered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'VINTAHSEEN0003000',
    'kenteken': '120',
    'model': 'BMW 6',
  },
  {
    'loanRef': '9670000008',
    'condition': 'Registered',
    'status': 'New',
    'maturity': '22-04-2024',
    'vin': 'MSTahseen001',
    'kenteken': '120',
    'model': 'BMW 6',
  },
  {
    'loanRef': '9670000008',
    'condition': 'Unregistered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'NSTAHSEEN0002',
    'kenteken': 'HK051AB',
    'model': 'BMW 6',
  },
  {
    'loanRef': '9670000009',
    'condition': 'Unregistered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'NSTAHSEEN0003',
    'kenteken': 'HK051AC',
    'model': 'ASTON MARTIN',
  },
  {
    'loanRef': '9670000001',
    'condition': 'Unregistered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'NSTAHSEEN0012',
    'kenteken': 'HK051AB',
    'model': 'YARIS',
  },
];

class StockListScreen extends StatefulWidget {
  const StockListScreen({super.key});

  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  late List<bool> selectedRows;

  @override
  void initState() {
    super.initState();
    selectedRows = List<bool>.filled(stockData.length, false);
  }

  void _toggleSelectAll(bool? value) {
    if (value == null) return;
    setState(() {
      for (var i = 0; i < selectedRows.length; i++) {
        selectedRows[i] = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final allSelected = selectedRows.every((e) => e);
    final anySelected = selectedRows.any((e) => e);

    return Scaffold(
      appBar: const TitleBar(),
      body: Column(
        children: [
          // Table header row
          Container(
            color: Colors.tealAccent,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Checkbox(
                    value: allSelected,
                    onChanged: _toggleSelectAll,
                  ),
                ),
                _headerCell('Loan Ref No.'),
                _headerCell('Condition'),
                _headerCell('Status'),
                _headerCell('Maturity Date'),
                _headerCell('VIN No.'),
                _headerCell('Kenteken'),
                _headerCell('Model'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: stockData.length,
              itemBuilder: (context, index) {
                final row = stockData[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black87),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Checkbox(
                          value: selectedRows[index],
                          onChanged: (val) {
                            setState(() {
                              selectedRows[index] = val ?? false;
                            });
                          },
                        ),
                      ),
                      _dataCell(row['loanRef']!),
                      _dataCell(
                        row['condition']!,
                        color: row['condition'] == 'Registered'
                            ? Colors.green.shade100
                            : Colors.orange.shade100,
                      ),
                      _dataCell(row['status']!),
                      _dataCell(row['maturity']!),
                      _dataCell(row['vin']!),
                      _dataCell(row['kenteken']!),
                      _dataCell(row['model']!),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: anySelected
                  ? () {
                Navigator.pushNamed(context, '/request-details');
              }
                  : null,
              child: const Text('Send Request', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2, // Stock_list index
        onTap: (index) {
          // Example navigation logic
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/auto-finance');
              break;
            case 2:
            // Already on Stock_list
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/loan-confirmation');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/more');
              break;
          }
        },
      ),
    );
  }

  Widget _headerCell(String text) => Expanded(
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  Widget _dataCell(String text, {Color? color}) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: color,
      child: Text(text, overflow: TextOverflow.ellipsis),
    ),
  );
}

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  String paymentMethod = 'Direct Deposit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //hard coded for now.
            _detailRow('Planned Date', '11-04-25'),
            _detailRow('Settlement Method', 'DAAS'),
            _detailRow('Customer Name', 'Will Simmons'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //hard coded for now.
                _amountCard('Total Receivable Settlement', '€ 0.00', Icons.account_balance_wallet),
                _amountCard('Loan Settlement Request', '€ 7,213.05', Icons.request_page),
                _amountCard('Grand Total', '€ 7,213.05', Icons.attach_money),
              ],
            ),
            const SizedBox(height: 30),
            const Text('Select Payment Method', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: paymentMethod,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'Direct Deposit', child: Text('Direct Deposit')),
                DropdownMenuItem(value: 'Bank Transfer', child: Text('Bank Transfer')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    paymentMethod = value;
                  });
                }
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Request Sent!')),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Send Request', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3, // Loan Confirmation index
        onTap: (index) {
          // Example navigation logic, adjust routes as needed
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/auto-finance');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/stocklist');
              break;
            case 3:
            // Already on Loan Confirmation
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/more');
              break;
          }
        },
      ),
    );
  }

  Widget _detailRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    ),
  );

  Widget _amountCard(String label, String value, IconData icon) => Expanded(
    child: Card(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.teal, size: 28),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}
*/
//second comment was my second code but it didnt have the animation of success coming up after the submit request was done.

/*void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NotificationViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stocklist App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const StockListScreen(),
      routes: {
        '/request-details': (_) => const RequestDetailsScreen(),
      },
    );
  }
}

// Mock data for stock list
final List<Map<String, String>> stockData = [
  {
    'loanRef': '9670000008',
    'condition': 'Registered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'VINTAHSEEN0003000',
    'kenteken': '120',
    'model': 'BMW 6',
  },
  {
    'loanRef': '9670000008',
    'condition': 'Registered',
    'status': 'New',
    'maturity': '22-04-2024',
    'vin': 'MSTahseen001',
    'kenteken': '120',
    'model': 'BMW 6',
  },
  {
    'loanRef': '9670000008',
    'condition': 'Unregistered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'NSTAHSEEN0002',
    'kenteken': 'HK051AB',
    'model': 'BMW 6',
  },
  {
    'loanRef': '9670000009',
    'condition': 'Unregistered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'NSTAHSEEN0003',
    'kenteken': 'HK051AC',
    'model': 'ASTON MARTIN',
  },
  {
    'loanRef': '9670000001',
    'condition': 'Unregistered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'NSTAHSEEN0012',
    'kenteken': 'HK051AB',
    'model': 'YARIS',
  },
];

class StockListScreen extends StatefulWidget {
  const StockListScreen({super.key});

  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  late List<bool> selectedRows;

  @override
  void initState() {
    super.initState();
    selectedRows = List<bool>.filled(stockData.length, false);
  }

  void _toggleSelectAll(bool? value) {
    if (value == null) return;
    setState(() {
      for (var i = 0; i < selectedRows.length; i++) {
        selectedRows[i] = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final allSelected = selectedRows.every((e) => e);
    final anySelected = selectedRows.any((e) => e);

    return Scaffold(
      appBar: const TitleBar(),
      body: Column(
        children: [
          // Send Request button at top right in a box
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(140, 40),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    onPressed: anySelected
                        ? () {
                      Navigator.pushNamed(context, '/request-details');
                    }
                        : null,
                    child: const Text('Send Request'),
                  ),
                ),
              ],
            ),
          ),

          // Table header row
          Container(
            color: Colors.tealAccent,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Checkbox(
                    value: allSelected,
                    onChanged: _toggleSelectAll,
                  ),
                ),
                _headerCell('Loan Ref No.'),
                _headerCell('Condition'),
                _headerCell('Status'),
                _headerCell('Maturity Date'),
                _headerCell('VIN No.'),
                _headerCell('Kenteken'),
                _headerCell('Model'),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: stockData.length,
              itemBuilder: (context, index) {
                final row = stockData[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black87),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Checkbox(
                          value: selectedRows[index],
                          onChanged: (val) {
                            setState(() {
                              selectedRows[index] = val ?? false;
                            });
                          },
                        ),
                      ),
                      _dataCell(row['loanRef']!),
                      _dataCell(
                        row['condition']!,
                        color: row['condition'] == 'Registered'
                            ? Colors.green.shade100
                            : Colors.orange.shade100,
                      ),
                      _dataCell(row['status']!),
                      _dataCell(row['maturity']!),
                      _dataCell(row['vin']!),
                      _dataCell(row['kenteken']!),
                      _dataCell(row['model']!),
                    ],
                  ),
                );
              },
            ),
          ),

          // Removed the bottom "Send Request" button
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2, // Stocklist index
        onTap: (index) {
          // Example navigation logic
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/auto-finance');
              break;
            case 2:
            // Already on Stocklist
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/loan-confirmation');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/more');
              break;
          }
        },
      ),
    );
  }

  Widget _headerCell(String text) => Expanded(
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  Widget _dataCell(String text, {Color? color}) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: color,
      child: Text(text, overflow: TextOverflow.ellipsis),
    ),
  );
}

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  String paymentMethod = 'Direct Deposit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hard coded for now.
            _detailRow('Planned Date', '11-04-25'),
            _detailRow('Settlement Method', 'DAAS'),
            _detailRow('Customer Name', 'Will Simmons'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Hard coded for now.
                _amountCard('Total Receivable Settlement', '€ 0.00', Icons.account_balance_wallet),
                _amountCard('Loan Settlement Request', '€ 7,213.05', Icons.request_page),
                _amountCard('Grand Total', '€ 7,213.05', Icons.attach_money),
              ],
            ),
            const SizedBox(height: 30),
            const Text('Select Payment Method', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: paymentMethod,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'Direct Deposit', child: Text('Direct Deposit')),
                DropdownMenuItem(value: 'Bank Transfer', child: Text('Bank Transfer')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    paymentMethod = value;
                  });
                }
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Request Sent!')),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Send Request', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3, // Loan Confirmation index
        onTap: (index) {
          // Example navigation logic, adjust routes as needed
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/auto-finance');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/stocklist');
              break;
            case 3:
            // Already on Loan Confirmation
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/more');
              break;
          }
        },
      ),
    );
  }

  Widget _detailRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    ),
  );

  Widget _amountCard(String label, String value, IconData icon) => Expanded(
    child: Card(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.teal, size: 28),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}*/
// this code works!


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NotificationViewModel(),
      child: const MyApp(),
    ),
  );
}

/// Root widget of the app, sets up MaterialApp and routes
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stocklist App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const StockListScreen(),
      routes: {
        '/request-details': (_) => const RequestDetailsScreen(),
      },
    );
  }
}

/// Sample mock data representing stock items
final List<Map<String, String>> stockData = [
  {
    'loanRef': '9670000008',
    'condition': 'Registered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'VINTAHSEEN0003000',
    'kenteken': '120',
    'model': 'BMW 6',
  },
  {
    'loanRef': '9670000008',
    'condition': 'Registered',
    'status': 'New',
    'maturity': '22-04-2024',
    'vin': 'MSTahseen001',
    'kenteken': '120',
    'model': 'BMW 6',
  },
  {
    'loanRef': '9670000008',
    'condition': 'Unregistered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'NSTAHSEEN0002',
    'kenteken': 'HK051AB',
    'model': 'BMW 6',
  },
  {
    'loanRef': '9670000009',
    'condition': 'Unregistered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'NSTAHSEEN0003',
    'kenteken': 'HK051AC',
    'model': 'ASTON MARTIN',
  },
  {
    'loanRef': '9670000001',
    'condition': 'Unregistered',
    'status': 'Sold Out',
    'maturity': '22-04-2024',
    'vin': 'NSTAHSEEN0012',
    'kenteken': 'HK051AB',
    'model': 'YARIS',
  },
];

/// Screen displaying the stock list with selectable rows and a "Send Request" button
class StockListScreen extends StatefulWidget {
  const StockListScreen({super.key});

  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  late List<bool> selectedRows; // Tracks which rows are selected

  @override
  void initState() {
    super.initState();
    // Initialize all rows as unselected
    selectedRows = List<bool>.filled(stockData.length, false);
  }

  /// Toggles selection of all rows when the header checkbox is tapped
  void _toggleSelectAll(bool? value) {
    if (value == null) return;
    setState(() {
      for (var i = 0; i < selectedRows.length; i++) {
        selectedRows[i] = value;
      }
    });
  }

  /// Shows a success dialog with animation when request submission succeeds
  void _showSuccessDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Success',
      pageBuilder: (context, animation1, animation2) {
        // This builder is required but unused, content is in transitionBuilder
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation1, animation2, child) {
        // Animate opacity and scale for smooth fade-in effect
        final curvedValue = Curves.easeInOut.transform(animation1.value);
        return Opacity(
          opacity: curvedValue,
          child: Transform.scale(
            scale: curvedValue,
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              content: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green, size: 64),
                    SizedBox(height: 16),
                    Text(
                      'Request submitted successfully!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(), // Close dialog
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if all rows are selected (for "select all" checkbox)
    final allSelected = selectedRows.every((e) => e);
    // Check if any row is selected (to enable "Send Request" button)
    final anySelected = selectedRows.any((e) => e);

    return Scaffold(
      appBar: const TitleBar(),
      body: Column(
        children: [
          // "Send Request" button aligned top-right inside a styled box
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(140, 40),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    onPressed: anySelected
                        ? () async {
                      // Navigate to RequestDetailsScreen and await result
                      final result = await Navigator.pushNamed(context, '/request-details');
                      if (result == true) {
                        if (!mounted) return; //currently in tree or not
                        // Show success animation dialog on return
                        _showSuccessDialog();
                      }
                    }
                        : null, // Disable button if no rows selected
                    child: const Text('Send Request'),
                  ),
                ),
              ],
            ),
          ),

          // Table header row with "select all" checkbox and column titles
          Container(
            color: Colors.tealAccent,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Checkbox(
                    value: allSelected,
                    onChanged: _toggleSelectAll,
                  ),
                ),
                _headerCell('Loan Ref No.'),
                _headerCell('Condition'),
                _headerCell('Status'),
                _headerCell('Maturity Date'),
                _headerCell('VIN No.'),
                _headerCell('Kenteken'),
                _headerCell('Model'),
              ],
            ),
          ),

          // List of stock rows with individual checkboxes
          Expanded(
            child: ListView.builder(
              itemCount: stockData.length,
              itemBuilder: (context, index) {
                final row = stockData[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black87),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Checkbox(
                          value: selectedRows[index],
                          onChanged: (val) {
                            setState(() {
                              selectedRows[index] = val ?? false;
                            });
                          },
                        ),
                      ),
                      _dataCell(row['loanRef']!),
                      _dataCell(
                        row['condition']!,
                        color: row['condition'] == 'Registered'
                            ? Colors.green.shade100
                            : Colors.orange.shade100,
                      ),
                      _dataCell(row['status']!),
                      _dataCell(row['maturity']!),
                      _dataCell(row['vin']!),
                      _dataCell(row['kenteken']!),
                      _dataCell(row['model']!),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Custom bottom navigation bar with navigation logic
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2, // Stocklist tab index
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/auto-finance');
              break;
            case 2:
            // Already on Stocklist, do nothing
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/loan-confirmation');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/more');
              break;
          }
        },
      ),
    );
  }

  /// Helper widget for table header cells with bold text
  Widget _headerCell(String text) => Expanded(
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  /// Helper widget for table data cells with optional background color
  Widget _dataCell(String text, {Color? color}) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: color,
      child: Text(text, overflow: TextOverflow.ellipsis),
    ),
  );
}

/// Screen showing request details and payment method selection
class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  String paymentMethod = 'Direct Deposit'; // Default payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display request info rows
            _detailRow('Planned Date', '11-04-25'),
            _detailRow('Settlement Method', 'DAAS'),
            _detailRow('Customer Name', 'Will Simmons'),
            const SizedBox(height: 20),

            // Summary cards showing financial info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _amountCard('Total Receivable Settlement', '€ 0.00', Icons.account_balance_wallet),
                _amountCard('Loan Settlement Request', '€ 7,213.05', Icons.request_page),
                _amountCard('Grand Total', '€ 7,213.05', Icons.attach_money),
              ],
            ),
            const SizedBox(height: 30),

            // Payment method selection dropdown
            const Text('Select Payment Method', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: paymentMethod,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'Direct Deposit', child: Text('Direct Deposit')),
                DropdownMenuItem(value: 'Bank Transfer', child: Text('Bank Transfer')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    paymentMethod = value;
                  });
                }
              },
            ),
            const Spacer(),

            // Final "Send Request" button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {
                  // Show snackbar and return success result to previous screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Request Sent!')),
                  );
                  Navigator.pop(context, true); // Return true on success
                },
                child: const Text('Send Request', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),

      // Bottom nav bar with current tab and navigation logic
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3, // Loan Confirmation tab index
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/auto-finance');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/stocklist');
              break;
            case 3:
            // Already on Loan Confirmation, do nothing
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/more');
              break;
          }
        },
      ),
    );
  }

  /// Helper widget to display a label and value in a row
  Widget _detailRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    ),
  );

  /// Helper widget to display a card with an icon, label, and value
  Widget _amountCard(String label, String value, IconData icon) => Expanded(
    child: Card(
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.teal, size: 28),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}
