class StoryNotifier < ActionMailer::Base
  default from: "notifications@fooball.herokuapp.com"

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_story_email(story, story_creator, user)
    @story = story
    @story_creator = story_creator
    @user = user

    mail( 
      to: @user.email,
      subject: "#{@story_creator.name} just created a story: #{@story.title}"
    )
  end
end