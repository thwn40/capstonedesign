import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공지사항')),
      body: Text('포인트기능 추가'),
    );
  }
}


// Future<void> main() async{
 
//   return runApp(
      



// // class Func2 extends StatefulWidget {
// //   @override
//   _Func2State createState() => _Func2State();
// }

// class _Func2State extends State<Func2> {
//   TextEditingController _ct;
//   @override
//   void initState() {
//     this._ct = new TextEditingController(text: "");
//     super.initState();
//   }
//   @override
//   void dispose() {
//     this._ct?.dispose();
//     super.dispose();
//   }
//   LocalProvider _localProvider;
//   @override
//   Widget build(BuildContext context) {
//     this._localProvider = Provider.of<LocalProvider>(context);
//     return this._ct == null
//       ? Container()
//       : Scaffold(
//           appBar: AppBar(title: Text("주소 및 좌표 검색 _ KakaO"),),
//           body: Center(
//             child: Container(
//               padding: EdgeInsets.all(20.0),
//               child: TextField(
//                 controller: this._ct,
//               ),
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             child: Icon(Icons.search),
//             onPressed: () async{
//               await _localProvider.search(searchData: _ct.text);
//               _ct.text = "";
//               await Navigator.of(context).push(
//                 MaterialPageRoute(
//                   settings: RouteSettings(
//                     name: '/kakaoAddress'
//                   ),
//                   builder: (BuildContext context) => SearchPage()
//                 )
//               );
//               return;
//             },
//           ),
//         );
//   }
// }
// class SearchPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     LocalProvider _local = Provider.of<LocalProvider>(context);
//     _local.data ??= [];
//     return Scaffold(
//       appBar: AppBar(title: Text("검색 결과"),),
//       body: (_local._data == null || _local.data.isEmpty)
//         ? Container()
//         : ListView.builder(
//         itemCount: int.parse(_local.data['meta']['total_count'].toString()),
//         itemBuilder: (BuildContext context, int index) => ListTile(
//           title: Text(_local.data['documents'][index]['address_name'].toString()),
//           subtitle: Text("x: ${_local.data['documents'][index]['x'].toString()} , y: ${_local.data['documents'][index]['y'].toString()}"),
//           onTap: (){},
//         )
//       ),
//     );
//   }
// }