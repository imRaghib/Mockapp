import 'package:flutter/material.dart';
import 'title_bar.dart';
import 'package:provider/provider.dart';
import 'custom_bottom_nav_bar.dart'; //

//entry
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        //ChangeNotifierProvider(create: (_) => LoanConfirmationScreen()),
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
      title: 'Loan Confirmation',
      debugShowCheckedModeBanner: false,
      home:  LoanConfirmationScreen(),
    );
  }
}


class LoanConfirmationScreen extends StatefulWidget {
  const LoanConfirmationScreen({super.key});
  @override
  State<LoanConfirmationScreen> createState() => _LoanConfirmationScreenState();
}

class _LoanConfirmationScreenState extends State<LoanConfirmationScreen> {
  String selectedLoanStatus = 'Current';
  String selectedRegistration = 'All';
  String vinSearch = '';
  int currentPage = 1;

  // Sample data
  final List<Map<String, String>> allData = List.generate(10, (index) {
    return {
      'loanRefNo': '9670000008',
      'vin': index == 0
          ? 'VINTAHSEEN0003000'
          : index == 1
          ? 'MSTahseen001'
          : index == 2
          ? 'NSTAHSEEN0002'
          : index == 3
          ? 'VINTAHSEEN0002000'
          : 'TAHSEENTESTB${index}COL',
      'registration': index < 2
          ? '120'
          : index < 4
          ? 'HK051AB'
          : 'KMM0001',
      'date': '22-04-2024',
      'make': index < 4 ? 'BMW Cooper S' : '7205',
      'model': index < 4 ? 'BMW Cooper S' : '7205',
    };
  });

  List<Map<String, String>> get filteredData {
    return allData.where((item) {
      final statusMatch = selectedLoanStatus == 'All' || selectedLoanStatus == 'Current';
      final regMatch = selectedRegistration == 'All' || item['registration'] == selectedRegistration;
      final vinMatch = vinSearch.isEmpty || (item['vin']?.toLowerCase().contains(vinSearch.toLowerCase()) ?? false);
      return statusMatch && regMatch && vinMatch;
    }).toList();
  }

  List<String> get registrationOptions {
    final regs = allData.map((e) => e['registration']!).toSet().toList();
    regs.insert(0, 'All');
    return regs;
  }

  void _showRequestDialog(Map<String, String> row) async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _RequestDialog(row: row),
    );
    if (result == true) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const _SuccessGifDialog(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: TitleBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedLoanStatus,
                    decoration: const InputDecoration(
                      labelText: 'Loan Status',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: ['Current', 'All']
                        .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() => selectedLoanStatus = val ?? 'Current');
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedRegistration,
                    decoration: const InputDecoration(
                      labelText: 'Registration Number',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: registrationOptions
                        .map((reg) => DropdownMenuItem(
                      value: reg,
                      child: Text(reg),
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() => selectedRegistration = val ?? 'All');
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'VIN No.',
                      border: OutlineInputBorder(),
                      isDense: true,
                      suffixIcon: Icon(Icons.filter_alt_outlined),
                    ),
                    onChanged: (val) {
                      setState(() => vinSearch = val);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Table Header
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                children: const [
                  SizedBox(width: 30),
                  Expanded(child: Text('Loan Ref No.', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('VIN No.', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Registration No.', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Request Date', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Make', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Model Description', style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(width: 40),
                ],
              ),
            ),
            // Table Body
            Expanded(
              child: filteredData.isEmpty
                  ? const Center(child: Text('No records found.'))
                  : ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final item = filteredData[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        Expanded(child: Text(item['loanRefNo'] ?? '')),
                        Expanded(child: Text(item['vin'] ?? '')),
                        Expanded(child: Text(item['registration'] ?? '')),
                        Expanded(child: Text(item['date'] ?? '')),
                        Expanded(child: Text(item['make'] ?? '')),
                        Expanded(child: Text(item['model'] ?? '')),
                        SizedBox(
                          width: 40,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios, color: Colors.teal, size: 20),
                            onPressed: () => _showRequestDialog(item),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Pagination (static for sample)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 16),
                  onPressed: currentPage > 1
                      ? () {
                    setState(() => currentPage--);
                  }
                      : null,
                ),
                ...List.generate(3, (i) {
                  final page = i + 1;
                  return TextButton(
                    onPressed: () => setState(() => currentPage = page),
                    child: Text(
                      '$page',
                      style: TextStyle(
                        fontWeight: currentPage == page ? FontWeight.bold : FontWeight.normal,
                        color: currentPage == page ? Colors.green : Colors.black,
                      ),
                    ),
                  );
                }),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    setState(() => currentPage++);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 3),
    );
  }
}

class _RequestDialog extends StatefulWidget {
  final Map<String, String> row;
  const _RequestDialog({required this.row});

  @override
  State<_RequestDialog> createState() => _RequestDialogState();
}

class _RequestDialogState extends State<_RequestDialog> {
  String paymentMethod = 'Direct Deposit';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Request Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Details Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoBlock('Planned Date', '11-04-25'),
                  _infoBlock('Settlement Method', 'DAAS'),
                  _infoBlock('Customer Name', 'Will Simmons'),
                ],
              ),
              const SizedBox(height: 16),
              // Amounts
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _amountBlock(Icons.account_balance_wallet, 'Total Receivable\nSettlement', '€ 0.00', Colors.green),
                  _amountBlock(Icons.request_page, 'Loan Settlement\nRequest', '€ 7,213.05', Colors.orange),
                  _amountBlock(Icons.payments, 'Grand Total', '€ 7,213.05', Colors.blue),
                ],
              ),
              const SizedBox(height: 20),
              // Payment Method
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Select Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: paymentMethod,
                decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: ['Direct Deposit', 'Cheque', 'Cash']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  setState(() => paymentMethod = val ?? 'Direct Deposit');
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF21C08B),
                  ),
                  child: const Text('Send Request', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoBlock(String label, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    ],
  );

  Widget _amountBlock(IconData icon, String label, String value, Color color) => Row(
    children: [
      CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    ],
  );
}

class _SuccessGifDialog extends StatelessWidget {
  const _SuccessGifDialog();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: Image.asset('lib/assets/images/success.gif'),
          ),
          const SizedBox(height: 16),
          const Text('Request Sent Successfully!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}


