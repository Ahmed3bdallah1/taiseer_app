import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../user_features/root/view/root_view.dart';

final companyRootIndex = StateNotifierProvider.autoDispose<CompanyRootController, int>((ref) {
  ref.listenSelf((previous, next) {
    ref.invalidate(hideNavBarProvider);
  });
  return CompanyRootController();
});

class CompanyRootController extends StateNotifier<int> {
  CompanyRootController() : super(0);
  Map<String, dynamic>? args;

  bool isSelectedIndex(int index) {
    return state == index;
  }

  NavBarCompanyItem getHomeScreenCategory() {
    return NavBarCompanyItem.values[state];
  }

  goBack() {
    state = 0;
  }

  reset() {
    state = 0;
  }

  setSelectedIndex(int index, {Map<String, dynamic>? args}) {
    if (state == index) {
      state = -1;
    }
    this.args = args;
    state = index;
  }

  setSelectedCat(NavBarCompanyItem item, {Map<String, dynamic>? args}) {
    if (state == item.index) {
      state = -1;
    }
    this.args = args;
    state = item.index;
  }
}

enum NavBarCompanyItem {
  home,
  date,
  notifications,
  search,
  followOrder
}