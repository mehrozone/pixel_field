import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_field/core/app_theme.dart';
import 'package:pixel_field/features/collection/data/models/bottle_model.dart';

class HistoryWidget extends StatefulWidget {
  final BottleModel bottle;
  const HistoryWidget({super.key, required this.bottle});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  @override
  Widget build(BuildContext context) {
    final historyItems = widget.bottle.historyItems;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(historyItems!.length, (i) {
          final item = historyItems[i];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.background),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline
                Column(
                  children: [
                    SizedBox(
                      width: 24,
                      child: Column(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          if (i < historyItems.length - 1)
                            Container(
                              width: 2,
                              height: 280,
                              color: Colors.yellow,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                // Card content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.label!,
                        style: GoogleFonts.lato(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        item.title!,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ...(item.descriptions!.cast<String>().map(
                        (desc) => Text(
                          desc,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.bottomNavBarColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.attach_file,
                                  color: Colors.white70,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Attachments',
                                  style: GoogleFonts.lato(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              children: List.generate(
                                item.attachments!.length,
                                (j) => GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          child: InteractiveViewer(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Image.network(
                                                item.attachments![j],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    margin: EdgeInsets.only(
                                      right: j < item.attachments!.length - 1
                                          ? 8
                                          : 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          item.attachments![j],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
