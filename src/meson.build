

#================================
# Config.vala allows us to set variables in Meson, for the Vala app to use later

config_file = configure_file(
    input: 'Config.vala.in',
    output: '@BASENAME@',
    configuration: config_data
)


#================================
# dependencies

# json to package/unpackage API requests
# libsoup to send/received from API
# libsecret to handle API keys securely

deps = [
  dependency ('gtk4'),
  dependency ('granite-7', version: '>=7.7.0'),
  dependency ('json-glib-1.0'),
  dependency ('libsoup-3.0'),
  dependency ('libsecret-1')
]


#================================
# Letsgo
sources = files (
  'Constants.vala',

  'Enums' / 'Formality.vala',
  'Enums' / 'StatusCode.vala',
  'Enums' / 'HighlightColor.vala',
#  'Enums' / 'HeatmapLevel.vala',

  'Objects' / 'Lang.vala',
  'Objects' / 'DDModel.vala',

  'Services' / 'Secrets.vala',
  'Services' / 'ZoomController.vala',

  'Backend' / 'DeepL' / 'DeepL.vala',
  'Backend' / 'DeepL' / 'DeepLUtils.vala',

  'Widgets' / 'Panes' / 'Pane.vala',
  'Widgets' / 'Panes' / 'SourcePane.vala',
  'Widgets' / 'Panes' / 'TargetPane.vala',
  'Widgets' / 'Panes' / 'PaneSeparator.vala',

  'Widgets' / 'LanguageItem.vala',
  'Widgets' / 'LogToolbar.vala',
  'Widgets' / 'ErrorBonusBox.vala',
  'Widgets' / 'TextView.vala',
  'Widgets' / 'HeaderBar.vala',
  'Widgets' / 'LanguageDropDown.vala',
  'Widgets' / 'SwitchWidget.vala',

  'Widgets' / 'Buttons' / 'OrientationBox.vala',
  'Widgets' / 'Buttons' / 'RetryButton.vala',
  'Widgets' / 'Buttons' / 'TranslateButton.vala',
#  'Widgets' / 'Buttons' / 'ToggleHighlight.vala',
  'Widgets' / 'Buttons' / 'ZoomBox.vala',

  'Widgets' / 'Popovers' / 'SettingsPopover.vala',
  'Widgets' / 'Popovers' / 'OptionsPopover.vala',

  'Widgets' / 'PopoverWidgets' / 'ApiEntry.vala',
  'Widgets' / 'PopoverWidgets' / 'ApiLevel.vala',

  'Enums' / 'ZoomType.vala',
  'Enums' / 'ZoomLevel.vala',

  'Views' / 'TranslationView.vala',
  'Views' / 'ErrorView.vala',
  'Views' / 'LogView.vala',

  'Windows' / 'MainWindow.vala',
  'Application.vala',
)

#================================
# Windows specific stuff
# theres a gio-windows and a gio-unix. We need to add depending on case 
# We need to compile an icon and add to the sources to avoid "missing icon" icon at every turn
# So AFAIK ico.rc just point to an ico file in the same folder it is, so this is like gresource

if windows_build
  deps += dependency('gio-windows-2.0')
  ico_src = import('windows').compile_resources('../windows/icons/ico.rc')
  sources += ico_src

else
  deps += dependency('gio-unix-2.0')

endif

#================================
# Create a new executable, list the files we want to compile, and install
# win_subsystem does not seem to cause issues in non-win builds
executable(
    app_id,
    config_file,
    gresource,
    sources,
    dependencies: deps,
    vala_args: vala_flags,
    win_subsystem: 'windows',
    install: true
)