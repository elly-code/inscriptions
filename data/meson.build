

gschema_conf = configuration_data()
gschema_conf.set('APP_ID', app_id)
gschema_file = configure_file(
    input: 'inscriptions.gschema.xml.in',
    output: app_id + '.gschema.xml',
    configuration: gschema_conf,
)

install_data(
    gschema_file,
    install_dir: get_option('datadir') / 'glib-2.0' / 'schemas',
)

compile_schemas = find_program('glib-compile-schemas', required: false, disabler: true)
    test('Validate schema file',
    compile_schemas,
    args: ['--strict', '--dry-run', meson.current_source_dir()],
)

# metainfo confuses windows, and icons are 
if not windows_build

    # Install the standard icons in standard build
    if not get_option('development')

        icon_sizes = ['16', '32', '48', '64', '128']

        foreach i : icon_sizes
            install_data(
                'icons' / 'hicolor' / i + '.png',
                install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i / 'apps',
                rename: app_id + '.png'
            )
            install_data(
                'icons' / 'hicolor@2' / i + '@2.png',
                install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i + '@2' / 'apps',
                rename: app_id + '.png'
            )
        endforeach

    # Install the dev icon in development builds
    else
        install_data(
            'icons' / 'dev64.svg',
            install_dir: get_option('datadir') / 'icons' / 'hicolor' / 'scalable' / 'apps',
            rename: app_id + '.svg'
        )

        install_data(
            'icons' / 'dev48.svg',
            install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', '48x48', 'apps'),
            rename: app_id + '.svg'
        )

        install_data(
            'icons' / 'dev64.svg',
            install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', '64x64', 'apps'),
            rename: app_id + '.svg'
        )
    endif
    

    # Inject some variables into the desktop file before merging in the translations
    desktop_conf = configuration_data()
    desktop_conf.set('APP_NAME', app_name)
    desktop_conf.set('APP_ID', app_id)
    desktop_file_in = configure_file(
    input: 'inscriptions.desktop.in.in',
    output: app_id + '.desktop.in',
    configuration: desktop_conf,
    )

    desktop_file = i18n.merge_file(
    input: desktop_file_in,
    output: app_id + '.desktop',
    po_dir: meson.project_source_root() / 'po' / 'extra',
    type: 'desktop',
    install: true,
    install_dir: get_option('datadir') / 'applications',
    )


    # Inject some variables into the metainfo file before merging in the translations
    appstream_conf = configuration_data()
    appstream_conf.set('APP_ID', app_id)
    appstream_conf.set('APP_NAME', app_name)
    appstream_conf.set('GETTEXT_PACKAGE', meson.project_name())
    appstream_file_in = configure_file(
        input: 'inscriptions.metainfo.xml.in.in',
        output: app_id + '.metainfo.xml.in',
        configuration: appstream_conf,
    )

    appstream_file = i18n.merge_file(
        input: appstream_file_in,
        output: app_id + '.metainfo.xml',
        po_dir: meson.project_source_root() / 'po' / 'extra',
        type: 'xml',
        install: true,
        install_dir: get_option('datadir') / 'metainfo',
    )

    # Test definitions
    desktop_utils = find_program('desktop-file-validate', required: false)
    if desktop_utils.found()
    test('Validate desktop file', desktop_utils, args: [desktop_file])
    endif

    appstreamcli = find_program('appstreamcli', required: false, disabler: true)
    test('Validate appstream file',
    appstreamcli,
    args: ['validate', '--no-net', '--explain', appstream_file],
    )


endif