#
#   ICONS
#

if development
    install_data(
        'dev64.svg',
        install_dir: get_option('datadir') / 'icons' / 'hicolor' / 'scalable' / 'apps',
        rename: app_id + '.svg'
    )

    install_data(
        'dev48.svg',
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', '48x48', 'apps'),
        rename: app_id + '.svg'
    )

    install_data(
        'dev64.svg',
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', '64x64', 'apps'),
        rename: app_id + '.svg'
    )

else
    icon_sizes = ['16', '32', '48', '64', '128']

    foreach i : icon_sizes
        install_data(
            'hicolor' / i + '.png',
            install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i / 'apps',
            rename: app_id + '.png'
        )
        install_data(
            'hicolor@2' / i + '@2.png',
            install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i + '@2' / 'apps',
            rename: app_id + '.png'
        )
    endforeach
endif