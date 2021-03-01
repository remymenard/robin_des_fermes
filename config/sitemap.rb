require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = ENV["DOMAIN"] || "localhost:3000"
SitemapGenerator::Sitemap.create_index = true

SitemapGenerator::Sitemap.create do

  {fr: :french}.each_pair do |locale, name|
    group(:sitemaps_path => "sitemaps/#{locale}/", :filename => name) do
      add root_path(locale: locale), :changefreq => 'daily'

      Farm.find_each do |farm|
        add farms_path(farm, locale: locale), :changefreq => 'weekly', :lastmod => farm.updated_at
      end

      Product.find_each do |product|
        add product_path(product, locale: locale), :changefreq => 'weekly', :lastmod => product.updated_at
      end
    end
  end
end


SitemapGenerator::Sitemap.ping_search_engines(ENV["DOMAIN"])
