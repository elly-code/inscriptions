/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Aside from bonus actions, the Window is centered around a Gtk.Stack to switch views.
 * Usually when switching to an ErrorView, status code handling is disabled to let it managed, and a "Back" button is added to set it back.
 */
public class Inscriptions.MainWindow : Gtk.ApplicationWindow {

    Inscriptions.HeaderBar headerbar;
    Gtk.Stack stack_window_view;
    public ZoomController zoom_controller;

    public Inscriptions.TranslationView translation_view;
    Inscriptions.ErrorView? errorview = null;

    construct {
        Intl.setlocale ();
        title = _("Inscriptions");
        icon_name = APP_ID;

        // I know you can do this with binds, but it adds unnecessary read/writes everytime you do shit
        default_height = Application.settings_ui.get_int (KEY_WINDOW_HEIGHT);
        default_width = Application.settings_ui.get_int (KEY_WINDOW_WIDTH);
        maximized = Application.settings_ui.get_boolean (KEY_WINDOW_MAXIMIZED);

#if DEVEL
        title += _(" (Devel)");
        add_css_class ("devel");
#endif

        /* ---------------- HEADERBAR ---------------- */

        stack_window_view = new Gtk.Stack () {
            transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT
        };

        headerbar = new Inscriptions.HeaderBar (stack_window_view);
        insert_action_group ("headerbar", headerbar.actions);


        set_titlebar (headerbar);



        /* ---------------- MAIN VIEW ---------------- */
        translation_view = new Inscriptions.TranslationView ();
        insert_action_group ("translation-view", translation_view.actions);

        stack_window_view.add_titled (translation_view, "translation", _("Translate"));
        stack_window_view.add_titled (new LogView (), "messages", _("Messages"));

        child = stack_window_view;

        stack_window_view.visible_child = translation_view;
        set_focus (translation_view.source_pane.textview);




        zoom_controller = new ZoomController ((Gtk.Widget)this);
        insert_action_group ("zoom-controller", zoom_controller.actions);

        var keypress_controller = new Gtk.EventControllerKey ();
        var scroll_controller = new Gtk.EventControllerScroll (VERTICAL) {
            propagation_phase = Gtk.PropagationPhase.CAPTURE
        };

        ((Gtk.Widget)this).add_controller (keypress_controller);
        ((Gtk.Widget)this).add_controller (scroll_controller);



        /* -------------------- CONNECTS AND BINDS -------------------- */

        // We need this for Ctr + Scroll. We delegate everything to zoomcontroller
        keypress_controller.key_pressed.connect (zoom_controller.on_key_press_event);
        keypress_controller.key_released.connect (zoom_controller.on_key_release_event);
        scroll_controller.scroll.connect (zoom_controller.on_scroll);

        // The menu popover just relays events to the window controller
        headerbar.menu_popover.keypress_controller.key_pressed.connect (zoom_controller.on_key_press_event);
        headerbar.menu_popover.keypress_controller.key_released.connect (zoom_controller.on_key_release_event);
        headerbar.menu_popover.scroll_controller.scroll.connect (zoom_controller.on_scroll);

        Application.settings_ui.bind (KEY_ZOOM,
            zoom_controller, "zoom",
            GLib.SettingsBindFlags.DEFAULT);

        check_up_key.begin (null);
        Application.backend.answer_received.connect (on_answer_received);
        headerbar.back_requested.connect (() => {on_back_clicked ();});
        close_request.connect (on_close);
    }

    /**
     * Load the API key asyncally, and complain if there is none
     */
    private async bool check_up_key () {
        string key = yield Secrets.get_default ().load_secret ();

        if (key.chomp () == "") {
            on_error (Inscriptions.StatusCode.NO_KEY, _("No saved API Key"));
            return false;
        }
        return true;
    }

    /**
     * Handler listening to backend. Intercept bad status codes or empty answers
     */
    public void on_answer_received (uint status_code, string? answer = null) {
        print (status_code.to_string ());

        if (status_code != Soup.Status.OK) {
            print ("Switching to error view, with status " + status_code.to_string () + "\nMessage: " + answer);
            on_error (status_code, answer);
            return;
        }

        // We get GTK Critical error messages when it is null
        // We also do not want to react to "Empty" answers. They are usually from checking usage
        if (answer == null) {
            return;
        }

        translation_view.target_pane.text = answer;
        translation_view.target_pane.spin (false);
    }

    /**
     * Handler for the back button. Re-set everything we need, and we may want to translate
     */
    private void on_back_clicked (bool? retry = false) {
        print ("\nBack to main view");
        Application.backend.answer_received.connect (on_answer_received);
        stack_window_view.visible_child = translation_view;
        stack_window_view.remove (errorview);
        errorview = null;
        headerbar.on_main_view = true;

        if (retry) {
            translation_view.on_text_to_translate ();
        }
    }

    /**
     * Convenience function to move to dedicated error view, disable and enable whatever is needed
     */
    private void on_error (uint status_code, string? answer = _("No details available")) {

        // ErrorView may need to do some fiddling. We reconnect when going back to main view via on_back_clicked
        Application.backend.answer_received.disconnect (on_answer_received);

        errorview = new Inscriptions.ErrorView (status_code, answer);
        stack_window_view.add_titled (errorview, "error", _("Error"));
        stack_window_view.visible_child = errorview;

        headerbar.on_main_view = false;
        errorview.return_to_main.connect (on_back_clicked);
    }

    /**
     * Handler for window closing. We do not use binds because i dont like the idea of writing to disk whenever user does anything
     */
    private bool on_close () {
        int height, width;
        get_default_size (out width, out height);
        Application.settings_ui.set_int (KEY_WINDOW_HEIGHT, height);
        Application.settings_ui.set_int (KEY_WINDOW_WIDTH, width);
        Application.settings_ui.set_boolean (KEY_WINDOW_MAXIMIZED, maximized);
        return false;
    }

    public void open (string content) {
        translation_view.source_pane.text = content;
    }

    public void action_zoom_in () {
        zoom_controller.zoom_in ();
    }

    public void action_zoom_default () {
        zoom_controller.zoom_default ();
    }

    public void action_zoom_out () {
        zoom_controller.zoom_out ();
    }
}

