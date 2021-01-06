import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_calculator/Utils/ApiEndPoints.dart';
import 'package:time_calculator/Utils/ImagePaths.dart';
import 'package:time_calculator/Utils/Strings.dart';
import 'package:time_calculator/model/BaseTimeModel.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  var time = "";
  var isDayOrNot = ImagePaths.day;
  var color = Colors.white;
  var load = false;
  var countryName = "";

  @override
  void initState() {
    super.initState();

    load = true;

    getTime(Strings.india, ApiEndPoints.india);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(isDayOrNot),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loadingOrContent(load),
              RaisedButton.icon(
                color: Colors.green,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                icon: Icon(Icons.location_on),
                label: Text(Strings.chooseLocation),
                onPressed: () {
                  _modalBottomSheetMenu();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void getTime(String countryNames, String endpoint) async {
    var baseTimeModel =
        BaseTimeModel(location: countryNames, flag: '', endPoint: endpoint);
    await baseTimeModel.getTime();
    setState(() {
      load = false;
      time = baseTimeModel.time;
      isDayOrNot = baseTimeModel.isDayTime ? ImagePaths.day : ImagePaths.night;
      color = baseTimeModel.isDayTime ? Colors.black : Colors.white;
      countryName = baseTimeModel.location;
    });
  }

  Widget loadingOrContent(value) {
    if (value) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    } else {
      return Center(
        child: Container(
          child: Column(
            children: [
              Text(
                countryName,
                style: TextStyle(fontSize: 50.0, color: color),
              ),
              Text(
                time,
                style: TextStyle(fontSize: 50.0, color: color),
              )
            ],
          ),
        ),
      );
    }
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 500.0,
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(1.0),
                        topRight: Radius.circular(1.0))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            Strings.chooseLocation,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: IconButton(
                            icon: Icon(Icons.highlight_remove),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: getCountry().length,
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(getCountry()[index].flag),
                          ),
                          title: Text(getCountry()[index].location),
                          onTap: () {
                            setState(() {
                              load = true;
                              getTime(getCountry()[index].location,
                                  getCountry()[index].endPoint);
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  List<BaseTimeModel> getCountry() {
    List<BaseTimeModel> list = [];

    list.add(
      BaseTimeModel(
          location: Strings.india,
          endPoint: ApiEndPoints.india,
          flag: ImagePaths.india),
    );

    list.add(
      BaseTimeModel(
          location: Strings.australia,
          endPoint: ApiEndPoints.australia,
          flag: ImagePaths.australia),
    );

    list.add(
      BaseTimeModel(
          location: Strings.bangkok,
          endPoint: ApiEndPoints.bangkok,
          flag: ImagePaths.bangkok),
    );

    list.add(
      BaseTimeModel(
          location: Strings.dubai,
          endPoint: ApiEndPoints.dubai,
          flag: ImagePaths.dubai),
    );
    list.add(
      BaseTimeModel(
          location: Strings.london,
          endPoint: ApiEndPoints.london,
          flag: ImagePaths.london),
    );

    list.add(
      BaseTimeModel(
          location: Strings.moscow,
          endPoint: ApiEndPoints.moscow,
          flag: ImagePaths.moscow),
    );
    list.add(
      BaseTimeModel(
          location: Strings.newYork,
          endPoint: ApiEndPoints.newYork,
          flag: ImagePaths.newYork),
    );

    list.add(
      BaseTimeModel(
          location: Strings.paris,
          endPoint: ApiEndPoints.paris,
          flag: ImagePaths.paris),
    );
    list.add(
      BaseTimeModel(
          location: Strings.rome,
          endPoint: ApiEndPoints.rome,
          flag: ImagePaths.rome),
    );

    list.add(
      BaseTimeModel(
          location: Strings.singapore,
          endPoint: ApiEndPoints.singapore,
          flag: ImagePaths.singapore),
    );

    return list;
  }
}
