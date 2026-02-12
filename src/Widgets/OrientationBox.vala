/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Simple two-buttons horizontal box using in SettingsPopover to toggle view
 */
public class Inscriptions.OrientationBox : Gtk.Box {


    construct {
        homogeneous = true;
        hexpand = true;
        margin_start = MARGIN_MENU_BIG;
        margin_end = MARGIN_MENU_BIG;
        margin_bottom = MARGIN_MENU_HALF;

        var box_horiz = new Gtk.Box (HORIZONTAL, MARGIN_MENU_HALF) {
            halign = Gtk.Align.CENTER
        };
        box_horiz.append (new Gtk.Image.from_icon_name ("view-dual"));
        box_horiz.append (new Gtk.Label (_("Horizontal")));

        var toggle_horizontal = new Gtk.ToggleButton () {
            child = box_horiz,
            tooltip_text = _("Switch the view to horizontally aligned panes")
        };
        //toggle_horizontal.add_css_class ("rotated");


        var box_vert = new Gtk.Box (HORIZONTAL, MARGIN_MENU_HALF) {
            halign = Gtk.Align.CENTER
        };
        //TRANSLATORS: This refers to the view: Either the panels are stacked vertically, or lined horizontally
        box_vert.append (new Gtk.Image.from_icon_name ("view-dual"));
        box_vert.append (new Gtk.Label (_("Vertical")));
        box_vert.add_css_class (STYLE_CLASS_ROTATED);

        var toggle_vertical = new Gtk.ToggleButton () {
            child = box_vert,
            tooltip_text = _("Switch the view to vertically stacked panes")
        };

        /***************** CONNECTS *****************/
        Application.settings.bind (KEY_VERTICAL_LAYOUT,
            toggle_horizontal, "active",
            SettingsBindFlags.INVERT_BOOLEAN
        );

        Application.settings.bind (KEY_VERTICAL_LAYOUT,
            toggle_vertical, "active",
            SettingsBindFlags.DEFAULT
        );

        append (toggle_horizontal);
        append (toggle_vertical);

        add_css_class (Granite.STYLE_CLASS_LINKED);
    }
}
