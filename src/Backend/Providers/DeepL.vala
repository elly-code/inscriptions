/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */
/*  

/**
 * Bespoke and soft like a bnuy
 * 
 */
/*  public class Inscriptions.Providers.DeepL : Object, Provider {

  const string URL_DEEPL_FREE = "https://api-free.deepl.com";
  const string URL_DEEPL_PRO = "https://api.deepl.com";
  const string REST_OF_THE_URL = "/v2/translate";
  const string URL_USAGE = "/v2/usage";

  public string get_name () {
    return "DeepL";
  }

  public Inscriptions.Provider.ExtraFeatures get_supported_features () {
    return CHECK_USAGE | SET_CONTEXT | SET_FORMALITY;
  }

  public string[]? get_supported_formality () {
    return {"DE", "FR", "IT", "ES", "ES-419", "NL", "PL", "PT-BR", "PT-PT", "JA", "RU"};
  }

  public Soup.Message prepare_translation_request (string api_key, Inscriptions.TranslationRequest request) {

    return new Soup.Message ("", "");
  }

  public AnswerData unwrap_translation_answer (string json_answer, bool is_error) {

    return AnswerData () {message = "", detected_language_code = ""};
  }

  public Soup.Message? prepare_check_usage (string api_key) {
    return null;
  }

  public Usage unwrap_check_usage (string json_answer, bool is_error) {
    return Usage () {current = 0, max = 0};
  }

  internal GLib.Settings? settings { get; set; }

  public Lang[] get_source_languages () {

  }

  public Lang[] get_target_languages () {

  }

  construct {
    settings = null;
  }
}  */
