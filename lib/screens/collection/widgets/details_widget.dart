import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_field/features/collection/data/models/bottle_model.dart';

class DetailsWidget extends StatefulWidget {
  final BottleModel bottle;
  const DetailsWidget({super.key, required this.bottle});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  Widget build(BuildContext context) {
    // Details
    final details = widget.bottle.details;
    if (details == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailRow('Distillery', details.distillery ?? ''),
        _detailRow('Region', details.region ?? ''),
        _detailRow('Country', details.country ?? ''),
        _detailRow('Type', details.type ?? ''),
        _detailRow('Age statement', details.ageStatement ?? ''),
        _detailRow('Filled', details.filled ?? ''),
        _detailRow('Bottled', details.bottled ?? ''),
        _detailRow('Cask number', details.caskNumber ?? ''),
        _detailRow('ABV', details.aBV ?? ''),
        _detailRow('Size', details.size ?? ''),
        _detailRow('Finish', details.finish ?? ''),
      ],
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
          ),
          Text(
            value,
            style: GoogleFonts.lato(color: Color(0xffB8BDBF), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
