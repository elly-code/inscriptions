/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * a
 */
public class Inscriptions.BackendController : Object, BackendTemplate {

    private BackendType current_backend_type {get; set;}
    private BackendTemplate current_backend {get; set;}
    public signal void backend_changed (BackendType new_backend);

    public Lang[] supported_source_languages { get; set; }
    public Lang[] supported_target_languages { get; set; }

    // Ensure only once instance, accessible whenever needed.
    private static BackendController? instance;
    public static BackendController get_default () {
        if (instance == null) {
            instance = new BackendController ();
        }
        return instance;
    }

    construct {
        on_backend_changed ();
        Application.settings.changed[KEY_BACKEND].connect (on_backend_changed);
    }

    private void on_backend_changed () {
        var int_new_backend_type = Application.settings.get_enum (KEY_BACKEND);
        var new_backend = BackendType.from_int (int_new_backend_type);


        supported_source_languages = current_backend.supported_source_languages;
        supported_target_languages = current_backend.supported_target_languages;

        backend_changed (new_backend);
    }



  public string source_lang {
    get {return current_backend.source_lang;}
    set {current_backend.source_lang = value;}
}

  public string target_lang {
    get {return current_backend.target_lang;}
    set {current_backend.target_lang = value;}
}
  public uint status_code {
    get {return current_backend.status_code;}
    set {current_backend.status_code = value;}
}

  public void check_usage () {current_backend.check_usage ();}

  int current_usage {
    get {return current_backend.current_usage;}
    set {current_backend.current_usage = value;}
}
  int max_usage {
    get {return current_backend.max_usage;}
    set {current_backend.max_usage = value;}
}

 public void send_request (string text) {current_backend.send_request (text);}



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
			new Lang ("EN-GB",_("English (GB)")),
			new Lang ("EN-US",_("English (US)")),
			new Lang ("EO",_("Spanish (All)")),
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
