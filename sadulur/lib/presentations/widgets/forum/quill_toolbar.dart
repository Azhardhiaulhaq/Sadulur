import 'dart:io' as io show File;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class CustomQuillToolbar extends StatelessWidget {
  const CustomQuillToolbar({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final QuillController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    //   return QuillToolbar(
    //     configurations: const QuillToolbarConfigurations(),
    //     child: SingleChildScrollView(
    //         scrollDirection: Axis.horizontal,
    //         child: Wrap(
    //           children: [
    //             QuillToolbarHistoryButton(
    //               isUndo: true,
    //               controller: controller,
    //             ),
    //             QuillToolbarHistoryButton(
    //               isUndo: false,
    //               controller: controller,
    //             ),
    //             QuillToolbarToggleStyleButton(
    //               options: const QuillToolbarToggleStyleButtonOptions(),
    //               controller: controller,
    //               attribute: Attribute.bold,
    //             ),
    //             QuillToolbarToggleStyleButton(
    //               options: const QuillToolbarToggleStyleButtonOptions(),
    //               controller: controller,
    //               attribute: Attribute.italic,
    //             ),
    //             QuillToolbarToggleStyleButton(
    //               controller: controller,
    //               attribute: Attribute.underline,
    //             ),
    //             QuillToolbarClearFormatButton(
    //               controller: controller,
    //             ),
    //             const VerticalDivider(),
    //             // QuillToolbarImageButton(
    //             //   controller: controller,
    //             // ),
    //             // QuillToolbarCameraButton(
    //             //   controller: controller,
    //             // ),
    //             // QuillToolbarVideoButton(
    //             //   controller: controller,
    //             // ),
    //             const VerticalDivider(),
    //             QuillToolbarColorButton(
    //               controller: controller,
    //               isBackground: false,
    //             ),
    //             QuillToolbarColorButton(
    //               controller: controller,
    //               isBackground: true,
    //             ),
    //             const VerticalDivider(),
    //             QuillToolbarSelectHeaderStyleDropdownButton(
    //               controller: controller,
    //             ),
    //             const VerticalDivider(),
    //             QuillToolbarToggleCheckListButton(
    //               controller: controller,
    //             ),
    //             QuillToolbarToggleStyleButton(
    //               controller: controller,
    //               attribute: Attribute.ol,
    //             ),
    //             QuillToolbarToggleStyleButton(
    //               controller: controller,
    //               attribute: Attribute.ul,
    //             ),
    //             QuillToolbarToggleStyleButton(
    //               controller: controller,
    //               attribute: Attribute.inlineCode,
    //             ),
    //             QuillToolbarToggleStyleButton(
    //               controller: controller,
    //               attribute: Attribute.blockQuote,
    //             ),
    //             QuillToolbarIndentButton(
    //               controller: controller,
    //               isIncrease: true,
    //             ),
    //             QuillToolbarIndentButton(
    //               controller: controller,
    //               isIncrease: false,
    //             ),
    //             const VerticalDivider(),
    //             QuillToolbarLinkStyleButton(controller: controller),
    //           ],
    //         )),
    //   );
    // }

    return QuillToolbar.simple(
        configurations: QuillSimpleToolbarConfigurations(
            controller: controller,
            showAlignmentButtons: true,
            multiRowsDisplay: false,
            showSmallButton: true,
            buttonOptions: QuillSimpleToolbarButtonOptions(
              base: QuillToolbarBaseButtonOptions(
                // Request editor focus when any button is pressed
                afterButtonPressed: focusNode.requestFocus,
                globalIconSize: 14,
              ),
              selectHeaderStyleDropdownButton:
                  const QuillToolbarSelectHeaderStyleDropdownButtonOptions(
                textStyle: TextStyle(
                  fontSize: 14,
                ),
                // iconTheme: QuillIconTheme(
                //   iconSelectedColor: Colors.red,
                // ),
              ),
            )));
  }
}
