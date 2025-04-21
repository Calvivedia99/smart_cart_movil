import 'package:flutter/material.dart';
import '../widgets/inicio/header_widget.dart';
import '../widgets/inicio/search_bar_widget.dart';
import '../widgets/inicio/promo_banner_widget.dart';
import '../widgets/inicio/home_sections.dart' as home_sections;

class HomeBodyContent extends StatelessWidget {
  final String userName;
  final String? userPhotoUrl;
  final VoidCallback onMenuPressed;

  const HomeBodyContent({
    super.key,
    required this.userName,
    required this.userPhotoUrl,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  HeaderWidget(
                    userName: userName,
                    userInitial:
                        userName.isNotEmpty ? userName[0].toUpperCase() : "?",
                    userPhotoUrl: userPhotoUrl,
                    onMenuPressed: onMenuPressed,
                  ),
                  const SizedBox(height: 20),
                  const SearchBarWidget(),
                  const SizedBox(height: 20),
                  const PromoBannerWidget(),
                  const SizedBox(height: 20),
                  const home_sections.CategorySection(),
                  const SizedBox(height: 20),
                  const home_sections.ProductsSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
