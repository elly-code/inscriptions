/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * A convenience wrapper allowing to build the DropDown we want with a list of languages, and access selection and changes easily
 */
public class Inscriptions.LanguageDropDown : Granite.Bin {

  Inscriptions.DDModel model;
  Gtk.DropDown dropdown;

  public string selected {
    owned get { return get_selected_language ();}
    set { set_selected_language (value);}
  }

  /**
   * Emitted by the widget for others to update themselves
   */
  public signal void language_changed (string code = ""); // Listened to by others

  /**
   * Called by other elements for the DD to update what to grey out
   */
  public signal void update_greyout (string code = "");

  construct {
    hexpand = true;
    model = new Inscriptions.DDModel ();

    var expression = new Gtk.PropertyExpression (typeof (Inscriptions.Lang), null, "both");
    dropdown = new Gtk.DropDown (model.model, expression) {
      factory = model.factory_header,
      list_factory = model.factory_list,
      enable_search = true,
      search_match_mode= Gtk.StringFilterMatchMode.SUBSTRING,
      show_arrow = false,
      hexpand = true
    };

    child = dropdown;

    /* ---------------- CONNECTS AND BINDS ---------------- */
    model.language_changed.connect (on_language_changed);
    update_greyout.connect (on_update_greyout);
  }

  private void on_language_changed (string language_code) {
    //var selected_lang = dropdown.get_selected_item () as Lang; 
    //print ("\nSELECTED %s\n".printf (selected_lang.code));
    //language_changed (selected_lang.code);
    language_changed (language_code);
  }

  private void on_update_greyout (string language_code) {
    //var selected_lang = dropdown.get_selected_item () as Lang;
    //print ("\nUPDATE GREYOUT %s\n".printf (language_code));
    //language_changed (selected_lang.code);
    model.update_greyout (language_code);
  }

  private void set_selected_language (string code) {
    var position = model.model_where_code (code);
    dropdown.set_selected (position);
    language_changed (code);
  }

  private string get_selected_language () {
    var selected_lang = dropdown.get_selected_item () as Lang;
    return selected_lang.code;
  }

  public void add_languages (Lang[] languages) {
    foreach (var language in languages) {
      model.model_append (language);
    }
  }
}
