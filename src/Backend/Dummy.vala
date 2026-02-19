/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

// Translation service that use translate
public class Inscriptions.Dummy : Object, BackendTemplate {

  string source_lang {get; set;}
  string target_lang {get; set;}
  public uint status_code { get; set; }
  public Lang[] supported_source_languages { get; set; }
  public Lang[] supported_target_languages { get; set; }

  public int current_usage { get; set; }
  public int max_usage { get; set; }

  construct {
      supported_source_languages = { new Lang ("source", _("Source"))};
      supported_target_languages = {
        new Lang ("echo", _("Echo")),
        new Lang ("up", _("Echo Up")),
        new Lang ("down", _("Echo Down")),
      };

      max_usage = 100;
  }

  public void check_usage () {
    current_usage = Random.int_range (0, 101);
    usage_retrieved (200, current_usage, max_usage);
  }

  public void send_request (string text) {
    switch (target_lang) {
      case "echo": answer_received (200, text); return;
      case "up": answer_received (200, text.ascii_up ()); return;
      case "down": answer_received (200, text.ascii_down ()); return;
    }
  }
}
