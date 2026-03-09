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

  public signal void language_changed (string code = "");

  public LanguageDropDown (Lang[] languages) {

    hexpand = true;
    model = new Inscriptions.DDModel ();

    foreach (var language in languages) {
      model.model_append (language);
    }

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
    dropdown.notify["selected-item"].connect (on_selected_language);
  }

  private void on_selected_language () {
      var selected_lang = dropdown.get_selected_item () as Lang;
      language_changed (selected_lang.code);
  }

  private void set_selected_language (string code) {
    var position = model.model_where_code (code);
    dropdown.set_selected (position);
  }

  private string get_selected_language () {
      var selected_lang = dropdown.get_selected_item () as Lang;
      return selected_lang.code;
  }
}
