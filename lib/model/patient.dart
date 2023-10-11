class PatientModel {
  final String id;
  final String patientName;
  final String patientAge;
  final String gender;
  final String phNumber;

  PatientModel({
    required this.id,
    required this.patientName,
    required this.patientAge,
    required this.gender,
    required this.phNumber,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': patientName,
        'age': patientAge,
        'gender': gender,
        'phNumber': phNumber,
      };
}
