import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import 'display.dart';

import 'package:pdf/widgets.dart' as pw;

class PdfGenerationPage extends StatefulWidget {
  const PdfGenerationPage({super.key});

  @override
  _PdfGenerationPageState createState() => _PdfGenerationPageState();
}

class _PdfGenerationPageState extends State<PdfGenerationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController receiptNoController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  SignatureController controller = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.red,
      exportBackgroundColor: Colors.yellow);
  //Uint8List? exportedImage;
  final pdf = pw.Document();

  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: receiptNoController,
                  decoration: InputDecoration(
                    labelText: 'Receipt number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the receipt number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                buildDateField(dateController),
              ],
            ),
            const SizedBox(
              width: 20,
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: studentNameController,
                  decoration: InputDecoration(
                    labelText: 'Student Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the student name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the phone number';
                    }
                    if (value.length != 10) {
                      return 'Phone number should have 10 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    if (!isValidEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLines: 1,
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    if (!isNumeric(value)) {
                      return 'Please enter a valid numeric amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Signature(
                  controller: SignatureController(

                  )
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final data = {
                        'Receipt Number': receiptNoController.text,
                        'Date': dateController.text,
                        'Student Name': studentNameController.text,
                        'Phone': phoneController.text,
                        'Email': emailController.text,
                        'Address': addressController.text,
                        'Amount': amountController.text,
                      };

                      int amount = int.tryParse(amountController.text) ?? 0;
                     // final signatureData = await _captureSignature();

                      setState(() {
                        totalAmount += amount;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataDisplayPage(
                            receiptNumber: data['Receipt Number'] ?? '',
                            date: data['Date'] ?? '',
                            studentName: data['Student Name'] ?? '',
                            phone: data['Phone'] ?? '',
                            email: data['Email'] ?? '',
                            address: data['Address'] ?? '',
                            amount: data['Amount'] ?? '',


                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: const Text(
                    'Add Data',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'font/bold.ttf'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    receiptNoController.clear();
                    dateController.clear();
                    studentNameController.clear();
                    phoneController.clear();
                    emailController.clear();
                    addressController.clear();
                    amountController.clear();
                    setState(() {
                      totalAmount = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: const Text(
                    'Clear Data',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            // Signature(
            //   controller: controller,
            //   width: 180,
            //   height: 100,
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 80, top: 10),
            //       child: ElevatedButton(
            //         onPressed: () async{
            //            exportedImage = await controller.toPngBytes();
            //            setState(() {
            //
            //            });
            //         },
            //         style: ButtonStyle(
            //           backgroundColor:
            //               MaterialStateProperty.all(Colors.blueGrey),
            //         ),
            //         child: const Text("Save"),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(right: 70, top: 10),
            //       child: ElevatedButton(
            //         onPressed: () {
            //           controller.clear();
            //         },
            //         style: ButtonStyle(
            //           backgroundColor:
            //               MaterialStateProperty.all(Colors.blueGrey),
            //         ),
            //         child: const Text("Clear"),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 20,),
           // if(exportedImage!=null)Image.memory(exportedImage!)
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      keyboardType: keyboardType,
      maxLength: maxLength,
      validator: validator,
    );
  }

  Widget buildDateField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        labelText: 'Date',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelStyle:
            TextStyle(fontWeight: FontWeight.bold), // Make the label text bold

        suffixIcon: const Icon(Icons.calendar_today),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the date';
        }
        return null;
      },
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
}
