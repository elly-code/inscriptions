
/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * The GUI sends this to the Backend, which will read relevant fields and process
 */
public struct Inscriptions.TranslationRequest {
    int provider;
    string source_language_code;
    string target_language_code;
    string text_to_translate;
    string? context;
    Inscriptions.Formality? formality_level;
}

/**
 * The Backend will answer with this and let the GUI decide wtf to do with it.
 * 
 * If the status code is not a success, message will be an error code, and the initial request will be non-null
 *
 * language_detected will be null if irrelevant
 * The 
 */
public struct Inscriptions.BackendAnswer {
    StatusCode status_code;
    string message;
    string? language_detected;
    TranslationRequest? initial_request;
}
