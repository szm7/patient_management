class DoctorModel {
  final String id;
  final String doctorName;
  final String experience;
  final String department;
  final String specialization;
  final String availability;

  DoctorModel(
      {required this.id,
      required this.doctorName,
      required this.experience,
      required this.department,
      required this.specialization,
      required this.availability});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': doctorName,
        'experience': experience,
        'department': department,
        'specialization': specialization,
        'availability': availability
      };
}
