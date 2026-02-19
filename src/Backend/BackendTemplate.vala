/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */


 /*
The object has two signals:
  answer_received (translated_text): This one tells us we have translated text
  language_detected (detected_language_code): this one is to set language detected to detected language

  Handlers on the other side will know what to do with the signals.

  public void reload:
  Set the various object properties

  public void send_request (string text)
  allrounder for the service, takes a text to translate and takes care of the rest

  public string detect_system
  Detects what system language code we do be do having

  public string prep_json (string text)
  does the whole wrapping request into a json we can send

  public string unwrap_json (text_json)
  does the whole unwrapping response from a json we get back
 
 
  If you want to write your own backend, everything would pretty much work if you
   do a drop in replacement with send_request (text) and the two signals to retrieve
   i may open up a bit more the possibilities to do other BackendType in the future


  public void send_request (text);
  public signal void answer_received (string translated_text);
  public signal void language_detected (string? detected_language_code = null);
  public signal void usage_retrieved (int current_word_usage, int max_word_usage);

  public const string SUPPORTED_FORMALITY
public const SUPPORTED_SOURCE
public const SUPPORTED_TARGET

  */

// Translation service that use translate
public interface Inscriptions.BackendTemplate : Object {

  public abstract string source_lang {get; set;}
  public abstract string target_lang {get; set;}
  public abstract uint status_code {get; set;}

  /**
  * Connect to this signal to receive translated text
  */
  public signal void answer_received (uint status_code, string translated_text = "");

 /**
  * Connect to this signal to know when language is detected
  */
  public signal void language_detected (string? detected_language_code = null);

 /**
  * Call this 
  */
  public abstract void check_usage ();

 /**
  * Connect to this signal to get usage
  */
  public signal void usage_retrieved (uint status_code, int current_usage, int max_usage);
  public abstract int current_usage {get; set; default = 0;}
  public abstract int max_usage {get; set; default = 0;}

 /**
  * Call this method to send asynchronously a request.
  * Connect to answer_received to get a parsed answer
  */
  public abstract void send_request (string text);

 /**
  * Call this 
  */
  public abstract Lang[] supported_source_languages {get; internal set;}
  public abstract Lang[] supported_target_languages  {get; internal set;}
}
