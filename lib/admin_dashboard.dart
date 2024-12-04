import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String position = '';
  File? imageFile;

  // Function to pick an image from the local file system
  Future<void> pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Check if the file is an image (you can add more checks if necessary)
        if (pickedFile.path.endsWith('.jpg') || pickedFile.path.endsWith('.jpeg') || pickedFile.path.endsWith('.png') || pickedFile.path.endsWith('.gif')) {
          setState(() {
            imageFile = File(pickedFile.path); // Save the selected image locally
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please select a valid image file.'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No image selected.'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error picking image: $e'),
      ));
    }
  }

  Future<void> addCandidateLocally() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save candidate data locally (e.g., display in the app)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Candidate added successfully!'),
      ));

      // You can add further functionality here, like saving the image path or candidate data in a local database or list.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill out all fields.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Candidate Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a candidate name' : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Position'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a position' : null,
                onSaved: (value) => position = value!,
              ),
              SizedBox(height: 16),
              imageFile == null
                  ? Text('No image selected')
                  : Image.file(imageFile!, height: 100),
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Pick Image'),
              ),
              ElevatedButton(
                onPressed: addCandidateLocally,
                child: Text('Add Candidate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
