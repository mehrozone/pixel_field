import 'package:flutter/material.dart';
import 'collection_screen.dart';
import '../core/app_theme.dart';

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
        return const Center(
          child: Text('Scan', style: TextStyle(fontSize: 32)),
        );
      case 1:
        return const CollectionScreen();
      case 2:
        return const Center(
          child: Text('Shop', style: TextStyle(fontSize: 32)),
        );
      case 3:
        return const Center(
          child: Text('Settings', style: TextStyle(fontSize: 32)),
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
        backgroundColor: AppColors.card,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white70,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Collection',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.local_bar), label: 'Shop'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
