require "test_helper"

class ActiveRecordTest < ActiveSupport::TestCase

  test "mapping with an array" do
    expected = %w(pending published unpublished)
    Post.stubs(:statuses).returns(expected)

    post = FactoryGirl.build(:post)
    assert_equal "published", post.mapping(:status)

    post = FactoryGirl.build(:post, :status => "unpublished")
    assert_equal "unpublished", post.mapping('status')

    post = FactoryGirl.build(:post, :status => "unexisting")
    assert_equal "unexisting", post.mapping(:status)
  end

  test "mapping with a two dimension array" do
    expected = [["Publicado", "published"], ["Pendiente", "pending"], ["No publicado", "unpublished"]]
    Post.stubs(:statuses).returns(expected)

    post = FactoryGirl.build(:post)
    assert_equal "Publicado", post.mapping(:status)

    post = FactoryGirl.build(:post, :status => "unpublished")
    assert_equal "No publicado", post.mapping(:status)
  end

  test "mapping with a hash" do
    expected = { "Pending - Hash" => "pending", "Published - Hash" => "published", "Not Published - Hash" => "unpublished" }
    Post.stubs(:statuses).returns(expected)

    post = FactoryGirl.build(:post)
    assert_equal "Published - Hash", post.mapping(:status)
    post = FactoryGirl.build(:post, :status => "unpublished")
    assert_equal "Not Published - Hash", post.mapping(:status)
  end

  test "mapping with a hash when value does not exist on the mapping definition" do
    Post.stubs(:statuses).returns(Hash.new)
    page = FactoryGirl.build(:post, :status => "unexisting")
    assert_equal "unexisting", page.mapping(:status)
  end

  test "to_label returns email for TypusUser" do
    typus_user = FactoryGirl.build(:typus_user)
    assert_equal typus_user.email, typus_user.to_label
  end

  test "to_label returns name for Category" do
    category = FactoryGirl.build(:category, :name => "Chunky Bacon")
    assert_match "Chunky Bacon", category.to_label
  end

  test "to_label returns Model#id because Category#name is empty" do
    assert_match /Category#/, FactoryGirl.build(:category, :name => nil).to_label
  end

  test "to_label returns default Model#id" do
    assert_match /Post#/, FactoryGirl.build(:post).to_label
  end

  test "to_resource" do
    assert_equal "typus_users", TypusUser.to_resource
    assert_equal "delayed/tasks", Delayed::Task.to_resource
  end

end
