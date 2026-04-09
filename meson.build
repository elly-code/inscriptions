# project name and programming language
project(
  'inscriptions',
  'vala', 'c',
  version: '1.1.3'
)

app_name = 'Inscriptions'
app_id = 'io.github.elly_code.' + meson.project_name()
app_version = meson.project_version()

#================================
# Include Gnome and the translations module
gnome = import('gnome')
i18n = import('i18n')


vala_flags = []
if get_option('development')
  app_id +=  '.devel'
  vcs_tag = run_command('git', 'rev-parse', '--short', 'HEAD').stdout().strip()
  app_version += '-@0@'.format (vcs_tag)
  vala_flags += ['--define', 'DEVEL']

endif

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (app_id), language:'c')

# Windows needs icons, special arguments, and skip libportal
windows_build = build_machine.system() == 'windows'
if windows_build
    vala_flags += ['--define', 'WINDOWS']
endif

add_project_arguments(vala_flags, language: 'vala')


#================================
config_data = configuration_data()
config_data.set('version', meson.project_version())
config_data.set_quoted('LOCALEDIR', get_option('prefix') / get_option('localedir'))
config_data.set_quoted('GETTEXT_PACKAGE', app_id)
config_data.set_quoted('APP_NAME', app_name)
config_data.set_quoted('APP_ID', app_id)
config_data.set_quoted('APP_VERSION', app_version)

config_file = configure_file(
  input: 'src/Config.vala.in',
  output: '@BASENAME@',
  configuration: config_data
)

gresource = gnome.compile_resources(
  'as-resources',
  'data' / 'inscriptions.gresource.xml',
  source_dir: 'data',
  c_name: 'as'
)

#================================
# dependencies
deps = [
  dependency ('granite-7'),
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

subdir ('src')
subdir('data')
subdir('po')

gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
  update_desktop_database: true,
)