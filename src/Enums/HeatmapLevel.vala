/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * For the formality options as in OptionsPopover.
 * We use its Int aspect for saving/restoring in gsettings.
 * We convert it to string for the DeepL API request.
 */
public enum Inscriptions.HeatmapLevel {
    NONE,
    SELECTED,
    GREYED_OUT,
    FADED1,
    FADED2,
    FADED3,
    FADED4;
}
