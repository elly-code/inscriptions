/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Small horizontal box to simulate return codes in the LogView.
 * It mostly just sends signals on the backend behalf for valid codes.
 */
public class Inscriptions.LogToolbar : Gtk.Box {

  int status_code = 200;

  construct {
    orientation = Gtk.Orientation.HORIZONTAL;
    spacing = 0;

    /* ---------- SEND BUTTON ---------- */
    var send_button_label = new Gtk.Label (_("Receive status code: "));
    var send_button_box = new Gtk.Box (HORIZONTAL, 0);
    send_button_box.append (new Gtk.Image.from_icon_name ("mail-send-symbolic"));
    send_button_box.append (send_button_label);

    var send_button = new Gtk.Button () {
      child = send_button_box,
      tooltip_text = _("Simulate a fake status code answer for debugging purposes")
    };
    send_button.add_css_class (Granite.STYLE_CLASS_FLAT);


    /* ---------- Status code selector ---------- */

    //  string[] choices = {
    //    "Manual",
    //    "",
    //    "",
    //    "",
    //    ""
    //  };
    //  var selector = new Gtk.DropDown.from_strings (choices);




    /* ---------- Code entry ---------- */
    Granite.ValidatedEntry entry;
    Regex? regex = null;
    try {
        regex = new Regex ("^[0-9]*$");
    } catch (Error e) {
        critical (e.message);
    }

    entry = new Granite.ValidatedEntry.from_regex (regex) {
      text = status_code.to_string (),
      max_width_chars = 4,
      max_length = 3
    };

    append (send_button);
    append (entry);

    entry.changed.connect (() => {
      if (entry.is_valid) {
        status_code = int.parse (entry.text);
        //send_button.label = _("Receive %i").printf (status_code);
      }
    });

    /* ---------- CONNECTS AND BINDS ---------- */
    send_button.clicked.connect (() => {
      Application.backend.answer_received (status_code, _("Simulated status code"));
    });
  }
}
