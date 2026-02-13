
# Letsgo
sources = files (
  'Constants.vala',

  'Enums' / 'Formality.vala',
  'Enums' / 'StatusCode.vala',
  'Enums' / 'HighlightColor.vala',

  'Objects' / 'Lang.vala',
  'Objects' / 'DDModel.vala',

  'Services' / 'Secrets.vala',

  'Backend' / 'DeepL' / 'DeepL.vala',
  'Backend' / 'DeepL' / 'DeepLUtils.vala',

  'Widgets' / 'HeaderBar.vala',
  'Widgets' / 'Buttons' / 'OrientationBox.vala',
  'Widgets' / 'ApiEntry.vala',
  'Widgets' / 'ApiLevel.vala',
  'Widgets' / 'Pane.vala',
  'Widgets' / 'SourcePane.vala',
  'Widgets' / 'TargetPane.vala',
  'Widgets' / 'Buttons' / 'RetryButton.vala',
  'Widgets' / 'LogToolbar.vala',
  'Widgets' / 'ErrorBonusBox.vala',
  'Widgets' / 'TextView.vala',

  'Widgets' / 'Popovers' / 'SettingsPopover.vala',
  'Widgets' / 'Popovers' / 'OptionsPopover.vala',

  'Views' / 'TranslationView.vala',
  'Views' / 'ErrorView.vala',
  'Views' / 'LogView.vala',

  'Windows' / 'MainWindow.vala',
  'Application.vala',
)

# Create a new executable, list the files we want to compile, and install
executable(
    meson.project_name (),
    config_file,
    gresource,
    sources,
    dependencies: deps,
    win_subsystem: 'windows',
    install: true
)