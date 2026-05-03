import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/constants/app_sizes.dart';
import 'package:hdi_mini_test/core/di/injection.dart';
import 'package:hdi_mini_test/core/extensions/general_state_extension.dart';
import 'package:hdi_mini_test/core/extensions/refresher_extension.dart';
import 'package:hdi_mini_test/core/widgets/app_error_state_widget.dart';
import 'package:hdi_mini_test/core/widgets/app_refresher.dart';
import 'package:hdi_mini_test/features/dashboard/domain/entities/member_entity.dart';
import 'package:hdi_mini_test/features/dashboard/presentation/bloc/member_info_bloc.dart';
import 'package:hdi_mini_test/features/dashboard/presentation/bloc/member_info_event.dart';
import 'package:hdi_mini_test/features/dashboard/presentation/widgets/member_card.dart';
import 'package:hdi_mini_test/features/dashboard/presentation/widgets/membership_status_card.dart';
import 'package:hdi_mini_test/features/main_layout/presentation/routes/main_shell_route.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/entities/transaction_entity.dart';
import 'package:hdi_mini_test/features/purchase_history/domain/usecases/get_transactions_use_case.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_history_bloc.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/bloc/purchase_history_event.dart';
import 'package:hdi_mini_test/features/purchase_history/presentation/widgets/transaction_section.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );
  final memberBloc = di<MemberInfoBloc>();
  final purchaseBloc = di<PurchaseHistoryBloc>();
  bool isMemberLoading = false;
  bool isPurchaseLoading = false;

  @override
  void initState() {
    super.initState();
    memberBloc.add(GetMemberInfo());
    purchaseBloc.add(
      const PurchaseHistoryFetch(
        params: GetTransactionsParams(limit: 3),
      ),
    );
  }

  @override
  void dispose() {
    refreshController.dispose();
    memberBloc.close();
    purchaseBloc.close();
    super.dispose();
  }

  void stopRefresh() {
    if (!isMemberLoading && !isPurchaseLoading) {
      refreshController.stopRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: memberBloc,
          listener: (_, state) {
            isMemberLoading = state is Loading;
            stopRefresh();
          },
        ),
        BlocListener(
          bloc: purchaseBloc,
          listener: (_, state) {
            isPurchaseLoading = state is Loading;
            stopRefresh();
          },
        ),
      ],
      child: AppRefresher(
        controller: refreshController,
        onRefresh: () {
          memberBloc.add(GetMemberInfo());
          purchaseBloc.add(
            const PurchaseHistoryFetch(
              params: GetTransactionsParams(limit: 3),
            ),
          );
        },
        child: ListView(
          padding: const EdgeInsets.all(LayoutSize.pMedium),
          children: [
            // Member Profile Section
            BlocProvider.value(
              value: memberBloc,
              child: _MemberInfoSection(),
            ),

            const SizedBox(height: LayoutSize.pLarge),

            // Membership Status Section
            BlocProvider.value(
              value: memberBloc,
              child: _MembershipStatusSection(),
            ),

            const SizedBox(height: LayoutSize.pLarge),

            Text(
              'Dashboard Summary',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: LayoutSize.pMedium),

            // Last Transaction Section
            BlocProvider.value(
              value: purchaseBloc,
              child: _LastTransactionSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberInfoSection extends StatelessWidget {
  const _MemberInfoSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberInfoBloc, GeneralState<MemberEntity>>(
      bloc: BlocProvider.of<MemberInfoBloc>(context),
      builder: (context, state) => switch (state) {
        Initial() || Loading() => Skeletonizer(
          enabled: true,
          child: const MemberCard(),
        ),

        Success<MemberEntity>(:final data) => MemberCard(
          member: data,
        ),

        Error(:final failure) => AppErrorStateWidget(
          failure: failure,
          onRetry: () =>
              BlocProvider.of<MemberInfoBloc>(context).add(GetMemberInfo()),
        ),
      },
    );
  }
}

class _MembershipStatusSection extends StatelessWidget {
  const _MembershipStatusSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberInfoBloc, GeneralState<MemberEntity>>(
      bloc: BlocProvider.of<MemberInfoBloc>(context),
      builder: (context, state) => switch (state) {
        Initial() || Loading() => Skeletonizer(
          enabled: true,
          child: const MembershipStatusCard(),
        ),

        Error(:final failure) => AppErrorStateWidget(
          failure: failure,
          onRetry: () =>
              BlocProvider.of<MemberInfoBloc>(context).add(GetMemberInfo()),
        ),

        Success<MemberEntity>(:final data) => MembershipStatusCard(
          status: data.membershipStatus,
        ),
      },
    );
  }
}

class _LastTransactionSection extends StatelessWidget {
  const _LastTransactionSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last Transactions',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        const SizedBox(height: LayoutSize.pSmall),

        BlocBuilder<PurchaseHistoryBloc, GeneralState<List<TransactionEntity>>>(
          bloc: BlocProvider.of<PurchaseHistoryBloc>(context),
          builder: (context, state) {
            return Column(
              children: [
                TransactionSection(
                  shrinkWrap: true,
                  state: state,
                  onRetry: () =>
                      BlocProvider.of<PurchaseHistoryBloc>(context).add(
                        const PurchaseHistoryFetch(
                          params: GetTransactionsParams(limit: 3),
                        ),
                      ),
                ),

                if (state.hasData) ...[
                  const SizedBox(height: LayoutSize.pMedium),
                  Center(
                    child: TextButton(
                      onPressed: () => const PurchaseHistoryRoute().go(context),
                      child: const Text('See more'),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
