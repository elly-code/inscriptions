/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Specialized subclass of Pane. The Stack is used to display waiting
 */
public class Inscriptions.TargetPane : Inscriptions.Pane {

    Gtk.WindowHandle placeholder_handle;
    Gtk.Spinner loading;
    Gtk.WindowHandle spin_view;
    Gtk.Button mailto_button;

    public SimpleActionGroup actions { get; construct; }
    public const string ACTION_PREFIX = "targetpane.";
    public const string ACTION_SAVETEXT = "save-text";
    public const string ACTION_COPY = "copy";
    public const string ACTION_SENDASMAIL = "send-as-mail";

    public static Gee.MultiMap<string, string> action_accelerators = new Gee.HashMultiMap<string, string> ();
    private const GLib.ActionEntry[] ACTION_ENTRIES = {
        {ACTION_SAVETEXT, action_save_text},
        {ACTION_COPY, copy_to_clipboard},
        {ACTION_SENDASMAIL, on_mailto}
    };

    construct {
        actions = new SimpleActionGroup ();
        actions.add_action_entries (ACTION_ENTRIES, this);

        // Translation view
        unowned var app = ((Gtk.Application) GLib.Application.get_default ());
        app.set_accels_for_action (ACTION_PREFIX + ACTION_SAVETEXT, {"<Control>s", "<Control><Shift>s"});
        app.set_accels_for_action (ACTION_PREFIX + ACTION_COPY, {"<Control><Shift>c"});
        app.set_accels_for_action (ACTION_PREFIX + ACTION_SENDASMAIL, {"<Control>m"});

        //textview.editable = false;
        dropdown.tooltip_text = _("Set the language to translate to");
        dropdown.add_languages (Inscriptions.TargetLang ());
        //dropdown.selected = Application.settings.get_string (KEY_TARGET_LANGUAGE);

        /* -------- Placeholder, first thing the user sees -------- */
        var placeholder_box = new Gtk.Box (VERTICAL, 0) {
            hexpand = vexpand = true,
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER,
            margin_start = MARGIN_MENU_HALF,
            margin_end = MARGIN_MENU_HALF
        };

        var placeholder = new Gtk.Label (_("Ready to translate")) {
            wrap = true
        };
        placeholder.add_css_class (Granite.STYLE_CLASS_H2_LABEL);

        // "%.2f" is replaced with a number
        var placeholder_info = new Gtk.Label (_("Translation %.2fs after typing").printf (DEBOUNCE_IN_S)) {
            wrap = true
        };
        placeholder_info.add_css_class (Granite.STYLE_CLASS_H4_LABEL);

        var placeholder_translatebutton = new TranslateButton () {
            halign = Gtk.Align.CENTER,
            width_request = 96,
            height_request = 24,
            margin_top = MARGIN_MENU_BIG
        };

        var switchwidget = new Inscriptions.SwitchWidget (placeholder_info, placeholder_translatebutton) {
            halign = Gtk.Align.CENTER
        };

        placeholder_box.append (placeholder);
        placeholder_box.append (switchwidget);

        placeholder_handle = new Gtk.WindowHandle () {
            child = placeholder_box
        };
        stack.add_child (placeholder_handle);
        show_placeholder ();

        /* -------- SPINNER VIEW -------- */
        loading = new Gtk.Spinner () {
            valign = Gtk.Align.CENTER,
            width_request = 64,
            height_request = 64
        };

        spin_view = new Gtk.WindowHandle () {
            child = loading
        };

        stack.add_child (spin_view);



        /* -------- Widget bottom left switching between auto and a button -------- */

        // "Auto" appears in a place very limited in space
        var placeholder_translatebutton_dim = new Gtk.Label ("") { //_("Auto")
            // "%.2f" is replaced with a number
            tooltip_text = _("Translation will be done %.2fs after typing has stopped").printf (DEBOUNCE_IN_S),
            halign = Gtk.Align.START,
            wrap = true
        };
        placeholder_translatebutton_dim.add_css_class (Granite.STYLE_CLASS_DIM_LABEL);

        var switch_toolbar = new Inscriptions.SwitchWidget (placeholder_translatebutton_dim, new TranslateButton ()) {
            transition_type = Gtk.StackTransitionType.SLIDE_UP_DOWN //Gtk.StackTransitionType.SLIDE_LEFT_RIGHT
        };

        actionbar.pack_start (switch_toolbar);


        /* -------- TOOLBAR BOTTOM RIGHT -------- */
        var copy = new Gtk.Button.from_icon_name ("edit-copy-symbolic") {
            action_name = ACTION_PREFIX + ACTION_COPY,
            tooltip_markup = Granite.markup_accel_tooltip (
                    {"<Control><Shift>c"},
                    _("Copy to clipboard")
            ),
            margin_start = 3
        };

        var save_as_button = new Gtk.Button.from_icon_name ("document-save-as-symbolic") {
            action_name = ACTION_PREFIX + ACTION_SAVETEXT,
            tooltip_markup = Granite.markup_accel_tooltip (
                    {"<Control>s", "<Control><Shift>s"},
                    _("Save the translation in a text file")
            ),
            margin_start = 3
        };

        mailto_button = new Gtk.Button.from_icon_name ("mail-send-symbolic") {
            action_name = ACTION_PREFIX + ACTION_SENDASMAIL,
            tooltip_markup = Granite.markup_accel_tooltip (
                    {"<Control>m"},
                    _("Write an email with the translation")
            ),
            margin_start = 3
        };

        actionbar.pack_end (copy);
        actionbar.pack_end (save_as_button);
        actionbar.pack_end (mailto_button);   //TODO: Wait out for the svg renderer bug to be solver


        /***************** CONNECTS AND BINDS *****************/
        //dropdown.language_changed.connect ((code) => {Application.settings.set_string (KEY_TARGET_LANGUAGE, code);});

        Application.settings_ui.bind (KEY_AUTO_TRANSLATE,
            switchwidget, "first-widget-visible",
            GLib.SettingsBindFlags.DEFAULT);

        Application.settings_ui.bind (KEY_AUTO_TRANSLATE,
            switch_toolbar, "first-widget-visible",
            GLib.SettingsBindFlags.DEFAULT);

        Application.settings_ui.changed[KEY_AUTO_TRANSLATE].connect (on_auto_translate_changed);

        textview.buffer.changed.connect (on_buffer_changed);
    }

    private void on_mailto () {
        var translation = textview.buffer.text;
        var body = Uri.escape_string (translation, null, true);
        var mailto_uri = "mailto:?body=%s".printf (body);
        var launcher = new Gtk.UriLauncher (mailto_uri);
        debug ("MAILTO: %s".printf (mailto_uri));
        launcher.launch.begin (null, null);
        message (_("Opening mail client"), false);
    }

    private void on_auto_translate_changed () {        
        if (Application.settings_ui.get_boolean (KEY_AUTO_TRANSLATE)) {
            // TRANSLATORS: This is for a small notification toast. Very little space is available. "%.2f" is replaced with a number
            message (_("Translation %.2fs after typing").printf (DEBOUNCE_IN_S), false);

        } else {
            // TRANSLATORS: This is for a small notification toast. Very little space is available
            message (_("Automatic translation paused"), false);
        }
    }

    //  private void on_target_changed (string language_code) {
    //      Application.settings.set_string (KEY_TARGET_LANGUAGE, language_code);
    //      target_changed (language_code);
    //  }
    private void copy_to_clipboard () {
        var clipboard = Gdk.Display.get_default ().get_clipboard ();
        clipboard.set_text (textview.buffer.text);
        message (_("Copied"), false);
    }

    public void show_placeholder () {
        stack.visible_child = placeholder_handle;
    }

    public void spin (bool if_spin) {
        if (if_spin) {
            loading.start ();
            stack.visible_child = spin_view;
        } else {
            loading.stop ();
            stack.visible_child = main_view;
        }
        //loading_revealer.reveal_child = if_spin;
    }

    private void on_buffer_changed () {
        if (text.chomp () == "") {
            return;
        }

        stack.visible_child = main_view;
        textview.buffer.changed.disconnect (on_buffer_changed);
    }

    public void action_save_text () {
        var all_files_filter = new Gtk.FileFilter () {
        name = _("All files"),
        };
        all_files_filter.add_pattern ("*");

        var text_files_filter = new Gtk.FileFilter () {
        name = _("Text files"),
        };
        text_files_filter.add_mime_type ("text/*");

        var filter_model = new ListStore (typeof (Gtk.FileFilter));
        filter_model.append (all_files_filter);
        filter_model.append (text_files_filter);

        var filename = _("translation %s-%s.txt").printf (
            Application.settings_translate.get_string (KEY_SOURCE_LANGUAGE),
            Application.settings_translate.get_string (KEY_TARGET_LANGUAGE)
        );
        var save_dialog = new Gtk.FileDialog () {
            //TRANSLATORS: The following text is for the dialog to save the translation
            title = _("Save translation to text file"),
            accept_label = _("Save"),
            initial_name = filename,
            default_filter = text_files_filter,
            filters = filter_model,
            modal = true
        };

        save_dialog.save.begin (Application.main_window, null, (obj, res) => {
            try {
                var file = save_dialog.save.end (res);
                    var content = this.text;
                    FileUtils.set_contents (file.get_path (), content);
                    message (_("Saved"), false);

            } catch (Error err) {
                warning ("Failed to save file: %s", err.message);
            }
        });
    }
}
