import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../providers/murls_item.dart';
import '../providers/murls_items.dart';
import 'package:murls/utilities/styles.dart';

class addUrls extends StatefulWidget {
  // const addUrls({Key? key}) : super(key: key);
  static const routeName = '/add-urls';
  final String? urlid;
  const addUrls({Key? key, this.urlid}) : super(key: key);

  @override
  _addUrlsState createState() => _addUrlsState();
}

class _addUrlsState extends State<addUrls> {
  final _form = GlobalKey<FormState>();
  final _URLSFocusNode = FocusNode();

  final _UrlController = TextEditingController();
  String selectdate = '';
  bool status = false;
  DateTime pickdate = DateTime.now();
  Color _favIconColor = Colors.grey;

  var _create_urls = Murls(
    Alias: '',
    murlsUrl: '',
    Expirydatetime: '',
    click: 0,
    Id: '',
    boost: false,
    Createddatetime: DateTime.now().toIso8601String(),
    UserURl: '',
  );
  var _initValues = {
    'Alias': '',
    'murlsUrl': '',
    'datetime': '',
    'click': '',
    'boost': '',
  };
  var _isInit = true;
  var _isLoading = false;
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
        selectdate = pickedDate.toIso8601String();
        pickdate = pickedDate;
      });
    });
  }

  void didChangeDependencies() {
    if (_isInit) {
      final urlid = widget.urlid == null ? '' : widget.urlid;

      if (urlid != '') {
        _create_urls =
            Provider.of<murls_detail>(context, listen: false).findById(urlid!);

        _initValues = {
          'Alias': _create_urls.Alias,
          'datetime': _create_urls.Expirydatetime,
          'click': _create_urls.click.toString(),
          'boost': _create_urls.boost.toString(),
          'murlsUrl': '',
        };
        status = _create_urls.boost;
        selectdate = _create_urls.Expirydatetime.toString();
        pickdate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(selectdate);

        _UrlController.text = _create_urls.murlsUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void dispose() {
    _URLSFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_create_urls.Id != '') {
      try {
        await Provider.of<murls_detail>(context, listen: false)
            .updateUrls(_create_urls.Id, _create_urls);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('okay'),
              )
            ],
          ),
        );
      }
    } else {
      try {
        await Provider.of<murls_detail>(context, listen: false)
            .addUrls(_create_urls);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('okay'),
              )
            ],
          ),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                              initialValue: _initValues['Alias'],
                              decoration: kalaisdecor,
                              textInputAction: TextInputAction.next,
                              //controller: _UrlController,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_URLSFocusNode);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _create_urls = Murls(
                                  Alias: value!.toLowerCase().toString(),
                                  murlsUrl: _create_urls.murlsUrl,
                                  Expirydatetime: _create_urls.Expirydatetime,
                                  click: _create_urls.click,
                                  Id: _create_urls.Id,
                                  boost: _create_urls.boost,
                                  Createddatetime: _create_urls.Createddatetime,
                                  UserURl: _create_urls.UserURl,
                                );
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              // initialValue: _initValues['murlsUrl'],
                              decoration: kurlsdecor,
                              focusNode: _URLSFocusNode,
                              controller: _UrlController,
                              keyboardType: TextInputType.url,
                              onFieldSubmitted: (_) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter urls URL.';
                                }
                                if (!value.startsWith(RegExp('http')) &&
                                    !value.startsWith(RegExp('https'))) {
                                  return 'Please enter a valid URL.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _create_urls = Murls(
                                  Alias: _create_urls.Alias,
                                  murlsUrl: value.toString(),
                                  Expirydatetime: _create_urls.Expirydatetime,
                                  click: _create_urls.click,
                                  Id: _create_urls.Id,
                                  boost: _create_urls.boost,
                                  Createddatetime: _create_urls.Createddatetime,
                                  UserURl: _create_urls.UserURl,
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 35,
                                      width: 145,
                                      child: OutlineButton(
                                        child: Text(
                                          status ? 'BOOSTED' : 'BOOST',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(
                                            () {
                                              if (status == false) {
                                                //  _favIconColor = Colors.brown;
                                                status = true;
                                              } else {
                                                // _favIconColor = Colors.grey;
                                                status = false;
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: OutlinedButton(
                                        onPressed: () => presentdatepicker(),
                                        child: Text(
                                          selectdate == ''
                                              ? 'Expiry Date'
                                              : '${DateFormat.yMd().format(pickdate)}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            ElevatedButton(
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
                                  Expirydatetime: selectdate,
                                  click: _create_urls.click,
                                  Id: _create_urls.Id,
                                  boost: status,
                                  Createddatetime: _create_urls.Createddatetime,
                                  UserURl: _create_urls.UserURl,
                                );

                                _saveForm();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom + 10),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
    );
  }
}
