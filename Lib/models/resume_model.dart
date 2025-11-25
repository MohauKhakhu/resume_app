class Education {
  final int? id;
  final String qualification;
  final String institution;
  final String period;
  final String details;

  Education({
    this.id,
    required this.qualification,
    required this.institution,
    required this.period,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'qualification': qualification,
      'institution': institution,
      'period': period,
      'details': details,
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      id: map['id'],
      qualification: map['qualification'],
      institution: map['institution'],
      period: map['period'],
      details: map['details'],
    );
  }
}

class Experience {
  final int? id;
  final String position;
  final String company;
  final String period;
  final List<String> responsibilities;

  Experience({
    this.id,
    required this.position,
    required this.company,
    required this.period,
    required this.responsibilities,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'position': position,
      'company': company,
      'period': period,
      'responsibilities': responsibilities.join('||'),
    };
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      id: map['id'],
      position: map['position'],
      company: map['company'],
      period: map['period'],
      responsibilities: (map['responsibilities'] as String).split('||'),
    );
  }
}

class Skill {
  final int? id;
  final String category;
  final List<String> items;

  Skill({
    this.id,
    required this.category,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'items': items.join('||'),
    };
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      id: map['id'],
      category: map['category'],
      items: (map['items'] as String).split('||'),
    );
  }
}

class Project {
  final int? id;
  final String title;
  final String description;

  Project({
    this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}

class Certification {
  final int? id;
  final String provider;
  final List<String> certifications;

  Certification({
    this.id,
    required this.provider,
    required this.certifications,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'provider': provider,
      'certifications': certifications.join('||'),
    };
  }

  factory Certification.fromMap(Map<String, dynamic> map) {
    return Certification(
      id: map['id'],
      provider: map['provider'],
      certifications: (map['certifications'] as String).split('||'),
    );
  }
}

class Reference {
  final int? id;
  final String name;
  final String position;
  final String company;
  final String contact;

  Reference({
    this.id,
    required this.name,
    required this.position,
    required this.company,
    required this.contact,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'company': company,
      'contact': contact,
    };
  }

  factory Reference.fromMap(Map<String, dynamic> map) {
    return Reference(
      id: map['id'],
      name: map['name'],
      position: map['position'],
      company: map['company'],
      contact: map['contact'],
    );
  }
}

class ContactInfo {
  final int? id;
  final String type;
  final String value;
  final String icon;

  ContactInfo({
    this.id,
    required this.type,
    required this.value,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'value': value,
      'icon': icon,
    };
  }

  factory ContactInfo.fromMap(Map<String, dynamic> map) {
    return ContactInfo(
      id: map['id'],
      type: map['type'],
      value: map['value'],
      icon: map['icon'],
    );
  }
}