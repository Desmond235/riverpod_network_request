
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageIndexProvider = StateProvider<int>((ref) => 0);


final canGoToPreviousPageProvider = Provider<bool>((ref){
  return ref.watch(pageIndexProvider) != 0;
});