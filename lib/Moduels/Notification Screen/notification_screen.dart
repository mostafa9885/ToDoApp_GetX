
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todowithgetx/Shared/Style/Icon%20Broken/icon_broken.dart';
import 'package:todowithgetx/Shared/Style/Theme/theme_class.dart';

class NotificationScreen extends StatefulWidget {

  final String text;

  const NotificationScreen({Key? key, required this.text}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  String _text = '';

  @override
  void initState() {
    // TODO: implement initState
    _text = widget.text;
  }


  String OpenSansFamily = 'OpenSans';
  String QuicksandFamily = 'Quicksand';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()
          {
            Get.back();
            print('back');
          },
          icon: Icon(IconBroken.arrowLeft2),
        ),
        title: Text(
          'Notification',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
        ),
        actions:
        [
          IconButton(
            onPressed: ()
            {
              ThemeServices().switchThemeMode();
            },
            icon: Icon(
                Icons.brightness_4_outlined,
            ),
          ),
        ],
        titleSpacing: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children:
              [
                Text(
                  'Hello',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    fontFamily: QuicksandFamily,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You have a new reminder',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: QuicksandFamily,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                  color: Color(0xFFF94F4F),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Icon(
                                IconBroken.paper,
                                color: Colors.white,
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                'Title: ${_text.toString().split('|')[0]}',
                                style: TextStyle(
                                  fontFamily: QuicksandFamily,
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Icon(
                              IconBroken.moreCircle,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                'Description: ${_text.toString().split('|')[1]}',
                                style: TextStyle(
                                  fontFamily: QuicksandFamily,
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 20,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Icon(
                              IconBroken.calendar,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                'Date: ${_text.toString().split('|')[2]}',
                                style: TextStyle(
                                  fontFamily: QuicksandFamily,
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 20,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
