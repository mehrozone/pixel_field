import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_field/features/collection/presentation/bloc/collection_cubit.dart';
import 'package:pixel_field/screens/bottle_detail_screen.dart';

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
    final bgColor = const Color(0xFF0B1519);
    final cardColor = const Color(0xFF16232A);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My collection',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.62,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
              ),
              itemCount: bottles.length,
              itemBuilder: (itemBuilderContext, index) {
                final bottle = bottles[index];
                return GestureDetector(
                  onTap: () {
                    final id = bottle.id;
                    print(
                      '[CollectionScreen] Navigating to bottle with id: $id',
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            BottleDetailScreen(bottle: bottle),
                      ),
                    );
                    // context.go('/bottle/$id');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              bottle.image,
                              height: 140,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          bottle.name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${bottle.age} ${bottle.number}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '(${bottle.bottleIndex})',
                          style: GoogleFonts.lato(
                            color: Colors.white70,
                            fontSize: 16,
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
