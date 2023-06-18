class PortfolioModel {
  String? email;
  String? name;
  String? avatar;
  String? work;
  String? speciality;
  String? experience;
  String? education;
  String? description;
  String? title;
  String? address;

  PortfolioModel({
    this.email,
    this.name,
    this.avatar,
    this.speciality,
    this.description,
    this.education,
    this.experience,
    this.work,
    this.address,
    this.title,
  });

  // receiving data from server
  factory PortfolioModel.fromMap(map) {
    return PortfolioModel(
      email: map['email'],
      name: map['name'],
      avatar: map['avatar'],
      work: map['work'],
      speciality: map['speciality'],
      experience: map['experience'],
      education: map['education'],
      description: map['description'],
      title: map['title'],
      address: map['address'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'avatar': avatar,
      'work': work,
      'speciality': speciality,
      'experience': experience,
      'education': education,
      'description': description,
      'title': title,
      'address': address,
    };
  }
}
