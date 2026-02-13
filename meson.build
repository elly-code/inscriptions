# project name and programming language
project(
  'io.github.elly_code.inscriptions',
  'vala', 'c',
  version: '1.0.0'
)

# Include Gnome and the translations module
gnome = import('gnome')
i18n = import('i18n')

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')


## Set de config data
config_data = configuration_data()
config_data.set('version', meson.project_version())
config_data.set_quoted('LOCALEDIR', get_option('prefix') / get_option('localedir'))
config_data.set_quoted('GETTEXT_PACKAGE', meson.project_name())
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

# List the dependencies we need
# need for libcurl
deps = [
  dependency ('granite-7'),
  dependency ('gtk4'),
  dependency ('libsoup-3.0'),
  dependency ('json-glib-1.0'),
  dependency ('libsecret-1')
]

subdir ('src')
subdir('data')
subdir('po')

gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
  update_desktop_database: true,
)