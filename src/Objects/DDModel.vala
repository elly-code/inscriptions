
/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * DDModel, to manage lists of Lang objects (Languages), notably for the dropdown of Pane
 * In human, this is to have a custom dropdown for language selection
 * 
 * There is a ListStore, and two factories: factory_header to display the selected language, and factory_list for the widgets showing up in the list (LanguageItem)
 *
 * List widgets (LanguageItem) are not directly accessible, so we manipulate them via two signals they are connected to: language_changed and update_greyout
 *
 * language_changed advertize to the list widgets to show a little check icon if they are the one selected,
 * 
 * update_greyout advertizes to the list widgets whether they are supposed to be selectable/greyed_out
 */
public class Inscriptions.DDModel : Object {

	static string[] heatmap = Application.settings.get_strv (KEY_HEATMAP);

	public GLib.ListStore model {get; set;}
	public Gtk.SignalListItemFactory factory_header {get; set;}
	public Gtk.SignalListItemFactory factory_list {get; set;}

	// Signal emitted by factory_header.bind when a language is selected, which factory_list.bind listens to
	public signal void language_changed (string language_code_selected);
	public signal void update_greyout (string language_code_greyout);

	public DDModel () {
		//heatmap = Application.settings.get_strv (KEY_HEATMAP);

		// The Langs will populate this thing
		model = new GLib.ListStore(typeof(Lang));

		factory_header = new Gtk.SignalListItemFactory();
		factory_list = new Gtk.SignalListItemFactory();

		// This one does simple labels for each language, to be shown by the dropdown
		factory_header.setup.connect (on_factory_header_setup);
		factory_header.bind.connect (on_factory_header_bind);

		// This one generates a custom widget for each element in the popup list
		factory_list.setup.connect (on_factory_list_setup);
		factory_list.bind.connect (on_factory_list_bind);
	}

	// ----------------------------------------
	/* DROPDOWN VISIBLE LABEL */
	private void on_factory_header_setup (Gtk.SignalListItemFactory f, Object o) {
		var list_item =  (Gtk.ListItem)o;
		list_item.child = new Gtk.Label ("");
		list_item.focusable = true;
	}

	private void on_factory_header_bind (Gtk.SignalListItemFactory f, Object o) {
		var list_item = (Gtk.ListItem)o;
		var item_language = list_item.get_item () as Lang;
		var item = list_item.get_child () as Gtk.Label;
		item.label = item_language.name;

		// We save up a heatmap. It is rebuilt from scratch to avoid redundant language codes
		// We could check beforehand and gate this but it would affect lisibility
		string[] temp_heatmap = {item_language.code};
		foreach (var recent_language_code in heatmap) {
			if (recent_language_code != item_language.code) {
				temp_heatmap += recent_language_code;
			}

			if (temp_heatmap.length == 5) {
				break;
			}
		}
		heatmap = temp_heatmap;
		Application.settings.set_strv (KEY_HEATMAP, heatmap);

		//Application.settings.set_strv (KEY_HEATMAP, heatmap);
		print ("\n");
		foreach (var element in heatmap) {
			print (element + " ");
		}

		// Tell everyone language changed
		// Items are connected to this and get their shit together out of it
		language_changed (item_language.code);
		//print ("switched to: %s %s\n".printf (item_language.name, item_language.code));
	}

	// ----------------------------------------
	/* DROPDOWN POPUP LIST */
	private void on_factory_list_setup (Gtk.SignalListItemFactory f, Object o) {
		var list_item =  (Gtk.ListItem)o;
		var list_item_child = new Inscriptions.LanguageItem ("", "");

		list_item.child = list_item_child;
		list_item.focusable = true;

		// Synchronize between the language item being dimmed, and its list entry being clickable
		list_item_child.bind_property ("sensitive", list_item,
			"activatable",
			GLib.BindingFlags.DEFAULT
		);
	}

	private void on_factory_list_bind (Gtk.SignalListItemFactory f, Object o) {
		var list_item = (Gtk.ListItem)o;
		var item_language = list_item.get_item () as Lang;

		var list_item_child = list_item.get_child() as Inscriptions.LanguageItem;
		list_item_child.language_label = item_language.name;
		list_item_child.language_code = item_language.code;
		// Listen to language change, let every item sort its shit
		language_changed.connect (list_item_child.on_position_changed);
		update_greyout.connect (list_item_child.on_greyout_changed);
		//print ("binding: %s\n".printf (item_language.name));
	}


	// ----------------------------------------
	/* LIST MANAGEMENT */
	public void model_append (Lang l) {
		model.append (l);
	}

	public void model_remove(Lang l) {
		uint pos;
		if(model.find_with_equal_func(l, (a,b) => {
					return ((Lang)a).code == ((Lang)b).code;
				}, out pos)) {
			model.remove(pos);
		}
	}

	public uint model_where_code (string code) {
		uint pos;
		var l = new Lang (code,"");
		if(model.find_with_equal_func(l, (a,b) => {
					return ((Lang)a).code == ((Lang)b).code;
				}, out pos)) {
			return (pos);
		}
		return pos;
	}
}

