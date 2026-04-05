/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025-2026 Stella & Charlie (teamcons.carrd.co)
 */

 /*************************************************/
/**
* Used in a signal to tell windows in which way to change zoom
*/
 public enum Inscriptions.ZoomType {
    ZOOM_OUT,
    DEFAULT_ZOOM,
    ZOOM_IN,
    NONE;

    public static ZoomType from_delta (double delta) {
        if (delta == 0) {return NONE;}

        if (delta > 0) {
            return ZOOM_OUT;

        } else {
            return ZOOM_IN;
        }
    }
}
