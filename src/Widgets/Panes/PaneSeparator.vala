/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * A base object that is then subclassed into a SourcePane and a TargetPane.
 * It takes a DDModel to fill the dropdown with languages
 */
public class Inscriptions.PaneSeparator : Gtk.Box {

    Gtk.Box right_side;

    public bool visible_right {
        get {return right_side.visible;}
        set {
            right_side.visible = value;
        }
    }

    construct {
        orientation = Gtk.Orientation.VERTICAL;
        halign = Gtk.Align.CENTER;
        spacing = 0;
        vexpand = true;
        hexpand = false;

            //TRANSLATORS: This is for a button that switches source and target language
            var switchlang_button = new Gtk.Button.from_icon_name ("media-playlist-repeat-symbolic") {
                action_name = TranslationView.ACTION_PREFIX + TranslationView.ACTION_SWITCH_LANG,
                tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>I"}, _("Switch languages")),
                valign = Gtk.Align.START
            };

            var left_side = new Gtk.Box (Gtk.Orientation.VERTICAL, 0) {
                vexpand = true
            };
            left_side.add_css_class ("view");

            var center_separator = new Gtk.Separator (Gtk.Orientation.VERTICAL) {
                halign = Gtk.Align.CENTER,
                vexpand = true
            };

            right_side = new Gtk.Box (Gtk.Orientation.VERTICAL, 0) {
                vexpand = true,
                visible = false
            };
            right_side.add_css_class ("view");

            // Same class as textview view, so we can avoid a jarring background color
            //

            // An empty actionbar that links both actionbars from both panes as if they were a singular one
            var miniactionbar_left = new Gtk.ActionBar () {
                valign = Gtk.Align.END,
                vexpand = true,
                height_request = 32
            };
            miniactionbar_left.add_css_class (Granite.STYLE_CLASS_FLAT);

            var miniactionbar_right = new Gtk.ActionBar () {
                valign = Gtk.Align.END,
                vexpand = true,
                height_request = 32
            };
            miniactionbar_right.add_css_class (Granite.STYLE_CLASS_FLAT);

            left_side.append (miniactionbar_left);
            right_side.append (miniactionbar_right);

            var middlebox = new Gtk.CenterBox () {
                orientation = Gtk.Orientation.HORIZONTAL
            };
            middlebox.start_widget = left_side;
            middlebox.center_widget = center_separator;
            middlebox.end_widget = right_side;

            var center_handle = new Gtk.WindowHandle () {
                child = middlebox,
                vexpand = true
            };

            append (switchlang_button);
            append (center_handle);
    }
}
