/*
* SPDX-License-Identifier: GPL-3.0-or-later
* SPDX-FileCopyrightText: {{YEAR}} {{DEVELOPER_NAME}} <{{DEVELOPER_EMAIL}}>
*/

public class Inscriptions.Application : Gtk.Application {

    internal static Settings settings;
    internal static DeepL backend;
    internal static MainWindow main_window;

    public const string ACTION_PREFIX = "app.";
    public const string ACTION_QUIT = "action_quit";
    public static Gee.MultiMap<string, string> action_accelerators = new Gee.HashMultiMap<string, string> ();

    private const GLib.ActionEntry[] ACTION_ENTRIES = {
        { ACTION_QUIT, quit}
    };

    public Application () {
        Object (
            application_id: RDNN,
            flags: ApplicationFlags.HANDLES_OPEN
        );
    }

    construct {
        Intl.setlocale (LocaleCategory.ALL, "");
        Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
        Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (GETTEXT_PACKAGE);
    }

    static construct {
        settings = new GLib.Settings (RDNN);

        // Backend takes care of the async for us. We give it the text
        // And it will emit a signal whenever finished, which we can connect to
        backend = new DeepL ();
    }

    protected override void startup () {
        base.startup ();
        Gtk.init ();
        Granite.init ();

        add_action_entries (ACTION_ENTRIES, this);
        set_accels_for_action ("app.action_quit", {"<Control>q"});

        // Styling
        var granite_settings = Granite.Settings.get_default ();
        var gtk_settings = Gtk.Settings.get_default ();

        // Force Slate on other DE, as else there is a risk whatever theme is running it breaks the app
        unowned string desktop_environment = Environment.get_variable ("XDG_CURRENT_DESKTOP");
        if (desktop_environment != "Pantheon") {
            gtk_settings.gtk_theme_name = "io.elementary.stylesheet.slate";
        }

        gtk_settings.gtk_application_prefer_dark_theme = (
	            granite_settings.prefers_color_scheme == DARK
            );
	
        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = (
                    granite_settings.prefers_color_scheme == DARK
                );
        });

        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("/io/github/elly_code/inscriptions/Application.css");

        Gtk.StyleContext.add_provider_for_display (
            Gdk.Display.get_default (),
            provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );

    }

    protected override void activate () {
        if (main_window != null) {
            main_window.present ();
            return;
        }

        main_window = new MainWindow () {
            application = this
        };
        main_window.show ();
        main_window.present ();
    }

    protected override void open (File[] files, string hint) {
        if (main_window == null) {
            activate ();
        }
        var file = files [0];
        string content = "";

        try {
            FileUtils.get_contents (file.get_path (), out content);

        } catch (Error e) {
            warning ("Failed to open file: %s", e.message);

            var dialog = new Granite.MessageDialog (
                _("Couldn't open file"),
                e.message,
                new ThemedIcon ("document-open")
            ) {
                badge_icon = new ThemedIcon ("dialog-error"),
                modal = true,
                transient_for = main_window
            };
            dialog.present ();
            dialog.response.connect (dialog.destroy);
        }

        main_window.open (content);
    }

    public static int main (string[] args) {
        return new Application ().run (args);
    }
}