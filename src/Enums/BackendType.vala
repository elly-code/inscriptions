/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * A convenient way to track all existing BackendType
 */
public enum Inscriptions.BackendType {
    DUMMY,
    DEEPL,
    LIBRETRANSLATE;

    public string to_name () {
      switch (this) {
        case DUMMY:           return _("Dummy");
        case DEEPL:           return _("DeepL");
        case LIBRETRANSLATE:  return _("LibreTranslate");
        default: return _("DeepL");
      }
    }

    public string to_secrets_label () {
      switch (this) {
        case DUMMY:           return "Super-Secret-Key";
        case DEEPL:           return "DeepL-Auth-Key";
        case LIBRETRANSLATE:  return "API_KEY";
        default: return "DeepL-Auth-Key";
      }
    }

    public string to_settings_prefix () {
      switch (this) {
        case DUMMY:           return ".dummy";
        case DEEPL:           return ".deepl";
        case LIBRETRANSLATE:  return ".libretranslate";
        default: return ".deepl";
      }
    }

    public static BackendType from_int (int number) {
      switch (number) {
        case 0: return DUMMY;
        case 1: return DEEPL;
        case 2: return LIBRETRANSLATE;
        default: return DEEPL;
      }
    }

    public const BackendType[] ALL = {DUMMY, DEEPL, LIBRETRANSLATE};
    public const string[] STRING_ALL = {N_("Dummy"), N_("DeepL"), N_("LibreTranslate")};
}