

#================================

config_data_quoted = configuration_data()
config_data_quoted.set_quoted('LOCALEDIR', get_option('prefix') / get_option('localedir'))
config_data_quoted.set_quoted('GETTEXT_PACKAGE', gettext_name)
config_data_quoted.set_quoted('APP_NAME', app_name)
config_data_quoted.set_quoted('APP_ID', app_id)
config_data_quoted.set_quoted('APP_PATH', app_path)
config_data_quoted.set_quoted('APP_VERSION', app_version)
config_file = configure_file(
    input: 'Config.vala.in',
    output: '@BASENAME@',
    configuration: config_data_quoted
)


#================================
# dependencies
deps = [
  dependency ('granite-7', version: '>=7.7.0'),
  dependency ('gtk4'),
  dependency ('libsoup-3.0'),
  dependency ('json-glib-1.0'),
  dependency ('libsecret-1')
]

# We need to compile an icon into the exe to avoid "missing icon" icon at every turn
if windows_build
  deps += dependency('gio-windows-2.0')
  ico_src = import('windows').compile_resources('windows/icons/ico.rc')

else
  deps += dependency('gio-unix-2.0')
endif

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
# Create a new executable, list the files we want to compile, and install
# win_subsystem does not seem to cause issues in non-win builds
executable(
    app_id,
    config_file,
    gresource,
    sources,
    dependencies: deps,
    win_subsystem: 'windows',
    install: true
)