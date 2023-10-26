import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muhamad Amal Wildan',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInForm();
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  String _signInMessage = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _signInMessage = 'Sukses Submit';
      });
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
        _signInMessage = 'Gagal Submit';
      });
    }
  }

  @override //build widget form
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400, // Atur lebar kontainer
          height: 400, // Atur panjang
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.lightGreen[
                100], // Mengubah warna latar belakang menjadi ungu pastel
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate,
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Centang form di tengah secara vertikal
              children: [
                Text(
                  'Absensi Data Mahasiswa',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(labelText: 'Nama'),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'nama tidak boleh kosong';
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Gunakan Huruf Alfabet';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nimController, // Tambahkan input NIM
                  decoration: InputDecoration(labelText: 'NIM'),
                  keyboardType:
                      TextInputType.number, // Input hanya menerima angka
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'NIM tidak boleh kosong';
                    }
                    if (value.length < 9) {
                      return 'NIM terdiri dari 10 angka';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Gunakan hanya angka';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email Untirta'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zAZ]{2,}))$')
                        .hasMatch(value)) {
                      return 'Masukkan email yang valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[400],
                  ),
                ),
                Text(
                  _signInMessage,
                  style: TextStyle(
                      color: _signInMessage == 'Sukses Submit'
                          ? Colors.green
                          : Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
