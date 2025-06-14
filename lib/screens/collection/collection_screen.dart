import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_field/core/app_icons.dart';
import 'package:pixel_field/core/app_theme.dart';
import 'package:pixel_field/features/collection/presentation/bloc/collection_cubit.dart';
import 'package:pixel_field/screens/collection/bottle_detail_screen.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  void initState() {
    super.initState();
    // Only load bottles if not already loaded
    final cubit = context.read<CollectionCubit>();
    if (cubit.state is! CollectionLoaded) {
      cubit.loadBottles();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = AppColors.background;
    final cardColor = AppColors.card;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 24,
              right: 24,
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My collection',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: () {},
                    radius: 200,
                    borderRadius: BorderRadius.circular(200),
                    child: SvgPicture.asset(AppIcons.notificationActive),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<CollectionCubit, CollectionState>(
        builder: (buildContext, state) {
          if (state is CollectionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CollectionError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          if (state is CollectionLoaded) {
            final bottles = state.bottles;
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.56,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: bottles.length,
              itemBuilder: (itemBuilderContext, index) {
                final bottle = bottles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            BottleDetailScreen(bottle: bottle),
                      ),
                    );
                    // context.go('/bottle/$id');
                  },
                  child: Container(
                    decoration: BoxDecoration(color: cardColor),
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            bottle.image ?? '',
                            height: 169,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bottle.name ?? '',
                                textAlign: TextAlign.right,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${bottle.details?.filled}#${bottle.details?.caskNumber}',
                                textAlign: TextAlign.right,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '(${bottle.bottleIndex ?? ''})',
                                textAlign: TextAlign.right,

                                style: GoogleFonts.lato(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text(
              'No bottles found',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
