import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:murls/providers/murls_items.dart';

import 'package:provider/provider.dart';

import '../widgets/graph.dart';
import 'add_new_urls.dart';

class url_detail extends StatefulWidget {
  const url_detail({Key? key}) : super(key: key);

  static const routeName = '/urls-Detail';

  @override
  _url_detailState createState() => _url_detailState();
}

class _url_detailState extends State<url_detail> {
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
    int end = loadedUrl.murlsUrl.length < 20 ? loadedUrl.murlsUrl.length : 40;

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
        // decoration: kcontainerboxdecor,
        child: Column(
          children: <Widget>[
            Container(
              color: const Color(0xff81e5cd),
              height: 300,
              width: double.infinity,
              child: BarChartSample1(),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: ListTile(title: Text('Shorten_URL'))),
                Expanded(
                    child: GestureDetector(
                  child: ListTile(
                    title: Text('https://${loadedUrl.UserURl}'),
                  ),
                  onLongPress: () {
                    Clipboard.setData(
                      new ClipboardData(text: 'https://${loadedUrl.UserURl}'),
                    );
                    key.currentState!.showSnackBar(
                      new SnackBar(
                        content: new Text(
                          "Copied urls",
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
                Expanded(child: ListTile(title: Text('URL'))),
                Expanded(
                    child: ListTile(
                        title:
                            Text(' ${loadedUrl.murlsUrl.substring(0, end)}')))
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: ListTile(title: Text('Created Date'))),
                Expanded(
                    child: ListTile(
                        title:
                            Text(' ${DateFormat.yMd().format(createddate)}')))
                // Text('${loadedUrl.Createddatetime}'),
                //   ))
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: ListTile(title: Text('Expiry Date'))),
                Expanded(
                    child: ListTile(
                        title: Text(expirydate != null
                            ? '${DateFormat.yMd().format(expirydate)}'
                            : 'no expiry date')))
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: ListTile(title: Text('BOOST'))),
                Expanded(
                    child: ListTile(
                        title: Text(loadedUrl.boost
                            ? 'your url is boosted'
                            : 'your url not is boosted')))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
