/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * Used in the custom TextView, alternates background color between sentences.
 */
public enum Inscriptions.HighlightColor {
    BLUEBERRY,
    MINT,
    LIME,
    BANANA,
    ORANGE,
    STRAWBERRY,
    BUBBLEGUM,
    GRAPE,
    COCOA,
    SLATE,
    LATTE;

    /*************************************************/
    /**
    * for use in CSS. Ex: @BLUEBERRY_500
    */
    public string to_string () {
        switch (this) {
            case BLUEBERRY:     return "blueberry";
            case MINT:          return "mint";
            case LIME:          return "lime";
            case BANANA:        return "banana";
            case ORANGE:        return "orange";
            case STRAWBERRY:    return "strawberry";
            case BUBBLEGUM:     return "bubblegum";
            case GRAPE:         return "grape";
            case COCOA:         return "cocoa";
            case SLATE:         return "slate";
            case LATTE:         return "latte";
            default: return "BLUEBERRY";
        }
    }


    /*************************************************/
    /**
    * for use in CSS. Ex: @BLUEBERRY_500
    */
    public string to_hex_dark () {
        switch (this) {
            case BLUEBERRY:     return "#002e99";
            case MINT:          return "#007367";
            case LIME:          return "#206b00";
            case BANANA:        return "#ad5f00";
            case ORANGE:        return "#a62100";
            case STRAWBERRY:    return "#7a0000";
            case BUBBLEGUM:     return "#910e38";
            case GRAPE:         return "#452981";
            case COCOA:         return "#3d211b";
            case SLATE:         return "#0e141f";
            case LATTE:         return "#804b00";
            default: return "#002e99";
        }
    }


    /*************************************************/
    /**
    * for use in CSS. Ex: @BLUEBERRY_500
    */
    public string to_hex_light () {
        switch (this) {
            case BLUEBERRY:     return "#8cd5ff";
            case MINT:          return "#89ffdd";
            case LIME:          return "#d1ff82";
            case BANANA:        return "#fff394";
            case ORANGE:        return "#ffc27d";
            case STRAWBERRY:    return "#ff8c82";
            case BUBBLEGUM:     return "#fe9ab8";
            case GRAPE:         return "#e4c6fa";
            case COCOA:         return "#a3907c";
            case SLATE:         return "#95a3ab";
            case LATTE:         return "#efdfc4";
            default: return "#8cd5ff";
        }
    }

    /*************************************************/
    /**
    * for use in CSS. Ex: @BLUEBERRY_500
    */
    public Gtk.TextTag to_tag_dark () {
        var tag = new Gtk.TextTag (this.to_string () + "-dark");
        Gdk.RGBA rgba_color = Gdk.RGBA ();
        rgba_color.parse (this.to_hex_dark ());
        tag.background_rgba = rgba_color;
        return tag;
    }

    public Gtk.TextTag to_tag_light () {
        var tag = new Gtk.TextTag (this.to_string () + "-light");
        Gdk.RGBA rgba_color = Gdk.RGBA ();
        rgba_color.parse (this.to_hex_light ());
        tag.background_rgba = rgba_color;
        return tag;
    }

    /*************************************************/
    /**
    * convenient list of all supported themes
    */
    public static HighlightColor[] all () {
        return {BLUEBERRY, MINT, LIME, BANANA, ORANGE, STRAWBERRY, BUBBLEGUM, GRAPE, COCOA, SLATE, LATTE};
    }
}