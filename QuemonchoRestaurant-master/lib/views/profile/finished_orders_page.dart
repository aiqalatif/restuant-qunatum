import 'package:flutter/material.dart';

class FinishedOrders extends StatelessWidget {
  const FinishedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finished Orders'),
        backgroundColor: Colors.white,
        elevation: 0.4,
      ),
      body: const Center(
        child: Text('Finished Orders'),
      )
    );
  }
}