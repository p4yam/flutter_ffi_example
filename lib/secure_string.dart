import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';


class SecureString extends StatefulWidget {
  const SecureString({Key key}) : super(key: key);

  @override
  _SecureStringState createState() => _SecureStringState();
}

class _SecureStringState extends State<SecureString> {

  String _apiKey ='';

  @override
  initState(){
    _getData();
    super.initState();
  }

_getData(){
  final DynamicLibrary nativeAddLib = Platform.isAndroid
      ? DynamicLibrary.open("libapi_util.so")
      : DynamicLibrary.process();

  final apiPointer =
  nativeAddLib.lookup<NativeFunction<Pointer<Utf8> Function()>>('get_api');

  final apiFunction = apiPointer.asFunction<Pointer<Utf8> Function()>();
  _apiKey = Utf8.fromUtf8(apiFunction());
  setState(() {
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter FFI Example'),
      ),
      body: Center(
        child: Text(_apiKey),
      ),
    );
  }
}