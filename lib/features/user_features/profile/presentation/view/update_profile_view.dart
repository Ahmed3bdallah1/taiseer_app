import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:learning/config/app_color.dart';

import '../../../../../../ui/shared_widgets/custom_app_bar.dart';
import '../manager/update_profile_provider.dart';
import 'edit_profile.dart';

class UpdateProfileView extends ConsumerWidget {
  const UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final updatedUser = ref.watch(refreshProfileProvider);
    return Scaffold(
      body: updatedUser.customWhen(
        ref: ref,
        refreshable: refreshProfileProvider.future,
        data: (data) => const EditProfileScreen(),
      ),
    );
  }
}
