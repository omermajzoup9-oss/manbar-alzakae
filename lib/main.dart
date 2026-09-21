import 'package:flutter/material.dart';

void main() {
  runApp(const ManbarApp());
}

class ManbarApp extends StatelessWidget {
  const ManbarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'منبر الزكاة',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Cairo',
      ),
      home: const ZakatHome(),
    );
  }
}

class ZakatHome extends StatefulWidget {
  const ZakatHome({super.key});

  @override
  State<ZakatHome> createState() => _ZakatHomeState();
}

class _ZakatHomeState extends State<ZakatHome> {
  final _controller = TextEditingController();
  double _zakat = 0;

  void _calculate() {
    double amount = double.tryParse(_controller.text)?? 0;
    setState(() {
      if (amount >= 85 * 2000) { // افتراض نصاب
        _zakat = amount * 0.025;
      } else {
        _zakat = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('منبر الزكاة - حساب الزكاة'),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'أدخل مجموع مالك الذي حال عليه الحول',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'المبلغ بالجنيه السوداني',
                prefixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('احسب الزكاة', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 30),
            if (_zakat > 0)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green),
                ),
                child: Text(
                  'مقدار الزكاة الواجبة: ${_zakat.toStringAsFixed(0)} جنيه',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[800]),
                ),
              )
            else if (_controller.text.isNotEmpty)
              const Text('المبلغ لم يبلغ النصاب', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
