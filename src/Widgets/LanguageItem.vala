/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Used by DDModel to display Lang items in a Pane Dropdown
 */
public class Inscriptions.LanguageItem : Gtk.Box {

  public uint position {get; construct;}
  public bool selected {get; set; default = false;}
  public string label {get; set; default = "";}

  Gtk.Label label_widget;
  Gtk.Image selected_emblem;

  public LanguageItem (uint position, string label) {
    Object (
      position: position,
      label: label,
      orientation: Gtk.Orientation.HORIZONTAL,
      spacing: Inscriptions.SPACING_TOOLBAR_HEADER,
      halign: Gtk.Align.CENTER,
      hexpand: true
    );
  }

  construct {
    label_widget = new Gtk.Label (label);
    selected_emblem = new Gtk.Image.from_icon_name ("emblem-default-symbolic") {
      visible = selected
    };

    append (label_widget);
    append (selected_emblem);

    bind_property ("label",
      label_widget, "label",
      GLib.BindingFlags.DEFAULT);

    bind_property ("selected",
      selected_emblem, "visible",
      GLib.BindingFlags.DEFAULT);
  }
}
