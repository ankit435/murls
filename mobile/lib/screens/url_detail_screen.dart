import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:murls/providers/murls_items.dart';
import 'package:murls/screens/listed_url_screen.dart';

import 'package:provider/provider.dart';

import '../widgets/graph.dart';
import 'add_new_urls.dart';
import '../utilities/styles.dart';

// ignore: camel_case_types
class url_detail extends StatefulWidget {
  const url_detail({Key? key}) : super(key: key);

  static const routeName = '/urls-Detail';

  @override
  _url_detailState createState() => _url_detailState();
}

// ignore: camel_case_types
class _url_detailState extends State<url_detail> {
  // ignore: non_constant_identifier_names
  void _startAddNewUrl(BuildContext context, String Id) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      isScrollControlled: false,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: addUrls(urlid: Id),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
  //

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    final urlid = ModalRoute.of(context)!.settings.arguments as String;

    final loadedUrl = Provider.of<murls_detail>(
      context,
      listen: false,
    ).findById(urlid);

    DateTime? expirydate = loadedUrl.Expirydatetime != ''
        ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
            .parse(loadedUrl.Expirydatetime)
        : null;
    DateTime createddate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
        .parse(loadedUrl.Createddatetime);
    int end = loadedUrl.murlsUrl.length <= 40 ? loadedUrl.murlsUrl.length : 40;

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(
            '${loadedUrl.Alias[0].toUpperCase()}${loadedUrl.Alias.substring(1)}'),
        actions: [
          IconButton(
            onPressed: () {
              _startAddNewUrl(context, loadedUrl.Id);
            },
            icon: Icon(Icons.edit),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                // color: const Color(0xff81e5cd),
                height: 250,
                width: double.infinity,
                child: LineChartSample2(urlid: loadedUrl.Id),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: ListTile(
                    title: Text(
                      'Shortened URL',
                      style: kappbartext,
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    child: ListTile(
                      title: Text('${loadedUrl.UserURl}', style: kappbartext),
                      trailing: Icon(
                        Icons.copy,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Clipboard.setData(
                        new ClipboardData(text: '${loadedUrl.UserURl}'),
                      );

                      ScaffoldMessenger.maybeOf(context)!.hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        new SnackBar(
                          content: new Text(
                            "Copied urls",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  )),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: ListTile(title: Text('URL', style: kappbartext))),
                  Expanded(
                      child: ListTile(
                          title: Text(
                              ' ${loadedUrl.murlsUrl.substring(0, end)}',
                              style: kappbartext)))
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: ListTile(
                          title: Text('Created Date', style: kappbartext))),
                  Expanded(
                      child: ListTile(
                          title: Text(
                              ' ${DateFormat.yMd().format(createddate)}',
                              style: kappbartext)))
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: ListTile(
                          title: Text('Expiry Date', style: kappbartext))),
                  Expanded(
                      child: ListTile(
                          title: Text(
                              expirydate != null
                                  ? '${DateFormat.yMd().format(expirydate)}'
                                  : 'no expiry date',
                              style: kappbartext)))
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child:
                          ListTile(title: Text('Clicks', style: kappbartext))),
                  Expanded(
                    child: ListTile(
                      title: Text('${loadedUrl.click}', style: kappbartext),
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child:
                          ListTile(title: Text('BOOST', style: kappbartext))),
                  Expanded(
                    child: ListTile(
                      title: Text(
                          loadedUrl.boost
                              ? 'your url is boosted'
                              : 'your url not is boosted',
                          style: kappbartext),
                      trailing: loadedUrl.boost
                          ? Icon(
                              Icons.bolt,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.cable_rounded,
                              color: Colors.white,
                            ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
