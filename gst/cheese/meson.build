sources = [
  'gstcheesefilter.cpp',
]

configure_file(output : 'config.h', configuration : cdata)

gstcheese_filterexample = library('gstcheese',
  sources,
  cpp_args: plugin_c_args,
  link_args: ['-lopencv_core', '-lopencv_imgproc'],
  dependencies : [gst_dep, gstbase_dep, opencv_dep, gstopencv_dep],
  install : true,
  install_dir : plugins_install_dir,
)

