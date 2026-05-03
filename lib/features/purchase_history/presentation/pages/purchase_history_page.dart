import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/constants/app_sizes.dart';
import 'package:hdi_mini_test/core/di/injection.dart';
import 'package:hdi_mini_test/core/extensions/colors_extension.dart';
import 'package:hdi_mini_test/core/extensions/refresher_extension.dart';
import 'package:hdi_mini_test/core/widgets/app_loading.dart';
import 'package:hdi_mini_test/core/widgets/app_refresher.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/transaction_entity.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_history_bloc.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_history_event.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_filter_bloc.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_filter_event.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/widgets/filter_bar.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/widgets/transaction_section.dart';

class PurchaseHistoryPage extends StatefulWidget {
  const PurchaseHistoryPage({super.key});

  @override
  State<PurchaseHistoryPage> createState() => _PurchaseHistoryPageState();
}

class _PurchaseHistoryPageState extends State<PurchaseHistoryPage> {
  final EasyRefreshController refreshController = EasyRefreshController();
  final purchaseBloc = di<PurchaseHistoryBloc>();
  final filterBloc = di<PurchaseFilterBloc>();

  @override
  void initState() {
    super.initState();
    filterBloc.add(PurchaseFilterLoadStarted());
    purchaseBloc.add(const PurchaseHistoryFetch());
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: purchaseBloc,
      listener: (_, state) {
        if(state is! Loading) refreshController.stopRefresh();
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.all(LayoutSize.pMedium),
            child: Column(
              children: [
                FilterBar(
                  filterBloc: filterBloc,
                  onChanged: (params) {
                    purchaseBloc.add(PurchaseHistoryFetch(params: params));
                  },
                ),

                Flexible(
                  child: BlocBuilder<PurchaseHistoryBloc, GeneralState<List<TransactionEntity>>>(
                    bloc: purchaseBloc,
                    builder: (context, state) => AppRefresher(
                      controller: refreshController,
                      onRefresh: ()=> purchaseBloc.add(PurchaseHistoryFetch()),
                      child: TransactionSection(
                        state: state,
                        onRetry: () => purchaseBloc.add(const PurchaseHistoryFetch()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Loading UI Overlay
          BlocBuilder<PurchaseHistoryBloc, GeneralState<List<TransactionEntity>>>(
            bloc: purchaseBloc,
            builder: (context, state) {
              switch (state) {
                case Initial<List<TransactionEntity>>():
                case Loading<List<TransactionEntity>>():
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpa(0.5),
                    child: Center(
                      child: AppLoading.withBackground(),
                    ),
                  );
                default:
                  return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
