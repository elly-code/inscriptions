project(
  'inscriptions',
  ['c', 'vala'],
  version: '1.1.4',                 # Versioning: first should follow Gtk version, second and third depending how proud you are of the update
  license: 'GPL-3.0-or-later',
  version: '4.3.0',                 # Versioning: first should follow Gtk version, second and third depending how proud you are of the update
  meson_version: '>= 1.1'           # Use meson.options instead of meson_options.txt
)

app_name = meson.project_name()
app_id = 'io.github.elly_code.' + app_name
app_path = '/io/github/elly_code/' + app_name
app_version = meson.project_version()
publisher = 'elly-code'

development = get_option('development')
if development
  app_id +=  '.devel'
  add_project_arguments('--define=DEVEL', language: 'vala')

endif

gnome = import('gnome')
i18n = import('i18n')
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (app_name), language:'c')


#================================
# OS and Ports related

linux = get_option('profile') == 'linux'
windows = get_option('profile') == 'windows'


# Here is to autodetect and adjust
# Remember however that people may do cross compiling, so do not assume by default it is for linux
# So avoid else conditions adding linux stuff
build_machine_system = build_machine.system()
if build_machine_system == 'windows'
    windows = true

endif

# Here is to adjust the project accordingly to stuff
# Porting efforts: add your OS here

if windows
    add_project_arguments('--define=WINDOWS', language: 'vala')

elif linux
    add_project_arguments('--define=LINUX', language: 'vala')

endif


#================================
# Play nice with clang

# https://gitlab.gnome.org/GNOME/vala/-/issues/1413#note_1707480
if meson.get_compiler ('c').get_id () == 'clang'
    add_project_arguments('-Wno-incompatible-function-pointer-types', language: 'c')
endif

#================================

# config_data is reused accross all project to propagate variables we set once
config_data = configuration_data()
config_data = configuration_data(
    {
        'APP_NAME': app_name,
        'APP_ID': app_id,
        'APP_PATH': app_path,
        'APP_VERSION': app_version,
        'PUBLISHER': publisher,
        'LOCALEDIR': get_option('prefix') / get_option('localedir')
    }
)

subdir('po')
subdir('data')
subdir ('src')


gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
  update_desktop_database: true,
)