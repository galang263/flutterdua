import 'package:flutter/material.dart';

class FormApp extends StatefulWidget {
  const FormApp({super.key});

  @override
  State<FormApp> createState() => _FormAppState();
}

class _FormAppState extends State<FormApp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final  TextEditingController tglLahirController = TextEditingController();
  var _outputName = '';
  @override
  void dispose() {
    //menghapus inputan yang sudah di isi 
    _nameController.dispose();
    // mengeksekusi method dispose
    super.dispose();
  }
void _submitForm() {
  setState(() {
    _outputName = _nameController.text;
  });
  print ("Nama Lengkap: ${_nameController.text}");
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Nama Lengkap: ${_nameController.text}"))
  );
  _clearInput();
}

void _clearInput() {
_nameController.clear();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('my form app')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                   controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'enter your name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Nama Tidak Boleh Kosong Deks";
                    }
                    return null;
                  }
                ),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()){
                      _submitForm();
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.green, width: 1),
                ),
                child: Text('simpan'),
              ),
             Text(
              'Nama: ${_outputName.isEmpty ? "-" : _outputName}',
              style: const TextStyle(fontSize: 16),
             ),
            ],
          ),
        ),
        
      ),
    );
  }
}