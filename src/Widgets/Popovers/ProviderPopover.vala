/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Popover for the Options button, in the SourcePane. Displays advanced options for translation
 * Formality and Context are connected to settings, Formality depends on target language.
 */
public class Inscriptions.ProviderPopover : Gtk.Popover {

  public string selected_name {get; private set;}
  SimpleAction selected_provider_action;

  construct {
    width_request = 260;
    //halign = Gtk.Align.START;

    var box = new Gtk.Box (VERTICAL,0) {
      margin_top = MARGIN_MENU_BIG,
      margin_bottom = MARGIN_MENU_BIG,
      margin_start = MARGIN_MENU_BIG,
      margin_end = MARGIN_MENU_BIG
    };

    var select_provider = new Gtk.CheckButton.with_label (_("DeepL"));

    var libretranslate_checkbutton = new Gtk.CheckButton.with_label (_("Libretranslate")) {
      group = select_provider
    };

    var dummy_checkbutton = new Gtk.CheckButton.with_label (_("Echo")) {
      group = select_provider
    };

    box.append (select_provider);
    box.append (libretranslate_checkbutton);
    box.append (dummy_checkbutton);

    child = box;

    selected_provider_action = new SimpleAction.stateful ("provider", GLib.VariantType.INT32, new Variant.int32 (0));

    var action_group = new SimpleActionGroup ();
    action_group.add_action (selected_provider_action);
    insert_action_group ("select_provider", action_group);

    selected_provider_action.activate.connect (set_broadcast);
  }

    private void set_broadcast (GLib.Variant? value) {
      if (!selected_provider_action.get_state ().equal (value)) {
          selected_provider_action.set_state (value);
          selected_name = ((ProviderType)value).to_name ();
      }
  }
}
