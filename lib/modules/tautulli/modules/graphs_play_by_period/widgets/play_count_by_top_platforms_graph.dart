import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliGraphsPlayCountByTopPlatformsGraph extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Selector<TautulliState, Future<TautulliGraphData>>(
        selector: (_, state) => state.playCountByTopPlatformsGraph,
        builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<TautulliGraphData> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger().error('Unable to fetch Tautulli graph data: getPlaysByTopTenPlatforms', snapshot.error, StackTrace.current);
                    }
                    return TautulliGraphHelper.errorContainer;
                }
                if(snapshot.hasData) return _graph(context, snapshot.data);
                return TautulliGraphHelper.loadingContainer;
            },
        ),
    );

    Widget _graph(BuildContext context, TautulliGraphData data) {
        return LSCard(
            child: Column(
                children: [
                    Container(
                        height: TautulliGraphHelper.GRAPH_HEIGHT,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            child: BarChart(
                                BarChartData(
                                    alignment: TautulliGraphHelper.chartAlignment(),
                                    gridData: TautulliGraphHelper.gridData(),
                                    titlesData: TautulliGraphHelper.titlesData(data),
                                    borderData: TautulliGraphHelper.borderData(),
                                    barGroups: TautulliBarGraphHelper.barGroups(context, data),
                                    barTouchData: TautulliBarGraphHelper.barTouchData(context, data),
                                ),
                            ),
                            padding: EdgeInsets.all(14.0),
                        ),
                    ),
                    TautulliGraphHelper.createLegend(data.series),
                ],
            ),
        );
    }
}
