/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Wrapper to handle loading/Saving each key in a quick and smart manner
 *
 * It is done asynchronously to not have the UI hang and freeze.
 */
public class Inscriptions.Secrets : Object {

    // Ensure only once instance, accessible whenever needed.
    private static Secrets? instance;
    public static Secrets get_default () {
        if (instance == null) {
            instance = new Secrets ();
        }
        return instance;
    }

    // Only access through get_default ()
    private Secrets () {}
    private Secret.Schema schema;
    private GLib.HashTable<string,string> cached_keys;

    construct {
        schema = new Secret.Schema (APP_ID, Secret.SchemaFlags.NONE,
                                        "label", Secret.SchemaAttributeType.STRING);

        cached_keys = new GLib.HashTable<string,string> (str_hash, str_equal);
    }

    /**
     * Save a specific key according to its provider
     *
     * The function is sync, because it saves a cache real quick, then does the stuff in the background without blocking the UI
     */
    public void store_key (ProviderType provider, string new_key) {

        // Save a cache first before doing the heavy lifting
        cached_keys[provider.to_secrets_label ()] = new_key;

        // Lets go lesbians
        var attributes = new GLib.HashTable<string,string> (str_hash, str_equal);
        attributes["label"] = provider.to_secrets_label ();

        Secret.password_storev.begin (schema, attributes, Secret.COLLECTION_DEFAULT,
                                        provider.to_secrets_label (), new_key,
                                        null, (obj, async_res) => {

                                        try {
                                            bool res = Secret.password_store.end (async_res);
                                            print ("saved? %b".printf (res));

                                        } catch (Error e) {
                                            print (e.message);
                                        }
        });
    }

    /**
     * Load a specific key according to its provider
     *
     * If it answers null, then theres none we have and the user will get an error for the provider they chose
     * 
     * Despite being async, if the key has been retrieved or stored at least once since app start, this may return very quick
     */
    public async string? load_key (ProviderType provider) {

        // Do we have it already?
        var? cached = cached_keys[provider.to_secrets_label ()];
        if (cached != null) {
            return cached;
        }

        // We dont. Do it now.
        var attributes = new GLib.HashTable<string,string> (str_hash, str_equal);
        attributes["label"] = provider.to_secrets_label ();
        string? key = null;

        try {
            key = yield Secret.password_lookupv (schema, attributes, null);

        } catch (Error e) {
            print (e.message);
        }

        return key;
    }


}
