
{
  'targets': [

    {
      'target_name': 'mylib',
      'product_name': 'mylib',
      'type': 'static_library',
      'sources': [
        'src/implementation.cc',
      ],
      'include_dirs': [
         'include',
      ],
    },

    {
      'target_name': 'myapp',
      'type': 'executable',
      'sources': [
        './bin/myapp.cc',
      ],
      'include_dirs': [
         'include',
      ],
      'dependencies': [
        'mylib'
      ],
    },

    {
      'target_name': 'modulename',
      'product_name': 'modulename',
      'type': 'loadable_module',
      'product_prefix': '',
      'product_extension':'node',
      'sources': [
                   "node-addon/modulename.cpp",
      ],
      'include_dirs': [
         '/usr/local/include/node',
      ],
      'ldflags': [
      ],
      'cflags' : [
      ],
      'defines': [
        'PLATFORM="<(OS)"',
        '_LARGEFILE_SOURCE',
        '_FILE_OFFSET_BITS=64',
      ],
      'conditions': [
        [ 'OS=="mac"', {
          'libraries': [ '-undefined dynamic_lookup' ],
        }],
        [ 'OS=="win"', {
          'defines': [
            'PLATFORM="win32"',
          ],
        }],
      ]
  }
  ],
}