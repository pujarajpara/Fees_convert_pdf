// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DataDisplayPage extends StatefulWidget {
  final String receiptNumber;
  final String date;
  final String studentName;
  final String phone;
  final String email;
  final String address;
  final String amount;

  const DataDisplayPage({
    super.key,
    required this.receiptNumber,
    required this.date,
    required this.studentName,
    required this.phone,
    required this.email,
    required this.address,
    required this.amount,
  });

  @override
  State<DataDisplayPage> createState() => _DataDisplayPageState();
}

class _DataDisplayPageState extends State<DataDisplayPage> {
  bool showDivider = true;

  void _downloadAndOpenPdf(BuildContext context) async {
    final pdfPath = await generatePdf(context);

    if (pdfPath.isNotEmpty) {
      OpenFile.open(pdfPath);
    }
    print('PDF :$pdfPath');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/fib.png',
                          width: 100,
                        ),
                        Container(
                          height: 2,
                          width: 150,
                          margin: const EdgeInsets.only(
                            left: 15,
                          ),
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            'Flutter Training Academy',
                            style: TextStyle(
                              fontSize: 0.04 * screenWidth,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Receipt Number: ${widget.receiptNumber}',
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              'Date: ${widget.date}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Student Name: ${widget.studentName}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            'Phone: ${widget.phone}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            'Email: ${widget.email}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            'Address: ${widget.address}',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    color: Colors.black,
                    height: 50,
                    width: screenWidth * 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Description',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 55),
                          child: Text(
                            'Amt',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            '''Flutter App Devlopment
Traning Program''',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Column(
                        children: [
                          Container(
                            width: 2,
                            height: 300,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 35, top: 20),
                          child: Text(
                            widget.amount,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.black,
                thickness: 2,
              ),
              const Divider(
                color: Colors.black,
                thickness: 2,
                endIndent: 50,
                indent: 180,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 210),
                    child: Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 70),
                    child: Text(
                      widget.amount,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, right: 50),
                child: Row(
                  children: [
                    Icon(Icons.phone, size: 18),
                    SizedBox(width: 5),
                    Text('88 66 44 00 25'),
                    Spacer(),
                    Text(
                      'Fibtion',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.mail, size: 15),
                    const SizedBox(width: 5),
                    const Text('fibtion@gmail.com'),
                    const Spacer(),
                    Transform.rotate(
                      angle: 210 * 5 / 180,
                      child: SizedBox(
                        width: 80,
                        height: 40,
                        child: Image.asset(
                          'assets/signature2.png',
                          height: 100,
                          width: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25, right: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 18),
                    Text('''112-113,Times Shoppers,
 Sarthana Jakatnaka,Surat'''),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        '(Ruchit Mavani)',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Center(
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _downloadAndOpenPdf(context);
                    },
                    child: const Icon(
                      Icons.download,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> generatePdf(BuildContext context) async {
    final pdf = pw.Document();
    const pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
    );

    final Uint8List imageAsset =
    (await rootBundle.load('assets/fib.png')).buffer.asUint8List();
    final Uint8List signatureAsset =
    (await rootBundle.load('assets/signature2.png')).buffer.asUint8List();
    final phoneIconData = Uint8List.fromList(
        (await rootBundle.load('assets/phone_icon.png')).buffer.asUint8List());
    final mailIconData = Uint8List.fromList(
        (await rootBundle.load('assets/mail_icon.png')).buffer.asUint8List());
    final imageAsset1 = Uint8List.fromList(
        (await rootBundle.load('assets/map_icon.png')).buffer.asUint8List());
    pdf.addPage(
      pw.MultiPage(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          final screenWidth = pageTheme.pageFormat.availableWidth;
          return [
            pw.Row(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 20, left: 20),
                  child: pw.Column(
                    children: [
                      pw.Image(pw.MemoryImage(imageAsset),
                          width: 100, height: 100),
                      pw.Container(
                        height: 2,
                        width: 150,
                        margin: const pw.EdgeInsets.only(left: 15),
                        color: PdfColors.black,
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Text(
                          'Flutter Training Academy',
                          style: pw.TextStyle(
                            fontSize: 0.03 * screenWidth,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Padding(
              padding: const pw.EdgeInsets.all(16),
              child: pw.Row(
                children: [
                  pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              children: [
                                pw.Text(
                                  'Receipt Number:',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold, fontSize: 15),
                                ),
                                pw.SizedBox(width: 5),
                                // Add some spacing between key and value
                                pw.Text(
                                  widget.receiptNumber,
                                  style: const pw.TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Text(
                                  'Date:',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold, fontSize: 15),
                                ),
                                pw.SizedBox(width: 5),
                                // Add some spacing between key and value
                                pw.Text(
                                  widget.date,
                                  style: const pw.TextStyle(fontSize: 15),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                  pw.SizedBox(width: 20),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Text(
                              'Student Name:',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 15),
                            ),
                            pw.SizedBox(
                                width:
                                5), // Add some spacing between key and value
                            pw.Text(
                              widget.studentName,
                              style: const pw.TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Phone:',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 15),
                            ),
                            pw.SizedBox(
                                width:
                                5), // Add some spacing between key and value
                            pw.Text(
                              widget.phone,
                              style: const pw.TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Email:',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 15),
                            ),
                            pw.SizedBox(
                                width:
                                5), // Add some spacing between key and value
                            pw.Text(
                              widget.email,
                              style: const pw.TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Address:',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 15),
                            ),
                            pw.SizedBox(
                                width:
                                5), // Add some spacing between key and value
                            pw.Text(
                              widget.address,
                              style: const pw.TextStyle(fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.Row(children: [
              pw.Container(
                color: PdfColors.black,
                height: 50,
                width: 600,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 30),
                      child: pw.Text('Description:',
                          style: const pw.TextStyle(color: PdfColors.white)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 80),
                      child: pw.Text(
                        'Amt:',
                        style: const pw.TextStyle(color: PdfColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            pw.Padding(
              padding: const pw.EdgeInsets.only(right: 20, left: 30),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 20),
                        child: pw.Text(
                          '''Flutter App Devlopment
Traning Program''',
                          style: const pw.TextStyle(
                            color: PdfColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 220),
                    child: pw.Column(
                      children: [
                        pw.Container(
                          width: 2,
                          height: 300,
                          color: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                  pw.Column(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 52, top: 20),
                        child: pw.Text(widget.amount),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.Divider(
              height: 1,
              color: PdfColors.black,
              thickness: 2,
            ),
            pw.Divider(
              color: PdfColors.black,
              thickness: 2,
              endIndent: 50,
              indent: 320,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 360),
                  child: pw.Text('Total',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 80),
                  child: pw.Text(widget.amount.toString(),
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
              ],
            ),
            pw.SizedBox(height: 50),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 30, right: 50),
              child: pw.Row(children: [
                pw.Image(
                  pw.MemoryImage(
                    phoneIconData,
                  ),
                  height: 15,
                  width: 15,
                ),
                pw.SizedBox(width: 5),
                pw.Text('88 66 44 00 25'),
                pw.Spacer(),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    right: 25,
                  ),
                  child: pw.Text('Fibtion',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 15)),
                ),
              ]),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 30, right: 30),
              child: pw.Row(
                children: [
                  pw.Image(
                    pw.MemoryImage(
                      mailIconData,
                    ),
                    height: 15,
                    width: 12,
                  ),
                  pw.SizedBox(width: 6),
                  pw.Text('fibtion@gmail.com'),
                  pw.Spacer(),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 30, top: 15),
                    child: pw.Transform.rotate(
                      angle: 120 * 1 / 180,
                      child: pw.SizedBox(
                        width: 70,
                        height: 40,
                        child: pw.Image(
                          pw.MemoryImage(signatureAsset),
                          height: 60,
                          width: 70,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 25, right: 30),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Image(
                    pw.MemoryImage(
                      imageAsset1,
                    ),
                    height: 17,
                    width: 17,
                  ),
                  pw.Text(
                      ''' 112-113, Times Shoppers,\nSarthana Jakatnaka, Surat'''),
                  pw.Spacer(),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 15),
                    child: pw.Text('(Ruchit Mavani)',
                        style: const pw.TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    final tempDir = await getTemporaryDirectory();
    final pdfPath = '${tempDir.path}/prodemo2.pdf';
    final file = File(pdfPath);
    await file.writeAsBytes(await pdf.save());

    return pdfPath;
  }

  pw.Widget createKeyValue(String key, String value, {bool boldKey = false}) {
    return pw.Row(
      children: [
        pw.Text(
          '$key: ',
          style: boldKey ? pw.TextStyle(fontWeight: pw.FontWeight.bold) : null,
        ),
        pw.Text(value),
      ],
    );
  }
}