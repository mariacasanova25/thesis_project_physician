import 'package:flutter/material.dart';
import 'package:thesis_project_physician/communityForum/presentation/community_forum_screen.dart';
import 'package:thesis_project_physician/patients/presentation/patients_screen.dart';
import 'package:thesis_project_physician/profile/presentation/profile_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final pageController = PageController();
  int currentPage = 0;

  void selectPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  String get activePageTitle => switch (currentPage) {
        0 => 'Pacientes',
        1 => 'Fórum Comunitário',
        _ => '',
      };

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_2_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
            },
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (page) => setState(() => currentPage = page),
        children: const [
          PatientsScreen(),
          CommunityForumScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: currentPage,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.personal_injury_outlined),
            label: 'Pacientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Fórum',
          ),
        ],
      ),
    );
  }
}
