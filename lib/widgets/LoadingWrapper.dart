import 'package:flutter/material.dart';

class LoadingWrapper extends StatelessWidget {
  bool isLoading;
  Widget child;

  LoadingWrapper ({Key key, this.isLoading, this.child}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,

        //Loading circle
        !isLoading? SizedBox():
        Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        )
      ],
    );
  }


}
