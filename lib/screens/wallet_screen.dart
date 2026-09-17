import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120B22),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A102F),
        title: const Text('محفظة دودو لايف', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // كارت رصيد العملات الذهبية والألماس
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.deepPurpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: const [
                      Icon(Icons.monetization_on, color: Colors.amber, size: 36),
                      SizedBox(height: 8),
                      Text('العملات الذهبية', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      SizedBox(height: 4),
                      Text('12,450', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(height: 50, width: 1, color: Colors.white24),
                  Column(
                    children: const [
                      Icon(Icons.diamond, color: Colors.cyanAccent, size: 36),
                      SizedBox(height: 8),
                      Text('الألماس (الأرباح)', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      SizedBox(height: 4),
                      Text('3,200', style: TextStyle(color: Colors.cyanAccent, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            const Text(
              'اختر باقة الشحن:',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // قائمة باقات الشحن
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  // أمثلة لباقات الشحن
                  List<Map<String, dynamic>> packages = [
                    {'coins': '1,000 عملة', 'price': '\$ 0.99'},
                    {'coins': '5,500 عملة', 'price': '\$ 4.99'},
                    {'coins': '12,000 عملة', 'price': '\$ 9.99'},
                    {'coins': '30,000 عملة', 'price': '\$ 24.99'},
                    {'coins': '70,000 عملة', 'price': '\$ 49.99'},
                    {'coins': '150,000 عملة', 'price': '\$ 99.99'},
                  ];

                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A102F),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.amber.withOpacity(0.4)),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              packages[index]['coins'],
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 36),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            // عملية الدفع أو الشحن
                          },
                          child: Text(
                            packages[index]['price'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
