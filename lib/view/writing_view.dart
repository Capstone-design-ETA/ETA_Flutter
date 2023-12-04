import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:native_exif/native_exif.dart';
import 'package:http/http.dart' as http;

import 'package:kpostal/kpostal.dart';


class WritingView extends StatefulWidget {
  const WritingView({super.key});

  @override
  State<WritingView> createState() => _WritingViewState();
}

class _WritingViewState extends State<WritingView> {
  String gpsApiKey = dotenv.env["google_map_key"]!;

  DateTime? selectedDate;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();


  final picker = ImagePicker();

  List<XFile?> _images = [];
  Exif? exif;
  Map<String, Object>? attributes;
  DateTime? shootingDate;
  ExifLatLong? coordinates;

  @override
  void initState() {
    super.initState();
  }

  Future<void> showError(Object e) async {
    debugPrintStack(
        label: e.toString(), stackTrace: e is Error ? e.stackTrace : null);

    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(e.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future getImages() async {
    List<XFile>? pickedFiles = await picker.pickMultiImage();
    if (pickedFiles == null) {
      return;
    }
    setState(() {
      _images.addAll(pickedFiles);
    });
    print(pickedFiles.length);

    
    exif = await Exif.fromPath(pickedFiles[0]!.path);
    attributes = await exif!.getAttributes();
    shootingDate = await exif!.getOriginalDate();
    coordinates = await exif!.getLatLong();

    print(attributes);
    print(shootingDate);
    print(coordinates);

    final gpsUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinates!
        .latitude},${coordinates!.longitude}&key=$gpsApiKey&language=ko';
    final responseGps = await http.get(Uri.parse(gpsUrl));
    final formatted_address = jsonDecode(
        responseGps.body)['results'][0]['formatted_address'];
    ETALocation = jsonDecode(
        responseGps.body)['results'][0]['address_components'][3]['long_name'];
    print(ETALocation);


    setState(() {
      selectedDate = shootingDate;
      address = formatted_address;
    });
  }


  String postCode = '';
  String address = '';
  String latitude = '';
  String longitude = '';
  String kakaoLatitude = '';
  String kakaoLongitude = '';
  String ETALocation = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '나의 발자취',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 1.0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black)),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: _buildPhotoArea(),
                ),
                Text(
                  '날짜',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime.now());
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    },
                    child: Text(
                      selectedDate == null ? '' :
                      DateFormat('yyyy-MM-dd').format(selectedDate!),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF5F5F5),
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  '위치',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(context, MaterialPageRoute(
                        builder: (_) =>
                            KpostalView(
                              callback: (Kpostal result) {
                                setState(() {
                                  this.postCode = result.postCode;
                                  this.address = result.address;
                                  this.latitude = result.latitude.toString();
                                  this.longitude = result.longitude.toString();
                                  this.kakaoLatitude =
                                      result.kakaoLatitude.toString();
                                  this.kakaoLongitude =
                                      result.kakaoLongitude.toString();
                                  this.ETALocation =
                                      result.sigungu.toString();
                                });
                                print(ETALocation);
                              },
                            ),
                      ));
                    },
                    child: Text(
                      this.address,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF5F5F5),
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  '오늘의 일기',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: contentController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black87,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true),
                ),
                SizedBox(height: 40.0,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '완료',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF8474F7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minimumSize: const Size.fromHeight(53)))
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildPhotoArea() {
    return _images.isNotEmpty
        ? SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 8.0),
                width: 100,
                height: 100,
                child: Image.file(File(_images[index]!.path),
                  fit: BoxFit.cover,
                ),
              );
            }
          ),
        )
        : Container(
        width: 100,
        height: 100,
        child: IconButton(
          onPressed: () {
            getImages();
          },
          icon: Icon(Icons.camera_alt),
          color: Color(0xFF8474F7),
        )
    );
  }
}