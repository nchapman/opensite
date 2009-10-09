module Admin::PagesHelper
  def setup_page(page)
    returning(page) do |p|
      p.parts.build if p.parts.empty?
    end
  end
end
