
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

  'Widgets' / 'Panes' / 'Pane.vala',
  'Widgets' / 'Panes' / 'SourcePane.vala',
  'Widgets' / 'Panes' / 'TargetPane.vala',

  'Widgets' / 'LanguageItem.vala',
  'Widgets' / 'LogToolbar.vala',
  'Widgets' / 'ErrorBonusBox.vala',
  'Widgets' / 'TextView.vala',
  'Widgets' / 'HeaderBar.vala',

  'Widgets' / 'Buttons' / 'OrientationBox.vala',
  'Widgets' / 'Buttons' / 'RetryButton.vala',

  'Widgets' / 'Popovers' / 'SettingsPopover.vala',
  'Widgets' / 'Popovers' / 'OptionsPopover.vala',

  'Widgets' / 'PopoverWidgets' / 'ApiEntry.vala',
  'Widgets' / 'PopoverWidgets' / 'ApiLevel.vala',

  'Enums' / 'ZoomType.vala',
  'Enums' / 'ZoomLevel.vala',
  'Services' / 'ZoomController.vala',
  'Widgets' / 'ZoomableTextView.vala',


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