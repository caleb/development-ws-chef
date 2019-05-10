name 'development_ws'
run_list 'recipe[development_ws::default]'
default_source :supermarket
cookbook 'development_ws', '~> 1.0.0', path: 'cookbooks/development_ws'