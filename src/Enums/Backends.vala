/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * A convenient way to track all existing backends
 */
public enum Inscriptions.PossibleBackends {
    DEEPL,
    LIBRETRANSLATE;

    public string to_name () {
      switch (this) {
        case DEEPL:           return _("DeepL");
        case LIBRETRANSLATE:  return _("LibreTranslate");
        default: return _("DeepL");
      }
    }

    public string to_label () {
      switch (this) {
        case DEEPL:           return "DeepL-Auth-Key";
        case LIBRETRANSLATE:  return "API_KEY";
        default: return "DeepL-Auth-Key";
      }
    }

    public string to_backend () {
      switch (this) {
        case DEEPL:           return new Inscriptions.DeepL ();
        case LIBRETRANSLATE:  return "API_KEY";
        default: return "DeepL-Auth-Key";
      }
    }

    public static PossibleBackends from_int (int number) {
      switch (number) {
        case 0: return DEEPL;
        case 1: return LIBRETRANSLATE;
        default: return DEEPL;
      }
    }

    public static PossibleBackends[] all_backends () {
      return {DEEPL, LIBRETRANSLATE};
    }
}