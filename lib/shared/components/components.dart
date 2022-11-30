import 'package:flutter/material.dart';
import 'package:untitled1/modules/cubit/app%20cubit/app%20cubit.dart';
import 'package:untitled1/modules/news%20app/web%20view/web%20view%20screen.dart';

Widget words({
  String? name,
  Color? color,
}) =>
    Text(
      "$name",
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );

Widget square({
  Color? colorOfBox,
  String? image,
  String? name,
  Color? colorOfWord,
}) =>
    Container(
      width: 170,
      height: 180,
      padding: EdgeInsetsDirectional.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorOfBox,
      ),
      child: Column(
        children: [
          Image(
            image: AssetImage("$image"),
            color: Colors.white,
            height: 90,
            width: 90,
          ),
          SizedBox(
            height: 15,
          ),
          words(name: name, color: colorOfWord),
        ],
      ),
    );

Widget square2({
  int? num,
  String? name,
  Function()? addFunction,
  Function()? removeFunction,
}) =>
    Container(
      width: 170,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          words(color: Colors.black, name: "${name}"),
          words(color: Colors.black, name: "${num}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: addFunction,
                child: Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
                backgroundColor: Colors.black,
                mini: true,
              ),
              FloatingActionButton(
                onPressed: removeFunction,
                child: Icon(
                  Icons.remove,
                  color: Colors.grey,
                ),
                backgroundColor: Colors.black,
                mini: true,
              ),
            ],
          ),
        ],
      ),
    );

Widget smallText({
  String? name,
  Color? color,
}) =>
    Text(
      '$name',
      style: TextStyle(
        color: color,
      ),
      textAlign: TextAlign.left,
    );

Widget tasksItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDatabase(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.blue,
              child: Text(
                "${model['time']}",
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model['data']}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${model['title']}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateDatabase(
                  id: model['id'],
                  status: 'done',
                );
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateDatabase(
                  id: model['id'],
                  status: 'archived',
                );
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );

Widget itemBuilder(List<Map> tasks) {
  if (tasks.length > 0) {
    return ListView.separated(
      itemBuilder: (context, index) => tasksItem(tasks[index], context),
      separatorBuilder: (context, index) => Container(
        height: 1,
        color: Colors.grey,
      ),
      itemCount: tasks.length,
    );
  } else
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'please add new tasks ',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
}

Widget defaultTextFormedFailed({
  IconData? icon,
  String? name,
  TextInputType? type,
  Function()? onTap,
  TextEditingController? controller,
  FormFieldValidator<String>? validate,
  var onChange,
}) {
  return TextFormField(
    controller: controller,
    onTap: onTap,
    keyboardType: type,
    validator: validate,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      labelText: name,
      border: OutlineInputBorder(),
    ),
    onChanged: onChange,
  );
}
Future navigateTo(context , screen){
  return Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
Widget newsItem(items, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(items['url']));
      },
      child: Container(
        height: 120,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage("${items['urlToImage']}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${items['title']}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${items['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Divider(
      color: Colors.grey,
      thickness: 1,
    );

Widget listOfGetInfo(List<dynamic> list) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => InkWell(
        onTap: () {},
        child: newsItem(
          list[index],
          context,
        )),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: list.length,
);
