import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/education_screen.dart';
import 'screens/experience_screen.dart';
import 'screens/skills_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/certifications_screen.dart';
import 'screens/references_screen.dart';
import 'screens/contact_screen.dart';

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatelessWidget {
  const ResumeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mohau Khakhu - Resume',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
      routes: {
        '/education': (context) => const EducationScreen(),
        '/experience': (context) => const ExperienceScreen(),
        '/skills': (context) => const SkillsScreen(),
        '/projects': (context) => const ProjectsScreen(),
        '/certifications': (context) => const CertificationsScreen(),
        '/references': (context) => const ReferencesScreen(),
        '/contact': (context) => const ContactScreen(),
      },
    );
  }
}