/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

namespace Inscriptions.DeepLUtils {

  // FUCKY: DeepL is a bit weird with some codes
  // We have to hack at it for edge cases
  public string detect_system () {
    string system_language = Environment.get_variable ("LANG").ascii_up ();
    var minicode = system_language.substring (0, 2).ascii_up (-1);

    if (system_language == "C") {return "EN-GB";}
    if (system_language.has_prefix ("PT_BR")) {return "PT-BR";}
    if (system_language.has_prefix ("PT_PT")) {return "PT-PT";}
    if (system_language.has_prefix ("ZH_CN")) {return "ZH-HANS";}
    if (system_language.has_prefix ("ZH_TW")) {return "ZH-HANT";}
    if (system_language.has_prefix ("EN_GB")) {return "EN-GB";}
    if (system_language.has_prefix ("EN_US")) {return "EN-US";}
    if (system_language.has_prefix ("NO")) {return "NB";}
    if ((system_language.has_prefix ("ES_")) && (system_language.substring (0, 5) != "ES_ES")) {
      return "ES-419";
    }

    //print ("\nBackend: Detected system language: " + minicode);
    return minicode;
  }

  internal Bytes wrap_request_into_json (Inscriptions.TranslationRequest request, string[] supported_formality) {
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

    if (request.target_language_code in supported_formality) {
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

}
