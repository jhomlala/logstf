import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logstf/bloc/report_bloc.dart';
import 'package:logstf/model/player.dart';
import 'package:logstf/widget/progress_bar.dart';

class ReportGeneratorView extends StatefulWidget {
  final Player player;
  final String steamId64;

  const ReportGeneratorView({Key key, this.player, this.steamId64})
      : super(key: key);

  @override
  _ReportGeneratorViewState createState() => _ReportGeneratorViewState();
}

class _ReportGeneratorViewState extends State<ReportGeneratorView> {
  @override
  void initState() {
    reportBloc.startReportCollector(widget.steamId64);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple,
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
              stream: reportBloc.statusSubject,
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  int status = snapshot.data;
                  List<Widget> widgets = List();
                  if (status == 1){
                    widgets.add(Text("Loading logs"));
                  }
                  if (status == 2){
                    widgets.add(StreamBuilder(stream: reportBloc.logsSelectedCount, builder: (context,snapshot){
                      if (snapshot.hasData){
                        return Text("Downloading logs: " + snapshot.data.toString() + "/ " + reportBloc.shortLogs.length.toString());
                      } else{
                        return Container(height: 0,width: 0,);
                      }
                    },));
                  }


                  widgets.add(ProgressBar());
                  return Column(children: widgets,);
                } else {
                  return ProgressBar();
                }
              }));



  }
}
