/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * A base object that is then subclassed into a SourcePane and a TargetPane.
 * It takes a DDModel to fill the dropdown with languages
 */
public class Inscriptions.Pane : Gtk.Box {

    public Inscriptions.DDModel model {get; construct;}
    public Inscriptions.LanguageDropDown dropdown {get; construct;}

    public Inscriptions.TextView textview;
    public Gtk.ScrolledWindow scrolledwindow;
    public Gtk.ActionBar actionbar;

    public Gtk.Stack stack;
    public Gtk.Box main_view;

    private Granite.Toast toast;

    public string selected_language {
        owned get { return dropdown.selected;}
        set { dropdown.selected = value;}
    }

    string _greyed_out = "";
    public string greyed_out_language {
        owned get { return _greyed_out;}
        set { dropdown.update_greyout (value); _greyed_out = value;}
    }

    public string text {
        owned get { return textview.buffer.text;}
        set { textview.buffer.text = value;}
    }

    public signal void language_changed (string code = "");
    public signal void view_changed (bool if_main_view);

    construct {
        orientation = Gtk.Orientation.VERTICAL;
        spacing = 0;

        dropdown = new LanguageDropDown ();

        /* ---------------- VIEW ---------------- */
        textview = new Inscriptions.TextView ();
        textview.set_wrap_mode (Gtk.WrapMode.WORD_CHAR);

        scrolledwindow = new Gtk.ScrolledWindow () {
            child = textview
        };

        toast = new Granite.Toast ("") {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.END
        };

        var overlay = new Gtk.Overlay () {
            child = scrolledwindow
        };
        overlay.add_overlay (toast);
        //overlay.set_measure_overlay (toast, true);

        /* ---------------- TOOLBAR ---------------- */
        actionbar = new Gtk.ActionBar () {
            hexpand = true,
            vexpand = false,
            valign = Gtk.Align.END,
            height_request = 32
        };
        actionbar.add_css_class (Granite.STYLE_CLASS_FLAT);

        var handle = new Gtk.WindowHandle () {
            child = actionbar
        };

        /* ---------------- STACK ---------------- */

        main_view = new Gtk.Box (VERTICAL, 0);
        main_view.append (overlay);
        main_view.append (handle);

        stack = new Gtk.Stack () {
            transition_type = Gtk.StackTransitionType.NONE
        };
        stack.add_child (main_view);

        append (dropdown);
        append (stack);

        /***************** CONNECTS AND BINDS *****************/
        toast.default_action.connect (() => {
            textview.buffer.undo ();
        });

        dropdown.language_changed.connect ((code) => {language_changed (code);});

        stack.notify["visible-child"].connect (() => {
            print ("Changed");
            view_changed (stack.visible_child == main_view);
        });
    }
    // Respectful of Undo
    public void replace_text (string new_text) {

        Gtk.TextIter start, end;
        textview.buffer.get_bounds (out start, out end);

        textview.buffer.begin_user_action ();
        this.textview.buffer.delete (ref start, ref end);
        this.textview.buffer.insert (ref start, new_text, new_text.length);
        textview.buffer.end_user_action ();

        textview.grab_focus ();
    }

    public void clear () {
        replace_text ("");
    }

    public void message (string text, bool? undo = false) {
        toast.title = text;

        if (undo) {
            toast.set_default_action (_("Undo"));
        }

        toast.send_notification ();
    }
}
