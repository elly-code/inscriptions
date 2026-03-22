/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Switch between showing one or the other child widgets
 */
public class Inscriptions.SwitchWidget : Granite.Bin {

    public Gtk.Stack stack {get; construct;}
    public Gtk.Widget first_widget {get; construct;}
    public Gtk.Widget second_widget {get; construct;}

    public Gtk.StackTransitionType transition_type {
        get {return stack.transition_type;}
        set {stack.transition_type = value;}
    }

    public bool first_widget_visible {
        get {return stack.visible_child == first_widget;}
        set {
            if (value) {
                stack.visible_child = first_widget;
            } else {
                stack.visible_child = second_widget;
            }
        }
    }

    public SwitchWidget (Gtk.Widget first_widget, Gtk.Widget second_widget) {
        Object (first_widget: first_widget,
                second_widget: second_widget);
    }

    construct {
        stack = new Gtk.Stack () {
            transition_type = Gtk.StackTransitionType.SLIDE_UP_DOWN
        };

        stack.add_child (first_widget);
        stack.add_child (second_widget);

        stack.visible_child = first_widget;
        child = stack;
    }
}