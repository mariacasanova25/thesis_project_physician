import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Prescription {
  Prescription(
      {required this.name, //to be removed
      required this.dosage,
      required this.endDate,
      required this.frequency,
      required this.startDate,
      required this.times,
      required this.takenMeds,
      required this.id,
      required this.physicianId,
      required this.motive});

  final String name;
  final String id;
  final int dosage;
  final DateTime endDate;
  final DateTime startDate;
  final int frequency;
  final String motive;
  final String physicianId;
  final List<String> times;
  final Map<String, List<String>> takenMeds;

  factory Prescription.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    final Map<String, List<String>> takenMeds =
        (data!['takenMeds'] as Map<String, dynamic>).map((key, value) {
      return MapEntry(
          key, value != null ? List<String>.from(value) : <String>[]);
    });

    final List<String> times =
        (data['times'] as List?)?.cast<String>().toList() ?? [];

    return Prescription(
        name: data['name'],
        dosage: data['dosage'],
        endDate: DateTime(data['endDate'].toDate().year,
            data['endDate'].toDate().month, data['endDate'].toDate().day),
        frequency: data['frequency'],
        startDate: DateTime(data['startDate'].toDate().year,
            data['startDate'].toDate().month, data['startDate'].toDate().day),
        times: times,
        takenMeds: takenMeds,
        id: snapshot.id,
        motive: data['motive'],
        physicianId: data['physicianId']);
  }

  double getAdherence(DateTime date) {
    return (getTakenMedsDay(DateFormat('yyyy-MM-dd').format(date)) /
            nrMedsDay) *
        100;
  }

  double getGeneralAdherence() {
    double sum = 0;
    List<DateTime> days = generateDaysList();
    for (DateTime day in days) {
      sum += (getAdherence(day) / 100);
    }
    return sum / days.length;
  }

  List<DateTime> generateDaysList() {
    List<DateTime> days = [];
    DateTime date = startDate;

    days.add(date);
    while (date.isBefore(DateTime.now())) {
      date = date.add(const Duration(days: 1));
      date = DateTime(date.year, date.month, date.day);
      if (date.isAtSameMomentAs(DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)) ||
          date.isBefore(DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
        days.add(date);
      }
    }
    return days;
  }

  int getStreak() {
    int streak = 0;
    List<DateTime> dates = generateDaysList();
    for (DateTime date in dates) {
      if (getAdherence(date) == 100.0) {
        streak++;
      } else {
        streak = 0;
      }
    }

    return streak;
  }

  int get nrMedsDay {
    return 24 ~/ frequency;
  }

  int getTakenMedsDay(String date) {
    if (takenMeds[date] != null) {
      return takenMeds[date]!.where((time) => time != 'null').length;
    }
    return 0;
  }

  List<String> getSchedule(String startHour) {
    List<String> schedule = [];

    List<String> content = startHour.split('h');
    int hour = int.parse(content[0]);
    int minutes = int.parse(content[1]);

    for (int i = 0; i < nrMedsDay; i++) {
      int newHour = (hour + frequency * i) % 24;
      String formattedHour = newHour < 10 ? '0$newHour' : '$newHour';
      String formattedMinutes = minutes < 10 ? '0$minutes' : '$minutes';
      schedule.add('${formattedHour}h$formattedMinutes');
    }
    return schedule;
  }

  int getDifferenceTime(String time1, String time2) {
    List<String> content1 = time1.split('h');
    int hour1 = int.parse(content1[0]);
    int minutes1 = int.parse(content1[1]);

    List<String> content2 = time2.split('h');
    int hour2 = int.parse(content2[0]);
    int minutes2 = int.parse(content2[1]);

    int totalMinutes1 = hour1 * 60 + minutes1;
    int totalMinutes2 = hour2 * 60 + minutes2;

    int differenceInMinutes = (totalMinutes2 - totalMinutes1).abs();

    return differenceInMinutes ~/ 60;
  }

  int get duration {
    return endDate.difference(startDate).inDays;
  }
}
