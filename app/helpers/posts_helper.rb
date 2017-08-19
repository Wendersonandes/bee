module PostsHelper
  def display_likes(post)
    votes = post.votes_for.up.by_type(User)
    return list_likers(votes) if votes.size <= 8
    count_likers(votes)
  end

  def liked_post(post)
    return render 'posts/like_final', post: @post if current_user.voted_for? post
    render 'posts/unlike_final', post: @post
  end

  private

  def list_likers(votes)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to "#{voter.name} #{voter.sobrenome}",
                                profile_path(voter.user_name),
                                class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end

  def count_likers(votes)
    vote_count = votes.size
    vote_count.to_s + ' likes'
  end

  def like_plural(votes)
    return ' gostoram disso' if votes.count > 1
    ' gostou disso'
  end
end
