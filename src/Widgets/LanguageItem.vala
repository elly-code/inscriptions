/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Used by DDModel to display Lang items in a Pane Dropdown
 */
public class Inscriptions.LanguageItem : Gtk.Box {

  public string language_label {get; set;}
  public string language_code {get; set;}

  Gtk.Label label_widget;
  Gtk.Image selected_emblem;

  public LanguageItem (string language_label, string language_code) {
    Object (
      language_label: language_label,
      language_code: language_code,
      orientation: Gtk.Orientation.HORIZONTAL,
      spacing: 0,
      halign: Gtk.Align.FILL,
      hexpand: true
    );
  }

  construct {
    selected_emblem = new Gtk.Image.from_icon_name ("emblem-default-symbolic") {
      visible = false,
      halign = Gtk.Align.END
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

    bind_property ("language-label",
      label_widget, "label",
      GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);
  }

  public void on_position_changed (string language_code_selected) {

    if (language_code_selected == language_code) {
      label_widget.add_css_class ("bold");
      selected_emblem.visible = true;

    } else {
      label_widget.remove_css_class ("bold");
      selected_emblem.visible = false;
    }
  }
}
