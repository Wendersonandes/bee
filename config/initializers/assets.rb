# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( *.js ^[^_]*.css *.css.erb *.min.css *.min.js *.js.erb *.carousel.min.js)
Rails.application.config.assets.precompile += %w(pe-icon-7-stroke.css)
Rails.application.config.assets.precompile += %w(animate.css)
Rails.application.config.assets.precompile += %w(owl.theme.css)
Rails.application.config.assets.precompile += %w(owl.carousel.css)
Rails.application.config.assets.precompile += %w(light-bootstrap-dashboard.css)
# Rails.application.config.assets.precompile += %w(css-index.css)
# Rails.application.config.assets.precompile += [/.*\.js/,/.*\.css/]
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
