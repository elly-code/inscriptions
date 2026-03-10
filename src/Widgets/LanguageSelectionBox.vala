/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Small horizontal box containing Source and Target dropdowns and a switch languages button
 */
public class Inscriptions.LanguageSelectionBox : Gtk.Box {

  public LanguageDropDown dropdown_source {get; set;}
  public LanguageDropDown dropdown_target {get; set;}

  public string selected_source {
        owned get { return get_selected_language (true);}
        set { set_selected_language (value, true);}
  }

  public string selected_target {
        owned get { return get_selected_language (false);}
        set { set_selected_language (value, false);}
  }

  public signal void source_changed (string code = "");
  public signal void target_changed (string code = "");

  construct {
    orientation = Gtk.Orientation.HORIZONTAL;
    spacing = 0;
    hexpand = true;

    /* ---------------- SOURCE ---------------- */
    dropdown_source = new LanguageDropDown (Inscriptions.SourceLang ()) {
      tooltip_text = _("Set the language to translate from")
    };

    //TRANSLATORS: This is for a button that switches source and target language
    var switchlang_button = new Gtk.Button.from_icon_name ("media-playlist-repeat-symbolic") {
      tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>I"}, _("Switch languages"))
    };
    switchlang_button.action_name = TranslationView.ACTION_PREFIX + TranslationView.ACTION_SWITCH_LANG;

    dropdown_target = new LanguageDropDown (Inscriptions.SourceLang ()) {
      tooltip_text = _("Set the language to translate to")
    };



    var cb = new Gtk.CenterBox () {
      hexpand = true
    };

    cb.start_widget = dropdown_source;
    cb.center_widget = switchlang_button;
    cb.end_widget = dropdown_target;

    append (cb);

    /* ---------------- CONNECTS AND BINDS ---------------- */

    selected_source = Application.settings.get_string (KEY_SOURCE_LANGUAGE);
    selected_target = Application.settings.get_string (KEY_TARGET_LANGUAGE);

    dropdown_source.language_changed.connect (on_source_changed);
    dropdown_target.language_changed.connect (on_target_changed);
  }


  private void set_selected_language (string code, bool is_source) {
    if (is_source) {
      dropdown_source.selected = code;

    } else {
      dropdown_target.selected = code;
    }

    print ("Set " + code + " Source?" + is_source.to_string () + "\n");
  }

  private string get_selected_language (bool is_source) {
    if (is_source) {
      //print ("is selected " + selected.code + selected.name + "\n");
      return dropdown_source.selected;

    } else {
      //print ("is selected " + selected.code + selected.name + "\n");
      return dropdown_target.selected;
    }
  }

  private void on_source_changed (string language_code) {
    Application.settings.set_string (KEY_SOURCE_LANGUAGE, language_code);
    source_changed (language_code);
  }

  private void on_target_changed (string language_code) {
    Application.settings.set_string (KEY_TARGET_LANGUAGE, language_code);
    target_changed (language_code);
  }
}
