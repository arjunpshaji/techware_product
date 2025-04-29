import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techware_products/core/utils/app_fade_transition.dart';
import 'package:techware_products/core/utils/app_theme.dart';
import 'package:techware_products/domain/enitities/product_entity.dart';
import 'package:techware_products/presentation/notifiers/product_notifier.dart';
import 'package:techware_products/presentation/widgets/common_appbar.dart';
import 'package:techware_products/presentation/widgets/input_text.dart';
import 'package:techware_products/presentation/widgets/primary_button.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key});

  static Route route() {
    return AppFadeTransition(page: const AddProductPage());
  }

  @override
  ConsumerState<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _measurementController = TextEditingController();
  final _priceController = TextEditingController();

  Future<void> _addProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final measurement = _measurementController.text.trim();
      final price = double.parse(_priceController.text.trim());

      final qrData = 'Product: $name, Measurement: $measurement, Price: $price';

      final newProduct = ProductEntity(id: '', name: name, measurement: measurement, price: price, qrCodeData: qrData);

      final bool status = await ref.read(productNotifierProvider.notifier).addProduct(newProduct);
      if (status) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to add product')));
      }

      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor(context).background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CommonAppbar(title: "Add Product", isNeedBackArrow: true, arrowColor: appColor(context).primary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputText(
                controller: _nameController,
                onChanged: (value) {},
                labelText: 'Product Name',
                validator: (value) => value == null || value.isEmpty ? 'Enter product name' : null,
              ),
              const SizedBox(height: 16),
              InputText(
                controller: _measurementController,
                onChanged: (value) {},
                labelText: 'Measurement (e.g. 1L, 500g)',
                validator: (value) => value == null || value.isEmpty ? 'Enter measurement' : null,
              ),
              const SizedBox(height: 16),
              InputText(
                controller: _priceController,
                onChanged: (value) {},
                labelText: 'Price',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter price' : null,
              ),
              const SizedBox(height: 24),
              PrimaryButton(onPressed: _addProduct, buttonText: 'Add Product', buttonColor: appColor(context).buttonColor),
            ],
          ),
        ),
      ),
    );
  }
}
