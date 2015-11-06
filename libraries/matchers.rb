if defined? ChefSpec
  ChefSpec.define_matcher :sumologic_source

  def create_sumologic_source(resource_name:)
    ChefSpec::Matchers::ResourceMatcher.new :sumologic_source, :create,
      resource_name
  end

  def delete_sumologic_source(resource_name:)
    ChefSpec::Matchers::ResourceMatcher.new :sumologic_source, :delete,
      resource_name
  end
end
