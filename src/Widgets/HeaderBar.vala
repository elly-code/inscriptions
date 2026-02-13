/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Bespoke header Bar
 */
public class Inscriptions.HeaderBar : Granite.Bin {

    public Gtk.Stack stack_window_view {get; construct;}
    public signal void back_requested ();

    Gtk.HeaderBar headerbar;
    Gtk.Stack title_stack;
    Gtk.Label title_label;
    Gtk.StackSwitcher title_switcher;

    Gtk.Revealer back_revealer;
    Gtk.Button switchlang_button;
    Gtk.Revealer toolbar_revealer;
    Gtk.MenuButton popover_button;

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
        get {return title_stack.visible_child == title_switcher;}
        set {switcher_state (value);}
    }

    // Visibility of the toolbar and back_button
    public bool on_main_view {
        get {return toolbar_revealer.reveal_child;}
        set {
            toolbar_revealer.reveal_child = value;
            back_revealer.reveal_child = !value;

            //  if (value) {
            //      headerbar.remove_css_class (Granite.STYLE_CLASS_FLAT);
            //  } else {
            //      headerbar.add_css_class (Granite.STYLE_CLASS_FLAT);
            //  }
        }
    }

    public HeaderBar (Gtk.Stack stack_window_view) {
        Object (stack_window_view: stack_window_view);
    }

    construct {
        actions = new SimpleActionGroup ();
        actions.add_action_entries (ACTION_ENTRIES, this);

        unowned var app = ((Gtk.Application) GLib.Application.get_default ());
        app.set_accels_for_action (ACTION_PREFIX + ACTION_MENU, {"<Control>m"});
        app.set_accels_for_action (ACTION_PREFIX + ACTION_TOGGLE_MESSAGES, {"<Control><Shift>m"});

        title_label = new Gtk.Label (_("Inscriptions"));
        title_label.add_css_class (Granite.STYLE_CLASS_TITLE_LABEL);

        title_switcher = new Gtk.StackSwitcher () {
            stack = stack_window_view
        };
        
        title_stack = new Gtk.Stack () {
            transition_type = Gtk.StackTransitionType.SLIDE_UP_DOWN
        };

        title_stack.add_child (title_label);
        title_stack.add_child (title_switcher);
        title_stack.visible_child = title_label;

        //TRANSLATORS: Do not translate the name itself. You can write it in your writing system if that is usually done for your language
        headerbar = new Gtk.HeaderBar () {
            title_widget = title_stack
        };
        headerbar.add_css_class (Granite.STYLE_CLASS_FLAT);
        //headerbar.add_css_class (CSS_COLORED_HEADER);


        /* ---------------- PACK START ---------------- */
        //TRANSLATORS: Back button to go back to translating
        var back_button = new Gtk.Button.with_label (_("Back"));
        back_button.add_css_class (Granite.STYLE_CLASS_BACK_BUTTON);

        back_revealer = new Gtk.Revealer () {
            child = back_button,
            transition_type = Gtk.RevealerTransitionType.SWING_LEFT,
            reveal_child = false
        };
        headerbar.pack_start (back_revealer);
        

        //TRANSLATORS: This is for a button that switches source and target language
        switchlang_button = new Gtk.Button.from_icon_name ("media-playlist-repeat") {
            tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>I"}, _("Switch languages"))
        };
        switchlang_button.action_name = TranslationView.ACTION_PREFIX + TranslationView.ACTION_SWITCH_LANG;

        var toggle_highlight = new Gtk.ToggleButton () {
            icon_name = "format-text-highlight",
            tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>H"}, _("Highlight source and target sentences"))
        };

        var toolbar = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 5);
        toolbar.append (switchlang_button);
        toolbar.append (toggle_highlight);

        toolbar_revealer = new Gtk.Revealer () {
            child = toolbar,
            transition_type = Gtk.RevealerTransitionType.SWING_LEFT,
            reveal_child = true
        };

        headerbar.pack_start (toolbar_revealer);


        /* ---------------- PACK END ---------------- */
        popover_button = new Gtk.MenuButton () {
            icon_name = "open-menu",
            tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>M"}, _("Settings")),
        };

        popover_button.set_primary (true);
        popover_button.set_direction (Gtk.ArrowType.NONE);

        var menu_popover = new Inscriptions.SettingsPopover ();
        popover_button.popover = menu_popover;

        //TRANSLATORS: The two following texts are for a button. The functionality is diabled. You can safely ignore these.
        var translate_button = new Gtk.Button () {
            label = _("Translate"),
            tooltip_markup = Granite.markup_accel_tooltip (
                {"<Control>Return", "<Ctrl>T"}, 
                _("Start translating the entered text")
            )
        };
        translate_button.add_css_class (Granite.STYLE_CLASS_SUGGESTED_ACTION);
        translate_button.action_name = TranslationView.ACTION_PREFIX + TranslationView.ACTION_TRANSLATE;

        var translate_revealer = new Gtk.Revealer () {
            child = translate_button,
            transition_type = Gtk.RevealerTransitionType.SWING_RIGHT
        };
        
        var toolbar_right = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 5);
        toolbar_right.append (translate_revealer);
        toolbar_right.append (popover_button);

        headerbar.pack_end (toolbar_right);


        child = headerbar;

        /* -------------------- CONNECTS AND BINDS -------------------- */
        back_button.clicked.connect (() => {back_requested ();});

        Application.settings.bind (KEY_HIGHLIGHT,
            toggle_highlight, "active",
            GLib.SettingsBindFlags.DEFAULT);

        Application.settings.bind (KEY_AUTO_TRANSLATE, 
            translate_revealer, "reveal_child", 
            SettingsBindFlags.INVERT_BOOLEAN
        );
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
        if (if_show_switcher) {
            title_stack.visible_child = title_switcher;

        } else {
            title_stack.visible_child = title_label;
        }
    }
}