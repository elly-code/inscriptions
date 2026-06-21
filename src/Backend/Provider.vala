/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

 /**
  * a
  * 
  */
public interface Provider : Object {

  // Language codes. If null the backend does not support formality
  public abstract const string[]? SUPPORTS_FORMALITY = null;

  // Whether
  public abstract const bool SUPPORTS_CONTEXT = false;



  public abstract Soup.Message prepare_message (Inscriptions.TranslationRequest request, string api_key);


  public abstract string unwrap_json (string json_answer);

  public abstract void usage (out int current, out int max);


}
