require File.dirname(__FILE__) + '/../test_helper'

class ResponseTest < ActiveSupport::TestCase

  fixtures :responses
  fixtures :response_maps
  # set up the variable for test cases
  def setup
    @response = responses(:response0)
    @response1 = @response.id
    @responsemaps = response_maps(:response_maps0)
  end
  # test case for create function
  def test_create
    assert_equal Response.find(@response1).map_id, @response.map_id
    assert_equal Response.find(@response1).additional_comment, @response.additional_comment

  end
  # test case for update function
  def test_update
    assert_equal "review0", @response.additional_comment
    @response.additional_comment = "abcd"
    @response.save
    @response.reload
  
    assert_equal @response.additional_comment, "abcd"
  end
  # test case for the function to get the total score
  def test_get_total_score
    total_score = 0


    @scores1 = Score.find_all_by_response_id(@response.id)
    @scores1.each {|a|
    total_score   = a.score + total_score
    }
    assert_equal total_score , 15


  end
  # test case for the function notify on difference
  def test_notify_on_difference

    assert Mailer.deliver_message(:recipients => "abc@ncsu.edu",
                                  :subject => "Expertiza Notification",
                                  :body => "abc")
  end
  # test case for the display function
  def  test_display_as_html

    assert_equal  @responsemaps.reviewer_id, 380671078
    assert_equal  @responsemaps.reviewee_id, 538862539
    time = @response.updated_at
    puts time
    assert @response.display_as_html
  end
end
