{
  'targets': [
    {
      'target_name': 'modulename',
      'sources': [
        'node-addon/src/modulename.cpp'
      ],
      # sadly gyp does not support looking back relatively so
      # we cannot reference the mylib dep like '../mylib.gyp'
      'dependencies': [
        'mylib.gyp:mylib'
      ]
    }
  ]
}
