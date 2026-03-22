/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

 /**
 * Popover for the rightmost button. Kept to a minimum, and allows quick access to the user
 */
public class Inscriptions.SettingsPopover : Gtk.Popover {

  Inscriptions.ApiEntry api_entry;
  Gtk.Revealer usage_revealer;

  construct {
    width_request = 240;

    var box = new Gtk.Box (VERTICAL, 9) {
      margin_top = MARGIN_MENU_BIG,
      margin_bottom = MARGIN_MENU_STANDARD
    };

    /* -------------------- SEPARATOR -------------------- */

    var auto_switch = new Granite.SwitchModelButton (_("Translate automatically")) {
      description = _("The translation will start %.2f seconds after typing has stopped".printf (DEBOUNCE_IN_S)),
      hexpand = true
    };

    var highlight_switch = new Granite.SwitchModelButton (_("Highlight source and target sentences")) {
      description = _("Each line will be highlighted a different color to help compare both texts (Ctrl+H)"),
      hexpand = true
    };


    /* -------------------- SEPARATOR -------------------- */

    var support_button = new Gtk.LinkButton.with_label (DONATE_LINK, _("Support us!")) {
      halign = Gtk.Align.START,
      hexpand = true,
      margin_bottom = MARGIN_MENU_STANDARD,
      margin_start = MARGIN_MENU_BIG
    };

    var api_level = new ApiLevel () {
      margin_top = MARGIN_MENU_HALF,
      margin_start = MARGIN_MENU_BIG,
      margin_end = MARGIN_MENU_BIG
    };

    box.append (new OrientationBox ());
    box.append (new Gtk.Separator (HORIZONTAL));
    box.append (auto_switch);
    //box.append (highlight_switch);
    //box.append (edit_key_button);

    box.append (api_level);
    box.append (new Gtk.Separator (HORIZONTAL));
    box.append (support_button);

    child = box;

    /* -------------------- CONNECTS AND BINDS -------------------- */

    Application.settings_ui.bind (KEY_AUTO_TRANSLATE, 
      auto_switch, "active", 
      SettingsBindFlags.DEFAULT);

    Application.settings_ui.bind (KEY_HIGHLIGHT, 
      highlight_switch, "active", 
      SettingsBindFlags.DEFAULT);
  }
}
