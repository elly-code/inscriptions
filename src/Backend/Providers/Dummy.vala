/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */
/*  

/**
 *
 * Echo is intended as a test backend, and answers back whatever you send it, but modified
 * 
 * Each "language code" is just if uppercase, lowercase, unmodified... So we can text if the plumbing works
 * 
 * Funnily this could just be converted into some kind of text manipulation tool
 */

/*
public class Inscriptions.Dummy : Object, Inscriptions.Provider {

  construct {
      //supported_source_languages = { new Lang ("source", _("Source"))};
      //supported_target_languages = {
      //  new Lang ("echo", _("Echo")),
      //  new Lang ("up", _("Echo Up")),
      //  new Lang ("down", _("Echo Down")),
      //};

      //max_usage = 100;
  }

  //public void check_usage () {
  //  current_usage = Random.int_range (0, 101);
  //  usage_retrieved (200, current_usage, max_usage);
  //}

  //public void send_request (string text) {
  //  switch (target_lang) {
  //    case "echo": answer_received (200, text); return;
  //    case "up": answer_received (200, text.ascii_up ()); return;
  //    case "down": answer_received (200, text.ascii_down ()); return;
  //  }
  //}
}
  */

public class Inscriptions.Providers.Dummy : Object, Provider {

  public string get_name () {
    return "Echo";
  }

  public Inscriptions.Provider.ExtraFeatures get_supported_features () {
    return CHECK_USAGE | SET_CONTEXT | SET_FORMALITY;
  }

  public string[]? get_supported_formality () {
    return {"same"};
  }

  public Soup.Message prepare_translation_request (string api_key, Inscriptions.TranslationRequest request) {

    return new Soup.Message ("", "");
  }

  public AnswerData unwrap_translation_answer (string json_answer) {
    return AnswerData () {message = "", detected_language_code = ""};
  }

  public string unwrap_error (string json_answer) {
    return "oopsie daisie!";
  }

  public Soup.Message prepare_check_usage (string api_key) {
    return new Soup.Message ("", "");
  }

  public Usage unwrap_check_usage (string json_answer) {
    return Usage () {current = Random.int_range (0, 101), max = 100};
  }

  internal GLib.Settings? settings { get; set; }

  public Lang[] get_source_languages () {
    Lang[] langs = {
        new Lang ("whatever", _("whatever"))
    };
    return langs;
  }

  public Lang[] get_target_languages () {
    Lang[] langs = {
      new Lang ("up", _("ECHO UP")),
      new Lang ("same", _("Echo!")),
      new Lang ("down", _("echo down")),
    };
    return langs;
  }

  construct {
    settings = null;
  }
}