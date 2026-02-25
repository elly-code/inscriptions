
/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * DDModel, to manage lists of Lang objects (Languages), notably for the dropdown of Pane
 * Thank you stronnag!
 */
public class Inscriptions.DDModel : Object {
	public GLib.ListStore model {get; set;}
	public Gtk.SignalListItemFactory factory {get; set;}

	public DDModel () {
		model = new GLib.ListStore(typeof(Lang));
		factory = new Gtk.SignalListItemFactory();

		factory.setup.connect (on_factory_setup);
		factory.bind.connect (on_factory_bind);
	}

	private void on_factory_setup (Gtk.SignalListItemFactory f, Object o) {
		var list_item =  (Gtk.ListItem)o;
		var item = new Inscriptions.LanguageItem (list_item.position, "");

		list_item.child = item;
		list_item.focusable = true;
	}

	private void on_factory_bind (Gtk.SignalListItemFactory f, Object o) {
		var list_item = (Gtk.ListItem)o;
		var item_language = list_item.get_item () as Lang;
		var item = list_item.get_child() as Inscriptions.LanguageItem;

		//print ("position: " + list_item.position.to_string ());
		item.label = item_language.name;
	}

	public void model_append(Lang l) {
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

