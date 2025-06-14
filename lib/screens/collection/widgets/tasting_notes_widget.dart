import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_field/features/collection/data/models/bottle_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TastingNotesWidget extends StatefulWidget {
  final BottleModel bottle;
  const TastingNotesWidget({super.key, required this.bottle});

  @override
  State<TastingNotesWidget> createState() => _TastingNotesWidgetState();
}

class _TastingNotesWidgetState extends State<TastingNotesWidget> {
  YoutubePlayerController? _youtubeController;
  String? _lastVideoId;

  @override
  void initState() {
    super.initState();
    _initYoutubeController();
  }

  @override
  void didUpdateWidget(covariant TastingNotesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bottle.videoUrl != widget.bottle.videoUrl) {
      _initYoutubeController();
    }
  }

  void _initYoutubeController() {
    final videoId = YoutubePlayer.convertUrlToId(widget.bottle.videoUrl ?? '');
    if (videoId != null && videoId != _lastVideoId) {
      _youtubeController?.dispose();
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
      _lastVideoId = videoId;
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notes = widget.bottle.tastingNotesFull;
    final userNotes = widget.bottle.userNotes;
    final videoId = YoutubePlayer.convertUrlToId(widget.bottle.videoUrl ?? '');
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (videoId != null && videoId.isNotEmpty && _youtubeController != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: YoutubePlayer(
              controller: _youtubeController!,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
            ),
          )
        else
          Icon(Icons.videocam_off, color: Colors.white38, size: 48),
        Text(
          'Tasting notes',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Color(0xffE7E9EA),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'by ${widget.bottle.notesBy}',
          style: GoogleFonts.lato(color: Color(0xffB8BDBF), fontSize: 16),
        ),
        const SizedBox(height: 12),
        // Tasting notes cards
        ...['Nose', 'Palate', 'Finish'].map((title) {
          List<String> lines = [];
          if (notes != null) {
            if (title == 'Nose') lines = notes.nose ?? [];
            if (title == 'Palate') lines = notes.palate ?? [];
            if (title == 'Finish') lines = notes.finish ?? [];
          }
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF0E1C20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Color(0xffE7E9EA),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ...lines.map(
                  (line) => Text(
                    line,
                    style: GoogleFonts.lato(
                      color: Color(0xffE7E9EA),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        // Your notes
        Text(
          'Your notes',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Color(0xffE7E9EA),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        ...['Nose', 'Palate', 'Finish'].map((title) {
          List<String> userlines = [];
          if (userNotes != null) {
            if (title == 'Nose') userlines = userNotes.nose ?? [];
            if (title == 'Palate') userlines = userNotes.palate ?? [];
            if (title == 'Finish') userlines = userNotes.finish ?? [];
          }
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF0E1C20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Color(0xffE7E9EA),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ...userlines.map(
                  (line) => Text(
                    line,
                    style: GoogleFonts.lato(
                      color: Color(0xffE7E9EA),
                      fontSize: 16,
                    ),
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
