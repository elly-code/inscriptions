/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Simple button in a revealer, shown depending on settings
 */
public class Inscriptions.TranslateButton : Granite.Bin {

    construct {
        // var button_label = new Gtk.Label (_("Translate"));
        // var button_box = new Gtk.Box (HORIZONTAL, MARGIN_MENU_HALF);
        // button_box.append (new Gtk.Image.from_icon_name ("mail-send-symbolic"));
        // button_box.append (button_label);

        var translate_button = new Gtk.Button () {
            //child = button_box,
            label = _("Translate"),
            action_name = TranslationView.ACTION_PREFIX + TranslationView.ACTION_TRANSLATE,
            tooltip_markup = Granite.markup_accel_tooltip (
                {"<Control>Return", "<Ctrl>T"},
                _("Start translating the entered text")
            )
        };
        translate_button.add_css_class (Granite.STYLE_CLASS_SUGGESTED_ACTION);

        var translate_revealer = new Gtk.Revealer () {
            child = translate_button,
            transition_type = Gtk.RevealerTransitionType.SWING_RIGHT
        };
        child = translate_revealer;

        Application.settings_ui.bind (KEY_AUTO_TRANSLATE,
            translate_revealer, "reveal_child",
            SettingsBindFlags.INVERT_BOOLEAN
        );
    }
}
