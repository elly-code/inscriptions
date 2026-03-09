
/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * DDModel, to manage lists of Lang objects (Languages), notably for the dropdown of Pane
 * In human, this is to have a custom dropdown for language selection
 */
public class Inscriptions.DDModel : Object {
	public GLib.ListStore model {get; set;}
	public Gtk.SignalListItemFactory factory_header {get; set;}
	public Gtk.SignalListItemFactory factory_list {get; set;}

	// Signal emitted by factory_header.bind when a language is selected, which factory_list.bind listens to
	public signal void selection_changed (string language_code_selected);

	public DDModel () {
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

		// Tell everyone language changed
		selection_changed (item_language.code);
		//print ("switched to: %s %s\n".printf (item_language.name, item_language.code));
	}

	// ----------------------------------------
	/* DROPDOWN POPUP LIST */
	private void on_factory_list_setup (Gtk.SignalListItemFactory f, Object o) {
		var list_item =  (Gtk.ListItem)o;
		var list_item_child = new Inscriptions.LanguageItem ("", "");

		list_item.child = list_item_child;
		list_item.focusable = true;
	}

	private void on_factory_list_bind (Gtk.SignalListItemFactory f, Object o) {
		var list_item = (Gtk.ListItem)o;
		var item_language = list_item.get_item () as Lang;

		var list_item_child = list_item.get_child() as Inscriptions.LanguageItem;
		list_item_child.language_label = item_language.name;
		list_item_child.language_code = item_language.code;

		// Listen to language change, let every item sort its shit
		selection_changed.connect (list_item_child.on_position_changed);
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

