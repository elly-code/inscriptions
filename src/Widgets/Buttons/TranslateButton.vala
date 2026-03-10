/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Simple two-buttons horizontal box using in SettingsPopover to toggle view
 */
public class Inscriptions.TranslateButton : Granite.Bin {

    construct {
        //TRANSLATORS: The two following texts are for a button. The functionality is diabled. You can safely ignore these.
        var translate_button = new Gtk.Button () {
            label = _("Translate"),
            tooltip_markup = Granite.markup_accel_tooltip (
                {"<Control>Return", "<Ctrl>T"}, 
                _("Start translating the entered text")
            )
        };

        translate_button.add_css_class (Granite.STYLE_CLASS_SUGGESTED_ACTION);
        translate_button.action_name = TranslationView.ACTION_PREFIX + TranslationView.ACTION_TRANSLATE;

        var translate_revealer = new Gtk.Revealer () {
            child = translate_button,
            transition_type = Gtk.RevealerTransitionType.SWING_RIGHT
        };
        child = translate_revealer;

        Application.settings.bind (KEY_AUTO_TRANSLATE,
            translate_revealer, "reveal_child",
            SettingsBindFlags.INVERT_BOOLEAN
        );
    }
}
