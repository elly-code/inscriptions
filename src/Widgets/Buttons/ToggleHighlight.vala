/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Simple two-buttons horizontal box using in SettingsPopover to toggle view
 */
public class Inscriptions.ToggleHighlight : Gtk.Button {

    bool _active;
    public bool active {
        get {
            return _active;
        }
        set {
            if (value) {
                icon_name = "eye-not-looking-symbolic";
                tooltip_markup = Granite.markup_accel_tooltip (
                    {"<Ctrl>H"},
                    _("Hide highlighting")
                );

            } else {
                icon_name = "eye-open-negative-filled-symbolic";
                    tooltip_markup = Granite.markup_accel_tooltip (
                    {"<Ctrl>H"},
                    _("Show highlight for source and target sentences")
                );

            }
            _active = value;
        }
    }

    construct {
        clicked.connect (() => {active = !active;});

        Application.settings_ui.bind (KEY_HIGHLIGHT,
            this, "active",
            SettingsBindFlags.DEFAULT
        );
    }
}
