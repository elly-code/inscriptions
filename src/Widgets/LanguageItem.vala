/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Used by DDModel to display Lang items in a Pane Dropdown
 */
public class Inscriptions.LanguageItem : Gtk.Box {

  public string language_label {get; set;}
  public string language_code {get; set;}

  Gtk.Label label_widget;
  Gtk.Image selected_emblem;

  public bool selected {
    get {
      return selected_emblem.visible;
    }
    set {
      if (value) {
        label_widget.add_css_class ("bold");

      } else {
        label_widget.remove_css_class ("bold");

      }
      selected_emblem.visible = value;
    }
  }

  public LanguageItem (string language_label, string language_code) {
    Object (
      language_label: language_label,
      language_code: language_code,
      orientation: Gtk.Orientation.HORIZONTAL,
      spacing: 0,
      halign: Gtk.Align.FILL,
      hexpand: true,
      valign: Gtk.Align.CENTER
    );
  }

  construct {
    selected_emblem = new Gtk.Image.from_icon_name ("emblem-default-symbolic") {
      visible = false,
      halign = Gtk.Align.END,
      valign = Gtk.Align.CENTER,
      margin_end = MARGIN_MENU_BIG
    };
    selected_emblem.add_css_class (Granite.STYLE_CLASS_FLAT);

    label_widget = new Gtk.Label (language_label) {
      halign = Gtk.Align.CENTER,
      hexpand = true,
      xalign = 0.5f
    };

    var overlay = new Gtk.Overlay () {
      child = label_widget
    };
    overlay.add_overlay (selected_emblem);
    append (overlay);


    /* ---------- CONNECTS AND BINDS ---------- */
    bind_property ("language-label",
      label_widget, "label",
      GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);
  }

  public void on_position_changed (string language_code_selected) {
    //print ("ADJUST! ");
    selected = language_code_selected == language_code;
  }

  public void on_greyout_changed (string language_code_greyout) {
    //print ("ADJUST! ");

    if (language_code_greyout == language_code) {
      sensitive = false;

    } else {
      sensitive = true;
    }
  }
}
