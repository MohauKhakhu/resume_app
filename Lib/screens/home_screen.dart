import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../database/database_helper.dart';
import '../models/resume_model.dart';
import '../widgets/purple_card.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late Future<List<ContactInfo>> _contactInfo;

  @override
  void initState() {
    super.initState();
    _contactInfo = _databaseHelper.getContactInfo();
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _makePhoneCall(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CustomAppBar(
        title: 'My Resume',
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ResumeSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple.shade700,
                    Colors.purple.shade900,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'MOHAU KHAKHU',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'FULL-STACK DEVELOPER',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<List<ContactInfo>>(
                    future: _contactInfo,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(color: Colors.white);
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No contact info found');
                      }

                      final contactList = snapshot.data!;
                      return Wrap(
                        spacing: 15,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: contactList.map((contact) {
                          return GestureDetector(
                            onTap: () {
                              switch (contact.type) {
                                case 'phone':
                                  _makePhoneCall(contact.value);
                                  break;
                                case 'email':
                                  _launchEmail(contact.value);
                                  break;
                                case 'portfolio':
                                case 'github':
                                case 'linkedin':
                                  _launchURL(contact.value);
                                  break;
                              }
                            },
                            child: Tooltip(
                              message: contact.type,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _getContactIcon(contact.icon),
                                    const SizedBox(width: 6),
                                    Text(
                                      _getContactDisplayText(contact),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Navigation Grid
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildNavigationCard(
                    Icons.school,
                    'Education',
                    Colors.purple,
                    () => Navigator.pushNamed(context, '/education'),
                  ),
                  _buildNavigationCard(
                    Icons.work,
                    'Experience',
                    Colors.purple.shade700,
                    () => Navigator.pushNamed(context, '/experience'),
                  ),
                  _buildNavigationCard(
                    Icons.code,
                    'Skills',
                    Colors.purple.shade600,
                    () => Navigator.pushNamed(context, '/skills'),
                  ),
                  _buildNavigationCard(
                    Icons.assignment,
                    'Projects',
                    Colors.purple.shade500,
                    () => Navigator.pushNamed(context, '/projects'),
                  ),
                  _buildNavigationCard(
                    Icons.verified,
                    'Certifications',
                    Colors.purple.shade400,
                    () => Navigator.pushNamed(context, '/certifications'),
                  ),
                  _buildNavigationCard(
                    Icons.contact_page,
                    'References',
                    Colors.purple.shade300,
                    () => Navigator.pushNamed(context, '/references'),
                  ),
                ],
              ),
            ),

            // Summary Section
            PurpleCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.purple.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'PROFESSIONAL SUMMARY',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Dedicated and driven Full-Stack Developer with a curious mind and hands-on experience in application development, UI/UX design, and cybersecurity. Skilled in creating user-focused solutions that align with modern design principles and industry standards. Passionate about continuous learning and deeply curious about staying current with emerging technologies, always eager to contribute to innovative, impactful software solutions. Brings a blend of technical expertise, creative thinking, and an inquisitive approach to every project, with a focus on delivering reliable, scalable, and user-friendly applications.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            // Languages Section
            PurpleCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.language, color: Colors.purple.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'LANGUAGES',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: ['English', 'Sepedi', 'Venda', 'Zulu'].map((language) {
                      return Chip(
                        label: Text(
                          language,
                          style: TextStyle(
                            color: Colors.purple.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: Colors.purple.shade50,
                        side: BorderSide(color: Colors.purple.shade200),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(IconData icon, String title, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Icon _getContactIcon(String iconType) {
    switch (iconType) {
      case 'phone':
        return const Icon(Icons.phone, size: 14, color: Colors.white70);
      case 'email':
        return const Icon(Icons.email, size: 14, color: Colors.white70);
      case 'location':
        return const Icon(Icons.location_on, size: 14, color: Colors.white70);
      case 'web':
        return const Icon(Icons.public, size: 14, color: Colors.white70);
      case 'github':
        return const Icon(Icons.code, size: 14, color: Colors.white70);
      case 'linkedin':
        return const Icon(Icons.work, size: 14, color: Colors.white70);
      default:
        return const Icon(Icons.info, size: 14, color: Colors.white70);
    }
  }

  String _getContactDisplayText(ContactInfo contact) {
    switch (contact.type) {
      case 'phone':
        return 'Call';
      case 'email':
        return 'Email';
      case 'location':
        return 'Location';
      case 'portfolio':
        return 'Portfolio';
      case 'github':
        return 'GitHub';
      case 'linkedin':
        return 'LinkedIn';
      default:
        return contact.type;
    }
  }
}

class ResumeSearchDelegate extends SearchDelegate {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return const Center(
        child: Text('Enter a search term'),
      );
    }

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _databaseHelper.searchAll(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No results found'));
        }

        final results = snapshot.data!;
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return PurpleCard(
              margin: const EdgeInsets.all(8),
              child: _buildSearchResultItem(result),
            );
          },
        );
      },
    );
  }

  Widget _buildSearchResultItem(Map<String, dynamic> result) {
    switch (result['type']) {
      case 'education':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result['qualification'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(result['institution']),
            Text(result['period'], style: TextStyle(color: Colors.grey.shade600)),
          ],
        );
      case 'experience':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result['position'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(result['company']),
            Text(result['period'], style: TextStyle(color: Colors.grey.shade600)),
          ],
        );
      case 'skills':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result['category'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(result['items']),
          ],
        );
      case 'projects':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(result['description']),
          ],
        );
      default:
        return const Text('Unknown result type');
    }
  }
}