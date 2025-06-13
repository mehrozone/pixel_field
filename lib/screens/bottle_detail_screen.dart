import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_field/models/bottle_model.dart';

class BottleDetailScreen extends StatefulWidget {
  final BottleModel bottle;
  const BottleDetailScreen({super.key, required this.bottle});

  @override
  State<BottleDetailScreen> createState() => _BottleDetailScreenState();
}

class _BottleDetailScreenState extends State<BottleDetailScreen> {
  int _tabIndex = 0;
  final List<String> _tabs = ['Details', 'Label', 'History'];

  Color get yellow => const Color(0xFFFFC72C);
  Color get bgColor => const Color(0xFF0B1519);
  Color get cardColor => const Color(0xFF16232A);

  @override
  Widget build(BuildContext context) {
    final bottle = widget.bottle;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bottle.collection,
                        style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: yellow, width: 1),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.verified, color: yellow, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  bottle.status,
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Bottle Image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Image.asset(
                  bottle.image,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Bottle Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bottle ${bottle.bottleIndex}',
                    style: GoogleFonts.lato(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: bottle.name + ' ',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: bottle.age,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 24,
                            color: yellow,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    bottle.number,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Tabs
            Container(
              color: cardColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_tabs.length, (i) {
                  final selected = _tabIndex == i;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _tabIndex = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: selected
                            ? BoxDecoration(
                                color: yellow,
                                borderRadius: BorderRadius.circular(6),
                              )
                            : null,
                        child: Text(
                          _tabs[i],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: selected ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            // Tab Content
            Expanded(
              child: Container(
                color: bgColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: _buildTabContent(bottle),
                ),
              ),
            ),
            // Add to my collection button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellow,
                    foregroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Add to my collection'),
                ),
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
        // Details
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bottle.details.entries
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        e.key,
                        style: GoogleFonts.lato(color: Colors.white70),
                      ),
                      Text(
                        e.value,
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      case 1:
        // Label
        return bottle.attachments.isEmpty
            ? const Text(
                'No labels available',
                style: TextStyle(color: Colors.white70),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...bottle.attachments.map(
                    (img) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Image.asset(
                        img,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              );
      case 2:
        // History
        return Text(
          bottle.history,
          style: GoogleFonts.lato(color: Colors.white),
        );
      default:
        return const SizedBox();
    }
  }
}
