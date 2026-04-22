/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Bespoke header Bar
 */
public class Inscriptions.HeaderBar : Granite.Bin {

    public Gtk.Stack stack_window_view {get; construct;}
    public signal void back_requested ();

    Gtk.HeaderBar headerbar;
    Inscriptions.SwitchWidget switchwidget;
    Gtk.StackSwitcher title_switcher;

    Gtk.Revealer back_revealer;
    Gtk.Revealer toolbar_revealer;
    Gtk.MenuButton popover_button;
    public Inscriptions.SettingsPopover menu_popover;

    public SimpleActionGroup actions { get; construct; }
    public const string ACTION_PREFIX = "headerbar.";
    public const string ACTION_MENU = "menu";
    public const string ACTION_TOGGLE_MESSAGES = "toggle-messages";

    public static Gee.MultiMap<string, string> action_accelerators = new Gee.HashMultiMap<string, string> ();
    private const GLib.ActionEntry[] ACTION_ENTRIES = {
        { ACTION_MENU, on_menu}, 
        { ACTION_TOGGLE_MESSAGES, action_toggle_messages}, 
    };

    // Secret switch showing with ctrl+shift+M
    private bool show_switcher {
        get {return !switchwidget.first_widget_visible;}
        set {switcher_state (value);}
    }

    // Visibility of the toolbar and back_button
    public bool on_main_view {
        get {return toolbar_revealer.reveal_child;}
        set {
            toolbar_revealer.reveal_child = value;
            back_revealer.reveal_child = !value;
        }
    }

    public HeaderBar (Gtk.Stack stack_window_view) {
        Object (stack_window_view: stack_window_view);
    }

    construct {
        actions = new SimpleActionGroup ();
        actions.add_action_entries (ACTION_ENTRIES, this);

        unowned var app = ((Gtk.Application) GLib.Application.get_default ());
        app.set_accels_for_action (ACTION_PREFIX + ACTION_MENU, {"<Control>g"});
        app.set_accels_for_action (ACTION_PREFIX + ACTION_TOGGLE_MESSAGES, {"<Control><Shift>m"});
   
#if DEVEL
        var title_label = new Granite.HeaderLabel (_("%s (Devel)").printf (APP_NAME)) {
            size = Granite.HeaderLabel.Size.H4
        };
#else
        var title_label = new Granite.HeaderLabel (APP_NAME) {
            size = Granite.HeaderLabel.Size.H4
        };
#endif

        title_switcher = new Gtk.StackSwitcher () {
            stack = stack_window_view
        };

        switchwidget= new Inscriptions.SwitchWidget (title_label, title_switcher) {
            transition_type = Gtk.StackTransitionType.SLIDE_UP_DOWN
        };

        headerbar = new Gtk.HeaderBar () {
            title_widget = switchwidget
        };
        headerbar.add_css_class (Granite.STYLE_CLASS_FLAT);
        //headerbar.add_css_class (STYLE_CLASS_COLORED_HEADER);


        /* ---------------- PACK START ---------------- */
        //TRANSLATORS: Back button to go back to translating
        var back_button = new Granite.BackButton (_("Back"));

        back_revealer = new Gtk.Revealer () {
            child = back_button,
            transition_type = Gtk.RevealerTransitionType.SWING_LEFT,
            reveal_child = false
        };
        headerbar.pack_start (back_revealer);
        

        //TRANSLATORS: This is for a button that switches source and target language
        //  switchlang_button = new Gtk.Button.from_icon_name ("media-playlist-repeat") {
        //      tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>I"}, _("Switch languages"))
        //  };
        //  switchlang_button.action_name = TranslationView.ACTION_PREFIX + TranslationView.ACTION_SWITCH_LANG;

        var toggle_highlight = new Gtk.ToggleButton () {
            icon_name = "format-text-highlight",
            tooltip_markup = Granite.markup_accel_tooltip (
                {"<Ctrl>H"},
                _("Highlight source and target sentences"))
        };

        var toolbar = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 5);
        //toolbar.append (switchlang_button);
        //toolbar.append (toggle_highlight);

        toolbar_revealer = new Gtk.Revealer () {
            child = toolbar,
            transition_type = Gtk.RevealerTransitionType.SWING_LEFT,
            reveal_child = true
        };

        headerbar.pack_start (toolbar_revealer);


        /* ---------------- PACK END ---------------- */
        popover_button = new Gtk.MenuButton () {
            icon_name = "open-menu",
            tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>G"}, _("Settings")),
        };

        popover_button.set_primary (true);
        popover_button.set_direction (Gtk.ArrowType.NONE);

        menu_popover = new Inscriptions.SettingsPopover ();
        popover_button.popover = menu_popover;

        var toolbar_right = new Gtk.Box (Gtk.Orientation.HORIZONTAL, MARGIN_MENU_STANDARD);

        //toolbar_right.append (new TranslateButton ());
        toolbar_right.append (popover_button);

        headerbar.pack_end (toolbar_right);

        child = headerbar;

#if DEVEL
        switcher_state (true);
#endif

        /* -------------------- CONNECTS AND BINDS -------------------- */
        back_button.clicked.connect (() => {back_requested ();});

        Application.settings_ui.bind (KEY_HIGHLIGHT,
            toggle_highlight, "active",
            GLib.SettingsBindFlags.DEFAULT);
    }

    private void on_menu () {
        popover_button.activate ();
    }

    /**
     * The two below manage the super secret debug mode enabled/disabled with Ctrl+shift+M
     */
    private void action_toggle_messages () {
        switcher_state (!show_switcher);
    }

    private void switcher_state (bool if_show_switcher) {
        switchwidget.first_widget_visible = !if_show_switcher;
    }
}