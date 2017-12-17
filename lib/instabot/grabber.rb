module Grabber
  def handle_user_informations_data(user_id)
    puts '[+] '.cyan + "Trying to get user (#{user_id}) informations"
    log("Trying to get user (#{user_id}) informations", 'GRABBER')
    user_page = "https://www.instagram.com/web/friendships/#{user_id}/follow/"
    response  = get_page(user_page)
    last_page = response.uri.to_s
    username  = last_page.split('/')[3]
    response  = @agent.get("https://instagram.com/#{username}/?__a=1")
    data      = parse_response(response.body)

    set_user_informations(data)
  end

  def handle_media_informations_data(media_id)
    puts '[+] '.cyan + "Trying to get media (#{media_id}) informations"
    log("Trying to get media (#{media_id}) informations", 'GRABBER')
    response = @agent.get("https://www.instagram.com/p/#{media_id}/?__a=1")
    data     = parse_response(response.body)

    set_media_informations(data)

    unless @infinite_tags == true
      tags = @media_informations[:text].encode('UTF-8', invalid: :replace, undef: :replace, replace: '?').split(/\W+/)
      id   = 0
      tags.each do |tag|
        if tag == '_' || tag == '' || tag.nil?
          tags.delete(tag)
        else
          id += 1
          Config.options.tags << tag
        end
      end
      puts '[+] '.cyan + '[' + id.to_s.yellow + '] New tags added'
    end
  end

  def set_user_informations(data)
    @user_informations = {
      followers:   data.deep_find('followed_by')['count'],
      following:   data.deep_find('follows')['count'],
      is_private:  data.deep_find('is_private'),
      is_verified: data.deep_find('is_verified'),
      username:    data.deep_find('username'),
      posts:       data.deep_find('media')['count'],
      full_name:   data.deep_find('full_name'),
      id:          data.deep_find('id')
    }
  end

  def set_media_informations(data)
    @media_informations = {
      id:                  data.deep_find('id'),
      full_name:           data.deep_find('full_name'),
      owner:               data.deep_find('owner')['username'],
      is_video:            data.deep_find('is_video'),
      comments_disabled:   data.deep_find('comments_disabled'),
      viewer_has_liked:    data.deep_find('viewer_has_liked'),
      has_blocked_viewer:  data.deep_find('has_blocked_viewer'),
      followed_by_viewer:  data.deep_find('followed_by_viewer'),
      is_private:          data.deep_find('is_private'),
      is_verified:         data.deep_find('is_verified'),
      requested_by_viewer: data.deep_find('requested_by_viewer'),
      text:                data.deep_find('text') 
    }
  end

  def search(tags = [])
    tags.each do |tag|
      puts '[+] '.cyan + "Searching in hashtag [##{tag}]"
      log("Searching in hashtags [##{tag}]", 'GRABBER')
      url         = "https://www.instagram.com/explore/tags/#{tag}/?__a=1"
      response    = @agent.get(url)
      data        = parse_response(response.body)
      owners      = data.deep_find_all('owner')
      media_codes = data.deep_find_all('code')
      owners.map { |id| users << id['id'] }
      media_codes.map { |code| medias << code }
      Config.options.tags.delete(tag)
    end
    puts '[+] '.cyan + 'Total grabbed users [' + users.size.to_s.yellow + ']'
    puts '[+] '.cyan + 'Total grabbed medias [' + medias.size.to_s.yellow + ']'
    log("Total grabbed users(#{users.size}) & Total grabbed medias(#{medias.size})", 'GRABBER')
  end

  private

  def parse_response(body)
    data = JSON.parse(body)
    data.extend Hashie::Extensions::DeepFind
    data
  end
end
