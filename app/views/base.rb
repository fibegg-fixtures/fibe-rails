# frozen_string_literal: true

module Views
  class Base < Components::Base
    include Phlex::Rails::Helpers::CSRFMetaTags
    include Phlex::Rails::Helpers::CSPMetaTag
    include Phlex::Rails::Helpers::StyleSheetLinkTag
    include Phlex::Rails::Helpers::JavaScriptImportmapTags

    def cache_store = Rails.cache
  end
end
