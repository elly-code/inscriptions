
# Letsgo
sources = files (
  'Constants.vala',

  'Enums' / 'Formality.vala',
  'Enums' / 'StatusCode.vala',
  'Enums' / 'HighlightColor.vala',
  'Enums' / 'BackendType.vala',

  'Objects' / 'Lang.vala',
  'Objects' / 'DDModel.vala',

  'Backend' / 'BackendTemplate.vala',
  'Backend' / 'Dummy.vala',
  'Backend' / 'DeepL' / 'DeepL.vala',
  'Backend' / 'DeepL' / 'DeepLUtils.vala',

  'Services' / 'Secrets.vala',
  'Services' / 'BackendController.vala',

  'Widgets' / 'Panes' / 'Pane.vala',
  'Widgets' / 'Panes' / 'SourcePane.vala',
  'Widgets' / 'Panes' / 'TargetPane.vala',

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