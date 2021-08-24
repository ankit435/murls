import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/murls_item.dart';
import '../providers/murls_items.dart';
import 'package:murls/utilities/styles.dart';
import 'package:uuid/uuid.dart';

class addUrls extends StatefulWidget {
  const addUrls({Key? key}) : super(key: key);
  static const routeName = '/add-urls';

  @override
  _addUrlsState createState() => _addUrlsState();
}

class _addUrlsState extends State<addUrls> {
  final _form = GlobalKey<FormState>();
  final _URLSFocusNode = FocusNode();
  String selectdate = '';
  bool status = false;
  DateTime pickdate = DateTime.now();

  var _create_urls = Murls(
    Alias: '',
    murlsUrl: '',
    datetime: '',
    click: 0,
    Id: Uuid().v4(),
    boost: false,
  );
  // void dispose() {
  //   _URLSFocusNode.dispose();
  // }

  void presentdatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectdate = pickedDate.toString();
        pickdate = pickedDate;
      });
    });
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    Provider.of<murls_detail>(context, listen: false).addUrls(_create_urls);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Form(
              key: _form,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autofocus: true,
                      //decoration: InputDecoration(hintText: 'Alias'),
                      decoration: kalaisdecor,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_URLSFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _create_urls = Murls(
                          Alias: value.toString(),
                          murlsUrl: _create_urls.murlsUrl,
                          datetime: _create_urls.datetime,
                          click: _create_urls.click,
                          Id: _create_urls.Id,
                          boost: _create_urls.boost,
                        );
                      },
                    ),
                    TextFormField(
                      // decoration: InputDecoration(hintText: 'URlS'),
                      decoration: kurlsdecor,
                      onFieldSubmitted: (_) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _create_urls = Murls(
                          Alias: _create_urls.Alias,
                          murlsUrl: value.toString(),
                          datetime: _create_urls.datetime,
                          click: _create_urls.click,
                          Id: _create_urls.Id,
                          boost: _create_urls.boost,
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlutterSwitch(
                              width: 100.0,
                              height: 55.0,
                              valueFontSize: 25.0,
                              toggleSize: 45.0,
                              value: status,
                              borderRadius: 30.0,
                              padding: 8.0,
                              activeColor: Colors.brown,
                              showOnOff: true,
                              onToggle: (value) {
                                setState(() {
                                  status = value;
                                });
                                _create_urls = Murls(
                                  Alias: _create_urls.Alias,
                                  murlsUrl: _create_urls.murlsUrl,
                                  datetime: _create_urls.datetime,
                                  click: _create_urls.click,
                                  Id: _create_urls.Id,
                                  boost: status,
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Card(
                                color: Colors.brown,
                                child: ElevatedButton(
                                  //textColor: Theme.of(context).primaryColor,
                                  style: kelevated,
                                  onPressed: () => presentdatepicker(),
                                  child: Text(
                                    selectdate == ''
                                        ? 'Expiry Date'
                                        : '${DateFormat.yMd().format(pickdate)}',
                                    // : '${DateFormat("yyyy-MM-dd hh:mm:ss").parse(selectdate)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Card(
                      color: Colors.brown,
                      child: ElevatedButton(
                        //style: style,
                        style: kelevated,
                        child: Text(
                          'Create Urls',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          _create_urls = Murls(
                            Alias: _create_urls.Alias,
                            murlsUrl: _create_urls.murlsUrl,
                            datetime: selectdate,
                            click: _create_urls.click,
                            Id: _create_urls.Id,
                            boost: status,
                          );

                          _saveForm();
                        },
                      ),
                    )
                  ],
                ),
              ),

              //   ),
            ),

////////////////////////////////////////////////////

            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
