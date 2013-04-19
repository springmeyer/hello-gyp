
{
  'includes': [ 'common.gyp' ],
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
    }
  ],
}