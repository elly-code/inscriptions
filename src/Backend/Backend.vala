/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * a
 */
public class Inscriptions.Backend : Object {

    public signal void provider_changed ();

    private const uint TIMEOUT = 3000; //ms
    public bool busy = false; //

    Secrets secrets;
    Soup.Session session;
    Inscriptions.Provider translation_provider;

    Inscriptions.ProviderType _provider_type;
    public Inscriptions.ProviderType provider_type {
        get {return _provider_type;}
        set {
            translation_provider = value.to_provider ();
            _provider_type = value;
            provider_changed ();
        }
    }

    // Ensure only once instance, accessible whenever needed.
    private static Backend? instance;
    public static Backend get_default () {
        if (instance == null) {
            instance = new Backend ();
        }
        return instance;
    }

    // Only access through get_default ()
    private Backend () {}

    construct {
        secrets = Secrets.get_default ();

        session = new Soup.Session () {
            timeout = TIMEOUT
        };

        var logger = new Soup.Logger (Soup.LoggerLogLevel.BODY);
        session.add_feature (logger);

        logger.set_printer ((_1, _2, dir, text) => {
            stderr.printf ("%c %s\n", dir, text);
        });

        //translation_provider = Inscriptions.Providers.DeepL ();
    }

    public async Inscriptions.BackendAnswer translate (Inscriptions.TranslationRequest translation_request) {

        busy = true;

        /*  
        // Ask Secret for API key
        // Ask Provider for URL, giving it API Key
        // Ask Provider for wrapped body

        // Create Msg
        soup_translation_request = provider.prepare_translation_request (api_key, request);

        // send message, get answer

        // Ask provider to unwrap answer
        
        var answerdata = AnswerData ();
        if (StatusCode == OK) {
            var answer_data = translation_provider.unwrap_answer (json_answer);
            var message = answer_data.message;
            var language_detected = answer_data.detected_language_code;

        } else {
            var message = translation_provider.unwrap_error (json_answer);
        }



        */

        busy = false;

        return BackendAnswer () {
            status_code = StatusCode.OK,
            message = "string message",
            language_detected = "string? language_detected",
            initial_request = translation_request
        };
    }

    public Provider.Features get_supported_features () {
        return translation_provider.get_supported_features ();
    }

    public string[] get_supported_formality () {
        return translation_provider.get_supported_formality ();
    }

    public Lang[] get_source_languages () {
        return translation_provider.get_source_languages ();
    }

    public Lang[] get_target_languages () {
        return translation_provider.get_target_languages ();
    }
}
