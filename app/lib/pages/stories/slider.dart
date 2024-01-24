import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat-game/models/story.dart';
import 'package:chat-game/models/story_savestate.dart';
import 'package:chat-game/pages/groups/groups_provider.dart';
import 'package:chat-game/pages/widgets/banner.dart';
import 'package:chat-game/pages/widgets/parallax.dart';
import 'package:chat-game/providers/iap_provider.dart';
import 'package:chat-game/providers/storage_provider.dart';
import 'package:chat-game/utils/logging.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:isar/isar.dart';

class CoverSlider extends ConsumerStatefulWidget {
  const CoverSlider({super.key, required this.stories});
  final List<Story> stories;

  @override
  ConsumerState<CoverSlider> createState() => _CoverSliderState();
}

class _CoverSliderState extends ConsumerState<CoverSlider> {
  @override
  Widget build(BuildContext context) {
    var productDetails = ref.watch(iapDetailsProvider);
    Log.w('$productDetails');
    return productDetails.when(
        data: (productDetails) => buildView(productDetails),
        loading: () => buildView(null),
        error: (e, s) => const Center(child: Text('Error')));

    ;
  }

  buildView(productDetails) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60.0),
      child: Column(children: [
        for (final story in widget.stories)
          if (story.id.isNotEmpty)
            StoryListItem(
                story: story,
                product: productDetails == null
                    ? null
                    : productDetails[story.id.toLowerCase()])
      ]),
    ));
  }
}

class StoryListItem extends ConsumerStatefulWidget {
  StoryListItem({super.key, required this.story, required this.product});
  final Story story;
  final Product? product;

  @override
  ConsumerState<StoryListItem> createState() => _StoryListItemState();
}

class _StoryListItemState extends ConsumerState<StoryListItem> {
  final GlobalKey _backgroundImageKey = GlobalKey();
  StorySaveState? saveState;
  bool expanded = false;

  @override
  void initState() {
    SaveStorage.isar.storySaveStates
        .filter()
        .idEqualTo(widget.story.id)
        .findFirst()
        .then((value) {
      if (mounted)
        setState(() {
          saveState = value;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: InkWell(
          onTap: () => setState(() => expanded = !expanded),
          child: expanded ? buildExpanded(context) : buildCollapsed(context),
        ));
  }

  Widget buildCollapsed(BuildContext context) {
    return AspectRatio(
      aspectRatio: 26 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            _buildParallaxBackground(context),
            _buildGradient(),
            Positioned(
                left: 20,
                bottom: 20,
                right: 20,
                child: _buildTitleAndSubtitle()),
            Positioned.fill(
                child: ClipRect(
              child: BannerX(label: bannerText, color: bannerColor),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
          scrollable: Scrollable.of(context),
          listItemContext: context,
          backgroundImageKey: _backgroundImageKey),
      children: [
        Image.asset(widget.story.cover,
            key: _backgroundImageKey, fit: BoxFit.cover),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black26, Colors.black54],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.6, 0.85]),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(widget.story.title,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
            )),
        AutoSizeText(widget.story.subtitle,
            maxLines: 1,
            style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 18))
      ],
    );
  }

  Widget buildExpanded(BuildContext context) {
    return AspectRatio(
        aspectRatio: 12 / 9,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(widget.story.cover,
                      key: _backgroundImageKey, fit: BoxFit.cover),
                ),
                Positioned.fill(
                    child: ClipRRect(
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                            child: Container(
                              color: Colors.black38,
                              alignment: Alignment.center,
                            )))),
                Positioned(
                    bottom: 20, left: 20, right: 20, child: _buildSummary()),
                Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: _buildTitleAndSubtitle()),
              ],
            )));
  }

  _buildSummary() {
    return Column(children: [
      AutoSizeText(widget.story.summary,
          maxLines: 6,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
      const SizedBox(height: 20),
      actionButton
    ]);
  }

  Row buildButton(String label, VoidCallback onPressed) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (widget.story.id.isNotEmpty)
          MaterialButton(
            onPressed: onPressed,
            color: Colors.white24,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(label,
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
      ],
    );
  }

  get bannerText {
    if (saveState != null && saveState!.node == 'EOF') return 'Completed';
    if (saveState != null) return 'Reading';
    if (widget.story.id.isEmpty) return 'Coming Soon';
    // Temp code for relaunch
    if (widget.story.id != 'B1S01') return 'Coming Soon';
    return 'New';
  }

  Widget get actionButton {
    if (widget.story.id != 'B1S01') {
      return buildButton(
          'Coming Soon',
          () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Stay Tuned!'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                            'A remastered version of this story will be available soon.\n'),
                        Text(
                            'If you have already purchased this story, you will continue to have access to the remastered version.',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'))
                    ],
                  )));
    }

    if (saveState == null)
      return buildButton('Read', () {
        ref.read(activeConversationIDProvider.notifier).state = '';
        context.go('/story/${widget.story.id}');
      });

    if (saveState!.node == 'EOF')
      return buildButton('Read Again', () {
        ref.read(activeConversationIDProvider.notifier).state = '';
        context.go('/story/${widget.story.id}');
      });
    return buildButton('Continue Reading', () {
      ref.read(activeConversationIDProvider.notifier).state = '';
      context.go('/story/${widget.story.id}');
    });

/* Tempcode for relaunch
    if (saveState == null) {
      if (widget.product?.purchased == true) {
        return buildButton('Read', () {
          ref.read(activeConversationIDProvider.notifier).state = '';
          context.go('/story/${widget.story.id}');
        });
      }
      if (widget.product?.details != null)
        return buildButton('Buy Now - ${widget.product!.details!.price}', () {
          openBuyDialog(context, widget.product!);
        });

      return buildButton('Buy', () {
        openBuyDialog(context, widget.product!);
      });
    }
    if (saveState!.node == 'EOF')
      return buildButton('Read Again', () {
        ref.read(activeConversationIDProvider.notifier).state = '';
        context.go('/story/${widget.story.id}');
      });
    return buildButton('Continue Reading', () {
      ref.read(activeConversationIDProvider.notifier).state = '';
      context.go('/story/${widget.story.id}');
    });*/
  }

  get bannerColor {
    if (saveState != null && saveState!.node == 'EOF') return Colors.green;
    if (saveState != null) return Colors.blue;
    if (widget.story.id.isEmpty) return Colors.deepOrange;
    return Colors.pink;
  }

  openBuyDialog(BuildContext context, Product product) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Buy ${product.details?.title}'),
              content: Text('Buy ${product.details?.price}'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      bool success = await InAppPurchase.instance
                          .buyNonConsumable(
                              purchaseParam: PurchaseParam(
                                  productDetails: product.details!));
                      Navigator.of(context).pop();
                    },
                    child: Text('Buy'))
              ],
            ));
  }
}
