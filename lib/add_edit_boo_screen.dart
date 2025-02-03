import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddEditBookScreen extends StatefulWidget {
  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  Uint8List? uploadedCoverBytes; // Store image as bytes
  String? uploadedCoverName;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  String _status = 'Want to Read';
  double _rating = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add / Edit Book')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(controller: _titleController, label: 'Book Title'),
            SizedBox(height: 20),
            _buildTextField(controller: _authorController, label: 'Author'),
            SizedBox(height: 20),
            _buildDropdown(),
            SizedBox(height: 20),
            _buildRatingSlider(),
            SizedBox(height: 20),
            _buildFileUploader(
              label: 'Upload Cover Image',
              fileName: uploadedCoverName,
              onPressed: _uploadCoverImage,
            ),
            if (uploadedCoverBytes != null)
              Image.memory(uploadedCoverBytes!, height: 150), // Show uploaded image
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveBook,
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _status,
      decoration: InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
      items: ['Read', 'Want to Read']
          .map((status) => DropdownMenuItem(value: status, child: Text(status)))
          .toList(),
      onChanged: (value) => setState(() => _status = value!),
    );
  }

  Widget _buildRatingSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rating: $_rating'),
        Slider(
          value: _rating,
          min: 1.0,
          max: 5.0,
          divisions: 4,
          label: _rating.toString(),
          onChanged: (newRating) => setState(() => _rating = newRating),
        ),
      ],
    );
  }

  Widget _buildFileUploader({required String label, String? fileName, required VoidCallback onPressed}) {
    return Column(
      children: [
        ElevatedButton(onPressed: onPressed, child: Text(fileName == null ? label : 'Replace $label')),
        if (fileName != null) Text('Uploaded: $fileName', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Future<void> _uploadCoverImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        uploadedCoverBytes = result.files.single.bytes;
        uploadedCoverName = result.files.single.name;
      });
    }
  }

  void _saveBook() {
    if (_titleController.text.isEmpty || _authorController.text.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    final newBook = {
      'title': _titleController.text,
      'author': _authorController.text,
      'status': _status,
      'rating': _rating,
      'coverBytes': uploadedCoverBytes, // Pass the cover image bytes
    };

    Navigator.pop(context, newBook);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
