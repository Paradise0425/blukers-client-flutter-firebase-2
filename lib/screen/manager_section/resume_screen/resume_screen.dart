import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/common_loader.dart';
import 'package:blukers_client_app/utils/app_style.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:blukers_client_app/utils/color_res.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({Key? key}) : super(key: key);

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  var args = Get.arguments;
  // PDFViewController? _pdfViewController;
  String remotePDFpath = "";
  bool loader = false;

  //var docFile;
  int? pages = 0;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
    if (kDebugMode) {
      print(remotePDFpath);
    }
  }

  Future<File> createFileOfPdfUrl() async {
    loader = true;
    Completer<File> completer = Completer();
    if (kDebugMode) {
      print("Start download file from internet!");
    }
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      var url = args['doc'];
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      if (kDebugMode) {
        print("Download files");
      }
      if (kDebugMode) {
        print("${dir.path}/$filename");
      }
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      loader = false;
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    //docFile = DefaultCacheManager().getSingleFile("https://firebasestorage.googleapis.com/v0/b/jobseek-5275d.appspot.com/o/files%2FDocument%20from%20Jyot%20Vavadiya?alt=media&token=e8da4c45-8050-4022-bc4d-32b6b6703634");
    return Scaffold(
      backgroundColor: ColorRes.black,
      body: loader == true
          ? const Center(
              child: CommonLoader(),
            )
          : Stack(
              children: <Widget>[
                Container(
                  height: Get.height,
                  width: Get.width,
                  color: ColorRes.black,
                ),
                Positioned(
                  top: 50,
                  child: SizedBox(
                    height: 600,
                    width: Get.width,
                    child: PDFView(
                      filePath: remotePDFpath,
                      enableSwipe: true,
                      swipeHorizontal: true,
                      autoSpacing: false,
                      pageFling: true,
                      pageSnap: true,
                      defaultPage: currentPage!,
                      fitPolicy: FitPolicy.BOTH,
                      preventLinkNavigation: false,
                      // if set to true the link is handled in flutter
                      onRender: (pages) {
                        setState(() {
                          pages = pages;
                          isReady = true;
                        });
                      },
                      onError: (error) {
                        setState(() {
                          errorMessage = error.toString();
                        });
                        if (kDebugMode) {
                          print(error.toString());
                        }
                      },
                      onPageError: (page, error) {
                        setState(() {
                          errorMessage = '$page: ${error.toString()}';
                        });
                        if (kDebugMode) {
                          print('$page: ${error.toString()}');
                        }
                      },
                      onViewCreated: (PDFViewController pdfViewController) {
                        _controller.complete(pdfViewController);
                      },
                      onLinkHandler: (String? uri) {
                        if (kDebugMode) {
                          print('goto uri: $uri');
                        }
                      },
                      onPageChanged: (int? page, int? total) {
                        if (kDebugMode) {
                          print('page change: $page/$total');
                        }
                        setState(() {
                          currentPage = page;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 150,
                  child: Center(
                    child: Text(
                      "seeResume".tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: ColorRes.white),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width - 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorRes.blukersOrangeColor,
                        // gradient: const LinearGradient(colors: [
                        //   ColorRes.gradientColor,
                        //   ColorRes.containerColor
                        // ]),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              color: ColorRes.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              Strings.back,
                              style: appTextStyle(
                                  color: ColorRes.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                errorMessage.isEmpty
                    ? !isReady
                        ? const Center(
                            child: CommonLoader(),
                          )
                        : const SizedBox()
                    : Center(
                        child: Text(errorMessage),
                      ),
              ],
            ),
    );
  }
}
