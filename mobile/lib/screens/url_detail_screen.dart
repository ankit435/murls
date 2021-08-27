import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:murls/providers/murls_items.dart';
import 'package:murls/screens/listed_url_screen.dart';
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

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(
            '${loadedUrl.Alias[0].toUpperCase()}${loadedUrl.Alias.substring(1)}'),
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
            GestureDetector(
              child: ListTile(
                title: Text(' ${loadedUrl.murlsUrl}'),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        //onPressed: () => _startAddNewUrl(context),
                        onPressed: () {
                          // Navigator.of(context).pushNamed(addUrls.routeName,
                          //     arguments: loadedUrl.Id);

                          _startAddNewUrl(context, loadedUrl.Id);
                        },
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              onLongPress: () {
                Clipboard.setData(
                  new ClipboardData(text: '${loadedUrl.murlsUrl}'),
                );
                key.currentState!.showSnackBar(
                  new SnackBar(
                    content: new Text(
                      "Copied urls",
                    ),
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Click == ${loadedUrl.click}',
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedUrl.datetime != '' ? 'Date == ${loadedUrl.datetime}' : '',
                //loadedUrl.datetime != '' ? 'Date == ${DateFormat.yMd().format(loadedUrl.datetime)}',
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                'Boost == ${loadedUrl.boost}',
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
