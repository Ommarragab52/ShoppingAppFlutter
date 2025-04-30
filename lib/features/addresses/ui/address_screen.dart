import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_app_bar.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Address'),
      body: CustomScrollView(
        slivers: [
          
        ],
      ),
    );
  }
}
