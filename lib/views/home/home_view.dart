import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit.dart';
import 'home_state.dart';
import 'widgets/logo_card.dart';
import 'widgets/tiles_grid.dart';

const _logoMinVerticalSpace = 140.0;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markup Test'),
        actions: [
          IconButton(
            onPressed: () => context.read<HomeCubit>().removeItem(),
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: () => context.read<HomeCubit>().addItem(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                const logoWidget = LogoCard();
                final tilesWidget = TilesGrid(items: state.items);

                if (state.items.isEmpty) {
                  return const Center(child: logoWidget);
                }

                final tileRowCount =
                    (state.items.length / gridColumns).ceil();
                final tileWidth =
                    (constraints.maxWidth -
                        gridPadding * 2 -
                        gridSpacing * (gridColumns - 1)) /
                    gridColumns;
                final tileHeight = tileWidth / tileAspectRatio;
                final tilesHeight =
                    gridPadding * 2 +
                    tileRowCount * tileHeight +
                    (tileRowCount - 1) * gridSpacing;

                final fitsInScreen =
                    tilesHeight + _logoMinVerticalSpace <=
                    constraints.maxHeight;

                if (fitsInScreen) {
                  return Column(
                    children: [
                      const Expanded(
                        child: Center(child: logoWidget),
                      ),
                      tilesWidget,
                    ],
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: logoWidget,
                      ),
                      tilesWidget,
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
