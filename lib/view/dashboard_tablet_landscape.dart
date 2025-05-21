/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'title_bar.dart';
import 'custom_bottom_nav_bar.dart';

/// ------------------- MAIN DASHBOARD SCREEN -------------------
void main() {
  // Entry point of the app.
  runApp(
    MultiProvider(
      providers: [
        // Register NotificationViewModel for app-wide state management.
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hiltermann mDealer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.teal),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
      },
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Custom app bar widget imported from title_bar.dart
    return Scaffold(
      appBar: const TitleBar(),
      body: const DashboardBody(),// Main content of the dashboard.
      // Custom bottom navigation bar widget imported from custom_bottom_nav_bar.dart
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
      backgroundColor: const Color(0xFFF6F8FA),
    );
  }
}


/// ------------------- DASHBOARD BODY -------------------
/// The scrollable content area of the dashboard screen.

class DashboardBody extends StatelessWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {// Allows vertical scrolling if content overflows screen height.

    return SingleChildScrollView(
      child: Column(
        children: const [

          CreditLimitDetailsCard(),// Card showing credit limit details
          WholesaleSummaryCard(),
          SizedBox(height: 30),//for extra space (bottom)
        ],
      ),
    );
  }
}

/// ------------------- CREDIT LIMIT DETAILS CARD -------------------

/// Card widget that displays credit limit information
class CreditLimitDetailsCard extends StatelessWidget {
  const CreditLimitDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,// Slight shadow for depth.
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CreditLimitHeader(),
            SizedBox(height: 18),
            _LimitTilesRow(),            // Row of tiles showing approved, utilized, and available limits.

            SizedBox(height: 24),
            PortfolioTable(),
          ],
        ),
      ),
    );
  }
}

/// ------------------- CREDIT LIMIT HEADER -------------------
//Header text for Credit Limit Details card.
class _CreditLimitHeader extends StatelessWidget {
  const _CreditLimitHeader();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Credit Limit Details',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

/// ------------------- LIMIT TILES ROW -------------------
/// Row containing three LimitTile widgets
class _LimitTilesRow extends StatelessWidget {
  const _LimitTilesRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Tile for Approved Limit with teal icon.
        LimitTile(
          icon: Icons.verified_user,
          label: 'Approved Limit',
          value: '1,000,000.00',// hard coded for now.
          color: Colors.teal,
        ),
        LimitTile(
          icon: Icons.account_balance_wallet,
          label: 'Utilized Limit',
          value: '968,534.30',// hard coded for now.
          color: Colors.orange,
        ),
        // Tile for Available Limit with blue icon.
        LimitTile(
          icon: Icons.account_balance,
          label: 'Available Limit',
          value: '31,465.70', // hard coded for now.
          color: Colors.blue,
        ),
      ],
    );
  }
}

/// ------------------- LIMIT TILE COMPONENT -------------------
class LimitTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const LimitTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

/// ------------------- PORTFOLIO TABLE -------------------
class PortfolioTable extends StatelessWidget {
  const PortfolioTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.teal),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(2),
        5: FlexColumnWidth(2),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFFF6F8FA)),
          children: [
            CustomTableHeader('Portfolio'),
            CustomTableHeader('Asset Condition'),
            CustomTableHeader('Floorplan Units'),
            CustomTableHeader('Permanent Limit'),
            CustomTableHeader('Utilized Limit'),
            CustomTableHeader('Available Balance'),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Hiltermann Lease'),
            _StatusBadge(text: 'Registered', color: Colors.teal),
            const CustomTableCell('23'),
            const CustomTableCell('1,000,000.00'),// hard coded for now.
            const CustomTableCell('968,534.30'),// hard coded for now.
            const CustomTableCell('31,465.70'),
          ],// hard coded for now.
        ),
        TableRow(
          children: [
            const CustomTableCell('Hiltermann Lease'),
            _StatusBadge(text: 'Un-registered', color: Colors.orange),
            const CustomTableCell('0'),
            const CustomTableCell('500,000.00'),// hard coded for now.
            const CustomTableCell('0.00'),
            const CustomTableCell('500,000.00'),// hard coded for now.
          ],
        ),
      ],
    );
  }
}

/// ------------------- WHOLESALE SUMMARY CARD -------------------
class WholesaleSummaryCard extends StatelessWidget {
  const WholesaleSummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _WholesaleHeader(),
            SizedBox(height: 18),
            WholesaleTable(),
          ],
        ),
      ),
    );
  }
}

/// ------------------- WHOLESALE HEADER -------------------
class _WholesaleHeader extends StatelessWidget {
  const _WholesaleHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Wholesale Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {/* Implement navigation */},
          child: const Text('View All'),
        )
      ],
    );
  }
}

/// ------------------- WHOLESALE TABLE -------------------
class WholesaleTable extends StatelessWidget {
  const WholesaleTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.teal),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(2.5),
        3: FlexColumnWidth(2.5),
        4: FlexColumnWidth(2.5),
      },
      children: [
        const TableRow(
          // FIX: Use a constant color value instead of Color(value)
          decoration: BoxDecoration(color: Color(0xFFF6F8FA)),
          children: [
            CustomTableHeader('Loan Status'),
            CustomTableHeader('No. of Loans'),
            CustomTableHeader('Principal O/S'),
            CustomTableHeader('Interest Accrued MTD'),
            CustomTableHeader('Incurred Interest'),
          ],
        ),
        TableRow(
          children: [
            _StatusBadge(text: 'Current', color: Colors.blue),
            const CustomTableCell('682'),
            const CustomTableCell('0.00'),
            const CustomTableCell('0.00'),
            const CustomTableCell('62,642,526.69'),
          ],
        ),
        TableRow(
          children: [
            _StatusBadge(text: 'Sold Out', color: Colors.green),
            const CustomTableCell('782'),
            const CustomTableCell('615,710,081.03'),// hard coded for now.
            const CustomTableCell('0.00'),// hard coded for now.
            const CustomTableCell('1,035,797.50'),// hard coded for now.
          ],
        ),
      ],
    );
  }
}

/// ------------------- REUSABLE TABLE COMPONENTS -------------------
class CustomTableHeader extends StatelessWidget {
  final String text;

  const CustomTableHeader(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CustomTableCell extends StatelessWidget {
  final String text;

  const CustomTableCell(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _StatusBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'title_bar.dart';
import 'custom_bottom_nav_bar.dart';

/// Entry point of the screen.
/// Sets up state management and launches the main app widget.
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         // Provides notification state throughout the app.
//         ChangeNotifierProvider(create: (_) => NotificationViewModel()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

/// Root widget of the app.
/// Sets theme, routes, and home screen.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'H    Hiltermann mDealer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.teal),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
      },
      home: const DashboardScreen(),
    );
  }
}

/// Main dashboard screen.
/// Contains app bar, main content, and bottom navigation.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleBar(), // Custom app bar widget.
      body: const DashboardContent(), // Scrollable dashboard content.
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
      backgroundColor: const Color(0xFFF6F8FA),
    );
  }
}

/// Scrollable content area of the dashboard.
/// Responsible for laying out main dashboard cards.
class DashboardContent extends StatelessWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          CreditLimitCard(), // Shows credit limit info.
          WholesaleSummaryCard(), // Shows wholesale loan summary.
          SizedBox(height: 30), // Bottom spacing.
        ],
      ),
    );
  }
}

/// Card widget displaying credit limit details.
/// Composes header, limit tiles, and portfolio table.
class CreditLimitCard extends StatelessWidget {
  const CreditLimitCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title of the card.
            Text(
              'Credit Limit Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 18),
            LimitTilesRow(), // Row of limit tiles.
            SizedBox(height: 24),
            PortfolioTable(), // Portfolio data table.
          ],
        ),
      ),
    );
  }
}

/// Row widget displaying three limit tiles side by side.
/// Each tile shows a specific credit limit metric.
class LimitTilesRow extends StatelessWidget {
  const LimitTilesRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        LimitTile(
          icon: Icons.verified_user,
          label: 'Approved Limit',
          value: '1,000,000.00',
          color: Colors.teal,
        ),
        LimitTile(
          icon: Icons.account_balance_wallet,
          label: 'Utilized Limit',
          value: '968,534.30',
          color: Colors.orange,
        ),
        LimitTile(
          icon: Icons.account_balance,
          label: 'Available Limit',
          value: '31,465.70',
          color: Colors.blue,
        ),
      ],
    );
  }
}

/// Single tile widget showing an icon, label, and value.
/// This widget is reusable for various limit types.
class LimitTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const LimitTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Circular icon with subtle background.
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        // Label describing the limit type.
        Text(label,
            style: const TextStyle(fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 4),
        // Numeric value of the limit.
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}

/// Table widget showing portfolio details.
/// Uses custom headers and cells for consistent style.
class PortfolioTable extends StatelessWidget {
  const PortfolioTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.teal),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(2),
        5: FlexColumnWidth(2),
      },
      children: [
        // Header row with light background.
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFFF6F8FA)),
          children: [
            CustomTableHeader('Portfolio'),
            CustomTableHeader('Asset Condition'),
            CustomTableHeader('Floorplan Units'),
            CustomTableHeader('Permanent Limit'),
            CustomTableHeader('Utilized Limit'),
            CustomTableHeader('Available Balance'),
          ],
        ),
        // Data row: Registered portfolio.
        TableRow(
          children: [
            const CustomTableCell('Hiltermann Lease'),
            _StatusBadge(text: 'Registered', color: Colors.teal),
            const CustomTableCell('23'),
            const CustomTableCell('1,000,000.00'),
            const CustomTableCell('968,534.30'),
            const CustomTableCell('31,465.70'),
          ],
        ),
        // Data row: Un-registered portfolio.
        TableRow(
          children: [
            const CustomTableCell('Hiltermann Lease'),
            _StatusBadge(text: 'Un-registered', color: Colors.orange),
            const CustomTableCell('0'),
            const CustomTableCell('500,000.00'),
            const CustomTableCell('0.00'),
            const CustomTableCell('500,000.00'),
          ],
        ),
      ],
    );
  }
}

/// Card widget displaying wholesale loan summary.
/// Contains header and loan data table.
class WholesaleSummaryCard extends StatelessWidget {
  const WholesaleSummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WholesaleHeader(), // Header with title and action button.
            SizedBox(height: 18),
            WholesaleTable(), // Table with wholesale loan data.
          ],
        ),
      ),
    );
  }
}

/// Header widget for wholesale summary card.
/// Displays the title and a "View All" button.
class WholesaleHeader extends StatelessWidget {
  const WholesaleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Wholesale Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            // TODO: Implement navigation or action for "View All"
          },
          child: const Text('View All'),
        ),
      ],
    );
  }
}

/// Table widget showing wholesale loan statuses and financial figures.
class WholesaleTable extends StatelessWidget {
  const WholesaleTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.teal),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(2.5),
        3: FlexColumnWidth(2.5),
        4: FlexColumnWidth(2.5),
      },
      children: [
        // Header row with light background.
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFFF6F8FA)),
          children: [
            CustomTableHeader('Loan Status'),
            CustomTableHeader('No. of Loans'),
            CustomTableHeader('Principal O/S'),
            CustomTableHeader('Interest Accrued MTD'),
            CustomTableHeader('Incurred Interest'),
          ],
        ),
        // Data row: Current loans.
        TableRow(
          children: [
            _StatusBadge(text: 'Current', color: Colors.blue),
            const CustomTableCell('682'),
            const CustomTableCell('0.00'),
            const CustomTableCell('0.00'),
            const CustomTableCell('62,642,526.69'),
          ],
        ),
        // Data row: Sold out loans.
        TableRow(
          children: [
            _StatusBadge(text: 'Sold Out', color: Colors.green),
            const CustomTableCell('782'),
            const CustomTableCell('615,710,081.03'),
            const CustomTableCell('0.00'),
            const CustomTableCell('1,035,797.50'),
          ],
        ),
      ],
    );
  }
}

/// Widget for table headers.
/// Displays bold, centered text with padding.
class CustomTableHeader extends StatelessWidget {
  final String text;

  const CustomTableHeader(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Widget for regular table cells.
/// Displays centered text with padding.
class CustomTableCell extends StatelessWidget {
  final String text;

  const CustomTableCell(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Badge widget to highlight statuses with colored background and text.
/// Used in tables to indicate statuses like "Registered" or "Sold Out".
class _StatusBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _StatusBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), // Light background color.
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
