project('gnome-latam-workshop', 'cpp', version : '0.0.0', license : 'LGPL')

plugins_install_dir = join_paths(get_option('libdir'), 'gstreamer-1.0')

cpp_compiler = meson.get_compiler('cpp')
pkg_version = meson.project_version()
api_version = '1.0'

gst_dep = dependency('gstreamer-1.0', version : '>=1.18',
    required : true, fallback : ['gstreamer', 'gst_dep'])
gstbase_dep = dependency('gstreamer-base-1.0', version : '>=1.18',
  fallback : ['gstreamer', 'gst_base_dep'])
opencv_dep = dependency('opencv', version : '>= 3', required: false)
if not opencv_dep.found()
  opencv_dep = dependency('opencv4', version : '>= 4.0.0', method: 'pkg-config', required: true)
endif
opencv_dep = opencv_dep.partial_dependency(compile_args: true)
gstopencv_dep = cpp_compiler.find_library('gstopencv-1.0', required: true)

plugin_c_args = ['-DHAVE_CONFIG_H']

cdata = configuration_data()
cdata.set_quoted('PACKAGE_VERSION', pkg_version)
cdata.set_quoted('PACKAGE', 'gnome-latam-workshop')
cdata.set_quoted('GST_LICENSE', 'LGPL')
cdata.set_quoted('GST_API_VERSION', api_version)
cdata.set_quoted('GST_PACKAGE_NAME', 'GNOME Latam: Cheese Filter plug-in')
cdata.set_quoted('GST_PACKAGE_ORIGIN', 'https://github.com/fluendo/gnome-latam-workshop')

subdir('gst')
