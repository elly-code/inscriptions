/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

 /**
 * Popover for the rightmost button. Kept to a minimum, and allows quick access to the user
 */
public class Inscriptions.SettingsPopover : Gtk.Popover {

  //Inscriptions.ApiEntry api_entry;
  //Gtk.Revealer usage_revealer;

  construct {
    width_request = 280;
    halign = Gtk.Align.CENTER;

    // Allow scrolling shenanigans from popover
    add_binding_action (Gdk.Key.plus, Gdk.ModifierType.CONTROL_MASK, ZoomController.ACTION_PREFIX + ZoomController.ACTION_ZOOM_IN, null);
    add_binding_action (Gdk.Key.equal, Gdk.ModifierType.CONTROL_MASK, ZoomController.ACTION_PREFIX + ZoomController.ACTION_ZOOM_DEFAULT, null);    
    add_binding_action (48, Gdk.ModifierType.CONTROL_MASK, ZoomController.ACTION_PREFIX + ZoomController.ACTION_ZOOM_DEFAULT, null);
    add_binding_action(Gdk.Key.minus, Gdk.ModifierType.CONTROL_MASK, ZoomController.ACTION_PREFIX + ZoomController.ACTION_ZOOM_OUT, null);

    var box = new Gtk.Box (VERTICAL, MARGIN_MENU_BIG) {
      margin_top = MARGIN_MENU_BIG,
      margin_bottom = MARGIN_MENU_STANDARD
    };

    /* -------------------- SEPARATOR -------------------- */

    var auto_switch = new Granite.SwitchModelButton (_("Translate automatically")) {
      description = _("Translation will start %.2f seconds after typing".printf (DEBOUNCE_IN_S)),
      hexpand = true
    };

    var highlight_switch = new Granite.SwitchModelButton (_("Highlight source and target")) {
      description = _("Each sentence will be highlighted to help compare both texts (Ctrl+H)"),
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

    var zoombox = new Inscriptions.ZoomBox ();

    box.append (zoombox);
    box.append (new OrientationBox ());
    box.append (new Gtk.Separator (HORIZONTAL));
    box.append (auto_switch);
    box.append (highlight_switch);
    
/*          var edit_key_button = new Gtk.Button () {
          child = new Gtk.Label ((_("Set up translation provider"))) {halign = Gtk.Align.START},
          tooltip_text = _("Use a different API key of your choosing"),
          hexpand = true
        };
        edit_key_button.add_css_class (Granite.STYLE_CLASS_MENUITEM);
        edit_key_button.clicked.connect (() => {
            Application.backend.answer_received (StatusCode.NO_KEY, _("Requested by user"));
        });

      box.append (edit_key_button);  */


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

    Application.settings_ui.bind (KEY_ZOOM, 
      zoombox, "zoom", 
      SettingsBindFlags.DEFAULT);
  }
}
