class ThemeManager {
  bool isDark = false;

  setDark(bool state) {
    isDark = state;
  }

  getDark() {
    return isDark;
  }
}
