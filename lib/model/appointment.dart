class AppointmentModel {
  final String id;
  final String patientName;
  final String doctorName;
  final String issue;
  final String date;
  final String time;
  final String status;

  AppointmentModel({
    required this.id,
    required this.patientName,
    required this.doctorName,
    required this.issue,
    required this.date,
    required this.time,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'patientName': patientName,
        'doctorName': doctorName,
        'issue': issue,
        'date': date,
        'time': time,
        'status': status
      };
}
