/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Displays a nice gauge with API Usage. Said gauge is tied to settings keys, and updated on every request.
 * Includes a convenience button to refresh manually if needed.
 */
public class Inscriptions.ApiLevel : Gtk.Box {

    Gtk.LevelBar api_usage;
    Gtk.Spinner spinner;
    Gtk.Button refresh_button;

    construct {
        orientation = Gtk.Orientation.VERTICAL;
        spacing = MARGIN_MENU_BIG;

        /***************** LABEL AND BUTTON *****************/
        var cb = new Gtk.CenterBox ();

        var api_usage_label = new Gtk.Label (_("API Usage")) {
            halign = Gtk.Align.START
        };
        api_usage_label.add_css_class (Granite.STYLE_CLASS_H4_LABEL);
        cb.start_widget = api_usage_label;

        spinner = new Gtk.Spinner () {
            spinning = false,
            visible = false
        };


        refresh_button = new Gtk.Button.from_icon_name ("view-refresh") {
            tooltip_text = _("Update API usage")
        };

        var edit_key_button = new Gtk.Button.from_icon_name ("document-edit") {
        tooltip_text = _("Use a different API key of your choosing"),
        };
        edit_key_button.add_css_class (Granite.STYLE_CLASS_FLAT);
        edit_key_button.clicked.connect (() => {
            Application.backend.answer_received (StatusCode.NO_KEY, _("Requested by user"));
        });


        var minibox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, Inscriptions.SPACING_TOOLBAR_MINI) {
            valign = Gtk.Align.CENTER
        };

        minibox.append (edit_key_button);
        minibox.append (spinner);
        minibox.append (refresh_button);

        cb.end_widget = minibox;

        append (cb);

        /***************** LEVEL BAR *****************/
        api_usage = new Gtk.LevelBar ();
        api_usage.min_value = 0;
        append (api_usage);

        spinner.bind_property ("spinning",
         refresh_button, "visible",
         GLib.BindingFlags.INVERT_BOOLEAN | GLib.BindingFlags.SYNC_CREATE);

        spinner.bind_property ("spinning",
         spinner, "visible",
         GLib.BindingFlags.DEFAULT | GLib.BindingFlags.SYNC_CREATE);

        Application.settings_translate.bind (KEY_CURRENT_USAGE, api_usage, "value", SettingsBindFlags.DEFAULT);
        Application.settings_translate.bind (KEY_MAX_USAGE, api_usage, "max-value", SettingsBindFlags.DEFAULT);

        refresh_button.clicked.connect (on_refresh);
        Application.backend.answer_received.connect (updated_usage);
        Application.backend.usage_retrieved.connect (updated_usage);
        updated_usage ();
    }

    private void updated_usage () {
/*  
        // Depending on fill, usage 
        if (api_usage.value > api_usage.max_value) {
            api_usage.remove_css_class (Granite.STYLE_CLASS_SUCCESS);
            api_usage.remove_css_class (Granite.STYLE_CLASS_WARNING);
            api_usage.add_css_class (Granite.STYLE_CLASS_ERROR);

        } else if (api_usage.value > (api_usage.max_value / 2)) {
            api_usage.remove_css_class (Granite.STYLE_CLASS_SUCCESS);
            api_usage.add_css_class (Granite.STYLE_CLASS_WARNING);
            api_usage.remove_css_class (Granite.STYLE_CLASS_ERROR);

        } else {
            api_usage.add_css_class (Granite.STYLE_CLASS_SUCCESS);
            api_usage.remove_css_class (Granite.STYLE_CLASS_WARNING);
            api_usage.remove_css_class (Granite.STYLE_CLASS_ERROR);
        }  */

        // Picking from settings as im not super sure what fires first between connect and binds
        this.tooltip_text = _("%s characters translated / %s maximum characters on your plan").printf (
            Application.settings_translate.get_int (KEY_CURRENT_USAGE).to_string (),
            Application.settings_translate.get_int (KEY_MAX_USAGE).to_string ());

            spinner.spinning = false;
    }

    private void on_refresh () {
        spinner.spinning = true;
        Application.backend.check_usage ();
    }
}
