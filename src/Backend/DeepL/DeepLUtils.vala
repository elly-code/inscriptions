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


  	public Lang[] supported_source_languages () {
		return {
			//TRANSLATORS: The following are all languages user can select as source or target for translation
			new Lang ("idk",_("Detect automatically")),
			new Lang ("system",_("System language")),
			new Lang ("AR",_("Arabic")),
			new Lang ("BG",_("Bulgarian")),
			new Lang ("CS",_("Czech")),
			new Lang ("DA",_("Danish")),
			new Lang ("DE",_("German")),
			new Lang ("EL",_("Greek")),
			new Lang ("EN",_("English (All)")),
			new Lang ("ES",_("Spanish (All)")),
			new Lang ("ET",_("Estonian")),
			new Lang ("FI",_("Finnish")),
			new Lang ("FR",_("French")),
			new Lang ("HE",_("Hebrew")),
			new Lang ("HU",_("Hungarian")),
			new Lang ("ID",_("Indonesian")),
			new Lang ("IT",_("Italian")),
			new Lang ("JA",_("Japanese")),
			new Lang ("KO",_("Korean")),
			new Lang ("LT",_("Lithuanian")),
			new Lang ("LV",_("Latvian")),
			new Lang ("NB",_("Norwegian Bokmål")),
			new Lang ("NL",_("Dutch")),
			new Lang ("PL",_("Polish")),
			new Lang ("PT",_("Portuguese (All)")),
			new Lang ("RO",_("Romanian")),
			new Lang ("RU",_("Russian")),
			new Lang ("SK",_("Slovak")),
			new Lang ("SL",_("Slovenian")),
			new Lang ("SV",_("Swedish")),
			new Lang ("TH",_("Thai")),
			new Lang ("TR",_("Turkish")),
			new Lang ("UK",_("Ukrainian")),
			new Lang ("VI",_("Vietnamese")),
			new Lang ("ZH",_("Chinese (All)"))
		};
	}

	public Lang[] supported_target_languages () {
		return {
			new Lang ("system",_("System language")),
			new Lang ("AR",_("Arabic")),
			new Lang ("BG",_("Bulgarian")),
			new Lang ("CS",_("Czech")),
			new Lang ("DA",_("Danish")),
			new Lang ("DE",_("German")),
			new Lang ("EL",_("Greek")),
			new Lang ("EN",_("English (GB)")),
			new Lang ("EN",_("English (US)")),
			new Lang ("ES",_("Spanish (All)")),
			new Lang ("ES-419",_("Spanish (Latin American)")),
			new Lang ("ET",_("Estonian")),
			new Lang ("FI",_("Finnish")),
			new Lang ("FR",_("French")),
			new Lang ("HE",_("Hebrew")),
			new Lang ("HU",_("Hungarian")),
			new Lang ("ID",_("Indonesian")),
			new Lang ("IT",_("Italian")),
			new Lang ("JA",_("Japanese")),
			new Lang ("KO",_("Korean")),
			new Lang ("LT",_("Lithuanian")),
			new Lang ("LV",_("Latvian")),
			new Lang ("NB",_("Norwegian Bokmål")),
			new Lang ("NL",_("Dutch")),
			new Lang ("PL",_("Polish")),
			new Lang ("PT-PT",_("Portuguese (Portugal)")),
			new Lang ("PT-BR",_("Portuguese (Brazilian)")),
			new Lang ("RO",_("Romanian")),
			new Lang ("RU",_("Russian")),
			new Lang ("SK",_("Slovak")),
			new Lang ("SL",_("Slovenian")),
			new Lang ("SV",_("Swedish")),
			new Lang ("TH",_("Thai")),
			new Lang ("TR",_("Turkish")),
			new Lang ("UK",_("Ukrainian")),
			new Lang ("VI",_("Vietnamese")),
			new Lang ("ZH-HANS",_("Chinese (Simplified)")),
			new Lang ("ZH-HANT",_("Chinese (Traditional)"))
		};
	}
}
