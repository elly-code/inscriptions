/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

namespace Inscriptions.DeepLUtils {

  // FUCKY: DeepL is a bit weird with some codes
  // We have to hack at it for edge cases
  public string detect_system () {
    string system_language = Environment.get_variable ("LANG").ascii_up ();
    var minicode = system_language.substring (0, 2).ascii_up (-1);

    if (system_language == "C") {return "EN-GB";}
    if (system_language.has_prefix ("PT_BR")) { return "PT-BR";}
    if (system_language.has_prefix ("PT_PT")) { return "PT-PT";}
    if (system_language.has_prefix ("ZH_CN")) {return "ZH-HANS";}
    if (system_language.has_prefix ("ZH_TW")) {return "ZH-HANT";}
    if (system_language.has_prefix ("EN_GB")) {return "EN-GB";}
    if (system_language.has_prefix ("EN_US")) {return "EN-US";}
    if (system_language.has_prefix ("NO")) {return "NB";}
    if ((system_language.has_prefix ("ES_")) && (system_language.substring (0, 5) != "ES_ES")) {
      return "ES-419";
    }

    print ("\nBackend: Detected system language: " + minicode);
    return minicode;
  }
}
