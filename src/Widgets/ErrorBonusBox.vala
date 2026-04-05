/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Used to display more information or options in an ErrorView, may however show nothing.
 * Mostly developer convenience, to not overload ErrorView, and do smarter error handlings.
 */
public class Inscriptions.ErrorBonusBox : Gtk.Box {

    const string ISSUES = "https://github.com/teamcons/inscriptions/issues/";
    const string LINK = "https://www.deepl.com/your-account/keys";
    public uint status { get; construct; }
    public bool if_report { get; construct; }

    public Gtk.Revealer usage_revealer;

    public ErrorBonusBox (uint status, bool if_report) {
        Object (status: status,
                if_report: if_report);
    }

    construct {
        orientation = Gtk.Orientation.VERTICAL;
        spacing = 0;

        // In the event the API is the issue, ask user
        StatusCode[] api_edit_list = {StatusCode.NO_KEY, StatusCode.FORBIDDEN};

        if (status in api_edit_list) {

            var api_entry = new Inscriptions.ApiEntry () {
                margin_bottom = MARGIN_MENU_BIG
            };

            //TRANSLATORS: This is the text of a link to DeepL website, specifically account settings
            var link = new Gtk.LinkButton.with_label (LINK, _("You can get an API key here")) {
                halign = Gtk.Align.START
            };

            var api_level = new Inscriptions.ApiLevel ();
            usage_revealer = new Gtk.Revealer () {
                transition_type = Gtk.RevealerTransitionType.SLIDE_DOWN,
                transition_duration = 500,
                child = api_level,
                reveal_child = (status != StatusCode.NO_KEY)
            };

            var explanation = new Gtk.Label (_("An API Key is like a password which allows you to use DeepL services\nYou can find it in your account settings on the DeepL website\nIt looks like this: <b>fr5617a-4875-4763-9119-564tjdvg89:fx</b>")) {
                use_markup = true,
                wrap_mode = Pango.WrapMode.WORD_CHAR,
                halign = Gtk.Align.START,
                margin_start = MARGIN_MENU_STANDARD,
                margin_top = margin_bottom = MARGIN_MENU_HALF
            };

            var expander = new Gtk.Expander (_("What is an API Key?")) {
                child = explanation,
                margin_top = MARGIN_MENU_BIG,
                margin_bottom = MARGIN_MENU_STANDARD
            };

            var instruction = new Gtk.Label (_("To be able to do translations, paste your API Key in the field below")) {
                halign = Gtk.Align.START
            };
            instruction.add_css_class (Granite.STYLE_CLASS_H4_LABEL);


            //explanation.add_css_class (Granite.STYLE_CLASS_DIM_LABEL);

            append (instruction);
            append (api_entry);
            append (link);
            append (expander);

            //append (usage_revealer);




        };


        if (if_report) {
            var link_to_github = new Gtk.LinkButton.with_label (ISSUES, _("Report issue to the developer")) {
                halign = Gtk.Align.START
            };
            append (link_to_github);
        }
    }
}