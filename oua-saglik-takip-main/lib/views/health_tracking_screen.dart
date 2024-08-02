import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saglik_takip/models/health_data.dart';
import 'package:saglik_takip/provider/health_data_provider.dart';
import 'package:saglik_takip/views/doktor_page.dart';
import 'package:saglik_takip/views/report_screen.dart';
import '../auth.dart';
class SaglikTakipEkrani extends StatelessWidget {
  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sağlık Takibi',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.teal.shade800,
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RaporEkrani()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdvicePage()),
              );
            },
          ),
          IconButton(
            onPressed: signOut,
            icon: Icon(Icons.logout,color: Colors.white,),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SaglikVeriListesi(),
          ),
          // Veri Ekle butonunu ekliyoruz
          SizedBox(
            width: screenWidth/1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade800),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SaglikVeriEkleDialog(), // Pop-up menü
                  );
                },
                child: Text('Veri Ekle',style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SaglikVeriListesi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final saglikVerisi = Provider.of<SaglikVeriProvider>(context).veri;

    return ListView.builder(
      itemCount: saglikVerisi.length,
      itemBuilder: (context, index) {
        final veri = saglikVerisi[index];
        final formattedDate =
            "${veri.tarih.day}/${veri.tarih.month}/${veri.tarih.year}";

        return ListTile(
          title: Text('Tarih: $formattedDate'),
          subtitle: Text(
              'Adım: ${veri.adim},\nKalori: ${veri.kalori},\nNabız: ${veri.nabiz},\nTansiyon: ${veri.tansiyon},\nŞeker Seviyesi: ${veri.sekerSeviyesi},\nKilo: ${veri.kilo}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SaglikVeriDuzenleFormu(
                      index: index,
                      veri: veri,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Provider.of<SaglikVeriProvider>(context, listen: false)
                      .veriSil(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class SaglikVeriEkleDialog extends StatefulWidget {
  @override
  _SaglikVeriEkleDialogState createState() => _SaglikVeriEkleDialogState();
}

class _SaglikVeriEkleDialogState extends State<SaglikVeriEkleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _adimKontrol = TextEditingController();
  final _kaloriKontrol = TextEditingController();
  final _nabizKontrol = TextEditingController();
  final _tansiyonKontrol = TextEditingController();
  final _sekerKontrol = TextEditingController();
  final _kiloKontrol = TextEditingController();

  @override
  void dispose() {
    _adimKontrol.dispose();
    _kaloriKontrol.dispose();
    _nabizKontrol.dispose();
    _tansiyonKontrol.dispose();
    _sekerKontrol.dispose();
    _kiloKontrol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Yeni Sağlık Verisi Ekle'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _adimKontrol,
                decoration: InputDecoration(labelText: 'Adım'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen adım sayısını girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kaloriKontrol,
                decoration: InputDecoration(labelText: 'Kalori'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kalori miktarını girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nabizKontrol,
                decoration: InputDecoration(labelText: 'Nabız'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen nabız sayısını girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tansiyonKontrol,
                decoration: InputDecoration(labelText: 'Tansiyon'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen tansiyonunuzu girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sekerKontrol,
                decoration: InputDecoration(labelText: 'Şeker Seviyesi'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şeker seviyenizi girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kiloKontrol,
                decoration: InputDecoration(labelText: 'Kilo'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kilonuzu girin';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              final yeniSaglikVerisi = SaglikVerisi(
                DateTime.now(),
                int.parse(_adimKontrol.text),
                int.parse(_kaloriKontrol.text),
                int.parse(_nabizKontrol.text),
                int.parse(_tansiyonKontrol.text),
                int.parse(_sekerKontrol.text),
                int.parse(_kiloKontrol.text),
              );
              Provider.of<SaglikVeriProvider>(context, listen: false)
                  .veriEkle(yeniSaglikVerisi);
              Navigator.of(context).pop(); // Dialog kapatılıyor
            }
          },
          child: Text('Veri Ekle'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('İptal'),
        ),
      ],
    );
  }
}

class SaglikVeriDuzenleFormu extends StatefulWidget {
  final int index;
  final SaglikVerisi veri;

  SaglikVeriDuzenleFormu({required this.index, required this.veri});

  @override
  _SaglikVeriDuzenleFormuState createState() => _SaglikVeriDuzenleFormuState();
}

class _SaglikVeriDuzenleFormuState extends State<SaglikVeriDuzenleFormu> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _adimKontrol;
  late TextEditingController _kaloriKontrol;
  late TextEditingController _nabizKontrol;
  late TextEditingController _tansiyonKontrol;
  late TextEditingController _sekerKontrol;
  late TextEditingController _kiloKontrol;

  @override
  void initState() {
    _adimKontrol = TextEditingController(text: widget.veri.adim.toString());
    _kaloriKontrol = TextEditingController(text: widget.veri.kalori.toString());
    _nabizKontrol = TextEditingController(text: widget.veri.nabiz.toString());
    _tansiyonKontrol =
        TextEditingController(text: widget.veri.tansiyon.toString());
    _sekerKontrol =
        TextEditingController(text: widget.veri.sekerSeviyesi.toString());
    _kiloKontrol = TextEditingController(text: widget.veri.kilo.toString());
    super.initState();
  }

  @override
  void dispose() {
    _adimKontrol.dispose();
    _kaloriKontrol.dispose();
    _nabizKontrol.dispose();
    _tansiyonKontrol.dispose();
    _sekerKontrol.dispose();
    _kiloKontrol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sağlık Verisini Düzenle'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _adimKontrol,
                decoration: InputDecoration(labelText: 'Adım'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen adım sayısını girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kaloriKontrol,
                decoration: InputDecoration(labelText: 'Kalori'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kalori miktarını girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nabizKontrol,
                decoration: InputDecoration(labelText: 'Nabız'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen nabız sayısını girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tansiyonKontrol,
                decoration: InputDecoration(labelText: 'Tansiyon'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen tansiyonunuzu girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sekerKontrol,
                decoration: InputDecoration(labelText: 'Şeker Seviyesi'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şeker seviyenizi girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kiloKontrol,
                decoration: InputDecoration(labelText: 'Kilo'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kilonuzu girin';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              final guncelVeri = SaglikVerisi(
                widget.veri.tarih,
                int.parse(_adimKontrol.text),
                int.parse(_kaloriKontrol.text),
                int.parse(_nabizKontrol.text),
                int.parse(_tansiyonKontrol.text),
                int.parse(_sekerKontrol.text),
                int.parse(_kiloKontrol.text),
              );
              Provider.of<SaglikVeriProvider>(context, listen: false)
                  .veriGuncelle(widget.index, guncelVeri);
              Navigator.of(context).pop();
            }
          },
          child: Text('Veriyi Güncelle'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('İptal'),
        ),
      ],
    );
  }
}
