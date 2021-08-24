import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:murls/providers/murls_items.dart';
import 'package:provider/provider.dart';
import 'package:murls/utilities/styles.dart';
import '../widgets/graph.dart';

class url_detail extends StatelessWidget {
  const url_detail({Key? key}) : super(key: key);

  static const routeName = '/urls-Detail';
  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    final islansacpe =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final urlid = ModalRoute.of(context)!.settings.arguments as String;
    final loadedUrl = Provider.of<murls_detail>(
      context,
      listen: false,
    ).findById(urlid);

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(loadedUrl.Alias),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // decoration: kcontainerboxdecor,
        child: Column(
          children: <Widget>[
            if (!islansacpe)
              Container(
                color: const Color(0xff81e5cd),
                height: 300,
                width: double.infinity,
                child: BarChartSample1(),
              ),
            SizedBox(height: 10),
            GestureDetector(
              child: Text(
                'URL == ${loadedUrl.murlsUrl}',
                style: TextStyle(
                  color: Color(0xff81e5cd),
                  fontSize: 20,
                ),
              ),
              onLongPress: () {
                Clipboard.setData(
                  new ClipboardData(text: '${loadedUrl.murlsUrl}'),
                );
                key.currentState!.showSnackBar(
                  new SnackBar(
                    content: new Text("Copied to Clipboard"),
                  ),
                );
              },
            ),
            // Text(
            //   'URL == ${loadedUrl.murlsUrl}',
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 20,
            //   ),
            // ),
            SizedBox(
              height: 10,
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
            )
          ],
        ),
      ),
    );
  }
}
