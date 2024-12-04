// met le fontawesome de licon pdf avec couleur rouge ,rend sa telechargeable(option pour telecharger) et je puisse telecharger ou imprimer.et du gend si je click sur le pdf je puisse voir tous le pdf et lire:
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'dart:io';

// void main() {
//   runApp(MaterialApp(
//     home: AnnouncementHistoryPage(),
//   ));
// }

// class AnnouncementHistoryPage extends StatelessWidget {
//   final List<Map<String, dynamic>> announcements = List.generate(
//     12,
//     (index) => {
//       'title': 'Annonce $index',
//       'message': 'Message de l\'annonce $index',
//       'visibility': 'Public',
//       'pinned': index.isOdd,
//       'department': 'Département ${index % 3 + 1}',
//       'createdAt': DateTime.now().subtract(Duration(days: index)),
//       'file': index % 2 == 0 ? File('path/to/sample.pdf') : File('path/to/sample.jpg'), // Example file paths
//     },
//   );

//   AnnouncementHistoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Historique des Annonces',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Stack(
//         children: [
//           ListView.builder(
//             itemCount: announcements.length,
//             itemBuilder: (context, index) {
//               final announcement = announcements[index];
//               return Card(
//                 elevation: 2,
//                 color: Colors.white,
//                 margin: const EdgeInsets.all(10),
//                 child: ListTile(
//                   title: Text(announcement['title']),
//                   subtitle: Text(announcement['message']),
//                   trailing: PopupMenuButton<String>(
//                     color: Colors.white,
//                     onSelected: (value) {
//                       if (value == 'Delete') {
//                         // Action de suppression
//                         print('Supprimer l\'annonce $index');
//                       }
//                     },
//                     itemBuilder: (BuildContext context) {
//                       return ['Delete'].map((String choice) {
//                         return PopupMenuItem<String>(
//                           value: choice,
//                           child: Text(choice),
//                         );
//                       }).toList();
//                     },
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AnnouncementDetailPage(
//                           announcement: announcement,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AnnouncementForm()),
//           );
//         },
//         icon: const Icon(Icons.add),
//         label: const Text('Add'),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }
// }

// class AnnouncementDetailPage extends StatelessWidget {
//   final Map<String, dynamic> announcement;

//   const AnnouncementDetailPage({super.key, required this.announcement});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Détails de l\'Annonce'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text('Titre: ${announcement['title']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               Text('Message: ${announcement['message']}', style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 10),
//               Text('Visibilité: ${announcement['visibility']}', style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 10),
//               Text('Épinglé: ${announcement['pinned'] ? 'Oui' : 'Non'}', style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 10),
//               Text('Département: ${announcement['department']}', style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 10),
//               Text('Date de Création: ${announcement['createdAt']}', style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 20),
//               if (announcement['file'] != null) _buildFilePreview(announcement['file']),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFilePreview(File file) {
//     return Container(
//       width: double.infinity,
//       height: 300,
//       color: Colors.grey.withOpacity(0.1),
//       alignment: Alignment.center,
//       child: file.path.endsWith('.pdf')
//           ? Container(
//               decoration: const BoxDecoration(
//                 color: Colors.red,
//               ),
//               child: const Icon(
//                 FontAwesomeIcons.filePdf,
//                 size: 100,
//                 color: Colors.white,
//               ),
//             )
//           : file.path.endsWith('.jpg') || file.path.endsWith('.png')
//               ? Image.file(
//                   file,
//                   fit: BoxFit.contain,
//                 )
//               : const Icon(Icons.insert_drive_file, size: 100, color: Colors.white),
//     );
//   }
// }

// class AnnouncementForm extends StatefulWidget {
//   @override
//   // ignore: library_private_types_in_public_api
//   _AnnouncementFormState createState() => _AnnouncementFormState();
// }

// class _AnnouncementFormState extends State<AnnouncementForm> {
//   final _formKey = GlobalKey<FormState>();

//   int? id;
//   int? announcementId;
//   int? teamId;
//   int? userId;
//   int? isRead;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? title;
//   String? message;
//   String? visibility;
//   int? pinned;
//   String? selectedDepartment;
//   File? _selectedFile;

//   final List<String> departments = [
//     'HR',
//     'Sales',
//     'IT',
//     'Finance',
//     'Marketing'
//   ];

//   void _selectDepartment() {
//     showModalBottomSheet(
//       backgroundColor: Colors.white,
//       context: context,
//       builder: (BuildContext context) {
//         return ListView.builder(
//           itemCount: departments.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               title: Text(departments[index]),
//               onTap: () {
//                 setState(() {
//                   selectedDepartment = departments[index];
//                 });
//                 Navigator.pop(context);
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<void> _pickFile() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.any);
//     if (result != null && result.files.single.path != null) {
//       setState(() {
//         _selectedFile = File(result.files.single.path!);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Créer une Annonce',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Titre',
//                     border: OutlineInputBorder(),
//                   ),
//                   onSaved: (value) => title = value,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Veuillez entrer un titre';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Message',
//                     border: OutlineInputBorder(),
//                   ),
//                   onSaved: (value) => message = value,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Veuillez entrer un message';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Visibilité',
//                     border: OutlineInputBorder(),
//                   ),
//                   onSaved: (value) => visibility = value,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Veuillez entrer la visibilité';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Épinglé (0 ou 1)',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.number,
//                   onSaved: (value) => pinned = int.tryParse(value ?? '0'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Veuillez indiquer si l\'annonce est épinglée';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 _buildDepartmentField(),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: _pickFile,
//                   child: const Text('Importer une image ou un fichier'),
//                 ),
//                 const SizedBox(height: 20),
//                 if (_selectedFile != null) _buildFilePreview(),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       // Soumettre l'annonce
//                       print('Annonce soumise : $title, $message, $visibility, $pinned, $selectedDepartment');
//                     }
//                   },
//                   child: const Text('Soumettre'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDepartmentField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20.0),
//       child: GestureDetector(
//         onTap: _selectDepartment,
//         child: InputDecorator(
//           decoration: InputDecoration(
//             labelText: 'Department',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//           ),
//           child: Text(selectedDepartment ?? 'Select Department'),
//         ),
//       ),
//     );
//   }

//   Widget _buildFilePreview() {
//     return Container(
//       width: 100,
//       height: 180,
//       color: Colors.grey.withOpacity(0.1),
//       alignment: Alignment.center,
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.8,
//         height: 200 * 0.8,
//         child: _selectedFile!.path.endsWith('.pdf')
//             ? Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.red,
//                 ),
//                 child: const Icon(
//                   FontAwesomeIcons.filePdf,
//                   size: 50,
//                   color: Colors.white,
//                 ))
//             : _selectedFile!.path.endsWith('.jpg') ||
//                     _selectedFile!.path.endsWith('.png')
//                 ? Image.file(
//                     _selectedFile!,
//                     fit: BoxFit.contain,
//                   )
//                 : const Icon(Icons.insert_drive_file,
//                     size: 50, color: Colors.white),
//       ),
//     );
//   }
// }
