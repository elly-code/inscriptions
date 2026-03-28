/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Flexible view created then shown when backend communicates an error code via @StatusCode
 * Depending on the code it receives, explanations, options, and details are shown, with an additional ErrorBox
 */
public class Inscriptions.ErrorView : Granite.Bin {

    const uint WAIT_BEFORE_MAIN = 1500; //In milliseconds

    ErrorBonusBox bonusbox;

    public uint status { get; construct; }
    public string message { get; construct; }

    string icon_name;
    string explanation_title;
    string explanation_text;
    bool report_link;

    public signal void return_to_main (bool? retry = true);

    //TRANSLATORS: This text shows up when the app fails to show technical details on an error
    public ErrorView (uint status, string? message = _("No details available")) {
        Object (
            status: status,
            message: message
        );
    }

    construct {
        var box = new Gtk.Box (VERTICAL, MARGIN_MENU_BIG) {
            valign = Gtk.Align.CENTER,
            halign = Gtk.Align.CENTER,
            margin_start = MARGIN_MENU_BIGGER,
            margin_end = MARGIN_MENU_BIGGER,
            margin_bottom = MARGIN_MENU_BIGGER,
        };

        Inscriptions.StatusCode.status_to_details (status,
            out explanation_title, out explanation_text, out icon_name, out report_link);

        var title = new Granite.Placeholder (explanation_title) {
            description = explanation_text,
            icon = new ThemedIcon (icon_name),
            halign = Gtk.Align.START,
            valign = Gtk.Align.CENTER,
        };
        box.append (title);

        // WEIRD: We get errors about TRUE being out of range for a gboolean and the value defaulting if we leave a default 
        bonusbox = new ErrorBonusBox (status, report_link);
        box.append (bonusbox);

        var retry_button = new Inscriptions.RetryButton () {
            halign = Gtk.Align.END,
            margin_top = MARGIN_MENU_BIG
        };
        retry_button.validated.connect (on_validated);

        box.append (retry_button);


        var details_text = message + "\n\n";
        var details_view = new Gtk.Label (details_text) {
            selectable = true,
            wrap = true,
            xalign = 0,
            yalign = 0
        };
        details_view.add_css_class (Granite.STYLE_CLASS_TERMINAL);

        var scroll_box = new Gtk.ScrolledWindow () {
            child = details_view,
            margin_top = 12,
            min_content_height = 90
        };

        var expander = new Gtk.Expander (_("Details")) {
            child = scroll_box,
            hexpand = true,
            margin_top = MARGIN_MENU_BIG + MARGIN_MENU_STANDARD
        };

        if (status != StatusCode.NO_KEY) {
            box.append (expander);
        }

        var handle = new Gtk.WindowHandle () {
            child = box
        };

        child = handle;
    }

    private void on_validated () {
        bonusbox.usage_revealer.reveal_child = true;
        Timeout.add_once (WAIT_BEFORE_MAIN, () => {
            return_to_main ();
        });
    }
}