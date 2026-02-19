/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
 * a
 */
public class Inscriptions.BackendController : Object, BackendTemplate {

    private BackendType current_backend_type {get; set;}
    private BackendTemplate current_backend {get; set;}
    public signal void backend_changed (BackendType new_backend);

    public Lang[] supported_source_languages { get; set; }
    public Lang[] supported_target_languages { get; set; }

    // Ensure only once instance, accessible whenever needed.
    private static BackendController? instance;
    public static BackendController get_default () {
        if (instance == null) {
            instance = new BackendController ();
        }
        return instance;
    }

    construct {
        on_backend_changed ();
        Application.settings.changed[KEY_BACKEND].connect (on_backend_changed);
    }

    private void on_backend_changed () {
        var int_new_backend_type = Application.settings.get_enum (KEY_BACKEND);
        var new_backend = BackendType.from_int (int_new_backend_type);


        supported_source_languages = current_backend.supported_source_languages;
        supported_target_languages = current_backend.supported_target_languages;

        backend_changed (new_backend);
    }



  public string source_lang {
    get {return current_backend.source_lang;}
    set {current_backend.source_lang = value;}
}

  public string target_lang {
    get {return current_backend.target_lang;}
    set {current_backend.target_lang = value;}
}
  public uint status_code {
    get {return current_backend.status_code;}
    set {current_backend.status_code = value;}
}

  public void check_usage () {current_backend.check_usage ();}

  int current_usage {
    get {return current_backend.current_usage;}
    set {current_backend.current_usage = value;}
}
  int max_usage {
    get {return current_backend.max_usage;}
    set {current_backend.max_usage = value;}
}

 public void send_request (string text) {current_backend.send_request (text);}


}
