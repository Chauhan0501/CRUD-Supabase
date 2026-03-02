import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../controllers/auth_controller.dart';
import '../../domain/entities/note_entity.dart';
import '../widgets/note_dialog.dart';
import '../widgets/note_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final noteController = Get.find<NoteController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'My Notes',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.logout_rounded, color: Colors.red[400]),
              onPressed: () => authController.logout(),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (noteController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (noteController.notes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.note_add_outlined, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  'No notes yet!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the + button to add one',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: noteController.notes.length,
          itemBuilder: (context, index) {
            final note = noteController.notes[index];
            return NoteCard(
              note: note,
              onEdit: () => Get.dialog(NoteDialog(note: note)),
              onDelete: () => noteController.removeNote(note.id!),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.dialog(NoteDialog()),
        backgroundColor: const Color(0xFF764BA2),
        label: const Text('Add Note', style: TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add),
        elevation: 4,
      ),
    );
  }
}
