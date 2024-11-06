// import 'package:flutter/material.dart';
// import 'package:pbl/BerandaDosenPage.dart';
// import 'package:pbl/ProfileDosenPage.dart';
// import 'package:pbl/NotificationScreen.dart'; // Add this import

// class NotificationTwo extends StatefulWidget {
//   @override
//   _NotificationTwoState createState() => _NotificationTwoState();
// }

// class _NotificationTwoState extends State<NotificationTwo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Notification',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: _buildToggleSwitch(),
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               children: [
//                 _buildNotificationCard(
//                   title: 'Tugas fotocopy 100 lembar',
//                   name: 'Irwil',
//                   message: 'Mengumpulkan tugas!',
//                   chatMessage: 'Chat box: saya sudah mengerjakan tugas',
//                 ),
//                 _buildNotificationCard(
//                   title: 'Tugas fotocopy 100 lembar',
//                   name: 'Dita Karang',
//                   message: 'Mengumpulkan tugas!',
//                   chatMessage: '',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 1,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Beranda',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notifikasi',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ],
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => BerandaDosenPage()),
//               );
//               break;
//             case 1:
//               // Already on notifications page
//               break;
//             case 2:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfileDosenPage()),
//               );
//               break;
//           }
//         },
//         selectedItemColor: const Color(0xFF1A237E),
//         unselectedItemColor: Colors.grey,
//       ),
//     );
//   }

//   Widget _buildToggleSwitch() {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.8,
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => NotificationScreen()),
//                 );
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'Pengajuan',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF1A237E),
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: const Center(
//                 child: Text(
//                   'Pengumpulan',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNotificationCard({
//     required String title,
//     required String name,
//     required String message,
//     required String chatMessage,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFB2B2D7),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       name,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: const [
//                   Icon(Icons.check, size: 20),
//                   SizedBox(width: 8),
//                   Icon(Icons.close, size: 20),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Text(
//             message,
//             style: const TextStyle(fontSize: 14),
//           ),
//           if (chatMessage.isNotEmpty) ...[
//             const SizedBox(height: 4),
//             Text(
//               chatMessage,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.black.withOpacity(0.7),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
