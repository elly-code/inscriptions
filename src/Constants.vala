/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

namespace Inscriptions {

	// Alkrjnlgjrt
	public const string DONATE_LINK = "https://ko-fi.com/teamcons/tip";
	public const string LINK = "https://www.deepl.com/your-account/keys";
    public const int DEBOUNCE_INTERVAL = 1250; // ms

    // Careful when using this to wrap to .2f decimals
    const float DEBOUNCE_IN_S = ((float)DEBOUNCE_INTERVAL) / 1000;

	// Styling
    public const string STYLE_CLASS_COLORED_HEADER = "primary-background";
    public const string STYLE_CLASS_ROTATED = "rotated";
	public const string STYLE_CLASS_CONSOLE = "console";
	public const string STYLE_CLASS_TITLE_LABEL = "label-title";

	// Consistent spacing
	public const int SPACING_TOOLBAR_HEADER = 5;
	public const int SPACING_TOOLBAR_MINI = 3;
	public const int MARGIN_MENU_HALF = 3;
	public const int MARGIN_MENU_STANDARD = 5;
	public const int MARGIN_MENU_BIG = 10;
	public const int MARGIN_MENU_BIGGER = 25;

	// Backend lingo
	public const string AUTO_DETECT_LANGUAGE = "idk";
	public const string SYSTEM_LANGUAGE = "system";

	// Used by LanguageItem for heatmaps in the LanguageDropDown
	public const string ACCENT_1 = "accent-1";
	public const string ACCENT_2 = "accent-2";
	public const string ACCENT_3 = "accent-3";
	public const string ACCENT_4 = "accent-4";
	public const string ACCENT_5 = "accent-5";

	// Autocomplete, save me!
	public const string SETTINGS_PATH_UI = APP_ID + ".ui";
	public const string SETTINGS_PATH_TRANSLATE = APP_ID + ".translate";

	// UI
	public const string KEY_WINDOW_HEIGHT = "window-height";
	public const string KEY_WINDOW_WIDTH = "window-width";
	public const string KEY_WINDOW_MAXIMIZED = "window-maximized";
	public const string KEY_VERTICAL_LAYOUT = "vertical-layout";
	public const string KEY_AUTO_TRANSLATE = "auto-translate";
	public const string KEY_HIGHLIGHT = "highlight";
	public const string KEY_HEATMAP = "language-heatmap";
	public const string KEY_ZOOM = "zoom";

	// Translate
	public const string KEY_SOURCE_LANGUAGE = "source-language";
	public const string KEY_TARGET_LANGUAGE = "target-language";
	public const string KEY_CONTEXT = "context";
	public const string KEY_FORMALITY = "formality";
	public const string KEY_CURRENT_USAGE = "current-usage";
	public const string KEY_MAX_USAGE = "max-usage";

	public const string DOMAIN = "iso_639_3";

	// https://developers.deepl.com/docs/getting-started/supported-languages
	// TODO: In the far future people might declare their own in a backend file
	public Lang[] SourceLang () {
		return {
			//TRANSLATORS: The following are all languages user can select as source or target for translation
			new Lang (AUTO_DETECT_LANGUAGE,_("Detect automatically")),
			new Lang (SYSTEM_LANGUAGE,_("System language")),
			new Lang ("ACE", dgettext (DOMAIN, "Acehnese")),
			new Lang ("AF",dgettext (DOMAIN, "Afrikaans")),
			new Lang ("SQ",dgettext (DOMAIN, "Albanian")),
			new Lang ("AR",dgettext (DOMAIN, "Arabic")),
			new Lang ("AN", dgettext (DOMAIN, "Aragonese")),
			new Lang ("HY",dgettext (DOMAIN, "Armenian")),
			new Lang ("AS",dgettext (DOMAIN, "Assamese")),
			new Lang ("AY",dgettext (DOMAIN, "Aymara")),
			new Lang ("AZ",dgettext (DOMAIN, "Azerbaijani")),
			new Lang ("BA",dgettext (DOMAIN, "Bashkir")),
			new Lang ("EU",dgettext (DOMAIN, "Basque")),
			new Lang ("BE",dgettext (DOMAIN, "Belarusian")),
			new Lang ("BN",dgettext (DOMAIN, "Bengali")),
			new Lang ("BHO",dgettext (DOMAIN, "Bhojpuri")),
			new Lang ("BS",dgettext (DOMAIN, "Bosnian")),
			new Lang ("BR",dgettext (DOMAIN, "Breton")),
			new Lang ("BG",dgettext (DOMAIN, "Bulgarian")),
			new Lang ("MY",dgettext (DOMAIN, "Burmese")),
			new Lang ("YUE",dgettext (DOMAIN, "Cantonese")),
			new Lang ("CA",dgettext (DOMAIN, "Catalan")),
			new Lang ("CEB",dgettext (DOMAIN, "Cebuano")),
			new Lang ("ZH",  _("%s (Unspecified variant)").printf (dgettext (DOMAIN, "Chinese"))),
			new Lang ("HR",dgettext (DOMAIN, "Croatian")),
			new Lang ("CS",dgettext (DOMAIN, "Czech")),
			new Lang ("DA",dgettext (DOMAIN, "Danish")),
			new Lang ("PRS",dgettext (DOMAIN, "Dari")),
			new Lang ("NL",dgettext (DOMAIN, "Dutch")),
			new Lang ("EN",_("%s (All variants)").printf (dgettext (DOMAIN, "English"))),
			new Lang ("EO",dgettext (DOMAIN, "Esperanto")),
			new Lang ("ET",dgettext (DOMAIN, "Estonian")),
			new Lang ("FI",dgettext (DOMAIN, "Finnish")),
			new Lang ("FR",dgettext (DOMAIN, "French")),
			new Lang ("GL",dgettext (DOMAIN, "Galician")),
			new Lang ("KA",dgettext (DOMAIN, "Georgian")),
			new Lang ("DE",dgettext (DOMAIN, "German")),
			new Lang ("EL",dgettext (DOMAIN, "Greek")),
			new Lang ("GN",dgettext (DOMAIN, "Guarani")),
			new Lang ("GU",dgettext (DOMAIN, "Gujarati")),
			new Lang ("HT",dgettext (DOMAIN, "Haitian Creole")),
			new Lang ("HA",dgettext (DOMAIN, "Hausa")),
			new Lang ("HE",dgettext (DOMAIN, "Hebrew")),
			new Lang ("HI",dgettext (DOMAIN, "Hindi")),
			new Lang ("HU",dgettext (DOMAIN, "Hungarian")),
			new Lang ("IS",dgettext (DOMAIN, "Icelandic")),
			new Lang ("IG",dgettext (DOMAIN, "Igbo")),
			new Lang ("ID",dgettext (DOMAIN, "Indonesian")),
			new Lang ("GA",dgettext (DOMAIN, "Irish")),
			new Lang ("IT",dgettext (DOMAIN, "Italian")),
			new Lang ("JA",dgettext (DOMAIN, "Japanese")),
			new Lang ("JV",dgettext (DOMAIN, "Javanese")),
			new Lang ("PAM",dgettext (DOMAIN, "Kapampangan")),
			new Lang ("KK",dgettext (DOMAIN, "Kazakh")),
			new Lang ("GOM",dgettext (DOMAIN, "Konkani")),
			new Lang ("KO",dgettext (DOMAIN, "Korean")),
			new Lang ("KMR",_("%s (Kurmanji)").printf (dgettext (DOMAIN, "Kurdish"))),
			new Lang ("CKB",_("%s (Sorani)").printf (dgettext (DOMAIN, "Kurdish"))),
			new Lang ("KY",dgettext (DOMAIN, "Kyrgyz")),
			new Lang ("LA",dgettext (DOMAIN, "Latin")),
			new Lang ("LV",dgettext (DOMAIN, "Latvian")),
			new Lang ("LN",dgettext (DOMAIN, "Lingala")),
			new Lang ("LT",dgettext (DOMAIN, "Lithuanian")),
			new Lang ("LMO",dgettext (DOMAIN, "Lombard")),
			new Lang ("LB",dgettext (DOMAIN, "Luxembourgish")),
			new Lang ("MK",dgettext (DOMAIN, "Macedonian")),
			new Lang ("MAI",dgettext (DOMAIN, "Maithili")),
			new Lang ("MG",dgettext (DOMAIN, "Malagasy")),
			new Lang ("MS",dgettext (DOMAIN, "Malay")),
			new Lang ("ML",dgettext (DOMAIN, "Malayalam")),
			new Lang ("MT",dgettext (DOMAIN, "Maltese")),
			new Lang ("MI",dgettext (DOMAIN, "Maori")),
			new Lang ("MR",dgettext (DOMAIN, "Marathi")),
			new Lang ("MN",dgettext (DOMAIN, "Mongolian")),
			new Lang ("NE",dgettext (DOMAIN, "Nepali")),
			new Lang ("NB",dgettext (DOMAIN, "Norwegian Bokmål")),
			new Lang ("OC",dgettext (DOMAIN, "Occitan")),
			new Lang ("OM",dgettext (DOMAIN, "Oromo")),
			new Lang ("PAG",dgettext (DOMAIN, "Pangasinan")),
			new Lang ("PS",dgettext (DOMAIN, "Pashto")),
			new Lang ("FA",dgettext (DOMAIN, "Persian")),
			new Lang ("PL",dgettext (DOMAIN, "Polish")),
			new Lang ("PT",_("%s (Unspecified)").printf (dgettext (DOMAIN, "Portuguese"))),
			new Lang ("PA",dgettext (DOMAIN, "Punjabi")),
			new Lang ("QU",dgettext (DOMAIN, "Quechua")),
			new Lang ("RO",dgettext (DOMAIN, "Romanian")),
			new Lang ("RU",dgettext (DOMAIN, "Russian")),
			new Lang ("SA",dgettext (DOMAIN, "Sanskrit")),
			new Lang ("SR",dgettext (DOMAIN, "Serbian")),
			new Lang ("ST",dgettext (DOMAIN, "Sesotho")),
			new Lang ("SCN",dgettext (DOMAIN, "Sicilian")),
			new Lang ("SK",dgettext (DOMAIN, "Slovak")),
			new Lang ("SL",dgettext (DOMAIN, "Slovenian")),
			new Lang ("ES",dgettext (DOMAIN, "Spanish")),
			new Lang ("SU",dgettext (DOMAIN, "Sundanese")),
			new Lang ("SW",dgettext (DOMAIN, "Swahili")),
			new Lang ("SV",dgettext (DOMAIN, "Swedish")),
			new Lang ("TL",dgettext (DOMAIN, "Tagalog")),
			new Lang ("TG",dgettext (DOMAIN, "Tajik")),
			new Lang ("TA",dgettext (DOMAIN, "Tamil")),
			new Lang ("TT",dgettext (DOMAIN, "Tatar")),
			new Lang ("TE",dgettext (DOMAIN, "Telugu")),
			new Lang ("TH",dgettext (DOMAIN, "Thai")),
			new Lang ("TS",dgettext (DOMAIN, "Tsonga")),
			new Lang ("TN",dgettext (DOMAIN, "Tswana")),
			new Lang ("TR",dgettext (DOMAIN, "Turkish")),
			new Lang ("TK",dgettext (DOMAIN, "Turkmen")),
			new Lang ("UK",dgettext (DOMAIN, "Ukrainian")),
			new Lang ("UR",dgettext (DOMAIN, "Urdu")),
			new Lang ("UZ",dgettext (DOMAIN, "Uzbek")),
			new Lang ("VI",dgettext (DOMAIN, "Vietnamese")),
			new Lang ("CY",dgettext (DOMAIN, "Welsh")),
			new Lang ("WO",dgettext (DOMAIN, "Wolof")),
			new Lang ("XH",dgettext (DOMAIN, "Xhosa")),
			new Lang ("YI",dgettext (DOMAIN, "Yiddish")),
			new Lang ("ZU",dgettext (DOMAIN, "Zulu"))
		};
	}

	public Lang[] TargetLang () {
		return {
			new Lang (SYSTEM_LANGUAGE,_("System language")),
			new Lang ("ACE",dgettext (DOMAIN, "Acehnese")),
			new Lang ("AF",dgettext (DOMAIN, "Afrikaans")),
			new Lang ("SQ",dgettext (DOMAIN, "Albanian")),
			new Lang ("AR",dgettext (DOMAIN, "Arabic")),
			new Lang ("AN",dgettext (DOMAIN, "Aragonese")),
			new Lang ("HY",dgettext (DOMAIN, "Armenian")),
			new Lang ("AS",dgettext (DOMAIN, "Assamese")),
			new Lang ("AY",dgettext (DOMAIN, "Aymara")),
			new Lang ("AZ",dgettext (DOMAIN, "Azerbaijani")),
			new Lang ("BA",dgettext (DOMAIN, "Bashkir")),
			new Lang ("EU",dgettext (DOMAIN, "Basque")),
			new Lang ("BE",dgettext (DOMAIN, "Belarusian")),
			new Lang ("BN",dgettext (DOMAIN, "Bengali")),
			new Lang ("BHO",dgettext (DOMAIN, "Bhojpuri")),
			new Lang ("BS",dgettext (DOMAIN, "Bosnian")),
			new Lang ("BR",dgettext (DOMAIN, "Breton")),
			new Lang ("BG",dgettext (DOMAIN, "Bulgarian")),
			new Lang ("MY",dgettext (DOMAIN, "Burmese")),
			new Lang ("YUE",dgettext (DOMAIN, "Cantonese")),
			new Lang ("CA",dgettext (DOMAIN, "Catalan")),
			new Lang ("CEB",dgettext (DOMAIN, "Cebuano")),
			new Lang ("ZH-HANS",_("%s (Simplified)").printf (dgettext (DOMAIN, "Chinese"))),
			new Lang ("ZH-HANT",_("%s (Traditional)").printf (dgettext (DOMAIN, "Chinese"))),
			new Lang ("ZH",_("%s (Unspecified variant)").printf (dgettext (DOMAIN, "Chinese"))),
			new Lang ("HR",dgettext (DOMAIN, "Croatian")),
			new Lang ("CS",dgettext (DOMAIN, "Czech")),
			new Lang ("DA",dgettext (DOMAIN, "Danish")),
			new Lang ("PRS",dgettext (DOMAIN, "Dari")),
			new Lang ("NL",dgettext (DOMAIN, "Dutch")),
			new Lang ("EN",_("%s (All variants)").printf (dgettext (DOMAIN, "English"))),
			new Lang ("EN-US",_("%s (American)").printf (dgettext (DOMAIN, "English"))),
			new Lang ("EN-GB",_("%s (British)").printf (dgettext (DOMAIN, "English"))),
			new Lang ("EO",dgettext (DOMAIN, "Esperanto")),
			new Lang ("ET",dgettext (DOMAIN, "Estonian")),
			new Lang ("FI",dgettext (DOMAIN, "Finnish")),
			new Lang ("FR",dgettext (DOMAIN, "French")),
			new Lang ("GL",dgettext (DOMAIN, "Galician")),
			new Lang ("KA",dgettext (DOMAIN, "Georgian")),
			new Lang ("DE",dgettext (DOMAIN, "German")),
			new Lang ("EL",dgettext (DOMAIN, "Greek")),
			new Lang ("GN",dgettext (DOMAIN, "Guarani")),
			new Lang ("GU",dgettext (DOMAIN, "Gujarati")),
			new Lang ("HT",dgettext (DOMAIN, "Haitian Creole")),
			new Lang ("HA",dgettext (DOMAIN, "Hausa")),
			new Lang ("HE",dgettext (DOMAIN, "Hebrew")),
			new Lang ("HI",dgettext (DOMAIN, "Hindi")),
			new Lang ("HU",dgettext (DOMAIN, "Hungarian")),
			new Lang ("IS",dgettext (DOMAIN, "Icelandic")),
			new Lang ("IG",dgettext (DOMAIN, "Igbo")),
			new Lang ("ID",dgettext (DOMAIN, "Indonesian")),
			new Lang ("GA",dgettext (DOMAIN, "Irish")),
			new Lang ("IT",dgettext (DOMAIN, "Italian")),
			new Lang ("JA",dgettext (DOMAIN, "Japanese")),
			new Lang ("JV",dgettext (DOMAIN, "Javanese")),
			new Lang ("PAM",dgettext (DOMAIN, "Kapampangan")),
			new Lang ("KK",dgettext (DOMAIN, "Kazakh")),
			new Lang ("GOM",dgettext (DOMAIN, "Konkani")),
			new Lang ("KO",dgettext (DOMAIN, "Korean")),
			new Lang ("KMR",_("%s (Kurmanji)").printf (dgettext (DOMAIN, "Kurdish"))),
			new Lang ("CKB",_("%s (Sorani)").printf (dgettext (DOMAIN, "Kurdish"))),
			new Lang ("KY",dgettext (DOMAIN, "Kyrgyz")),
			new Lang ("LA",dgettext (DOMAIN, "Latin")),
			new Lang ("LV",dgettext (DOMAIN, "Latvian")),
			new Lang ("LN",dgettext (DOMAIN, "Lingala")),
			new Lang ("LT",dgettext (DOMAIN, "Lithuanian")),
			new Lang ("LMO",dgettext (DOMAIN, "Lombard")),
			new Lang ("LB",dgettext (DOMAIN, "Luxembourgish")),
			new Lang ("MK",dgettext (DOMAIN, "Macedonian")),
			new Lang ("MAI",dgettext (DOMAIN, "Maithili")),
			new Lang ("MG",dgettext (DOMAIN, "Malagasy")),
			new Lang ("MS",dgettext (DOMAIN, "Malay")),
			new Lang ("ML",dgettext (DOMAIN, "Malayalam")),
			new Lang ("MT",dgettext (DOMAIN, "Maltese")),
			new Lang ("MI",dgettext (DOMAIN, "Maori")),
			new Lang ("MR",dgettext (DOMAIN, "Marathi")),
			new Lang ("MN",dgettext (DOMAIN, "Mongolian")),
			new Lang ("NE",dgettext (DOMAIN, "Nepali")),
			new Lang ("NB",dgettext (DOMAIN, "Norwegian Bokmål")),
			new Lang ("OC",dgettext (DOMAIN, "Occitan")),
			new Lang ("OM",dgettext (DOMAIN, "Oromo")),
			new Lang ("PAG",dgettext (DOMAIN, "Pangasinan")),
			new Lang ("PS",dgettext (DOMAIN, "Pashto")),
			new Lang ("FA",dgettext (DOMAIN, "Persian")),
			new Lang ("PL",dgettext (DOMAIN, "Polish")),
			new Lang ("PT-BR",_("%s (Brazilian)").printf (dgettext (DOMAIN, "Portuguese"))),
			new Lang ("PT-PT",_("%s (European)").printf (dgettext (DOMAIN, "Portuguese"))),
			new Lang ("PT",_("%s (Unspecified)").printf (dgettext (DOMAIN, "Portuguese"))),
			new Lang ("PA",dgettext (DOMAIN, "Punjabi")),
			new Lang ("QU",dgettext (DOMAIN, "Quechua")),
			new Lang ("RO",dgettext (DOMAIN, "Romanian")),
			new Lang ("RU",dgettext (DOMAIN, "Russian")),
			new Lang ("SA",dgettext (DOMAIN, "Sanskrit")),
			new Lang ("SR",dgettext (DOMAIN, "Serbian")),
			new Lang ("ST",dgettext (DOMAIN, "Sesotho")),
			new Lang ("SCN",dgettext (DOMAIN, "Sicilian")),
			new Lang ("SK",dgettext (DOMAIN, "Slovak")),
			new Lang ("SL",dgettext (DOMAIN, "Slovenian")),
			new Lang ("ES",dgettext (DOMAIN, "Spanish")),
			new Lang ("ES-419",_("%s (Latin American)").printf (dgettext (DOMAIN, "Spanish"))),
			new Lang ("SU",dgettext (DOMAIN, "Sundanese")),
			new Lang ("SW",dgettext (DOMAIN, "Swahili")),
			new Lang ("SV",dgettext (DOMAIN, "Swedish")),
			new Lang ("TL",dgettext (DOMAIN, "Tagalog")),
			new Lang ("TG",dgettext (DOMAIN, "Tajik")),
			new Lang ("TA",dgettext (DOMAIN, "Tamil")),
			new Lang ("TT",dgettext (DOMAIN, "Tatar")),
			new Lang ("TE",dgettext (DOMAIN, "Telugu")),
			new Lang ("TH",dgettext (DOMAIN, "Thai")),
			new Lang ("TS",dgettext (DOMAIN, "Tsonga")),
			new Lang ("TN",dgettext (DOMAIN, "Tswana")),
			new Lang ("TR",dgettext (DOMAIN, "Turkish")),
			new Lang ("TK",dgettext (DOMAIN, "Turkmen")),
			new Lang ("UK",dgettext (DOMAIN, "Ukrainian")),
			new Lang ("UR",dgettext (DOMAIN, "Urdu")),
			new Lang ("UZ",dgettext (DOMAIN, "Uzbek")),
			new Lang ("VI",dgettext (DOMAIN, "Vietnamese")),
			new Lang ("CY",dgettext (DOMAIN, "Welsh")),
			new Lang ("WO",dgettext (DOMAIN, "Wolof")),
			new Lang ("XH",dgettext (DOMAIN, "Xhosa")),
			new Lang ("YI",dgettext (DOMAIN, "Yiddish")),
			new Lang ("ZU",dgettext (DOMAIN, "Zulu"))
		};
	}
}
