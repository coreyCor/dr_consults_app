class TestController < ApplicationController
  def show
    # Just render the view
  end

  def update
    render turbo_stream: turbo_stream.replace("test_frame", "<p id='test_text'>✅ Updated via Turbo!</p>")
  end

  def destroy
    render turbo_stream: turbo_stream.replace("test_frame", "<p id='test_text'>🗑️ Deleted via Turbo!</p>")
  end
end
