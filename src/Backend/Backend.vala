/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * a
 */
public class Inscriptions.Backend : Object {

    private const uint TIMEOUT = 3000;

    Soup.Session session;
    Secrets secrets;

    construct {
        secrets = Secrets.get_default ();
    }
}
