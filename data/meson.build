
install_data(
    'inscriptions.gschema.xml',
    install_dir: get_option('datadir') / 'glib-2.0' / 'schemas',
    rename: meson.project_name() + '.gschema.xml'
)

# metainfo confuses windows, and icons are 
if not windows_build

    icon_sizes = ['16', '32', '48', '64', '128']

    foreach i : icon_sizes
    install_data(
        'icons' / 'hicolor' / i + '.png',
        install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i / 'apps',
        rename: meson.project_name() + '.png'
    )
    install_data(
        'icons' / 'hicolor@2' / i + '@2.png',
        install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i + '@2' / 'apps',
        rename: meson.project_name() + '.png'
    )
    endforeach



    i18n.merge_file(
        input: 'inscriptions.desktop.in',
        output: meson.project_name() + '.desktop',
        po_dir: meson.project_source_root() / 'po',
        type: 'desktop',
        install: true,
        install_dir: get_option('datadir') / 'applications'
    )

    i18n.merge_file(
        input: 'inscriptions.metainfo.xml.in',
        output: meson.project_name() + '.metainfo.xml',
        po_dir: meson.project_source_root() / 'po',
        install: true,
        install_dir: get_option('datadir') / 'metainfo'
    )

endif