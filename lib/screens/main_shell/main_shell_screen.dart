import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_field/core/app_icons.dart';
import '../collection/collection_screen.dart';
import '../../core/app_theme.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 1;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    });
  }

  Widget _buildScreen(int index) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    switch (index) {
      case 0:
        return Center(
          child: Text(
            'Scan',
            style: GoogleFonts.lato(fontSize: 12, color: Colors.white),
          ),
        );
      case 1:
        return CollectionScreen();
      case 2:
        return Center(
          child: Text(
            'Shop',
            style: GoogleFonts.lato(fontSize: 12, color: Colors.white),
          ),
        );
      case 3:
        return Center(
          child: Text(
            'Settings',
            style: GoogleFonts.lato(fontSize: 12, color: Colors.white),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff0B1518),
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white70,
        unselectedLabelStyle: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColors.white,
        ),
        selectedLabelStyle: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColors.white,
        ),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.scan,
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? Colors.white : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.collection,
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? Colors.white : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Collection',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.shop,
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? Colors.white : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppIcons.settings,
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? Colors.white : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
