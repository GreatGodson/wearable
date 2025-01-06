import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:wearable/app/modules/dashboard/presentation/pages/dashboard_page.dart';
import 'package:wearable/app/modules/onboarding/data/models/response/onboarding_model.dart';
import 'package:wearable/app/modules/onboarding/domain/service/onboarding_service.dart';
import 'package:wearable/core/framework/theme/spacings/spacings.dart';

import '../../../../../core/framework/navigator/navigator.dart';
import '../../../../shared/presentation/components/button_component.dart';
import '../components/indicator_component.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _pageViewIndexProvider = StateProvider.autoDispose((ref) => 0);

  late PageController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (ref.read(_pageViewIndexProvider) < 3 - 1) {
        ref.read(_pageViewIndexProvider.notifier).state++;
      } else {
        _timer.cancel();
      }

      _controller.animateToPage(
        ref.read(_pageViewIndexProvider),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<OnboardingDto>(
          future: OnboardingService.loadOnboarding(),
          builder: (context, snapshots) {
            final data = snapshots.data;
            final message = data?.message;
            return Column(
              children: [
                if (snapshots.hasData)
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      onPageChanged: (index) {
                        ref.read(_pageViewIndexProvider.notifier).state = index;
                      },
                      itemCount: message?.length,
                      itemBuilder: (context, index) {
                        final title = message?[index].title ?? "";
                        final description = message?[index].message ?? "";
                        final lottie = message?[index].lottie ?? "";

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Spacings.spacing24,
                            vertical: Spacings.spacing24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    title,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: Spacings.spacing32,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: Spacings.spacing24,
                                  ),
                                  Text(
                                    description,
                                    style: const TextStyle(
                                      fontSize: Spacings.spacing16,
                                    ),
                                  ),
                                ],
                              ),
                              Lottie.asset(lottie),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacings.spacing24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: PageViewIndicatorsComponent(
                          index: ref.watch(_pageViewIndexProvider),
                          count: 3,
                        ),
                      ),
                      const SizedBox(
                        width: Spacings.spacing24,
                      ),
                      Expanded(
                        child: ButtonComponent(
                          color: Colors.purple,
                          verticalPadding: Spacings.spacing18,
                          text: ref.watch(_pageViewIndexProvider) < 2
                              ? "Skip"
                              : "Start Journaling",
                          onPressed: () {
                            if (ref.read(_pageViewIndexProvider) == 2) {
                              navigator.pushReplace(
                                page: DashboardPage(),
                              );
                            }
                            if (ref.read(_pageViewIndexProvider) < 2) {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 1.0, end: 0, duration: 1000.ms),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
