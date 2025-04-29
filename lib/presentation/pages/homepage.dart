import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techware_products/core/utils/app_fade_transition.dart';
import 'package:techware_products/core/utils/app_theme.dart';
import 'package:techware_products/presentation/notifiers/auth_notifier.dart';
import 'package:techware_products/presentation/notifiers/product_notifier.dart';
import 'package:techware_products/presentation/pages/add_products_page.dart';
import 'package:techware_products/presentation/pages/product_details_page.dart';
import 'package:techware_products/presentation/pages/sign_in_page.dart';
import 'package:techware_products/presentation/widgets/common_appbar.dart';
import 'package:techware_products/presentation/widgets/loader_widget.dart';
import 'package:techware_products/presentation/widgets/product_tile.dart';
import 'package:techware_products/presentation/widgets/search_field.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static Route route() {
    return AppFadeTransition(page: const HomePage());
  }

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productNotifierProvider);

    return Scaffold(
      backgroundColor: appColor(context).background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: CommonAppbar(
          title: "Products",
          isNeedBackArrow: true,
          arrowColor: appColor(context).primary,
          actionWidget: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, AddProductPage.route());
                },
                icon: Icon(Icons.add, color: appColor(context).primary),
              ),

              IconButton(
                onPressed: () async {
                  await ref.read(authNotifierProvider.notifier).logout();
                  Navigator.pushAndRemoveUntil(context, SignInPage.route(), (route) => false);
                },
                icon: Icon(Icons.logout_rounded, color: appColor(context).errorText),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchField(
                hint: 'Search by name or QR data...',
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.trim().toLowerCase();
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: productsAsync.when(
        data: (products) {
          final filteredProducts =
              products.where((product) {
                final name = product.name.toLowerCase();
                final qrData = product.qrCodeData.toLowerCase();
                return name.contains(_searchQuery) || qrData.contains(_searchQuery);
              }).toList();

          if (filteredProducts.isEmpty) {
            return Center(child: Text('No matching products found.', style: TextStyle(color: appColor(context).primaryText)));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductTile(
                        product: product,
                        onTap: () {
                          Navigator.push(context, ProductDetailPage.route(product: product));
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const LoaderWidget(),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
