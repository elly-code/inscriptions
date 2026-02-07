/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Secret view for debbuging purposes, accessible via the switcher visible with Ctrl+Shift+M.
 * Both for developer convenience, and for cooperative users to access more informations on their issue.
 */
public class Inscriptions.TweaksView : Gtk.Box {

    Gtk.Scale delay_slider;
    Gtk.Label delay_slider_selected;

    construct {
        orientation = VERTICAL;
        spacing = 10;
        hexpand = vexpand = true;
        margin_top = margin_bottom = Inscriptions.MARGIN_MENU_BIGGER;
        margin_start = margin_end = Inscriptions.MARGIN_MENU_BIGGER;

        var stone_header = new Granite.SwitchModelButton (_("Stone header"));
        var auto_mode = new Granite.SwitchModelButton (_("Translate"));

        var delay_slider_box = new Gtk.CenterBox ();

        var delay_slider_label = new Gtk.Label (_("Debounce delay (ms)"));
        delay_slider = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 0.250, 5, 0.250) {
            width_request = 128
        };
        delay_slider.adjustment.step_increment = 0.250;

        delay_slider_selected = new Gtk.Label ("");
        var delay_slider_minibox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, Inscriptions.SPACING_TOOLBAR_MINI);
        delay_slider_minibox.append (delay_slider);
        delay_slider_minibox.append (delay_slider_selected);

        delay_slider_box.start_widget = delay_slider_label;
        delay_slider_box.end_widget = delay_slider_minibox;

        append (new OrientationBox ());
        append (stone_header);
        append (auto_mode);
        append (delay_slider_box);

        /***************** CONNECTS AND BINDS *****************/

        Application.settings.bind ("debounce",
            delay_slider.adjustment, "value",
            GLib.SettingsBindFlags.DEFAULT);

        delay_slider.adjustment.value_changed.connect (on_adjust_changed);
    }

    void on_adjust_changed () {
        delay_slider_selected.label = "%.2f".printf (delay_slider.adjustment.value);
    }
}