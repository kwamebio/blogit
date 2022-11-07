require "test_helper"

class BlogTest < ActiveSupport::TestCase
    test "is not valid without a name" do
      b = Blog.create(
        name: nil,
        link: 'http://www.testsubmission.com/'
      )
      assert b.errors[:name].any?
      refute b.valid?
    end

    test "is not valid without a link" do
      b = Blog.create(name: 'My test submission', link: nil)
      assert b.errors[:link].any?
      refute b.valid?
    end

    test "is valid with required attributes" do
      b = users(:kwame).blogs.create(
        name: 'fc barcelona',
        link: 'http://www.fcbarcelona.com/')
      assert b.valid?
    end

    test "returns highest vote first" do
      highest_id = blogs(:one).votes.map(&:id).max
      assert_equal highest_id, blogs(:one).votes.latest.first.id
    end

    test "return 3 latest votes" do
      10.times { blogs(:one).votes.create(user( :kwame)) }
      assert_equal 3, blogs(:one).votes.latest.size
    end

    test "is associated wit a user" do 
  assert_equal user(:kwame), blogs(:one).user
    end

    test "is associated wit a user" do 
  assert_equal user(:kwaku), blogs(:one).user
    end

  test "increments vote counter cache" do
    blogs(:two).votes.create(user_id: user_id(:kwame))
    blogs(:two).reload
    assert_equal 1, stories(:two).attributes['votes_count']
  end

  test "decrements votes counter cache" do 
    blogs(:one).votes.first.destroy
    blogs(:one).reload
    assert_equal 1, blogs(:one).attributes['votes_count']
  end

  test "casts vote after creating blog" do
    b = Blog.create(
      name: "Vote SmartThe 2008 Elections",
      link: "http://votesmart.org/",
      user: users(:kwame)
    )
    assert_equal users(:kwame), b.votes.first.user
  end
end
