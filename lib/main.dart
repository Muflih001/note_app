import 'package:flutter/material.dart';
import 'package:note_app/views/splashScreen.dart/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}



// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const NoteList(),
//     );
//   }
// }

// class NoteList extends StatefulWidget {
//   const NoteList({super.key});

//   @override
//   State<NoteList> createState() => _NoteListState();
// }

// class _NoteListState extends State<NoteList> {
//   List<Note> _notes = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchNotes();
//   }

//   void _fetchNotes() async {
//     // Simulate a delay to mimic a network request
//     await Future.delayed(const Duration(seconds: 1));

//     // Replace this with your actual database fetch logic
//     setState(() {
//       _notes = [
//         Note(title: 'Note 1', description: 'Description 1', date: '2023-02-20'),
//         Note(title: 'Note 2', description: 'Description 2', date: '2023-02-21'),
//         Note(title: 'Note 3', description: 'Description 3', date: '2023-02-22'),
//       ];
//     });
//   }

//   void _deleteNote(Note note) {
//     setState(() {
//       _notes.remove(note);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _notes.isEmpty
//          ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _notes.length,
//               itemBuilder: (context, index) {
//                 return NoteCard(
//                   note: _notes[index],
//                   onDelete: _deleteNote,
//                 );
//               },
//             ),
//     );
//   }
// }

// class Note {
//   final String title;
//   final String description;
//   final String date;

//   Note({required this.title, required this.description, required this.date});
// }

// class NoteCard extends StatelessWidget {
//   final Note note;
//   final Function(Note) onDelete;

//   const NoteCard({super.key, required this.note, required this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10.0),
//       child: InkWell(
//         child: Container(
//           padding: EdgeInsets.only(
//             left: 10,
//             right: 10,
//           ),
//           width: double.infinity,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10), color: Colors.amber[100]),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     note.title,
//                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
//                       IconButton(
//                         onPressed: () {
//                           onDelete(note);
//                         },
//                         icon: Icon(Icons.delete),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child: Text(
//                   note.description,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 4,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         note.date,
//                         style:
//                             TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                       ),
//                       IconButton(onPressed: () {}, icon: Icon(Icons.share)),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }