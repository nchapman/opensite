module Admin::SitesHelper
  def setup_site(site)
    returning(site) do |s|
      s.domains.build if s.domains.empty?
    end
  end
end
