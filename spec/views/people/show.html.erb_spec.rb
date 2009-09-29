require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/people/show.html.erb" do
  include PeopleHelper
  before(:each) do
    assigns[:person] = @person = stub_model(Person,
      :first_name => "value for first_name",
      :last_name => "value for last_name",
      :email => "value for email",
      :salt => "value for salt",
      :encrypted_password => "value for encrypted_password"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ first_name/)
    response.should have_text(/value\ for\ last_name/)
    response.should have_text(/value\ for\ email/)
    response.should have_text(/value\ for\ salt/)
    response.should have_text(/value\ for\ encrypted_password/)
  end
end
