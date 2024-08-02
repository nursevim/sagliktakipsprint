import 'package:flutter/material.dart';

import '../models/doktor.dart';

class AdvicePage extends StatelessWidget {
  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Ali Veli',
      specialty: 'Kardiyoloji',
      commonIssue: 'Yüksek Tansiyon',
      advice: 'Yüksek tansiyonla başa çıkmak için düzenli egzersiz yapın.',
      imageUrl: 'male.png',
    ),
    Doctor(
      name: 'Dr. Ayşe Fatma',
      specialty: 'Endokrinoloji',
      commonIssue: 'Diyabet',
      advice: 'Diyabet yönetiminde dengeli beslenme çok önemlidir.',
      imageUrl: 'female.png',
    ),
    Doctor(
      name: 'Dr. Mehmet Yılmaz',
      specialty: 'Gastroenteroloji',
      commonIssue: 'Mide Ekşimesi',
      advice: 'Mide ekşimesini önlemek için baharatlı yiyeceklerden kaçının.',
      imageUrl: 'male.png',
    ),
    Doctor(
      name: 'Dr. Elif Kaya',
      specialty: 'Nöroloji',
      commonIssue: 'Baş Ağrısı',
      advice: 'Baş ağrısını hafifletmek için yeterli su içmeyi unutmayın.',
      imageUrl: 'female.png',
    ),
    Doctor(
      name: 'Dr. Can Demir',
      specialty: 'Ortopedi',
      commonIssue: 'Eklem Ağrısı',
      advice: 'Eklem ağrısını hafifletmek için düzenli olarak esneme egzersizleri yapın.',
      imageUrl: 'male.png',
    ),
    Doctor(
      name: 'Dr. Zeynep Aksoy',
      specialty: 'Dermatoloji',
      commonIssue: 'Cilt Kuruluğu',
      advice: 'Cilt kuruluğunu önlemek için nemlendirici kullanın ve bol su için.',
      imageUrl: 'female.png',
    ),
    Doctor(
      name: 'Dr. Ahmet Öz',
      specialty: 'Psikiyatri',
      commonIssue: 'Anksiyete',
      advice: 'Anksiyete yönetiminde düzenli meditasyon ve nefes egzersizleri yapın.',
      imageUrl: 'male.png',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.teal.shade800,
        title: Text('Uzman Tavsiyeleri',style: TextStyle(color: Colors.white),),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(
            doctor: doctors[index],
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(doctors[index].name),
                  content: Text(doctors[index].advice),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Kapat'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  DoctorCard({required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('lib/images/${doctor.imageUrl}')
        ),
        title: Text(doctor.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Branş: ${doctor.specialty}'),
            Text('Yaygın Sorun: ${doctor.commonIssue}'),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
