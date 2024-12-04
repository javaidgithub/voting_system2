import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VotingForm extends StatefulWidget {
  @override
  _VotingFormState createState() => _VotingFormState();
}

class _VotingFormState extends State<VotingForm> {
  Map<String, String?> selectedCandidates = {};

  Future<List<Map<String, dynamic>>> fetchCandidates(String position) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('candidates')
        .where('position', isEqualTo: position)
        .get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  void submitVote() async {
    await FirebaseFirestore.instance.collection('votes').add({
      'votes': selectedCandidates,
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Vote submitted successfully!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Voting Form')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchCandidates('President'), // Change position as needed
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No candidates found'));
          }
          return ListView(
            children: snapshot.data!.map((candidate) {
              return RadioListTile<String>(
                title: Text(candidate['name']),
                subtitle: candidate['imageURL'] != null
                    ? Image.network(candidate['imageURL'], height: 50)
                    : null,
                value: candidate['name'],
                groupValue: selectedCandidates['President'], // Adjust for other positions
                onChanged: (value) {
                  setState(() {
                    selectedCandidates['President'] = value;
                  });
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: submitVote,
        child: Icon(Icons.check),
      ),
    );
  }
}
