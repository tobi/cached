# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cached}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tobias L\303\274tke"]
  s.date = %q{2009-06-10}
  s.description = %q{Small trial project that attempts to accelerate common active record like operations without too much black magic.}
  s.email = ["tobi@leetsoft.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "website/index.txt"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "config/website.yml.sample", "lib/cached.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "test/test_cached.rb", "test/test_helper.rb", "website/index.html", "website/index.txt", "website/javascripts/rounded_corners_lite.inc.js", "website/stylesheets/screen.css", "website/template.html.erb", "test/test_cached_delegation.rb", "test/test_config_compiler.rb", "test/test_record.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tobi/cached}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{cached}
  s.rubygems_version = %q{1.3.1}
  s.signing_key = %q{/Users/tobi/.gem/gem-private_key.pem}
  s.summary = %q{Small trial project that attempts to accelerate common active record like operations without too much black magic.}
  s.test_files = ["test/test_cached.rb", "test/test_cached_delegation.rb", "test/test_config_compiler.rb", "test/test_helper.rb", "test/test_record.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_development_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.2"])
    s.add_dependency(%q<newgem>, [">= 1.4.1"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
