/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * a
 */
public class Inscriptions.Backend : Object {

    private const uint TIMEOUT = 3000; //ms
    private bool busy = false; //

    // Only access through get_default ()
    private Backend () {}

    Soup.Session session;
    Secrets secrets;

    // Ensure only once instance, accessible whenever needed.
    private static Backend? instance;
    public static Backend get_default () {
        if (instance == null) {
            instance = new Backend ();
        }
        return instance;
    }

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
    }

    public async Inscriptions.BackendAnswer translate (Inscriptions.TranslationRequest translation_request) {

        busy = true;

        /*  
        // Ask Secret for API key
        // Ask Provider for URL, giving it API Key
        // Ask Provider for wrapped body

        // Create Msg
        // send message, get answer

        // Ask provider to unwrap answer
        
        */



        busy = false;

        return BackendAnswer () {
            status_code = StatusCode.OK,
            message = "string message",
            language_detected = "string? language_detected",
            initial_request = translation_request
        };
    }
}
