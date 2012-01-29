require "test_helper"

=begin

  What's being tested here?

    - CRUD

=end

class Admin::EntriesControllerTest < ActionController::TestCase

  setup do
    admin_sign_in
    @entry = FactoryGirl.create(:entry)
  end

  test "get index" do
    get :index
    assert_response :success
    assert_template 'index'
  end

  test "get new" do
    get :new
    assert_response :success
    assert_template 'new'
  end

  test "get new ignores url params" do
    %w(chunky_bacon).each do |param|
      get :new, { param => param }
      assert_response :success
      assert_template 'new'
    end
  end

  test "get new reads params[:resource]" do
    get :new, { :resource => { :title => "Chunky Bacon" } }
    assert_response :success
    assert_template 'new'
      assert_equal "Chunky Bacon", assigns(:item).title
  end

  test "post create and redirect to index" do
    assert_difference('Entry.count') do
      post :create, :entry => @entry.attributes, :_save => true
      assert_response :redirect
      assert_redirected_to "/admin/entries"
    end
  end

  test "post create and redirect to add new" do
    assert_difference('Entry.count') do
      post :create, :entry => @entry.attributes, :_addanother => true
      assert_response :redirect
      assert_redirected_to "/admin/entries/new"
    end
  end

  test "post create and continue editing" do
    assert_difference('Entry.count') do
      post :create, :entry => @entry.attributes, :_continue => true
      assert_response :redirect
      assert_redirected_to "/admin/entries/edit/#{Entry.last.id}"
    end
  end

  test "get show" do
    get :show, :id => @entry.id
    assert_response :success
    assert_template 'show'
  end

  test "get edit" do
    get :edit, :id => @entry.id
    assert_response :success
    assert_template 'edit'
  end

  test "post update and redirect to index" do
    post :update, :id => @entry.id, :entry => { :title => 'Updated' }, :_save => true
    assert_response :redirect
    assert_redirected_to "/admin/entries"
  end

  test "get toggle" do
    @request.env['HTTP_REFERER'] = "/admin/entries"

    assert !@entry.published
    get :toggle, :id => @entry.id, :field => "published"

    assert_response :redirect
    assert_redirected_to @request.env["HTTP_REFERER"]
    assert_equal "Entry successfully updated.", flash[:notice]
    assert @entry.reload.published
  end

  test "get toggle redirects to edit when validation fails" do
    @request.env['HTTP_REFERER'] = "/admin/entries"

    @entry.content = nil
    @entry.save(:validate => false)
    get :toggle, :id => @entry.id, :field => "published"
    assert_response :success
    assert_template "admin/resources/edit"
  end

end
