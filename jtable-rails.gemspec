# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jtable-rails}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Taylor Yelverton"]
  s.date = %q{2011-02-07}
  s.description = %q{A Rails gem to power the jTable jQuery plugin}
  s.email = %q{taylor@synergy-solutions.biz}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "jtable-rails.gemspec",
    "lib/jtable-rails.rb",
    "spec/model_specs/person_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/rails_app/.gitignore",
    "spec/support/rails_app/Gemfile",
    "spec/support/rails_app/Gemfile.lock",
    "spec/support/rails_app/Rakefile",
    "spec/support/rails_app/app/controllers/application_controller.rb",
    "spec/support/rails_app/app/controllers/people_controller.rb",
    "spec/support/rails_app/app/helpers/application_helper.rb",
    "spec/support/rails_app/app/helpers/people_helper.rb",
    "spec/support/rails_app/app/models/person.rb",
    "spec/support/rails_app/app/views/layouts/application.html.erb",
    "spec/support/rails_app/app/views/people/_form.html.erb",
    "spec/support/rails_app/app/views/people/edit.html.erb",
    "spec/support/rails_app/app/views/people/index.html.erb",
    "spec/support/rails_app/app/views/people/new.html.erb",
    "spec/support/rails_app/app/views/people/show.html.erb",
    "spec/support/rails_app/config.ru",
    "spec/support/rails_app/config/application.rb",
    "spec/support/rails_app/config/boot.rb",
    "spec/support/rails_app/config/database.yml",
    "spec/support/rails_app/config/environment.rb",
    "spec/support/rails_app/config/environments/development.rb",
    "spec/support/rails_app/config/environments/production.rb",
    "spec/support/rails_app/config/environments/test.rb",
    "spec/support/rails_app/config/initializers/backtrace_silencers.rb",
    "spec/support/rails_app/config/initializers/inflections.rb",
    "spec/support/rails_app/config/initializers/mime_types.rb",
    "spec/support/rails_app/config/initializers/secret_token.rb",
    "spec/support/rails_app/config/initializers/session_store.rb",
    "spec/support/rails_app/config/locales/en.yml",
    "spec/support/rails_app/config/routes.rb",
    "spec/support/rails_app/db/migrate/20110207142623_create_people.rb",
    "spec/support/rails_app/db/seeds.rb",
    "spec/support/rails_app/public/stylesheets/scaffold.css",
    "spec/support/rails_app/script/rails"
  ]
  s.homepage = %q{http://github.com/yelvert/jtable-rails}
  s.licenses = ["Ms-PL"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A Rails gem to power the jTable jQuery plugin}
  s.test_files = [
    "spec/model_specs/person_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/rails_app/app/controllers/application_controller.rb",
    "spec/support/rails_app/app/controllers/people_controller.rb",
    "spec/support/rails_app/app/helpers/application_helper.rb",
    "spec/support/rails_app/app/helpers/people_helper.rb",
    "spec/support/rails_app/app/models/person.rb",
    "spec/support/rails_app/config/application.rb",
    "spec/support/rails_app/config/boot.rb",
    "spec/support/rails_app/config/environment.rb",
    "spec/support/rails_app/config/environments/development.rb",
    "spec/support/rails_app/config/environments/production.rb",
    "spec/support/rails_app/config/environments/test.rb",
    "spec/support/rails_app/config/initializers/backtrace_silencers.rb",
    "spec/support/rails_app/config/initializers/inflections.rb",
    "spec/support/rails_app/config/initializers/mime_types.rb",
    "spec/support/rails_app/config/initializers/secret_token.rb",
    "spec/support/rails_app/config/initializers/session_store.rb",
    "spec/support/rails_app/config/routes.rb",
    "spec/support/rails_app/db/migrate/20110207142623_create_people.rb",
    "spec/support/rails_app/db/schema.rb",
    "spec/support/rails_app/db/seeds.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rails>, ["= 3.0.3"])
      s.add_runtime_dependency(%q<rails>, ["= 3.0.3"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rails>, ["= 3.0.3"])
      s.add_dependency(%q<rails>, ["= 3.0.3"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rails>, ["= 3.0.3"])
    s.add_dependency(%q<rails>, ["= 3.0.3"])
  end
end
