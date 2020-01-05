import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'application_localization.dart';

class ApplicationLocalizationDelegate
    extends LocalizationsDelegate<ApplicationLocalization> {
  const ApplicationLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', "pl"].contains(locale.languageCode);
  }

  @override
  bool shouldReload(LocalizationsDelegate old) {
    return false;
  }

  @override
  Future<ApplicationLocalization> load(Locale locale) {
    return SynchronousFuture<ApplicationLocalization>(
        ApplicationLocalization(locale));
  }
}
