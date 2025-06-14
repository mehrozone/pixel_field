import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_field/core/app_images.dart';
import 'package:pixel_field/core/app_theme.dart';
import 'package:pixel_field/features/collection/data/models/bottle_model.dart';
import 'package:pixel_field/screens/collection/widgets/details_widget.dart';
import 'package:pixel_field/screens/collection/widgets/history_widget.dart';
import 'package:pixel_field/screens/collection/widgets/tasting_notes_widget.dart';

class BottleDetailScreen extends StatefulWidget {
  final BottleModel bottle;
  const BottleDetailScreen({super.key, required this.bottle});

  @override
  State<BottleDetailScreen> createState() => _BottleDetailScreenState();
}

class _BottleDetailScreenState extends State<BottleDetailScreen> {
  int _tabIndex = 0;
  final List<String> _tabs = ['Details', 'Tasting Notes', 'History'];

  Color get yellow => const Color(0xFFFFC72C);
  Color get bgColor => const Color(0xFF0B1519);
  Color get cardColor => const Color(0xFF16232A);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottle = widget.bottle;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Fixed background color + image
            Positioned.fill(
              child: Container(
                color: AppColors.bottomNavBarColor,
                child: Image.asset(AppImages.background, fit: BoxFit.fitHeight),
              ),
            ),
            // Scrollable content
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 8,
                      top: 8,
                      bottom: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.bottomNavBarColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Text(
                            bottle.collection ?? '',
                            style: GoogleFonts.lato(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.bottomNavBarColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            splashRadius: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.bottomNavBarColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.genuineIcon,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              bottle.status ?? '',
                              style: GoogleFonts.lato(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.yellow,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Bottle image
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Image.asset(
                        bottle.image ?? '',
                        height: 411,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Info Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      decoration: BoxDecoration(color: AppColors.card),
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bottle ${bottle.bottleIndex ?? ''}',
                            style: GoogleFonts.lato(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${(bottle.name ?? '').split(' ').first} ',
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: bottle.age ?? '',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 32,
                                    color: AppColors.yellow,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            bottle.number ?? '',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Tabs
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: List.generate(_tabs.length, (i) {
                                final selected = _tabIndex == i;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _tabIndex = i),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selected
                                            ? AppColors.yellow
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        _tabs[i],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                          color: selected
                                              ? Colors.black
                                              : Color(0xff899194),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Tab Content
                          _buildTabContent(bottle),

                          // Add to my collection button
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 32,
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: AppColors.black, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Add to my collection',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BottleModel bottle) {
    switch (_tabIndex) {
      case 0:
        return DetailsWidget(bottle: bottle);
      case 1:
        return TastingNotesWidget(bottle: bottle);
      case 2:
        return HistoryWidget(bottle: bottle);
      default:
        return DetailsWidget(bottle: bottle);
    }
  }
}
