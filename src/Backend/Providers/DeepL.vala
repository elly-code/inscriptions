/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */
/*  

/**
 * Bespoke and soft like a bnuy
 * 
 */
public class Inscriptions.Providers.DeepL : Object, Provider {

  const string URL_DEEPL_FREE = "https://api-free.deepl.com";
  const string URL_DEEPL_PRO = "https://api.deepl.com";
  const string REST_OF_THE_URL = "/v2/translate";
  const string URL_USAGE = "/v2/usage";

  public string get_name () {
    return "DeepL";
  }

  public string get_auth_header () {
    return ProviderType.DEEPL.to_secrets_label ();
  }

  public Inscriptions.Provider.Features get_supported_features () {
    return CHECK_USAGE | SET_CONTEXT | SET_FORMALITY;
  }

  public string[] get_supported_formality () {
    return {"DE", "FR", "IT", "ES", "ES-419", "NL", "PL", "PT-BR", "PT-PT", "JA", "RU"};
  }

  private string get_correct_url (string api_key) {

    if (api_key.has_suffix (":fx")) {
      return URL_DEEPL_FREE;
    }
    
    return URL_DEEPL_PRO;
  }


  internal Bytes wrap_request_into_json (Inscriptions.TranslationRequest request) {

    var builder = new Json.Builder ();
    builder.begin_object ();
    builder.set_member_name ("text");
    builder.begin_array ();
    builder.add_string_value (request.text_to_translate);
    builder.end_array ();

    if (request.source_language_code != "idk") {
      builder.set_member_name ("source_lang");
      builder.add_string_value (request.source_language_code);
    }

    builder.set_member_name ("target_lang");
    builder.add_string_value (request.target_language_code);

    if (request.context != "") {
      builder.set_member_name ("context");
      builder.add_string_value (request.context);
    }

    if (request.target_language_code in get_supported_formality ()) {
      builder.set_member_name ("formality");
      builder.add_string_value (request.formality_level.to_string ());
    }

    builder.set_member_name ("show_billed_characters");
    builder.add_boolean_value (true);

    builder.end_object ();

    Json.Generator generator = new Json.Generator ();
    generator.set_root (builder.get_root ());
    string str = generator.to_data (null);

    return new Bytes (str.data);
  }

  public Soup.Message prepare_translation_request (string api_key, Inscriptions.TranslationRequest request) {

    var base_url = get_correct_url (api_key);
    var soup_message= new Soup.Message ("POST", base_url + REST_OF_THE_URL);
    soup_message.request_headers.append ("Content-Type", "application/json");
    soup_message.request_headers.append ("User-Agent", USER_AGENT);
    soup_message.request_headers.append ("Authorization", "%s %s".printf (get_auth_header (), api_key));
    soup_message.set_request_body_from_bytes ("application/json", wrap_request_into_json (request));   

    return soup_message;
  }

  public Soup.Message prepare_check_usage (string api_key) {

    var base_url = get_correct_url (api_key);
    var soup_message= new Soup.Message ("GET", base_url + URL_USAGE);
    soup_message.request_headers.append ("Content-Type", "application/json");
    soup_message.request_headers.append ("User-Agent", USER_AGENT);
    soup_message.request_headers.append ("Authorization", "%s %s".printf (get_auth_header (), api_key));

    return soup_message;
  }

  public AnswerData unwrap_translation_answer (string json_answer) {

    var parser = new Json.Parser ();
    try {
      parser.load_from_data (json_answer);
    
    } catch (Error e) {
      print ("\nCannot: " + e.message);
      return AnswerData () {message = json_answer, detected_language_code = ""};
    }

    var objects = parser.get_root ().get_object ();
    var array = objects.get_array_member ("translations");
    var translation = array.get_object_element (0);
    var billed_characters = (int)translation.get_int_member_with_default ("billed_characters", 0);

    //current_usage = current_usage + billed_characters;
    //Application.settings_translate.set_int (KEY_CURRENT_USAGE, current_usage);

    var detected_language_code = translation.get_string_member_with_default ("detected_source_language", (_("Cannot detect!")));
    string translated_text = translation.get_string_member_with_default ("text", _("Cannot retrieve translated text!"));

    return AnswerData () {message = translated_text, detected_language_code = detected_language_code};
  }

  public Usage unwrap_check_usage (string json_answer) {

    var parser = new Json.Parser ();
    try {
      parser.load_from_data (json_answer);
    
    } catch (Error e) {
      print ("\nCannot: " + e.message);
      return Usage () {current = -1, max = -1};
    }

    var objects = parser.get_root ().get_object ();
    var current_usage = (int)objects.get_int_member ("character_count");
    var max_usage = (int)objects.get_int_member ("character_limit");

    return Usage () {current = current_usage, max = max_usage};
  }

  public string unwrap_error (string json_answer) {

    var parser = new Json.Parser ();
    try {    
      parser.load_from_data (json_answer);
    } catch (Error e) {
      print ("\nCannot: " + e.message);
      return json_answer;
    }

    var objects = parser.get_root ().get_object ();
    return objects.get_string_member_with_default ("message", _("Cannot retrieve error message text!"));
  }

  internal GLib.Settings? settings { get; set; }

  public Lang[] get_source_languages () {
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

  public Lang[] get_target_languages () {
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

  construct {
    settings = null;
  }
}
