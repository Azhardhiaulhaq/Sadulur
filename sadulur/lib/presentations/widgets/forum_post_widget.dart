import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sadulur/presentations/widgets/forum/quill_editor.dart';
import 'package:sadulur/presentations/widgets/forum/quill_toolbar.dart';

class ForumPostWidget extends StatefulWidget {
  @override
  _ForumPostWidgetState createState() => _ForumPostWidgetState();
}

class _ForumPostWidgetState extends State<ForumPostWidget> {
  final quillController = quill.QuillController.basic();
  final TextEditingController titleController = TextEditingController();
  final _editorFocusNode = FocusNode();
  final _editorScrollController = ScrollController();
  var _isReadOnly = false;
  List<XFile>? _images;

  Future<void> _pickImages() async {
    List<XFile>? pickedImages =
        await ImagePicker().pickMultiImage(imageQuality: 50);

    if (pickedImages != null && pickedImages.isNotEmpty) {
      setState(() {
        _images = pickedImages;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Thread'),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Implement logic to send the post to the forum
              String title = titleController.text;
              String content = quillController.document.toPlainText();
              List<String> imagePaths =
                  _images?.map((image) => image.path).toList() ?? [];

              // // Implement your logic to post the thread with title, content, and images
              // print('Title: $title');
              // print('Content: $content');
              // print('Images: $imagePaths');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          CustomQuillToolbar(
              controller: quillController, focusNode: _editorFocusNode),
          // quill.QuillToolbar.simple(
          //   configurations: QuillSimpleToolbarConfigurations(
          //     controller: quillController,
          //     sharedConfigurations: const QuillSharedConfigurations(
          //       locale: Locale('en', 'US'),
          //     ),
          //   ),
          // ),
          Expanded(
            child: SingleChildScrollView(
              // Wrap with SingleChildScrollView
              child: CustomQuillEditor(
                configurations: QuillEditorConfigurations(
                  sharedConfigurations:
                      QuillSharedConfigurations(locale: Locale('en', 'US')),
                  controller: quillController,
                  readOnly: _isReadOnly,
                ),
                scrollController: _editorScrollController,
                focusNode: _editorFocusNode,
              ),
            ),
          ),
          // if (_images != null)
          //   Container(
          //     height: 100,
          //     child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: _images!.length,
          //       itemBuilder: (context, index) {
          //         return Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Image.file(
          //             File(_images![index].path),
          //             height: 80,
          //             width: 80,
          //             fit: BoxFit.cover,
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          ElevatedButton(
            onPressed: _pickImages,
            child: const Text('Pick Images'),
          ),
        ],
      ),
    );
  }
}

// QuillSharedConfigurations get _sharedConfigurations {
//     return const QuillSharedConfigurations(
//       // locale: Locale('en'),
//       extraConfigurations: {
//         QuillSharedExtensionsConfigurations.key:
//             QuillSharedExtensionsConfigurations(
//           assetsPrefix: 'assets', // Defaults to assets
//         ),
//       },
//     );
//   }
