import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'title_bar.dart'; // my existing TitleBar
import 'custom_bottom_nav_bar.dart'; // my existing Bottom Nav Bar

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => FinanceRequestViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FinanceRequestStatusScreen(),
    );
  }
}


// Model class
class FinanceRequest {
  final String loanRefNo;
  final String requestStatus;
  final String requestDate;
  final String vinNumber;
  final String make;
  final String portfolio;
  final String model;
  final String amount;

  FinanceRequest({
    required this.loanRefNo,
    required this.requestStatus,
    required this.requestDate,
    required this.vinNumber,
    required this.make,
    required this.portfolio,
    required this.model,
    required this.amount,
  });
}

// ViewModel
class FinanceRequestViewModel extends ChangeNotifier {
  final List<FinanceRequest> _requests = [
    FinanceRequest(
      loanRefNo: '96700000008',
      requestStatus: 'New',
      requestDate: '01-04-2024',
      vinNumber: 'TAHSEENTESTBICOL',
      make: 'BMW',
      portfolio: 'Hiltermann Lease',
      model: 'X5',
      amount: '\$1,200',
    ),
    FinanceRequest(
      loanRefNo: '96700000009',
      requestStatus: 'Approved',
      requestDate: '02-04-2024',
      vinNumber: 'TAKSEENTESTBTBCD3',
      make: 'FORD',
      portfolio: 'Hiltermann Lease',
      model: 'Focus',
      amount: '\$1,500',
    ),
    FinanceRequest(
      loanRefNo: '96700000010',
      requestStatus: 'Declined',
      requestDate: '03-04-2024',
      vinNumber: 'TAHSEENTESTBICOL',
      make: 'Toyota',
      portfolio: 'Hiltermann Lease',
      model: 'Corolla',
      amount: '\$900',
    ),
    FinanceRequest(
      loanRefNo: '96700000018',
      requestStatus: 'Approved',
      requestDate: '03-04-2025',
      vinNumber: 'TAHSEENTESTBIARQ',
      make: 'Toyota',
      portfolio: 'Hiltermann Lease',
      model: 'yaris',
      amount: '\$900',
    ),
  ];

  List<FinanceRequest> get requests => _requests;
}


class FinanceRequestStatusScreen extends StatefulWidget {
  const FinanceRequestStatusScreen({super.key});

  @override
  State<FinanceRequestStatusScreen> createState() =>
      _FinanceRequestStatusScreenState();
}
// State class for the FinanceRequestStatusScreen
class _FinanceRequestStatusScreenState
    extends State<FinanceRequestStatusScreen> {
  // Currently selected value for date filter (e.g., 'Today', 'This Week', etc.)

  String selectedDateFilter = 'Today';
  String selectedCondition = 'Current';
  String vinFilter = '';
  String? selectedStatus;

  final List<String> statusOptions = ['New', 'Approved', 'Declined'];
// Filters the list of FinanceRequest objects based on selected status and VIN filter

  List<FinanceRequest> _filteredRequests(List<FinanceRequest> requests) {
    return requests.where((req) {
      // Check if the selectedStatus is either null (no filter) or matches the request's status

      final matchStatus =
          selectedStatus == null || req.requestStatus == selectedStatus;
      // Check if the VIN filter is empty or the request's VIN number contains the entered filter text (case-insensitive)
      final matchVin = vinFilter.isEmpty ||
          req.vinNumber.toLowerCase().contains(vinFilter.toLowerCase());
      return matchStatus && matchVin;

      // Only include requests that match both the status and VIN filter
      //return matchStatus && matchVin;
    }).toList();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.greenAccent;
      case 'Declined':
        return Colors.redAccent;
      case 'New':
      default:
        return Colors.blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final requests = context.watch<FinanceRequestViewModel>().requests;
    final filteredRequests = _filteredRequests(requests);

    //face of everything.

    return Scaffold(
      appBar:  TitleBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 4),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Filter/Search Bar
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.only(bottom: 12, top: 12),
              child: Row(
                children: [
                  const Text(
                    'Finance Request Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Today',
                        groupValue: selectedDateFilter,
                        activeColor: Colors.teal,
                        onChanged: (value) {
                          setState(() {
                            selectedDateFilter = value!;
                          });
                        },
                      ),
                      const Text('Today'),
                      const SizedBox(width: 8),
                      Radio<String>(
                        value: 'This Week',
                        groupValue: selectedDateFilter,
                        activeColor: Colors.teal,
                        onChanged: (value) {
                          setState(() {
                            selectedDateFilter = value!;
                          });
                        },
                      ),
                      const Text('This Week'),
                      const SizedBox(width: 8),
                      Radio<String>(
                        value: 'Date Range',
                        groupValue: selectedDateFilter,
                        activeColor: Colors.teal,
                        onChanged: (value) {
                          setState(() {
                            selectedDateFilter = value!;
                          });
                        },
                      ),
                      const Text('Date Range'),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 150,
                    child: DropdownButtonFormField<String>(
                      value: selectedCondition,
                      decoration: const InputDecoration(
                        labelText: 'Condition',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      items: ['Current', 'Past Due', 'Closed']
                          .map((cond) => DropdownMenuItem(
                        value: cond,
                        child: Text(cond),
                      ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedCondition = val!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 170,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'VIN No.',
                        hintText: 'Enter Number',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onChanged: (val) {
                        setState(() {
                          vinFilter = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Status filter dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  value: selectedStatus,
                  hint: const Text('Filter by Status'),
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('All'),
                    ),
                    ...statusOptions.map(
                          (status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      selectedStatus = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Table Headers with Actions column
            Container(
              color: Colors.teal,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Row(
                children: const [
                  Expanded(
                      flex: 2,
                      child: Text('Loan Ref No.',
                          style: TextStyle(color: Colors.black))),
                  Expanded(
                      flex: 2,
                      child: Text('Request Status',
                          style: TextStyle(color: Colors.white))),
                  Expanded(
                      flex: 2,
                      child: Text('Request Date',
                          style: TextStyle(color: Colors.white))),
                  Expanded(
                      flex: 2,
                      child: Text('VIN Number',
                          style: TextStyle(color: Colors.white))),
                  Expanded(
                      flex: 2,
                      child:
                      Text('Make', style: TextStyle(color: Colors.white))),
                  Expanded(
                      flex: 2,
                      child: Text('Portfolio',
                          style: TextStyle(color: Colors.white))),
                  Expanded(
                      flex: 2,
                      child:
                      Text('Model', style: TextStyle(color: Colors.white))),
                  Expanded(
                      flex: 2,
                      child:
                      Text('Amount', style: TextStyle(color: Colors.white))),
                  Expanded(
                      flex: 2,
                      child:
                      Text('Actions', style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
            // Table Rows with Actions column
            Expanded(
              child: filteredRequests.isEmpty
                  ? const Center(child: Text('No data for selected filter'))
                  : ListView.builder(
                itemCount: filteredRequests.length,
                itemBuilder: (context, index) {
                  final req = filteredRequests[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 8),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(req.loanRefNo)),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _statusColor(req.requestStatus),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(req.requestStatus),
                          ),
                        ),
                        Expanded(flex: 2, child: Text(req.requestDate)),
                        Expanded(flex: 2, child: Text(req.vinNumber)),
                        Expanded(flex: 2, child: Text(req.make)),
                        Expanded(flex: 2, child: Text(req.portfolio)),
                        Expanded(flex: 2, child: Text(req.model)),
                        Expanded(flex: 2, child: Text(req.amount)),
                        // Actions column
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_red_eye,
                                    color: Colors.teal),
                                onPressed: () {
                                  // Implement view logic if needed
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.picture_as_pdf,
                                    color: Colors.teal),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) =>
                                        InvoiceDialog(request: req),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.send,
                                    color: Colors.teal),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    builder: (_) =>
                                        RequestDetailsSheet(request: req),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
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

// Bottom sheet for Request Details
class RequestDetailsSheet extends StatelessWidget {
  final FinanceRequest request;
  const RequestDetailsSheet({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    String paymentMethod = 'Direct Deposit';
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Request Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: const [
                  Expanded(
                      child: _InfoBox(label: 'Planned Date', value: '11-04-25')),
                  Expanded(
                      child:
                      _InfoBox(label: 'Settlement Method', value: 'DAAS')),
                  Expanded(
                      child: _InfoBox(label: 'Customer Name', value: 'Will Simmons')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _SummaryBox(
                  icon: Icons.monetization_on,
                  label: 'Total Receivable\nSettlement',
                  value: '€ 0.00',
                  color: Colors.green,
                ),
                _SummaryBox(
                  icon: Icons.receipt,
                  label: 'Loan Settlement\nRequest',
                  value: '€ 7,213.05',
                  color: Colors.orange,
                ),
                _SummaryBox(
                  icon: Icons.account_balance_wallet,
                  label: 'Grand Total',
                  value: '€ 7,213.05',
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: paymentMethod,
              items: const [
                DropdownMenuItem(
                    value: 'Direct Deposit', child: Text('Direct Deposit')),
                DropdownMenuItem(value: 'Cheque', child: Text('Cheque')),
              ],
              onChanged: (val) {},
              decoration: const InputDecoration(
                labelText: 'Payment Method',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  // Add your send request logic here
                },
                child: const Text('Send Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;
  const _InfoBox({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _SummaryBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _SummaryBox(
      {required this.icon, required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

// Invoice Dialog Widget with dynamic data
class InvoiceDialog extends StatelessWidget {
  final FinanceRequest request;
  const InvoiceDialog({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      child: SizedBox(
        width: 450,
        height: 520,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey.shade200,
                      child: Text(
                        "H",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.teal[800]),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "HILTERMANN",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 1.5,
                              color: Colors.grey[900],
                            ),
                          ),
                          const Text(
                            "LEASE",
                            style: TextStyle(
                              fontSize: 13,
                              letterSpacing: 2,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          "Business address",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        Text(
                          "City, State, IN - 000 000",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        Text(
                          "TAX: ID: 09XXXXXXXXXXXXXX",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Invoice Info Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Business Partner
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Business Partner",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            request.portfolio,
                            style: const TextStyle(fontSize: 13),
                          ),
                          Text(
                            request.make,
                            style: const TextStyle(fontSize: 13),
                          ),
                          Text(
                            request.vinNumber,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    // Invoice Number
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Invoice Number",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            request.loanRefNo,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    // Invoice Amount
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Invoice amt (USD)",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            request.amount,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Invoice Dates Row
                Row(
                  children: const [
                    Expanded(
                      child: _InvoiceDateInfo(
                        label: "Invoice Date",
                        value: "02-04-2024",
                      ),
                    ),
                    Expanded(
                      child: _InvoiceDateInfo(
                        label: "Due date",
                        value: "02-04-2024",
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(height: 24),

                // Loan & Vehicle Information Table
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Loan & Vehicle Information",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey[800]),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1.5),
                      2: FlexColumnWidth(1.5),
                      3: FlexColumnWidth(1.5),
                      4: FlexColumnWidth(1.5),
                    },
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.grey.shade300),
                    ),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey.shade100),
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Loan Identifier",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Make",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Model",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Portfolio",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              request.loanRefNo,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              request.make,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              request.model,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              request.portfolio,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              request.amount,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Subtotal and Total (you can customize these values)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "Subtotal",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    SizedBox(width: 56),
                    Text(
                      "\$4,500.00",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "Total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black87),
                    ),
                    SizedBox(width: 56),
                    Text(
                      "\$4,950.00",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.teal),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Bottom PDF controls (mocked)
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.chevron_left, color: Colors.white),
                      Text(
                        "1 / 2",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      Icon(Icons.chevron_right, color: Colors.white),
                      SizedBox(width: 8),
                      Icon(Icons.remove, color: Colors.white, size: 18),
                      SizedBox(width: 2),
                      Text(
                        "100%",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      Icon(Icons.add, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Icon(Icons.picture_as_pdf, color: Colors.white),


                      Icon(Icons.print, color: Colors.white),
                      Icon(Icons.download, color: Colors.white),
                      // have to make this downloaded able to local storage.
                      Icon(Icons.share, color: Colors.white),
                      // have to make this shareable able via options.
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InvoiceDateInfo extends StatelessWidget {
  final String label;
  final String value;
  const _InvoiceDateInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
