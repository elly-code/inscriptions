/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
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

	// Consistent spacing
	public const int SPACING_TOOLBAR_HEADER = 5;
	public const int SPACING_TOOLBAR_MINI = 3;
	public const int MARGIN_MENU_HALF = 3;
	public const int MARGIN_MENU_STANDARD = 5;
	public const int MARGIN_MENU_BIG = 10;
	public const int MARGIN_MENU_BIGGER = 25;

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
}

namespace Inscriptions {
	// https://developers.deepl.com/docs/getting-started/supported-languages
	// TODO: In the far future people might declare their own in a backend file
	public Lang[] SourceLang () {
		return {
			//TRANSLATORS: The following are all languages user can select as source or target for translation
			new Lang ("idk",_("Detect automatically")),
			new Lang ("system",_("System language")),
			new Lang ("ACE",_("Acehnese")),
			new Lang ("AF",_("Afrikaans")),
			new Lang ("SQ",_("Albanian")),
			new Lang ("AR",_("Arabic")),
			new Lang ("AN",_("Aragonese")),
			new Lang ("HY",_("Armenian")),
			new Lang ("AS",_("Assamese")),
			new Lang ("AY",_("Aymara")),
			new Lang ("AZ",_("Azerbaijani")),
			new Lang ("BA",_("Bashkir")),
			new Lang ("EU",_("Basque")),
			new Lang ("BE",_("Belarusian")),
			new Lang ("BN",_("Bengali")),
			new Lang ("BHO",_("Bhojpuri")),
			new Lang ("BS",_("Bosnian")),
			new Lang ("BR",_("Breton")),
			new Lang ("BG",_("Bulgarian")),
			new Lang ("MY",_("Burmese")),
			new Lang ("YUE",_("Cantonese")),
			new Lang ("CA",_("Catalan")),
			new Lang ("CEB",_("Cebuano")),
			new Lang ("ZH",_("Chinese (Unspecified variant)")),
			new Lang ("HR",_("Croatian")),
			new Lang ("CS",_("Czech")),
			new Lang ("DA",_("Danish")),
			new Lang ("PRS",_("Dari")),
			new Lang ("NL",_("Dutch")),
			new Lang ("EN",_("English (All variants)")),
			new Lang ("EO",_("Esperanto")),
			new Lang ("ET",_("Estonian")),
			new Lang ("FI",_("Finnish")),
			new Lang ("FR",_("French")),
			new Lang ("GL",_("Galician")),
			new Lang ("KA",_("Georgian")),
			new Lang ("DE",_("German")),
			new Lang ("EL",_("Greek")),
			new Lang ("GN",_("Guarani")),
			new Lang ("GU",_("Gujarati")),
			new Lang ("HT",_("Haitian Creole")),
			new Lang ("HA",_("Hausa")),
			new Lang ("HE",_("Hebrew")),
			new Lang ("HI",_("Hindi")),
			new Lang ("HU",_("Hungarian")),
			new Lang ("IS",_("Icelandic")),
			new Lang ("IG",_("Igbo")),
			new Lang ("ID",_("Indonesian")),
			new Lang ("GA",_("Irish")),
			new Lang ("IT",_("Italian")),
			new Lang ("JA",_("Japanese")),
			new Lang ("JV",_("Javanese")),
			new Lang ("PAM",_("Kapampangan")),
			new Lang ("KK",_("Kazakh")),
			new Lang ("GOM",_("Konkani")),
			new Lang ("KO",_("Korean")),
			new Lang ("KMR",_("Kurdish (Kurmanji)")),
			new Lang ("CKB",_("Kurdish (Sorani)")),
			new Lang ("KY",_("Kyrgyz")),
			new Lang ("LA",_("Latin")),
			new Lang ("LV",_("Latvian")),
			new Lang ("LN",_("Lingala")),
			new Lang ("LT",_("Lithuanian")),
			new Lang ("LMO",_("Lombard")),
			new Lang ("LB",_("Luxembourgish")),
			new Lang ("MK",_("Macedonian")),
			new Lang ("MAI",_("Maithili")),
			new Lang ("MG",_("Malagasy")),
			new Lang ("MS",_("Malay")),
			new Lang ("ML",_("Malayalam")),
			new Lang ("MT",_("Maltese")),
			new Lang ("MI",_("Maori")),
			new Lang ("MR",_("Marathi")),
			new Lang ("MN",_("Mongolian")),
			new Lang ("NE",_("Nepali")),
			new Lang ("NB",_("Norwegian Bokmål")),
			new Lang ("OC",_("Occitan")),
			new Lang ("OM",_("Oromo")),
			new Lang ("PAG",_("Pangasinan")),
			new Lang ("PS",_("Pashto")),
			new Lang ("FA",_("Persian")),
			new Lang ("PL",_("Polish")),
			new Lang ("PT",_("Portuguese (Unspecified)")),
			new Lang ("PA",_("Punjabi")),
			new Lang ("QU",_("Quechua")),
			new Lang ("RO",_("Romanian")),
			new Lang ("RU",_("Russian")),
			new Lang ("SA",_("Sanskrit")),
			new Lang ("SR",_("Serbian")),
			new Lang ("ST",_("Sesotho")),
			new Lang ("SCN",_("Sicilian")),
			new Lang ("SK",_("Slovak")),
			new Lang ("SL",_("Slovenian")),
			new Lang ("ES",_("Spanish")),
			new Lang ("SU",_("Sundanese")),
			new Lang ("SW",_("Swahili")),
			new Lang ("SV",_("Swedish")),
			new Lang ("TL",_("Tagalog")),
			new Lang ("TG",_("Tajik")),
			new Lang ("TA",_("Tamil")),
			new Lang ("TT",_("Tatar")),
			new Lang ("TE",_("Telugu")),
			new Lang ("TH",_("Thai")),
			new Lang ("TS",_("Tsonga")),
			new Lang ("TN",_("Tswana")),
			new Lang ("TR",_("Turkish")),
			new Lang ("TK",_("Turkmen")),
			new Lang ("UK",_("Ukrainian")),
			new Lang ("UR",_("Urdu")),
			new Lang ("UZ",_("Uzbek")),
			new Lang ("VI",_("Vietnamese")),
			new Lang ("CY",_("Welsh")),
			new Lang ("WO",_("Wolof")),
			new Lang ("XH",_("Xhosa")),
			new Lang ("YI",_("Yiddish")),
			new Lang ("ZU",_("Zulu"))
		};
	}

	public Lang[] TargetLang () {
		return {
			new Lang ("system",_("System language")),
			new Lang ("ACE",_("Acehnese")),
			new Lang ("AF",_("Afrikaans")),
			new Lang ("SQ",_("Albanian")),
			new Lang ("AR",_("Arabic")),
			new Lang ("AN",_("Aragonese")),
			new Lang ("HY",_("Armenian")),
			new Lang ("AS",_("Assamese")),
			new Lang ("AY",_("Aymara")),
			new Lang ("AZ",_("Azerbaijani")),
			new Lang ("BA",_("Bashkir")),
			new Lang ("EU",_("Basque")),
			new Lang ("BE",_("Belarusian")),
			new Lang ("BN",_("Bengali")),
			new Lang ("BHO",_("Bhojpuri")),
			new Lang ("BS",_("Bosnian")),
			new Lang ("BR",_("Breton")),
			new Lang ("BG",_("Bulgarian")),
			new Lang ("MY",_("Burmese")),
			new Lang ("YUE",_("Cantonese")),
			new Lang ("CA",_("Catalan")),
			new Lang ("CEB",_("Cebuano")),
			new Lang ("ZH-HANS",_("Chinese (Simplified)")),
			new Lang ("ZH-HANT",_("Chinese (Traditional)")),
			new Lang ("ZH",_("Chinese (Unspecified variant)")),
			new Lang ("HR",_("Croatian")),
			new Lang ("CS",_("Czech")),
			new Lang ("DA",_("Danish")),
			new Lang ("PRS",_("Dari")),
			new Lang ("NL",_("Dutch")),
			new Lang ("EN",_("English (All variants)")),
			new Lang ("EN-US",_("English (American)")),
			new Lang ("EN-GB",_("English (British)")),
			new Lang ("EO",_("Esperanto")),
			new Lang ("ET",_("Estonian")),
			new Lang ("FI",_("Finnish")),
			new Lang ("FR",_("French")),
			new Lang ("GL",_("Galician")),
			new Lang ("KA",_("Georgian")),
			new Lang ("DE",_("German")),
			new Lang ("EL",_("Greek")),
			new Lang ("GN",_("Guarani")),
			new Lang ("GU",_("Gujarati")),
			new Lang ("HT",_("Haitian Creole")),
			new Lang ("HA",_("Hausa")),
			new Lang ("HE",_("Hebrew")),
			new Lang ("HI",_("Hindi")),
			new Lang ("HU",_("Hungarian")),
			new Lang ("IS",_("Icelandic")),
			new Lang ("IG",_("Igbo")),
			new Lang ("ID",_("Indonesian")),
			new Lang ("GA",_("Irish")),
			new Lang ("IT",_("Italian")),
			new Lang ("JA",_("Japanese")),
			new Lang ("JV",_("Javanese")),
			new Lang ("PAM",_("Kapampangan")),
			new Lang ("KK",_("Kazakh")),
			new Lang ("GOM",_("Konkani")),
			new Lang ("KO",_("Korean")),
			new Lang ("KMR",_("Kurdish (Kurmanji)")),
			new Lang ("CKB",_("Kurdish (Sorani)")),
			new Lang ("KY",_("Kyrgyz")),
			new Lang ("LA",_("Latin")),
			new Lang ("LV",_("Latvian")),
			new Lang ("LN",_("Lingala")),
			new Lang ("LT",_("Lithuanian")),
			new Lang ("LMO",_("Lombard")),
			new Lang ("LB",_("Luxembourgish")),
			new Lang ("MK",_("Macedonian")),
			new Lang ("MAI",_("Maithili")),
			new Lang ("MG",_("Malagasy")),
			new Lang ("MS",_("Malay")),
			new Lang ("ML",_("Malayalam")),
			new Lang ("MT",_("Maltese")),
			new Lang ("MI",_("Maori")),
			new Lang ("MR",_("Marathi")),
			new Lang ("MN",_("Mongolian")),
			new Lang ("NE",_("Nepali")),
			new Lang ("NB",_("Norwegian Bokmål")),
			new Lang ("OC",_("Occitan")),
			new Lang ("OM",_("Oromo")),
			new Lang ("PAG",_("Pangasinan")),
			new Lang ("PS",_("Pashto")),
			new Lang ("FA",_("Persian")),
			new Lang ("PL",_("Polish")),
			new Lang ("PT-BR",_("Portuguese (Brazilian)")),
			new Lang ("PT-PT",_("Portuguese (European)")),
			new Lang ("PT",_("Portuguese (Unspecified)")),
			new Lang ("PA",_("Punjabi")),
			new Lang ("QU",_("Quechua")),
			new Lang ("RO",_("Romanian")),
			new Lang ("RU",_("Russian")),
			new Lang ("SA",_("Sanskrit")),
			new Lang ("SR",_("Serbian")),
			new Lang ("ST",_("Sesotho")),
			new Lang ("SCN",_("Sicilian")),
			new Lang ("SK",_("Slovak")),
			new Lang ("SL",_("Slovenian")),
			new Lang ("ES",_("Spanish")),
			new Lang ("ES-419",_("Spanish (Latin American)")),
			new Lang ("SU",_("Sundanese")),
			new Lang ("SW",_("Swahili")),
			new Lang ("SV",_("Swedish")),
			new Lang ("TL",_("Tagalog")),
			new Lang ("TG",_("Tajik")),
			new Lang ("TA",_("Tamil")),
			new Lang ("TT",_("Tatar")),
			new Lang ("TE",_("Telugu")),
			new Lang ("TH",_("Thai")),
			new Lang ("TS",_("Tsonga")),
			new Lang ("TN",_("Tswana")),
			new Lang ("TR",_("Turkish")),
			new Lang ("TK",_("Turkmen")),
			new Lang ("UK",_("Ukrainian")),
			new Lang ("UR",_("Urdu")),
			new Lang ("UZ",_("Uzbek")),
			new Lang ("VI",_("Vietnamese")),
			new Lang ("CY",_("Welsh")),
			new Lang ("WO",_("Wolof")),
			new Lang ("XH",_("Xhosa")),
			new Lang ("YI",_("Yiddish")),
			new Lang ("ZU",_("Zulu"))
		};
	}
}
