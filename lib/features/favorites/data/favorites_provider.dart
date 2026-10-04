import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  static const String _prefsKey = 'salam_saved_favorites';

  FavoritesNotifier() : super({'p1', 'p3'}) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedList = prefs.getStringList(_prefsKey);
      if (savedList != null && savedList.isNotEmpty) {
        state = savedList.toSet();
      }
    } catch (_) {
      // Fallback to default memory state
    }
  }

  Future<void> _saveToPrefs(Set<String> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_prefsKey, favorites.toList());
    } catch (_) {}
  }

  void toggleFavorite(String placeId) {
    if (state.contains(placeId)) {
      state = {...state}..remove(placeId);
    } else {
      state = {...state, placeId};
    }
    _saveToPrefs(state);
  }

  bool isFavorite(String placeId) {
    return state.contains(placeId);
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>(
  (ref) {
    return FavoritesNotifier();
  },
);
