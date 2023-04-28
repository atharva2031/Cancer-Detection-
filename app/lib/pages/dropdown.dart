import 'package:flutter/material.dart';
import 'package:app/utils/globals.dart';
import 'imagePage.dart';

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  DropdownPageState createState() => DropdownPageState();
}

class DropdownPageState extends State<DropdownPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue;
                });
              },
              items: <String>[
                'Blood Cancer',
                'Brain Cancer',
                'Breast Cancer',
                'Cervical Cancer',
                'Colon Cancer',
                'Kidney Cancer',
                'Lung Cancer',
                'Oral Cancer'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            selectedOption == 'Blood Cancer'
                ? DropdownButton<String>(
                    value: subOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        subOption = newValue;
                      });
                    },
                    items: <String>[
                      'Leukemia',
                      'Lymphoma',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                : const SizedBox(),
            selectedOption == 'Breast Cancer'
                ? DropdownButton<String>(
                    value: subOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        subOption = newValue;
                      });
                    },
                    items: <String>['Histopathology', 'pCR', 'Ultrasound']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                : const SizedBox(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyImagePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('CHOOSE THE IMAGE'),
            )
          ],
        ),
      ),
    );
  }
}
