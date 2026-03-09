/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * A base object that is then subclassed into a SourcePane and a TargetPane.
 * It takes a DDModel to fill the dropdown with languages
 */
public class Inscriptions.ZoomableTextView : Gtk.TextView {
    private ZoomController zoom_controller;

    construct {
        zoom_controller = new ZoomController ((Gtk.Widget)this);

        var keypress_controller = new Gtk.EventControllerKey ();
        var scroll_controller = new Gtk.EventControllerScroll (VERTICAL) {
            propagation_phase = Gtk.PropagationPhase.CAPTURE
        };

        add_controller (keypress_controller);
        add_controller (scroll_controller);

        // We need this for Ctr + Scroll. We delegate everything to zoomcontroller
        keypress_controller.key_pressed.connect (zoom_controller.on_key_press_event);
        keypress_controller.key_released.connect (zoom_controller.on_key_release_event);
        scroll_controller.scroll.connect (zoom_controller.on_scroll);
    }
}
