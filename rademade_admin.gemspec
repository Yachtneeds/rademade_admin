#encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

require 'rademade_admin/rademade_admin_version'

Gem::Specification.new do |s|
  s.name        = 'rademade_admin'
  s.version     = RademadeAdmin::VERSION
  s.authors     = ['Vladislav Melanitskiy', 'Denis Sergienko', 'Sergey Kuzhavskiy']
  s.email       = %w(co@rademade.com olol.toor@gmail.com kuzh@rademade.com)
  s.homepage    = 'https://github.com/Rademade/rademade_admin'
  s.summary     = 'Rails admin panel engine'
  s.description = 'Best rails admin panel. Great mechanism for customization and rapid development'
  s.licenses    = ['MIT']

  s.files       = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'Bowerfile', 'README.rdoc']
  s.test_files  = Dir['test/**/*']

  # Core dependencies
  s.add_dependency 'rails', '~> 5'
  s.add_dependency 'kaminari'

  # Auth
  s.add_dependency 'jwt'

  # Images
  s.add_dependency 'carrierwave'
  s.add_dependency 'light_resizer'

  # Assets
  s.add_dependency 'bower-rails', '>= 0.8.2'
  s.add_dependency 'sass-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'autoprefixer-rails'

  s.add_dependency 'i18n-js'
  s.add_dependency 'ejs'

  # Public JS assets
  s.add_dependency 'jquery-rails'
  s.add_dependency 'select2-rails', '~> 3.5'

  # Admin
  s.add_dependency 'mini_magick' # TODO remove. Need for ckeditor or light_resizer.
  s.add_dependency 'simple_form'
  s.add_dependency 'ckeditor'
  s.add_dependency 'cancan'
  s.add_dependency 'configurations'
end
