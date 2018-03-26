import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_list_drag_and_drop/my_draggable.dart';


class MyApp2 extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp2> {


  final double _kHeight = 70.0;

  final double _kScrollThreashhold = 80.0;

  bool shouldScrollUp = false;
  bool shouldScrollDown = false;

  ScrollController scrollController = new ScrollController();

  List<Data> rows = new List<Data>()
    ..add(new Data('0'))
    ..add(new Data('1'))
    ..add(new Data('2'))
    ..add(new Data('3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsd3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsd3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsffsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsffsdfsdfsdfsdfsdfsdfdsf'))
    ..add(new Data('3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsd3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsd3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsffsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsffsdfsdfsdfsdfsdfsdfdsf'))
    ..add(new Data('3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsd3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsd3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsffsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsffsdfsdfsdfsdfsdfsdfdsf'))
    ..add(new Data('3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsd3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsd3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsffsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsf3ffffffffffffffffffsdfsdfsdfsdfsdfsdfsdfsdfsdfdsffsdfsdfsdfsdfsdfsdfdsf'))
    //..add(new Data('3'))
    ..add(new Data('4'))
    ..add(new Data('5'));
  /*  ..add('7')
    ..add('8')
    ..add('9')
    ..add('10')
    ..add('11')
    ..add('12')
    ..add('13')
    ..add('14')
    ..add('15')
    ..add('16')
    ..add('17')
    ..add('18')
    ..add('19')
    ..add('20');*/


  double dragHeight;

  @override
  void initState() {
    super.initState();


  }

  bool isScrolling = false;

  void _maybeScroll() {
    if(isScrolling) return;
    if(shouldScrollUp) {
      isScrolling = true;
      var scrollTo = scrollController.offset - 50.0;
      scrollController.animateTo(
          scrollTo, duration: new Duration(milliseconds: 250),
          curve: Curves.linear).then((it) {
        isScrolling = false;
        _maybeScroll();
      });
    }
    if(shouldScrollDown) {
      isScrolling = true;
      var scrollTo = scrollController.offset + 50.0;
      scrollController.animateTo(
          scrollTo, duration: new Duration(milliseconds: 250),
          curve: Curves.linear).then((it) {
        isScrolling = false;
        _maybeScroll();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Test",
      home: new Scaffold(
        body: new ListView.builder(itemBuilder: (BuildContext context2, int index) {
            return new DraggableListItem(
              data: rows[index],
              index: index,
              draggedHeight: dragHeight,
              onDragStarted: (double draggedHeight){
                dragHeight = draggedHeight;
                print("drag started at $index");
                setState((){
                  rows.removeAt(index);
                  rows.removeAt(index);
              //    rows[index].color = Colors.white;
                  rows.insert(index, new Data(""));
                });
              },
              onDragCompleted: (){
                shouldScrollUp = false;
              },
              onAccept: (Data data) {
                //data is row coming from
                setState((){
                  rows.removeAt(index);
                  rows.insert(index, data);
                });

              },
              onLeave: (Data data) {
                if(rows[index].data != "") return;
                // Debug
                print('${data.data} is Leaving row $index');
                setState((){
                  rows.removeAt(index);
              //    rows[index].color = Colors.white;
                });

              },
              onWillAccept: (Data data) {
                if(rows[index].data == "") return false;
                // Debug
                print('$index will accept row ${data.data}');
                setState((){
               //   rows[index].color = Colors.red;
                  rows.insert(index, new Data(""));
                });

                return true;
              },
              onMove: (Offset offset){
                double screenHeight = MediaQuery.of(context2).size.height;

                if(offset.dy < _kScrollThreashhold) {
                  shouldScrollUp = true;
                } else {
                  shouldScrollUp = false;
                }
                if(offset.dy > screenHeight - _kScrollThreashhold) {
                  shouldScrollDown = true;
                } else {
                  shouldScrollDown = false;
                }
                _maybeScroll();
              },
            );
        },
          controller: scrollController,
          itemCount: rows.length,
        ),
      ),
    );

  }
}

class DraggableListItem extends StatelessWidget {



  final Data data;
  final int index;


  final double _kScrollThreashhold = 80.0;

  final double _kHeight = 70.0;


  final double draggedHeight;


  final ValueChanged<double> onDragStarted;
  final VoidCallback onDragCompleted;
  final MyDragTargetAccept<Data> onAccept;
  final MyDragTargetLeave<Data> onLeave;
  final MyDragTargetWillAccept<Data> onWillAccept;
  final ValueChanged<Offset> onMove;

  DraggableListItem({this.data, this.index, this.onDragStarted, this.onDragCompleted, this.onAccept, this.onLeave, this.onWillAccept, this.onMove, this.draggedHeight});

  @override
  Widget build(BuildContext context) {
    return new LongPressMyDraggable<Data>(
      child: _getListChild(index, context),
      feedback: _getFeedback(index, context),
      data: data,
      onMove: onMove,
      onDragStarted: (){
        RenderBox it = context.findRenderObject() as RenderBox;
        onDragStarted(it.size.height);
      },
      onDragCompleted: onDragCompleted,
    );
  }


  Widget _getActualChild() {
    return new SizedBox(
      child: new Card(
        color: data.color,
        child: new ListTile(
          title: new Text(data.data),
        ),
      ),
    );
  }


  Widget _getListChild(int index, BuildContext context) {
    return new MyDragTarget<Data>(builder: (BuildContext context, List candidateData, List rejectedData) {
      if(data.data == "") {
      //  print("returning $draggedHeight box for $index");
        return new SizedBox(height: draggedHeight,);
      }
      return _getActualChild();
    },
      onAccept: onAccept,
      onLeave: onLeave,
      onWillAccept: onWillAccept,

    );
  }

  Widget _getFeedback(int index, BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    return new ConstrainedBox(
      constraints: new BoxConstraints(maxWidth: maxWidth),
      child: new Transform(
        transform: new Matrix4.rotationZ(0.0872665),
        child: _getActualChild(),
      ),
    );
  }

}

class Data {
  final String data;
  Color color = Colors.white;

  Data(this.data, {this.color});
}