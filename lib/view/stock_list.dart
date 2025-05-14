import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'title_bar.dart';
import 'custom_bottom_nav_bar.dart';

/// ------------------------- MAIN FUNCTION -------------------------
void main() {
  runApp(

 // Providing the view models for app-wide access
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => StockListViewModel()),
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
      title: 'Stocklist',
      debugShowCheckedModeBanner: false,
      initialRoute: '/stocklist',
      routes: {
        '/stocklist': (context) => const StocklistScreen(),
      },
    );
  }
}

/// ------------------------- MODEL -------------------------
//modal class.
class StockItem {
  final String loanRefNo;
  final String condition;
  final String status;
  final String maturityDate;
  final String vinNo;
  final String kenteken;

  StockItem({
    required this.loanRefNo,
    required this.condition,
    required this.status,
    required this.maturityDate,
    required this.vinNo,
    required this.kenteken,
  });
}

/// ------------------------- VIEWMODEL -------------------------

class StockListViewModel extends ChangeNotifier {
  final List<StockItem> _items = [
    StockItem(
      loanRefNo: '96700000008',
      condition: 'Registered',
      status: 'Sold Out',
      maturityDate: '22-04-2024',
      vinNo: 'VINTAHSEEN0003000',
      kenteken: '120',
    ),
    StockItem(
      loanRefNo: '96700000008',
      condition: 'Unregistered',
      status: 'New',
      maturityDate: '22-04-2024',
      vinNo: 'NSTAHS0002',
      kenteken: 'HK051AB',
    ),
    StockItem(
      loanRefNo: '96700000008',
      condition: 'Unregistered',
      status: 'New',
      maturityDate: '22-04-2024',
      vinNo: 'NSTAHS0002',
      kenteken: 'HK051AB',
    ),
    StockItem(
      loanRefNo: '96700000008',
      condition: 'Registered',
      status: 'Sold Out',
      maturityDate: '22-04-2024',
      vinNo: 'NSTAHS0002',
      kenteken: 'HK051AB',
    ),
    StockItem(
      loanRefNo: '96700000008',
      condition: 'Unregistered',
      status: 'New',
      maturityDate: '22-04-2024',
      vinNo: 'NSTAHS0002',
      kenteken: 'HK051AB',
    ),
    StockItem(
      loanRefNo: '96700000008',
      condition: 'Registered',
      status: 'New',
      maturityDate: '22-04-2024',
      vinNo: 'NSTAHS0002',
      kenteken: 'HK051AB',
    ),
    StockItem(
      loanRefNo: '96700000008',
      condition: 'Unregistered',
      status: 'New',
      maturityDate: '22-04-2024',
      vinNo: 'NSTAHS0002',
      kenteken: 'HK051AB',
    ),
  ];

  List<StockItem> get items => _items;
}

/// Dummy NotificationViewModel for completeness
//class NotificationViewModel extends ChangeNotifier {}



/// ------------------------- UI -------------------------

class StocklistScreen extends StatefulWidget {
  const StocklistScreen({super.key});

  @override
  State<StocklistScreen> createState() => _StocklistScreenState();
}

class _StocklistScreenState extends State<StocklistScreen> {
  // Filter state
  String? selectedCondition;
  String? selectedStatus;

  // For demonstration, possible filter options
  final List<String> conditionOptions = ['Registered', 'Unregistered'];
  final List<String> statusOptions = ['Sold Out', 'New'];

  // Show filter menu
  void _showFilterMenu(BuildContext context) async {
    String? tempCondition = selectedCondition;
    String? tempStatus = selectedStatus;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: tempCondition,
                decoration: const InputDecoration(labelText: 'Condition'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('All')),
                  ...conditionOptions.map(
                        (c) => DropdownMenuItem(value: c, child: Text(c)),
                  ),
                ],
                onChanged: (value) => tempCondition = value,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: tempStatus,
                decoration: const InputDecoration(labelText: 'Status'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('All')),
                  ...statusOptions.map(
                        (s) => DropdownMenuItem(value: s, child: Text(s)),
                  ),
                ],
                onChanged: (value) => tempStatus = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedCondition = tempCondition;
                  selectedStatus = tempStatus;
                });
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  /// Filters the stock items based on the selected condition and status.
  /// If no filter is selected, all items are returned.
  /// Returns only those items that match both condition and status (if selected).

  List<StockItem> _filteredItems(List<StockItem> items) {
    return items.where((item) {
      final matchCondition = selectedCondition == null || item.condition == selectedCondition;
      final matchStatus = selectedStatus == null || item.status == selectedStatus;
      return matchCondition && matchStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final stockItems = context.watch<StockListViewModel>().items;
    final filteredItems = _filteredItems(stockItems);

    // Show badge if any filter is active
    bool isFilterActive = selectedCondition != null || selectedStatus != null;

    return Scaffold(
      appBar:  TitleBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top filters
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Condition',
                      hintText: 'Current',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'VIN No.',
                      hintText: 'Enter Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _showFilterMenu(context),
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.filter_list),
                      if (isFilterActive)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                            child: const Text(
                              '2',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Table Headers
            Container(
              color: Colors.teal,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Row(
                children: const [
                  Expanded(flex: 2, child: Text('Loan Ref No.')),
                  Expanded(flex: 2, child: Text('Condition')),
                  Expanded(flex: 2, child: Text('Status')),
                  Expanded(flex: 2, child: Text('Maturity Date')),
                  Expanded(flex: 2, child: Text('VIN No.')),
                  Expanded(flex: 2, child: Text('Kenteken')),
                  Icon(Icons.send),
                ],
              ),
            ),

            // Table Rows
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(child: Text('No data for selected filter'))
                  : ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black87)),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(item.loanRefNo)),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: item.condition == 'Registered'
                                  ? Colors.green[100]
                                  : Colors.orange[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(item.condition),
                          ),
                        ),
                        Expanded(flex: 2, child: Text(item.status)),
                        Expanded(flex: 2, child: Text(item.maturityDate)),
                        Expanded(flex: 2, child: Text(item.vinNo)),
                        Expanded(flex: 2, child: Text(item.kenteken)),
                        const Icon(Icons.send, color: Colors.teal),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
