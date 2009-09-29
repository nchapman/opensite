require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/people/edit.html.erb" do
  include PeopleHelper

  before(:each) do
    assigns[:person] = @person = stub_model(Person,
      :new_record? => false,
      :first_name => "value for first_name",
      :last_name => "value for last_name",
      :email => "value for email",
      :salt => "value for salt",
      :encrypted_password => "value for encrypted_password"
    )
  end

  it "renders the edit person form" do
    render

    response.should have_tag("form[action=#{person_path(@person)}][method=post]") do
      with_tag('input#person_first_name[name=?]', "person[first_name]")
      with_tag('input#person_last_name[name=?]', "person[last_name]")
      with_tag('input#person_email[name=?]', "person[email]")
      with_tag('input#person_salt[name=?]', "person[salt]")
      with_tag('input#person_encrypted_password[name=?]', "person[encrypted_password]")
    end
  end
end
