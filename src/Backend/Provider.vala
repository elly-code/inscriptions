/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

 /**
  * a
  * 
  */
public interface Inscriptions.Provider : Object {

  internal const string PROVIDER_SETTINGS_PREFIX = "";
#if WINDOWS
  internal const string USER_AGENT = APP_ID + "-" + APP_VERSION + " (Windows)";
#else
  internal const string USER_AGENT = APP_ID + "-" + APP_VERSION + " (Linux)";
#endif

  [Flags]
  public enum ExtraFeatures {
      NONE,
      CHECK_USAGE,
      SET_FORMALITY,
      SET_CONTEXT
  }

  public struct Usage {int current; int max;}
  public struct AnswerData {string message; string detected_language_code;}

  /**
   * NONE is for providers who can only translate, nothing else
   * 
   * CHECK_USAGE: Providers should have an implementation of {@link Provider.prepare_check_usage} and {@link Provider.unwrap_check_usage}
   * 
   * SET_FORMALITY and SET_CONTEXT: {@link Inscriptions.TranslationRequest} contains both. Simply ignore it/null it if unsupported.
   */
  public abstract string get_name ();
  public abstract ExtraFeatures get_supported_features ();
  public virtual string[]? get_supported_formality () {return {};}

  /**
   * Managing their internal settings is up to the provider
   */
  internal abstract Settings? settings {get; set; default = null;}



  /**
   * Provider gets as much info as possible, to allow it maximum flexibility
   * 
   * The message is sent by the backend itself
   */
  public abstract Soup.Message prepare_translation_request (string api_key, Inscriptions.TranslationRequest request);

  /**
   * Errors and the explanation given by the provider should be handled and returned if the status code is not OK
   * 
   */
  public abstract AnswerData unwrap_translation_answer (string json_answer);

  public abstract string unwrap_error (string json_answer);

  /**
   * Override this if your backend supports CHECK_USAGE
   * 
   */
  public virtual Soup.Message prepare_check_usage (string api_key) {return new Soup.Message ("", "");}
  public virtual Usage unwrap_check_usage (string json_answer) {return Usage () {current = 0, max = 0};}


  public abstract Lang[] get_source_languages ();
  public abstract Lang[] get_target_languages ();
}
