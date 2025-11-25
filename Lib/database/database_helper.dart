import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/resume_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'resume.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    // Education table
    await db.execute('''
      CREATE TABLE education(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        qualification TEXT,
        institution TEXT,
        period TEXT,
        details TEXT
      )
    ''');

    // Experience table
    await db.execute('''
      CREATE TABLE experience(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        position TEXT,
        company TEXT,
        period TEXT,
        responsibilities TEXT
      )
    ''');

    // Skills table
    await db.execute('''
      CREATE TABLE skills(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT,
        items TEXT
      )
    ''');

    // Projects table
    await db.execute('''
      CREATE TABLE projects(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT
      )
    ''');

    // Certifications table
    await db.execute('''
      CREATE TABLE certifications(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        provider TEXT,
        certifications TEXT
      )
    ''');

    // References table
    await db.execute('''
      CREATE TABLE references(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        position TEXT,
        company TEXT,
        contact TEXT
      )
    ''');

    // Contact info table
    await db.execute('''
      CREATE TABLE contact_info(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        value TEXT,
        icon TEXT
      )
    ''');

    // Insert initial data
    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    // Insert education
    await db.insert('education', Education(
      qualification: 'Advanced Diploma in Information and Communications Technology (Computer Science)',
      institution: 'Tshwane University of Technology',
      period: 'Feb 2024 - Nov 2025',
      details: 'Major in Integrated Software development, distributed programming, data structures and algorithms, Data science, Theory of Computer science and Software Engineering'
    ).toMap());

    await db.insert('education', Education(
      qualification: 'National Diploma in Information and Communications Technology (Software Development)',
      institution: 'Tshwane University of Technology',
      period: 'Feb 2018 - June 2021',
      details: 'Major in Development Software, Computing Systems, Technical programming, Information Systems, and Systems Software'
    ).toMap());

    await db.insert('education', Education(
      qualification: 'National Senior Certificate (NSC)',
      institution: 'Sefoloko Secondary School',
      period: '2016',
      details: ''
    ).toMap());

    // Insert experience
    await db.insert('experience', Experience(
      position: 'Software Developer',
      company: 'Forge Academy and labs',
      period: 'Oct 2024 - Present',
      responsibilities: [
        'Design, develop, and deploy scalable, secure web applications using modern frameworks',
        'Engineer fast, responsive user interfaces (UI/UX) and robust RESTful APIs',
        'Manage cloud hosting (AWS and Afrinost), databases, and deployment for optimal performance and uptime',
        'Implement technical SEO best practices and optimize performance for superior search rankings',
        'Build and integrate tools to capture leads, support sales funnels, and drive marketing growth',
        'Utilize Git/GitHub for version control and collaborate within Agile/Scrum teams',
        'Actively pursuing AWS Cloud Practitioner and CompTIA CySA+ certifications',
        'Continuously learn emerging technologies to apply the most effective solutions'
      ]
    ).toMap());

    await db.insert('experience', Experience(
      position: 'Web Developer',
      company: 'OL afrika media foundation',
      period: 'Sep 2023 - Mar 2024',
      responsibilities: [
        'Engineer responsive, high-performance web interfaces with HTML5, CSS3, and React, ensuring cross-device compatibility and accessibility',
        'Translate design mockups into clean, maintainable code and contribute to wireframing and prototyping in Figma',
        'Optimize UI performance and resolve bugs through rigorous testing, including unit tests and cross-browser compatibility checks'
      ]
    ).toMap());

    await db.insert('experience', Experience(
      position: 'Graphic Designer',
      company: 'Mogwape Business Enterprise',
      period: 'Sep 2022 - Aug 2023',
      responsibilities: [
        'Conceptualized and presented visual concepts that translated client briefs and project goals into compelling designs',
        'Produced a wide range of marketing collateral, including flyers, posters, and website assets, ensuring alignment with brand identity',
        'Developed key brand elements like custom illustrations, logos, and icons, maintaining visual consistency across all platforms',
        'Executed all projects using industry-standard tools, including Adobe Creative Suite (Photoshop, Illustrator) and Canva'
      ]
    ).toMap());

    await db.insert('experience', Experience(
      position: 'Systems Engineer',
      company: 'Bios Data Center',
      period: 'Jun 2022 - Sep 2022',
      responsibilities: [
        'Strengthened expertise in system security, risk management, and compliance frameworks through targeted training initiatives',
        'Performed system security assessments and authored detailed technical reports to guide risk-based decision-making',
        'Monitored system integrity by tracking changes, maintaining comprehensive activity logs, and enforcing security best practices',
        'Supported the incident response lifecycle by assisting in the identification, documentation, and mitigation of security events',
        'Gained practical experience utilizing security monitoring tools, log analyzers, and auditing platforms to protect assets'
      ]
    ).toMap());

    await db.insert('experience', Experience(
      position: 'Technical Support Intern',
      company: 'Fairplay Hardware',
      period: 'Aug 2021 - Feb 2022',
      responsibilities: [
        'Troubleshot and resolved hardware, software, and network issues to maintain seamless IT operations and minimize downtime',
        'Provided specialized technical support for the Kerridge retail system, guiding users through navigation and resolving complex issues',
        'Streamlined support processes by meticulously logging tickets and maintaining a knowledge base of solutions'
      ]
    ).toMap());

    // Insert skills
    await db.insert('skills', Skill(
      category: 'Programming Languages',
      items: ['Python', 'Java', 'C#', 'C++', 'JavaScript', 'PHP', 'SQL']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'Frameworks & Libraries',
      items: ['.NET', 'Spring Boot', 'Node.js', 'React.js', 'Blazor', 'Flutter', '.NET MAUI']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'Web Technologies',
      items: ['HTML', 'CSS', 'XML', 'Bootstrap', 'Tailwind CSS', 'RESTful APIs', 'SOAP']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'Cloud & Virtualization',
      items: ['Microsoft Azure', 'VMware', 'AWS (in progress)']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'Databases',
      items: ['PostgreSQL', 'MongoDB', 'SQL', 'NoSQL']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'Back-End & CMS',
      items: ['WordPress', 'Drupal', 'RESTful API Integration']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'Hardware & Networking',
      items: ['Infrastructure', 'LAN/WAN', 'VoIP', 'Routers', 'Servers', 'IoT']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'Version Control & Collaboration',
      items: ['Git', 'GitHub', 'Agile Methodologies']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'Testing & Debugging',
      items: ['Automated Unit Testing', 'Manual Testing', 'Bug Tracking', 'Cross-Browser Testing']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'Software Proficiency',
      items: ['Microsoft Project', 'Outlook', 'PowerPoint', 'Zendesk', 'Slack', 'Statistical Analysis Software', 'ERP Systems']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'UI/UX Design',
      items: ['Figma', 'Adobe XD', 'Responsive Design', 'User-Centered Design Principles']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'Graphic Design',
      items: ['Adobe Photoshop', 'Illustrator', 'Canva', 'Branding', 'Layout Design', 'Visual Storytelling']
    ).toMap());

    await db.insert('skills', Skill(
      category: 'Soft Skills',
      items: ['Problem-Solving', 'Adaptability', 'Creativity', 'System Documentation', 'Compliance Awareness', 'Basic Incident Response']
    ).toMap());

    // Insert projects
    await db.insert('projects', Project(
      title: 'BBBEE Compliance Portals',
      description: 'Automated scorecard calculations and document management'
    ).toMap());

    await db.insert('projects', Project(
      title: 'Invoicing & Payment Systems',
      description: 'With automated reminders and financial reporting'
    ).toMap());

    await db.insert('projects', Project(
      title: 'Responsive Websites & PWAs',
      description: 'Using Laravel, React, and Vue.js'
    ).toMap());

    await db.insert('projects', Project(
      title: 'Scalable Multi-tenant SaaS Platforms',
      description: 'Enterprise-level multi-tenant software solutions'
    ).toMap());

    await db.insert('projects', Project(
      title: 'End-to-end E-Commerce Systems',
      description: 'With inventory management and secure checkout'
    ).toMap());

    await db.insert('projects', Project(
      title: 'Business Automation Tools',
      description: 'Including custom CRM and analytics dashboards'
    ).toMap());

    // Insert certifications
    await db.insert('certifications', Certification(
      provider: 'Microsoft',
      certifications: ['Microsoft Certified: Azure Fundamentals']
    ).toMap());

    await db.insert('certifications', Certification(
      provider: 'VMware',
      certifications: [
        'VSP – Foundation',
        'VSP – Business Continuity',
        'VTSP – Business Continuity',
        'VSP – Disaster Recovery',
        'VTSP – Disaster Recovery',
        'VMware Ethics and Compliance'
      ]
    ).toMap());

    await db.insert('certifications', Certification(
      provider: 'SUSE',
      certifications: [
        'SUSE Foundation',
        'Technical Sales Specialist – SUSE Linux Enterprise Server'
      ]
    ).toMap());

    await db.insert('certifications', Certification(
      provider: 'Nutanix',
      certifications: [
        'Nutanix Certified Sales Representative (NCSR)',
        'NCSR – Unified Storage Exam'
      ]
    ).toMap());

    // Insert references
    await db.insert('references', Reference(
      name: 'Mr. Comfort Mokwena',
      position: 'Supervisor',
      company: 'OL Afrika Media Foundation',
      contact: 'Phone: 079 949 3791'
    ).toMap());

    await db.insert('references', Reference(
      name: 'Mrs. Pricilla Chewe',
      position: 'Supervisor',
      company: 'Mogwape Business Enterprise',
      contact: 'Email: precillatc@gmail.com | Phone: 074 873 0455'
    ).toMap());

    await db.insert('references', Reference(
      name: 'Mr. Edward Mauba',
      position: 'Mentor',
      company: 'Bios Data Centre',
      contact: 'Phone: 081 466 9869'
    ).toMap());

    await db.insert('references', Reference(
      name: 'Mr. Ben Szluha',
      position: 'Supervisor',
      company: 'FairPlay Hardware',
      contact: 'Phone: 071 613 6840'
    ).toMap());

    // Insert contact info
    await db.insert('contact_info', ContactInfo(
      type: 'phone',
      value: '+27 81 468 8426',
      icon: 'phone'
    ).toMap());

    await db.insert('contact_info', ContactInfo(
      type: 'email',
      value: 'khakhumohau@gmail.com',
      icon: 'email'
    ).toMap());

    await db.insert('contact_info', ContactInfo(
      type: 'location',
      value: 'Johannesburg, Gauteng',
      icon: 'location'
    ).toMap());

    await db.insert('contact_info', ContactInfo(
      type: 'portfolio',
      value: 'mohaukhakhu.github.io/resume2/',
      icon: 'web'
    ).toMap());

    await db.insert('contact_info', ContactInfo(
      type: 'github',
      value: 'github.com/Mohaukhakhu',
      icon: 'github'
    ).toMap());

    await db.insert('contact_info', ContactInfo(
      type: 'linkedin',
      value: 'https://za.linkedin.com/in/mohaukhakhu-482985186',
      icon: 'linkedin'
    ).toMap());
  }

  // Education methods
  Future<List<Education>> getEducation() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('education');
    return List.generate(maps.length, (i) => Education.fromMap(maps[i]));
  }

  // Experience methods
  Future<List<Experience>> getExperience() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('experience');
    return List.generate(maps.length, (i) => Experience.fromMap(maps[i]));
  }

  // Skills methods
  Future<List<Skill>> getSkills() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('skills');
    return List.generate(maps.length, (i) => Skill.fromMap(maps[i]));
  }

  // Projects methods
  Future<List<Project>> getProjects() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('projects');
    return List.generate(maps.length, (i) => Project.fromMap(maps[i]));
  }

  // Certifications methods
  Future<List<Certification>> getCertifications() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('certifications');
    return List.generate(maps.length, (i) => Certification.fromMap(maps[i]));
  }

  // References methods
  Future<List<Reference>> getReferences() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('references');
    return List.generate(maps.length, (i) => Reference.fromMap(maps[i]));
  }

  // Contact info methods
  Future<List<ContactInfo>> getContactInfo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contact_info');
    return List.generate(maps.length, (i) => ContactInfo.fromMap(maps[i]));
  }

  // Search methods
  Future<List<Map<String, dynamic>>> searchAll(String query) async {
    final db = await database;
    
    final educationResults = await db.query(
      'education',
      where: 'qualification LIKE ? OR institution LIKE ? OR details LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%']
    );

    final experienceResults = await db.query(
      'experience',
      where: 'position LIKE ? OR company LIKE ? OR responsibilities LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%']
    );

    final skillsResults = await db.query(
      'skills',
      where: 'category LIKE ? OR items LIKE ?',
      whereArgs: ['%$query%', '%$query%']
    );

    final projectsResults = await db.query(
      'projects',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%']
    );

    return [
      ...educationResults.map((e) => {...e, 'type': 'education'}),
      ...experienceResults.map((e) => {...e, 'type': 'experience'}),
      ...skillsResults.map((e) => {...e, 'type': 'skills'}),
      ...projectsResults.map((e) => {...e, 'type': 'projects'}),
    ];
  }
}