project(
  'inscriptions',
  'vala', 'c',
  version: '1.1.3',
  license: 'GPL-3.0-or-later'
)

app_name = meson.project_name()
app_id = 'io.github.elly_code.' + app_name
app_path = '/io/github/elly_code/' + app_name
app_version = meson.project_version()

#================================
# Include Gnome and the translations module
gnome = import('gnome')
i18n = import('i18n')
vala_flags = []

development_build = get_option('development')
if development_build
  app_id +=  '.devel'
  vala_flags += ['--define', 'DEVEL']
endif

# Windows needs icons, special arguments, and skip libportal
windows_build = get_option('windows_build')
if build_machine.system() == 'windows'
  windows_build = true
endif

if windows_build
  vala_flags += ['--define', 'WINDOWS']
endif

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (app_name), language:'c')


#================================

# config_data is reused accross all project to propagate variables we set once
config_data = configuration_data()
config_data.set('LOCALEDIR', get_option('prefix') / get_option('localedir'))
config_data.set('APP_NAME', app_name)
config_data.set('APP_ID', app_id)
config_data.set('APP_PATH', app_path)
config_data.set('APP_VERSION', app_version)

subdir('po')
subdir('data')
subdir ('src')


gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
  update_desktop_database: true,
)