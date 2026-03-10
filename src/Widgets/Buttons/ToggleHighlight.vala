/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Simple two-buttons horizontal box using in SettingsPopover to toggle view
 */
public class Inscriptions.ToggleHighlight : Granite.ModeSwitch {

    public ToggleHighlight () {
        base.from_icon_name ("eye-not-looking-symbolic", "eye-open-negative-filled-symbolic");
    }

    construct {
        tooltip_markup = Granite.markup_accel_tooltip (
            {"<Ctrl>H"},
            _("Highlight source and target sentences")
        );

        Application.settings.bind (KEY_HIGHLIGHT,
            this, "active",
            SettingsBindFlags.DEFAULT
        );
    }
}
