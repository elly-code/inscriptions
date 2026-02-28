/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2017-2024 Lains
 *                          2025 Contributions from the ellie_Commons community (github.com/ellie-commons/)
 *                          2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/*************************************************/
/**
* Responsible to apply zoom appropriately to a window.
* Mainly, this abstracts zoom into an int and swap CSS classes
* As a treat it includes also the plumbing for ctrl+scroll zooming
*/
public class Inscriptions.ZoomController : Object {

    private static bool is_control_key_pressed = false;
    private weak Gtk.Widget widget;

    const int ZOOM_MAX = 400;
    const int DEFAULT_ZOOM = 100;
    const int ZOOM_MIN = 20;


    // Avoid setting this unless it is to restore a specific value, do_set_zoom does not check input
    private int _old_zoom = DEFAULT_ZOOM;
    public int zoom {
        get {return _old_zoom;}
        set {do_set_zoom (value);}
    }

    public ZoomController (Gtk.Widget widget) {
        this.widget = widget;
        do_set_zoom (DEFAULT_ZOOM);
    }

    /**
    * Handler. Wraps a zoom enum into the correct function-
    */
    public void zoom_changed (ZoomType zoomtype) {
        print ("Zoom changed!");
        switch (zoomtype) {
            case ZoomType.ZOOM_IN:              zoom_in (); return;          // vala-lint=double-spaces
            case ZoomType.DEFAULT_ZOOM:         zoom_default (); return;     // vala-lint=double-spaces
            case ZoomType.ZOOM_OUT:             zoom_out (); return;         // vala-lint=double-spaces
            default:                            return;                      // vala-lint=double-spaces
        }
    }

    /**
    * Wrapper to check an increase doesnt go above limit
    */
    public void zoom_in () {
        if ((_old_zoom + 20) <= ZOOM_MAX) {
            zoom = _old_zoom + 20;
        } else {
            Gdk.Display.get_default ().beep ();
        }
    }

    public void zoom_default () {
        if (_old_zoom != DEFAULT_ZOOM ) {
            zoom = DEFAULT_ZOOM;
        } else {
            Gdk.Display.get_default ().beep ();
        }
    }

    /**
    * Wrapper to check an increase doesnt go below limit
    */
    public void zoom_out () {
        if ((_old_zoom - 20) >= ZOOM_MIN) {
            zoom = _old_zoom - 20;
        } else {
            Gdk.Display.get_default ().beep ();
        }
    }

    /**
    * Switch zoom classes, then reflect in the UI and tell the application
    */
    private void do_set_zoom (int new_zoom) {
        print ("Setting zoom: " + zoom.to_string ());

        // Switches the classes that control font size
        widget.remove_css_class (ZoomLevel.from_int ( _old_zoom).to_css_class ());
        _old_zoom = new_zoom;
        widget.add_css_class (ZoomLevel.from_int ( new_zoom).to_css_class ());
    }

    public bool on_key_press_event (uint keyval, uint keycode, Gdk.ModifierType state) {
        if (keyval == Gdk.Key.Control_L || keyval == Gdk.Key.Control_R) {
            print ("Press!");
            is_control_key_pressed = true;
        }

        return Gdk.EVENT_PROPAGATE;
    }

    public void on_key_release_event (uint keyval, uint keycode, Gdk.ModifierType state) {
        if (keyval == Gdk.Key.Control_L || keyval == Gdk.Key.Control_R) {
            print ("Release!");
            is_control_key_pressed = false;
        }
    }

    public bool on_scroll (double dx, double dy) {
        print ("Scroll + Ctrl!");

        if (!is_control_key_pressed) {
            return Gdk.EVENT_PROPAGATE;
        }

        zoom_changed (ZoomType.from_delta (dy));
        print ("Go! Zoooommmmm");

        return Gdk.EVENT_PROPAGATE;
    }
}
