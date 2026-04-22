# project name and programming language
project(
  'inscriptions',
  'vala', 'c',
  version: '1.1.3'
)

app_name = 'Inscriptions'
app_id = 'io.github.elly_code.' + meson.project_name()
app_path = '/io/github/elly_code/' + meson.project_name() + '/'
app_version = meson.project_version()
gettext_name = meson.project_name()

#================================
# Include Gnome and the translations module
gnome = import('gnome')
i18n = import('i18n')


vala_flags = []
if get_option('development')
  app_id +=  '.devel'
  vala_flags += ['--define', 'DEVEL']
endif

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (gettext_name), language:'c')

# Windows needs icons, special arguments, and skip libportal
windows_build = build_machine.system() == 'windows'
if windows_build
    vala_flags += ['--define', 'WINDOWS']
endif

add_project_arguments(vala_flags, language: 'vala')


#================================

config_data = configuration_data()
config_data.set('APP_NAME', app_name)
config_data.set('APP_ID', app_id)
config_data.set('APP_PATH', app_path)
config_data.set('APP_VERSION', app_version)
config_data.set('GETTEXT_PACKAGE', gettext_name)

subdir('po')
subdir('data')
subdir ('src')


gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
  update_desktop_database: true,
)