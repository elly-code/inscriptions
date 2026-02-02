/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * A base object that is then subclassed into a SourcePane and a TargetPane.
 * It takes a DDModel to fill the dropdown with languages
 */
public class Inscriptions.TextView : Gtk.TextView {

    static Gtk.Settings gtk_settings = Gtk.Settings.get_default ();
    HighlightColor[] all_colors = HighlightColor.all ();

    bool _priv_highlight;
    public bool highlight {
        get {
            return _priv_highlight;
        }
        set {
            set_highlighting (value);
            set_unset_handlers (value);
            _priv_highlight = value;
        }
    }

    construct {
        hexpand = true;
        vexpand = true;
        left_margin = 12;
        right_margin = 12;
        top_margin = 6;
        bottom_margin = 6;

        foreach (var color in all_colors) {
            buffer.tag_table.add (color.to_tag_dark ());
            buffer.tag_table.add (color.to_tag_light ());
        }

        Application.settings.bind ("highlight", 
            this, "highlight", 
            GLib.SettingsBindFlags.DEFAULT);
    }

    private void set_highlighting (bool is_set) {
        Gtk.TextIter start_sentence, end_sentence;
        buffer.get_bounds (out start_sentence, out end_sentence);

        if (!is_set) {
            buffer.remove_all_tags (start_sentence, end_sentence);
            return;
        }

        end_sentence = start_sentence;
        var iterate_colors = 0;
        HighlightColor tag;
        string suffix = "-light";

        if (gtk_settings.gtk_application_prefer_dark_theme) {
            suffix = "-dark";
        };

        while (!start_sentence.is_end ()) {

            end_sentence.forward_sentence_end ();
            tag = all_colors[iterate_colors];
            
            print ("\nTag: " + tag.to_string () + " for sentence: " + start_sentence.get_offset ().to_string ());

            buffer.freeze_notify ();
            buffer.apply_tag_by_name (tag.to_string () + suffix, start_sentence, end_sentence);
            buffer.thaw_notify ();

            start_sentence = end_sentence;

            if (iterate_colors == (all_colors.length - 1)) {
                iterate_colors = 0;
            } else {
                iterate_colors++;
            };
        }
    }

    private void set_unset_handlers (bool if_set) {
        if (if_set) {
            Application.backend.answer_received.connect_after (refresh);
            gtk_settings.notify["gtk-application-prefer-dark-theme"].connect (refresh);
            return;
        }

        Application.backend.answer_received.disconnect (refresh);
        gtk_settings.notify["gtk-application-prefer-dark-theme"].disconnect (refresh);
    }

    private void refresh () {
        set_highlighting (false);
        set_highlighting (true);
    }
}
