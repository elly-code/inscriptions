/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Simple button. I dont wanna define a button twice.
 */
public class Inscriptions.TranslateButton : Gtk.Button {

    construct {
        label = _("Translate");
        action_name = TranslationView.ACTION_PREFIX + TranslationView.ACTION_TRANSLATE;
 
        tooltip_markup = Granite.markup_accel_tooltip (
            {"<Control>Return", "<Ctrl>T"},
            _("Start translating the entered text")
        );

        add_css_class (Granite.STYLE_CLASS_SUGGESTED_ACTION);
    }
}
