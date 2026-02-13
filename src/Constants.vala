/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

namespace Inscriptions {

	// Alkrjnlgjrt
	public const string RDNN = "io.github.elly_code.inscriptions";  
	public const string DONATE_LINK = "https://ko-fi.com/teamcons";
	public const string LINK = "https://www.deepl.com/your-account/keys";
    public const int DEBOUNCE_INTERVAL = 1250; // ms

	// Styling
    public const string STYLE_CLASS_COLORED_HEADER = "primary-background";
    public const string STYLE_CLASS_ROTATED = "rotated";

	public const int SPACING_TOOLBAR_HEADER = 5;
	public const int SPACING_TOOLBAR_MINI = 3;

	public const int MARGIN_MENU_HALF = 3;
	public const int MARGIN_MENU_STANDARD = 6;
	public const int MARGIN_MENU_BIG = 12;
	public const int MARGIN_MENU_BIGGER = 24;

	// Autocomplete, save me!
	// Windows
	public const string KEY_WINDOW_HEIGHT = "window-height";
	public const string KEY_WINDOW_WIDTH = "window-width";
	public const string KEY_WINDOW_MAXIMIZED = "window-maximized";

	// UI
	public const string KEY_VERTICAL_LAYOUT = "vertical-layout";
	public const string KEY_AUTO_TRANSLATE = "auto-translate";
	public const string KEY_HIGHLIGHT = "highlight";

	// Backend
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

	public Lang[] TargetLang () {
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
