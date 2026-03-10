/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Specialized subclass of Pane for source text. The stack is not used, but an Options button is added.
 */
public class Inscriptions.SourcePane : Inscriptions.Pane {

  construct {
      stack.visible_child = main_view;
      //

      var options_button_label = new Gtk.Label (_("Options"));
      var options_button_box = new Gtk.Box (HORIZONTAL, 0);
      options_button_box.append (new Gtk.Image.from_icon_name ("tag-symbolic"));
      options_button_box.append (options_button_label);

      var options_button = new Gtk.MenuButton () {
          child = options_button_box,
          tooltip_text = _("Change options for the translation")
      };
      options_button.add_css_class (Granite.STYLE_CLASS_FLAT);
      options_button.add_css_class ("flat_menu_button");
      options_button_label.mnemonic_widget = options_button;
      options_button.popover = new Inscriptions.OptionsPopover () {halign = Gtk.Align.START};
      options_button.direction = Gtk.ArrowType.UP;

      actionbar.pack_start (options_button);

      var clear_button = new Gtk.Button.from_icon_name ("edit-clear-all-symbolic") {
          action_name = TranslationView.ACTION_PREFIX + TranslationView.ACTION_CLEAR_TEXT,
          tooltip_markup = Granite.markup_accel_tooltip (
            {"<Ctrl>L"}, 
            _("Clear text")
          ),
          margin_start = MARGIN_MENU_HALF,
          sensitive = false
      };

      var paste_button = new Gtk.Button.from_icon_name ("edit-paste-symbolic") {
          tooltip_text = _("Paste from clipboard"),
            margin_start = MARGIN_MENU_HALF
      };

      actionbar.pack_end (clear_button);
      actionbar.pack_end (paste_button);

      var open_button = new Gtk.Button.from_icon_name ("document-open-symbolic") {
          action_name = TranslationView.ACTION_PREFIX + TranslationView.ACTION_LOAD_TEXT,
          tooltip_markup = Granite.markup_accel_tooltip (
                  {"<Control>o"}, 
                  _("Load text from a file")
          )
      };
      actionbar.pack_end (open_button);

      /***************** CONNECTS AND BINDS *****************/
      paste_button.clicked.connect (paste_from_clipboard);
      textview.buffer.changed.connect (() => {
        clear_button.sensitive = (text != "");
      });
    }

  private void paste_from_clipboard () {
    var clipboard = Gdk.Display.get_default ().get_clipboard ();

   //Paste without overwrite:
   //    pane.textview.buffer.paste_clipboard (clipboard, null, true);
    clipboard.read_text_async.begin ((null), (obj, res) => {
      try {

        var pasted_text = clipboard.read_text_async.end (res);
        replace_text (pasted_text);
        message (_("Pasted"), true);

      } catch (Error e) {
        print ("Cannot access clipboard: " + e.message);
      }
    });
  }

  public void action_load_text () {
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

    var open_dialog = new Gtk.FileDialog () {
      //TRANSLATORS: The following text is for the dialog to load a text file to translate
      title = _("Open text file to translate"),
        accept_label = _("Open"),
        default_filter = text_files_filter,
        filters = filter_model,
        modal = true
    };

    open_dialog.open.begin (Application.main_window, null, (obj, res) => {
      try {
        var file = open_dialog.open.end (res);
        var content = "";
        FileUtils.get_contents (file.get_path (), out content);

        replace_text (content);
        message (_("Loaded from file"), true);

      } catch (Error err) {
        warning ("Failed to select file to open: %s", err.message);
      }
    });
  }
}
