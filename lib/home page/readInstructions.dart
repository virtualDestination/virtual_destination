import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfViewer extends StatefulWidget {
  @override
  _pdfViewerState createState() => _pdfViewerState();
}

class _pdfViewerState extends State<pdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SfPdfViewer.asset('assets/pdfs/instructions.pdf',
        canShowScrollStatus: true,enableDoubleTapZooming: true,initialZoomLevel: 1.00,
      enableTextSelection: true,),
    );
  }
}
