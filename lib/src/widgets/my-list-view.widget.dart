import 'package:flutter/material.dart';
import 'package:flutter_covid_app/src/models/prevention_info.dart';
import 'package:flutter_covid_app/src/models/preventions_info.dart';

class MyListViewWidget extends StatelessWidget {
  final PreventionsInfo items;

  MyListViewWidget({ @required this.items });

  @override
  Widget build(BuildContext context) {
    return _getListView();
  }

  Widget _getListView() {
    return ListView.separated(
      padding: EdgeInsets.all(10.0),
      itemCount: items.data.length,
      itemBuilder: (BuildContext context, int index) {
        var item = items.data[index];
        return _getListItem(context, item);
      }, 
      separatorBuilder: (BuildContext context, int index) {  
        return const Divider();
      },
    );
  }

  Widget _getListItem(BuildContext context, PreventionInfo preventionInfo) {
    var _listItem = Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 150,
      child: Card(
        color: Color.fromRGBO(45, 47, 57, 1.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10.0),
            ClipRRect(
              child: FadeInImage(
                placeholder: AssetImage('assets/img/default-image.png'), 
                image: AssetImage(preventionInfo.iconPath.toString()),
                fit: BoxFit.cover,
                height: 70.0
              )
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(preventionInfo.title, style: TextStyle(color: Colors.white, fontSize: 18), maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.justify),
                  Text(preventionInfo.description, style: TextStyle(color: Colors.white54, fontSize: 15), maxLines: 5, overflow: TextOverflow.ellipsis, textAlign: TextAlign.justify)
                ]
              )
            ),
            SizedBox(width: 10.0)
          ]
        )
      )
    );

    return GestureDetector(
      child: _listItem,
      onTap: () {
        print(preventionInfo.title);
      },
    );
  }
}